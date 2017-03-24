From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 16:15:58 +0000
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
Message-ID: <20170324161558.GA10491@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 24, 2017 at 07:51:34PM +0530, Pratyush Anand wrote:
> # cat hugetlb_test_stack.c
> 
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/resource.h>
> #include <sys/stat.h>
> #include <sys/time.h>
> #include <sys/types.h>
> 
> #define ALIGN(x, a)     (((x) + (a) - 1) & ~((a) - 1))
> #define PALIGN(p, a)    ((void *)ALIGN((unsigned long)(p), (a)))
> 
> int main(int argc, char *argv[])
> {
>         long hpage_size;;
>         void *stack_address, *mmap_address, *mmap_ret_address;
>         struct rlimit r;
>         int fd;
> 
>         if (argc < 3) {
>                 printf("Pass hugetlb page size as 1st argument and
> path of a file in hugetlbfs as second argument\n");
>                 exit(0);
>         }
>         hpage_size = atol(argv[1]);
> 
>         printf("hpage_size is %lx\n", hpage_size);
>         printf("file path is %s\n", argv[2]);
>         r.rlim_cur = RLIM_INFINITY;
>         r.rlim_max = RLIM_INFINITY;
>         setrlimit(RLIMIT_STACK, &r);
> 
>         fd = open(argv[2], O_RDWR);
> 
>         if (fd < 0) {
>                 printf("open() failed: %s\n", strerror(errno));
>                 return -1;
>         }
> 
>         stack_address = alloca(0);
>         mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
> 
>         printf("Address to be mapped is %p\n", mmap_address);
>         mmap_ret_address = mmap(mmap_address, hpage_size,
> PROT_READ|PROT_WRITE,
>                                 MAP_FIXED|MAP_SHARED, fd, 0);
>         printf("mmap_ret_address is %p\n", mmap_ret_address);
> }
> 
> # gcc -o hugetlb_test_stack hugetlb_test_stack.c
> # ls /sys/kernel/mm/hugepages/
> hugepages-2048kB  hugepages-524288kB
> 
> I used 524288KB page size file for test. It did not reproduces with
> 2048K page size.
> 
> # echo 5 > /sys/kernel/mm/hugepages/hugepages-524288kB/nr_hugepages
> #  mount -t hugetlbfs none /mnt/hugetlbfs -o pagesize=524288K
> # touch /mnt/hugetlbfs/test
> # ./hugetlb_test_stack 536870912  /mnt/hugetlbfs/test

I modified the test to print out some additional information, and ran it under
GDB, with a breakpoint on main, and ASLR enabled with:

	set disable-randomization off

It's clear from the log that the test is simply blatting a number of
important mappings including libc, so I think this is simply a broken
test.

(gdb) run               
Starting program: /host/home/nanook/htfs 536870912 /mnt/hugetlbfs/test

Breakpoint 1, 0x0000000000400848 in main ()
(gdb) info proc mappings
process 1301
Mapped address spaces:

          Start Addr           End Addr       Size     Offset objfile
            0x400000           0x410000    0x10000        0x0 /host/home/nanook/htfs
            0x410000           0x420000    0x10000        0x0 /host/home/nanook/htfs
      0xffffa76f0000     0xffffa7700000    0x10000        0x0 
      0xffffa7700000     0xffffa7830000   0x130000        0x0 /host/lib/aarch64-linux-gnu/libc-2.19.so
      0xffffa7830000     0xffffa7840000    0x10000   0x130000 /host/lib/aarch64-linux-gnu/libc-2.19.so
      0xffffa7840000     0xffffa7850000    0x10000        0x0 [vvar]
      0xffffa7850000     0xffffa7860000    0x10000        0x0 [vdso]
      0xffffa7860000     0xffffa7880000    0x20000        0x0 /host/lib/aarch64-linux-gnu/ld-2.19.so
      0xffffa7880000     0xffffa7890000    0x10000    0x10000 /host/lib/aarch64-linux-gnu/ld-2.19.so
      0xffffd90f0000     0xffffd9120000    0x30000        0x0 [stack]
(gdb) continue          
Continuing.
hpage_size is 20000000
file path is /mnt/hugetlbfs/test
Range to be mapped is 0xffffa0000000-0xffffbfffffff
Currently main at 0x400840

Program received signal SIGILL, Illegal instruction.
0x0000ffffa77c4c04 in __mmap (addr=<optimized out>, len=536870912, prot=3, 
    flags=17, fd=3, offset=0)
    at ../ports/sysdeps/unix/sysv/linux/aarch64/mmap.c:29
29      ../ports/sysdeps/unix/sysv/linux/aarch64/mmap.c: No such file or directory.

Thanks,
Mark.
