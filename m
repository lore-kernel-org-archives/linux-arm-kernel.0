From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Thu, 31 Jan 2013 17:32:18 +0400
Subject: IPC SHM alignment on ARMv7
Message-ID: <510A7262.4060307@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear colleagues,

It tuned out that IPC SHM works in a bit strange way on ARMv7:
the syscall sys_shmat() requires the argument shmaddr to be SHMLBA-aligned:

[ipc/shm.c]
[...]
  979     else if ((addr = (ulong)shmaddr)) {
  980         if (addr & (shmlba - 1)) {
  981             if (shmflg & SHM_RND)
  982                 addr &= ~(shmlba - 1);     /* round down */
  983             else
  984 #ifndef __ARCH_FORCE_SHMLBA
  985                 if (addr & ~PAGE_MASK)
  986 #endif
  987                     goto out;
  988         }
  989         flags = MAP_SHARED | MAP_FIXED;
[...]

since macro __ARCH_FORCE_SHMLBA is unconditionally defined for the ARM
architecture. However it uses the function arch_get_unmapped_area()
introduced in the commit 4197692eef113eeb8e3e413cc70993a5e667e5b8
in the mainstream kernel to allocate memory for a SHM segment.
However the function allocates SHMLBA-aligned memory only if
I or D caches alias as the following comment reads:

[arch/arm/mm/mmap.c]
[...]
  54 unsigned long
  55 arch_get_unmapped_area(struct file *filp, unsigned long addr,
  56         unsigned long len, unsigned long pgoff, unsigned long flags)
  57 {
  58     struct mm_struct *mm = current->mm;
  59     struct vm_area_struct *vma;
  60     int do_align = 0;
  61     int aliasing = cache_is_vipt_aliasing();
  62     struct vm_unmapped_area_info info;
  63
  64     /*
  65      * We only need to do colour alignment if either the I or D
  66      * caches alias.
  67      */
  68     if (aliasing)
  69         do_align = filp || (flags & MAP_SHARED);
[...]

So a SHM segment isn't always SHMLBA-aligned.


This results in the following inconvenience: the address returned
by the syscall sys_shmat() may not be passed as its argument
later. This is however crucial for implementing IPC SHM
checkpoint/restore for the ARM architecture I'm currently working on.


As far as I can see from the commit c0e9587841a0fd79bbf8296034faefb9afe72fb4
in the mainstream kernel:

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1939c90..5b121d8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -67,6 +67,8 @@ unsigned int processor_id;
  EXPORT_SYMBOL(processor_id);
  unsigned int __machine_arch_type;
  EXPORT_SYMBOL(__machine_arch_type);
+unsigned int cacheid;
+EXPORT_SYMBOL(cacheid);

  unsigned int __atags_pointer __initdata;

@@ -229,6 +231,25 @@ int cpu_architecture(void)
         return cpu_arch;
  }

+static void __init cacheid_init(void)
+{
+       unsigned int cachetype = read_cpuid_cachetype();
+       unsigned int arch = cpu_architecture();
+
+       if (arch >= CPU_ARCH_ARMv7) {
+               cacheid = CACHEID_VIPT_NONALIASING;
+               if ((cachetype & (3 << 14)) == 1 << 14)
+                       cacheid |= CACHEID_ASID_TAGGED;
+       } else if (arch >= CPU_ARCH_ARMv6) {
+               if (cachetype & (1 << 23))
+                       cacheid = CACHEID_VIPT_ALIASING;
+               else
+                       cacheid = CACHEID_VIPT_NONALIASING;
+       } else {
+               cacheid = CACHEID_VIVT;
+       }
+}
+
  /*
   * These functions re-use the assembly code in head.S, which

the flag CACHEID_VIPT_ALIASING is never set for ARMv7
so it's impossible to guarantee that a IPC SHM segment
is always SHMLBA-aligned.


Is it true that the desired SHM alignment is impossible
to be achieved on the ARMv7 architecture?

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov@parallels.com
