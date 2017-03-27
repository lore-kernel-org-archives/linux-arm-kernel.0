From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Mar 2017 18:45:10 +0100
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <dfddf8fa-6e61-9d94-46ef-34bad1c8c632@redhat.com>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
 <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
 <20170324181652.GC10746@leverpostej>
 <4796e7df-808c-b07b-209d-ea02ecf74888@redhat.com>
 <20170327121806.GA12578@leverpostej>
 <dfddf8fa-6e61-9d94-46ef-34bad1c8c632@redhat.com>
Message-ID: <20170327174510.GC13752@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 06:50:53PM +0530, Pratyush Anand wrote:
> Hi Mark,
> 
> Thanks a lot for your explanations!!
> 
> On Monday 27 March 2017 05:48 PM, Mark Rutland wrote:
> >So far, I have not managed to trigger a single SIGSEGV while running
> >under GDB.
> >
> >However, I have a theory that could explain that. I suspect that my
> >toolchain has built the binary with an executable stack, while yours has
> >not. Linux automatically sets READ_IMPLIES_EXEC for binaries with
> >executable stacks, which IIUC would implicitly make the mmap RWX rather
> >than RW.
> >
> >So in my case, the huge page is executable, and I get a SIGILL when
> >trying to execute from it. In your case, the huge page is not
> >executable, so you get a SIGSEGV.
> 
> Yes, your theory seems  convincing.
> I passed PROT_EXEC as well along with PROT_READ|PROT_WRITE to
> mmap(),and then I received SIGILL.

Ok, I think that explains it, then.

I was a little confused by the PMD being NULL in your initial splat, but
from a look at the mmap() codepaths, we lazily fault in hugetlbfs
mappings unless explicitly asked to populate them.

So mmap would have cleared any existing mappings (leaving the PMD NULL), 
set up the VMA as RW, then returned without setting up the new mapping
inthe page tables. Since that clobbered libc, when we get back to
userspace we immediately take an instruction abort, and since we're not
supposed to have execute permission, we get a SEGV.

Thanks,
Mark.
