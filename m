From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Nov 2017 13:41:54 +0000
Subject: [PATCH 00/23] KAISER: unmap most of the kernel from userspace
 page tables
In-Reply-To: <816a3491-3c2c-ec0a-810f-b593c25968f2@linux.intel.com>
References: <20171031223146.6B47C861@viggo.jf.intel.com>
 <20171102190106.GC22263@arm.com>
 <816a3491-3c2c-ec0a-810f-b593c25968f2@linux.intel.com>
Message-ID: <20171103134154.GB13499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:38:05PM -0700, Dave Hansen wrote:
> On 11/02/2017 12:01 PM, Will Deacon wrote:
> > On Tue, Oct 31, 2017 at 03:31:46PM -0700, Dave Hansen wrote:
> >> KAISER makes it harder to defeat KASLR, but makes syscalls and
> >> interrupts slower.  These patches are based on work from a team at
> >> Graz University of Technology posted here[1].  The major addition is
> >> support for Intel PCIDs which builds on top of Andy Lutomorski's PCID
> >> work merged for 4.14.  PCIDs make KAISER's overhead very reasonable
> >> for a wide variety of use cases.
> > I just wanted to say that I've got a version of this up and running for
> > arm64. I'm still ironing out a few small details, but I hope to post it
> > after the merge window. We always use ASIDs, and the perf impact looks
> > like it aligns roughly with your findings for a PCID-enabled x86 system.
> 
> Welcome to the party!
> 
> I don't know if you've found anything different, but there been woefully
> little code that's really cross-architecture.  The kernel task
> stack-mapping stuff _was_, but it's going away.  The per-cpu-user-mapped
> section stuff might be common, I guess.

I currently don't have anything mapped other than the trampoline page, so
I haven't had to do per-cpu stuff (yet). This will interfere with perf
tracing using SPE, but if that's the only thing that needs it then it's
a hard sell, I think.

> Is there any other common infrastructure that we can or should be sharing?

I really can't see anything. My changes are broadly divided into:

  * Page table setup
  * Exception entry/exit via trampoline
  * User access (e.g. get_user)
  * TLB invalidation
  * Context switch (backend of switch_mm)

which is all deeply arch-specific.

Will
