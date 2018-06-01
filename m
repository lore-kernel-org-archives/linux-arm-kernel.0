From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 1 Jun 2018 11:42:14 +0100
Subject: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
In-Reply-To: <20180601102913.ougz2vshzzttvuaj@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
 <20180515121921.GN7753@e103592.cambridge.arm.com>
 <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
 <20180516090121.GQ7753@e103592.cambridge.arm.com>
 <20180601102913.ougz2vshzzttvuaj@lakrids.cambridge.arm.com>
Message-ID: <20180601104214.GE22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 11:29:13AM +0100, Mark Rutland wrote:
> On Wed, May 16, 2018 at 10:01:32AM +0100, Dave Martin wrote:
> > On Tue, May 15, 2018 at 05:33:52PM +0100, Mark Rutland wrote:
> > > On Tue, May 15, 2018 at 01:19:26PM +0100, Dave Martin wrote:
> > > > On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> > > > > Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> > > > > to catch that kind of thing -- I could restore that.
> > > > 
> > > > IIUC:
> > > > 
> > > > 	if (0) {
> > > > 		BUILD_BUG_ON(1);
> > > > 	}
> > > > 
> > > > can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
> > > > in most of the SVE support code.
> > > 
> > > We already rely on BUILD_BUG() not firing in paths that can be trivially
> > > optimized away. e.g. in the cmpxchg code.
> > 
> > Fair enough.  I had been unsure on this point.
> > 
> > If you want to put a BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM64_SVE)) in
> > sve_user_enable() and build with CONFIG_ARM64_SVE=n to check it works,
> > then I'd be fine with that.
> > 
> > This doesn't capture the runtime part of the condition, but it's better
> > than nothing.
> 
> For the moment, I've kept the stubs, but placed a BUILD_BUG() in each,
> as per the above rationale. 
> 
> We generally do that rather than than BUILD_BUG_ON(!IS_ENABLED(...)) in
> a common definition, and it's more in keeping with the other stubs in
> <asm/fpsimd.h>.

OK, fine by me.

> > > > > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > > > > index 088940387a4d..79a81c7d85c6 100644
> > > > > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > > > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > > > > > >  	__sve_free(task);
> > > > > > >  }
> > > > > > >  
> > > > > > > -
> > > > > > 
> > > > > > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > > > > > trivial).
> > > > > 
> > > > > I'll assume that Ack stands regardless. :)
> > > > 
> > > > Actually, I was just commenting on the deleted blank line... 
> > > 
> > > Ah. I've restored that now.
> > 
> > I meant Ack to the deletion.  It looks like the blank line was
> > spuriously introduced in the first place.  But it doesn't hugely matter
> > either way.
> 
> Ok. I've dropped that for now to minimize the potential for conflicts,
> but we can clean this up later.

No big deal either way.

Cheers
---Dave
