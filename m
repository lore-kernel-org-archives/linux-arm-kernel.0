From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Thu, 31 Jan 2013 19:35:02 +0400
Subject: IPC SHM alignment on ARMv7
In-Reply-To: <20130131134747.GY23505@n2100.arm.linux.org.uk>
References: <510A7262.4060307@parallels.com>
 <20130131134747.GY23505@n2100.arm.linux.org.uk>
Message-ID: <510A8F26.6000609@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 05:47 PM, Russell King - ARM Linux wrote:
> Err, no.  Try again

OK, let me be more specific. The following code is a simplified
version of the test in the CRIU test suite that checks IPC SHM
checkpoint/restoration work correctly:

#include <stdio.h>
#include <sys/ipc.h>

int main()
{
     int loop;
     int shmid = shmget(0x94646337, 40960, IPC_CREAT);
     if (shmid < 0) {
         perror("Failed to get a SHM descriptor");
         return 1;
     }

     void *addr1, *addr2;

     addr1 = shmat(shmid, 0, 0);
     if (addr1 == (void*)-1) {
         perror("Failed to attach the SHM segment");
         return 2;
     }

     printf("Attached to %p\n", addr1);
     *((int*)addr1) = 1;

     shmdt(addr1);

     addr2 = shmat(shmid, addr1, 0);
     if (addr2 == (void*)-1) {
         perror("Failed to re-attach the SHM");
         printf("The SHM segment was formerly attached to %p\n", addr1);
         return 3;
     }

     if (addr2 != addr1) {
         printf("The SHM segment address changed: was %p, now %p\n", 
addr1, addr2);
         return 4;
     }

     return 0;
}


I'm running this code in the Linux 3.7.5:

root at crtest:~/ipc-fail# cat /proc/version
Linux version 3.7.5 (alex at alex-pc) (gcc version 4.6.3 20120201 
(prerelease) (crosstool-NG linaro-1.13.1-2012.02-20120222 - Linaro GCC 
2012.02) ) #1 SMP Thu Jan 31 19:01:37 MSK 2013

I'm running the kernel in the QEMU model of the board RM Versatile 
Express for Cortex-A9.
I use the config vexpress_defconfig to compile the kernel.


The test usually outputs something like:

root at crtest:~/ipc-fail# ./ipc-fail
Attached to 0x76e22000
Failed to re-attach the SHM: Invalid argument
The SHM segment was formely attached to 0x76e22000
root at crtest:~/ipc-fail# ./ipc-fail
Attached to 0x76df6000
Failed to re-attach the SHM: Invalid argument
The SHM segment was formely attached to 0x76df6000

However it sometimes succeeds:

root@crtest:~/ipc-fail# ./ipc-fail
Attached to 0x76e94000

As you can see the test fails when the address returned by
the function shmat() isn't SHMLBA-aligned.


I think that this is caused by the fact that the kernel function do_shmat()
requires the argument shmaddr to be SHMLBA-aligned:

[ipc/shm.c]
[...]
  958 long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong 
*raddr,
  959           unsigned long shmlba)
  960 {
[...]
  974
  975     err = -EINVAL;
  976     if (shmid < 0)
  977         goto out;
  978     else if ((addr = (ulong)shmaddr)) {
  979         if (addr & (shmlba - 1)) {
  980             if (shmflg & SHM_RND)
  981                 addr &= ~(shmlba - 1);     /* round down */
  982             else
  983 #ifndef __ARCH_FORCE_SHMLBA
  984                 if (addr & ~PAGE_MASK)
  985 #endif
  986                     goto out;



However, it can't guarantee that its returned address is SHMLBA-aligned
because the function arch_get_unmapped_area():

[arch/arm/mm/mmap.c]
[...]
  66 unsigned long
  67 arch_get_unmapped_area(struct file *filp, unsigned long addr,
  68         unsigned long len, unsigned long pgoff, unsigned long flags)
  69 {
  70     struct mm_struct *mm = current->mm;
  71     struct vm_area_struct *vma;
  72     unsigned long start_addr;
  73     int do_align = 0;
  74     int aliasing = cache_is_vipt_aliasing();
  75
  76     /*
  77      * We only need to do colour alignment if either the I or D
  78      * caches alias.
  79      */
  80     if (aliasing)
  81         do_align = filp || (flags & MAP_SHARED);
[...]
114 full_search:
115     if (do_align)
116         addr = COLOUR_ALIGN(addr, pgoff);
117     else
118         addr = PAGE_ALIGN(addr);
119
120     for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
121         /* At this point:  (!vma || addr < vma->vm_end). */
122         if (TASK_SIZE - len < addr) {
123             /*
124              * Start a new search - just in case we missed
125              * some holes.
126              */
127             if (start_addr != TASK_UNMAPPED_BASE) {
128                 start_addr = addr = TASK_UNMAPPED_BASE;
129                 mm->cached_hole_size = 0;
130                 goto full_search;
131             }
132             return -ENOMEM;
133         }
134         if (!vma || addr + len <= vma->vm_start) {
135             /*
136              * Remember the place where we stopped the search:
137              */
138             mm->free_area_cache = addr + len;
139             return addr;
140         }
141         if (addr + mm->cached_hole_size < vma->vm_start)
142                 mm->cached_hole_size = vma->vm_start - addr;
143         addr = vma->vm_end;
144         if (do_align)
145             addr = COLOUR_ALIGN(addr, pgoff);
146     }
147 }

aligns the returned address on a SHMLBA-boundary only if I or D caches alias
as the comment reads:

  76     /*
  77      * We only need to do colour alignment if either the I or D
  78      * caches alias.
  79      */

that isn't true for ARMv7.


So the question is whether it's possible to align a SHM segement
on a SHMLBA boundary unconditionally.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
