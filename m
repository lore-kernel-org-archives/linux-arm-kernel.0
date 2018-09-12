From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 12 Sep 2018 12:50:28 +0100
Subject: [RFC PATCH] KVM: arm64: Treat FPEXC32_EL2 as a regular guest
 system register
In-Reply-To: <20180912112157.GA14516@e113682-lin.lund.arm.com>
References: <1536153553-28767-1-git-send-email-Dave.Martin@arm.com>
 <20180912101704.GA23874@e113682-lin.lund.arm.com>
 <20180912111624.GF17801@e103592.cambridge.arm.com>
 <20180912112157.GA14516@e113682-lin.lund.arm.com>
Message-ID: <20180912115027.GG17801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 01:21:57PM +0200, Christoffer Dall wrote:
> On Wed, Sep 12, 2018 at 12:16:26PM +0100, Dave Martin wrote:
> > On Wed, Sep 12, 2018 at 12:17:04PM +0200, Christoffer Dall wrote:

[...]

> > > I think the point was actually to avoid saving/restoring FPEXC32_EL2
> > > when VFP was being trapped to EL2
> > 
> > With what purpose in mind?
> 
> I don't think we thought it through very carefully but just considered
> FPEXC32_EL2 as part of the VFP state, but as you say, that doesn't
> really make sense.
> 
> I was just objecting to the statement that this is a bring-over from the
> 32-bit side, which confused me, and I don't think that's true.

[...]

> > We saved neither the trap (since the VFP registers needed switching
> > anyway) nor the FPEXC32_EL2 switch (since we had to do that at guest
> > entry).
> > 
> > I may have misunderstood something.
> > 
> 
> No, we just didn't look at it that carefully back then.
> 
> > 
> > I was somewhat guessing likely rationale, so if you can suggest a
> > way to reword this that reflects the situation better I'd be happy
> > to change it.
> 
> "Christoffer was being stupid..." ;)  It was just the way
> it was, I don't think there was a good rationale, but I don't think it
> helps to understand the change to provide guesswork either, so just
> remove it.

OK, I'll drop the bogus history lesson from this patch.  It doesn't
really add anything here, especially if it's wrong.

> > Thinking about it, I don't see why FPEXC32_EL2 can't be handled via
> > vcpu_load()/_put().  This register doesn't matter for the host, and
> > I can't see why we would need to switch it when going through hyp.
> > 
> 
> That's another good point, should be able to do that.

[...]

> > I confess to a certain amount of "according to the spirit of the
> > architecture it obviously ought to work this way" reasoning.
> > 
> > Following the trail of documentation isn't trivial, so it would
> > be good if someone could check that they can reach the same conclusion
> > about FPEXC32_EL2 having no effect on the host.
> > 
> 
> That was definitely my conclusion as well.

OK, sounds good.

[...]

> > > We can queue this for the next merge window.
> > > 
> > > Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> > 
> > Thanks, modulo the question of maybe moving this to the vcpu_load()/
> > _put() path.
> > 
> 
> Sure, I'll look at the next version as well if you send a new version.

Will do.  Can't say exactly when.

Cheers
---Dave
