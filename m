From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Mar 2017 13:18:06 +0100
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <4796e7df-808c-b07b-209d-ea02ecf74888@redhat.com>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
 <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
 <20170324181652.GC10746@leverpostej>
 <4796e7df-808c-b07b-209d-ea02ecf74888@redhat.com>
Message-ID: <20170327121806.GA12578@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 05:44:58PM +0530, Pratyush Anand wrote:
> On Friday 24 March 2017 11:46 PM, Mark Rutland wrote:
> >>>For your report, it's not clear to me what's going on. Did you take the
> >>>/proc/pid/maps data from teh exact same process that the segfault
> >>>occurred in? and/or did you disable ASLR?
> >>Yes, it is from the same process.
> >That is troubling; I cannot explain that.
> 
> Can you pl try in an infinite loop for some time and see if
> "SIGSEGV" is received in any of the run at your end.

After several thousand runs, I see a few unhandled translations faults
(all for address 0) in dmesg. 

I suspect that in this case, the hugepage has clobbered some
datastructure used shortly after the return from the syscall, and we end
up dereferencing a pointer that's been replaced with zeroes.

> >>Since, I was not able to reproduce with gdb so, I had inserted a
> >>scanf() just before mmap() and then had read /proc/pid/maps.
> >That might be because GDB disables ASLR by default. Did you re-enable
> >ASLR within GDB with:
> >
> >	set disable-randomization off
> >
> >If not, could you give that a go?
> 
> Yes, with ASLR enabled, it reproduced in GDB as well. I do not see
> SIGILL, it is SIGSEGV there too.

So far, I have not managed to trigger a single SIGSEGV while running
under GDB.

However, I have a theory that could explain that. I suspect that my
toolchain has built the binary with an executable stack, while yours has
not. Linux automatically sets READ_IMPLIES_EXEC for binaries with
executable stacks, which IIUC would implicitly make the mmap RWX rather
than RW.

So in my case, the huge page is executable, and I get a SIGILL when
trying to execute from it. In your case, the huge page is not
executable, so you get a SIGSEGV.

Looking at your report below:

> Mapped address spaces:
> 
>           Start Addr           End Addr       Size     Offset objfile
>             0x400000           0x410000    0x10000        0x0
> /home/panand/work/hugetlb/hugetlb_test_stack
>             0x410000           0x420000    0x10000        0x0
> /home/panand/work/hugetlb/hugetlb_test_stack
>             0x420000           0x430000    0x10000    0x10000
> /home/panand/work/hugetlb/hugetlb_test_stack

All the entries from here ...

>       0xffffada70000     0xffffadbd0000   0x160000        0x0
> /usr/lib64/libc-2.17.so
>       0xffffadbd0000     0xffffadbe0000    0x10000   0x150000
> /usr/lib64/libc-2.17.so
>       0xffffadbe0000     0xffffadbf0000    0x10000   0x160000
> /usr/lib64/libc-2.17.so
>       0xffffadc10000     0xffffadc20000    0x10000        0x0 [vvar]
>       0xffffadc20000     0xffffadc30000    0x10000        0x0 [vdso]
>       0xffffadc30000     0xffffadc50000    0x20000        0x0
> /usr/lib64/ld-2.17.so
>       0xffffadc50000     0xffffadc60000    0x10000    0x10000
> /usr/lib64/ld-2.17.so
>       0xffffadc60000     0xffffadc70000    0x10000    0x20000

... to here ...

> /usr/lib64/ld-2.17.so
>       0xffffcb1d0000     0xffffcb200000    0x30000        0x0 [stack]
> (gdb) c
> Continuing.
> hpage_size is 20000000
> file path is /mnt/hugetlbfs/test
> stack_address is 0xffffcb1facc0
> Address to be mapped is 0xffffa0000000

... are clobbered by this map, which will cover the range:
	
	0xffffa0000000-0xFFFFC0000000

> Program received signal SIGSEGV, Segmentation fault.
> 0x0000ffffadb45a44 in __mmap (addr=<optimized out>, len=536870912,
> prot=3, flags=17, fd=7, offset=0)

That address falls within libc-2.17.so, which is clobbered by the mmap.

Do you happen to know how to parse that 'prot=3' in the SEGV report? I'm
guessing that means RW, !X.

Thanks,
Mark.
