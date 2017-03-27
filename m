From: panand@redhat.com (Pratyush Anand)
Date: Mon, 27 Mar 2017 18:50:53 +0530
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <20170327121806.GA12578@leverpostej>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
 <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
 <20170324181652.GC10746@leverpostej>
 <4796e7df-808c-b07b-209d-ea02ecf74888@redhat.com>
 <20170327121806.GA12578@leverpostej>
Message-ID: <dfddf8fa-6e61-9d94-46ef-34bad1c8c632@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks a lot for your explanations!!

On Monday 27 March 2017 05:48 PM, Mark Rutland wrote:
> So far, I have not managed to trigger a single SIGSEGV while running
> under GDB.
>
> However, I have a theory that could explain that. I suspect that my
> toolchain has built the binary with an executable stack, while yours has
> not. Linux automatically sets READ_IMPLIES_EXEC for binaries with
> executable stacks, which IIUC would implicitly make the mmap RWX rather
> than RW.
>
> So in my case, the huge page is executable, and I get a SIGILL when
> trying to execute from it. In your case, the huge page is not
> executable, so you get a SIGSEGV.

Yes, your theory seems  convincing.
I passed PROT_EXEC as well along with PROT_READ|PROT_WRITE to mmap(),and 
then I received SIGILL.

[...]

>> Program received signal SIGSEGV, Segmentation fault.
>> 0x0000ffffadb45a44 in __mmap (addr=<optimized out>, len=536870912,
>> prot=3, flags=17, fd=7, offset=0)
> That address falls within libc-2.17.so, which is clobbered by the mmap.
>
> Do you happen to know how to parse that 'prot=3' in the SEGV report? I'm
> guessing that means RW, !X.

Yes, it seems like that.

https://sourceware.org/git/?p=glibc.git;a=blob;f=bits/mman-linux.h;h=8126ce836947718576f09cd8f874a25b2c1340f7;hb=HEAD

~Pratyush
