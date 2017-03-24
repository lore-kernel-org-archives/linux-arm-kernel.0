From: panand@redhat.com (Pratyush Anand)
Date: Fri, 24 Mar 2017 19:51:34 +0530
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
Message-ID: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

One of the hugetlbfs test[1] fails on ARM64 kernel with Segmentation 
fault. Segmentation fault (unhandled level 2 translation fault [3]) 
happens just after kernel returns to user space from mmap() system call. 
See the tailored version of failing test case [2] (it reproduces in 
maximum 10 trials).

When it fails lr shows the address of the instruction which follow 
mmap() call in main. Also, if test is run with strace, then it says that 
mmap() system call was fine. (so,I believe lr is correct). Cross checked 
from /proc/pid/maps and PC is also correct.It is the address of 
instruction where kernel will return after executing mmap() system call. 
So, when the first user space instruction is executed after returning 
from kernel, it gives segmentation fault. Not sure what went wrong..Just 
a guess, probably this page was swapped out (core dump does not have 
this page), but kernel expect it to be there. Any pointer to debug will 
be helpful.

Following is one failing scenario, which leads to above assertions.

 From /proc/pid/maps:
ffffa1760000-ffffa18c0000 r-xp 00000000 fd:00 33718606 
/usr/lib64/libc-2.17.so

from dmesg:
[34928.473302] PC is at 0xffffa1835a44
[34928.476771] LR is at 0x400a3c

offset of failing address in libc-2.17.so =   0xffffa1835a44 - 
0xffffa1760000 = 0xD5A44

from objdump of  libc-2.17.so:
00000000000d5a30 <mmap>:
    d5a30:       93407c42        sxtw    x2, w2
    d5a34:       93407c63        sxtw    x3, w3
    d5a38:       93407c84        sxtw    x4, w4
    d5a3c:       d2801bc8        mov     x8, #0xde 
// #222
    d5a40:       d4000001        svc     #0x0
    d5a44:       b140041f        cmn     x0, #0x1, lsl #12
    d5a48:       54000048        b.hi    d5a50 <mmap+0x20>

and from objdump of test (hugetlb_test_stack):
00000000004008dc <main>:
   [...]
   400a30:       b940f7a4        ldr     w4, [x29,#244]
   400a34:       d2800005        mov     x5, #0x0 
// #0
   400a38:       97ffff3e        bl      400730 <mmap@plt>
   400a3c:       f9006fa0        str     x0, [x29,#216]

from core dump:
Program terminated with signal 11, Segmentation fault.
#0  0x0000ffffa1835a44 in ?? ()

(gdb) x/g 0x0000ffffa1835a44
0xffffa1835a44: Cannot access memory at address 0xffffa1835a44

~Pratyush


[1] 
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/stack_grow_into_huge.c

[2]
---------------------------------------------------------------------------
# cat hugetlb_test_stack.c

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>

#define ALIGN(x, a)     (((x) + (a) - 1) & ~((a) - 1))
#define PALIGN(p, a)    ((void *)ALIGN((unsigned long)(p), (a)))

int main(int argc, char *argv[])
{
         long hpage_size;;
         void *stack_address, *mmap_address, *mmap_ret_address;
         struct rlimit r;
         int fd;

         if (argc < 3) {
                 printf("Pass hugetlb page size as 1st argument and
path of a file in hugetlbfs as second argument\n");
                 exit(0);
         }
         hpage_size = atol(argv[1]);

         printf("hpage_size is %lx\n", hpage_size);
         printf("file path is %s\n", argv[2]);
         r.rlim_cur = RLIM_INFINITY;
         r.rlim_max = RLIM_INFINITY;
         setrlimit(RLIMIT_STACK, &r);

         fd = open(argv[2], O_RDWR);

         if (fd < 0) {
                 printf("open() failed: %s\n", strerror(errno));
                 return -1;
         }

         stack_address = alloca(0);
         mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);

         printf("Address to be mapped is %p\n", mmap_address);
         mmap_ret_address = mmap(mmap_address, hpage_size, 
PROT_READ|PROT_WRITE,
                                 MAP_FIXED|MAP_SHARED, fd, 0);
         printf("mmap_ret_address is %p\n", mmap_ret_address);
}

# gcc -o hugetlb_test_stack hugetlb_test_stack.c
# ls /sys/kernel/mm/hugepages/
hugepages-2048kB  hugepages-524288kB

I used 524288KB page size file for test. It did not reproduces with 
2048K page size.

# echo 5 > /sys/kernel/mm/hugepages/hugepages-524288kB/nr_hugepages
#  mount -t hugetlbfs none /mnt/hugetlbfs -o pagesize=524288K
# touch /mnt/hugetlbfs/test
# ./hugetlb_test_stack 536870912  /mnt/hugetlbfs/test
---------------------------------------------------------------------------

[3]
[34928.425865] hugetlb_test_st[10566]: unhandled level 2 translation 
fault (11) at 0xffffa1835a44, esr 0x82000006
[34928.435848] pgd = ffff8003c89eec00
[34928.439231] [ffffa1835a44] *pgd=00000043cfc70003, 
*pud=00000043cfc70003, *pmd=0000000000000000
[34928.447818]
[34928.449303] CPU: 1 PID: 10566 Comm: hugetlb_test_st Not tainted 
4.10.0-XXXXXX.aarch64 #1
[34928.457706] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene 
Mustang Board, BIOS 3.06.25 Oct 17 2016
[34928.467405] task: ffff8003c89b8000 task.stack: ffff800370294000
[34928.473302] PC is at 0xffffa1835a44
[34928.476771] LR is at 0x400a3c
[34928.479721] pc : [<0000ffffa1835a44>] lr : [<0000000000400a3c>] 
pstate: 80000000
[34928.487095] sp : 0000ffffc7384fd0
[34928.490400] x29: 0000ffffc7384fd0 x28: 0000000000000000
[34928.495685] x27: 0000000000000000 x26: 0000000000000000
[34928.500980] x25: 0000000000000000 x24: 0000000000000000
[34928.506265] x23: 0000000000000000 x22: 0000000000000000
[34928.511557] x21: 0000000000400770 x20: 0000000000000000
[34928.516841] x19: 0000000000000000 x18: 0000ffffc7384da0
[34928.522130] x17: 0000000000420048 x16: 0000ffffa1835a30
[34928.527414] x15: 00000000001815e7 x14: 0000ffffa194ffb8
[34928.532702] x13: ffffffffffffffff x12: 0000000000000013
[34928.537986] x11: 0000ffffc738f6de x10: 00000000ffffffff
[34928.543276] x9 : 0000000000400bd9 x8 : 00000000000000de
[34928.548559] x7 : 0000000000000000 x6 : 0000000000000000
[34928.553848] x5 : 0000000000000000 x4 : 0000000000000003
[34928.559131] x3 : 0000000000000011 x2 : 0000000000000003
[34928.564431] x1 : 0000000020000000 x0 : 0000ffffa0000000
[34928.569718]
