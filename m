From: panand@redhat.com (Pratyush Anand)
Date: Sat, 25 Mar 2017 17:44:58 +0530
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <20170324181652.GC10746@leverpostej>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
 <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
 <20170324181652.GC10746@leverpostej>
Message-ID: <4796e7df-808c-b07b-209d-ea02ecf74888@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 March 2017 11:46 PM, Mark Rutland wrote:
>>> For your report, it's not clear to me what's going on. Did you take the
>>> /proc/pid/maps data from teh exact same process that the segfault
>>> occurred in? and/or did you disable ASLR?
>> Yes, it is from the same process.
> That is troubling; I cannot explain that.

Can you pl try in an infinite loop for some time and see if "SIGSEGV" is 
received in any of the run at your end.

# while [[ 1 ]]; do  ./hugetlb_test_stack 536870912 
/mnt/hugetlbfs/test;done

>
>> Since, I was not able to reproduce with gdb so, I had inserted a
>> scanf() just before mmap() and then had read /proc/pid/maps.
> That might be because GDB disables ASLR by default. Did you re-enable
> ASLR within GDB with:
>
> 	set disable-randomization off
>
> If not, could you give that a go?

Yes, with ASLR enabled, it reproduced in GDB as well. I do not see 
SIGILL, it is SIGSEGV there too.

(gdb) set disable-randomization off
(gdb) b main
Breakpoint 1 at 0x400884
(gdb) r
Starting program: /home/panand/work/hugetlb/./hugetlb_test_stack 
536870912 /mnt/hugetlbfs/test

Breakpoint 1, 0x0000000000400884 in main ()
(gdb) info proc mappings
process 2949
Mapped address spaces:

           Start Addr           End Addr       Size     Offset objfile
             0x400000           0x410000    0x10000        0x0 
/home/panand/work/hugetlb/hugetlb_test_stack
             0x410000           0x420000    0x10000        0x0 
/home/panand/work/hugetlb/hugetlb_test_stack
             0x420000           0x430000    0x10000    0x10000 
/home/panand/work/hugetlb/hugetlb_test_stack
       0xffffada70000     0xffffadbd0000   0x160000        0x0 
/usr/lib64/libc-2.17.so
       0xffffadbd0000     0xffffadbe0000    0x10000   0x150000 
/usr/lib64/libc-2.17.so
       0xffffadbe0000     0xffffadbf0000    0x10000   0x160000 
/usr/lib64/libc-2.17.so
       0xffffadc10000     0xffffadc20000    0x10000        0x0 [vvar]
       0xffffadc20000     0xffffadc30000    0x10000        0x0 [vdso]
       0xffffadc30000     0xffffadc50000    0x20000        0x0 
/usr/lib64/ld-2.17.so
       0xffffadc50000     0xffffadc60000    0x10000    0x10000 
/usr/lib64/ld-2.17.so
       0xffffadc60000     0xffffadc70000    0x10000    0x20000 
/usr/lib64/ld-2.17.so
       0xffffcb1d0000     0xffffcb200000    0x30000        0x0 [stack]
(gdb) c
Continuing.
hpage_size is 20000000
file path is /mnt/hugetlbfs/test
stack_address is 0xffffcb1facc0
Address to be mapped is 0xffffa0000000

Program received signal SIGSEGV, Segmentation fault.
0x0000ffffadb45a44 in __mmap (addr=<optimized out>, len=536870912, 
prot=3, flags=17, fd=7, offset=0)
     at ../ports/sysdeps/unix/sysv/linux/aarch64/mmap.c:29
29        return (__ptr_t) INLINE_SYSCALL (mmap, 6, addr, len, prot, 
flags, fd, offset);
(gdb)

~Pratyush
