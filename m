From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jun 2011 21:49:49 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID
	on rollover
In-Reply-To: <20110608203615.GB13151@n2100.arm.linux.org.uk>
References: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
	<20110608200106.GA13151@n2100.arm.linux.org.uk>
	<20110608202323.GA4430@e102144-lin.cambridge.arm.com>
	<20110608203615.GB13151@n2100.arm.linux.org.uk>
Message-ID: <20110608204949.GA4713@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 09:36:15PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 08, 2011 at 09:23:23PM +0100, Will Deacon wrote:
> > On Wed, Jun 08, 2011 at 09:01:06PM +0100, Russell King - ARM Linux wrote:
> > > However, these patches are introducing a brand new race between the
> > > switch_mm code and the reset_context code.
> > > 
> > > With the new switch_mm() code, we switch TTBR0 to be the same as TTBR1.
> > > If we then receive an IPI for reset_context(), we will change TTBR0
> > > to point at a set of page tables which don't contain just global mappings.
> > > 
> > > After returning from reset_context(), we will resume switch_mm(), and
> > > change the ASID value with the page tables pointing to non-global
> > > mappings, violating the whole reason for the switch_mm() change.
> > 
> > Whilst this is a new race condition, it is analagous to the one we have
> > already and could be fixed at the same time.
> 
> Ok, I think we should revert the original patches then.  They were rushed
> in during the merge window, and as can be seen, rushing in patches because
> we _think_ they're right is never the correct thing to do - we've ended
> up with a completely broken situation as stuff now stands.

Seems a shame given that disabling interrupts during switch_mm would fix this,
but yes, reverting them is certainly better than having a broken kernel. I
think you just need to revert 6944/1 and 6943/1; the other two from that series
are fine to be left in.

> Let's take out these changes and sort it out properly - not only do we
> need to sort out these problems but we should also get rid of the
> __ARCH_WANT_INTERRUPTS_ON_CTXSW thing completely.  I have a patch which
> I've only tested on SA-1110 which does this so far, but it needs a little
> more work to clean up some stuff.

Could you post that code please? I can then rebase these patches against it for
future inclusion in mainline. Does the removal of
__ARCH_WANT_INTERRUPTS_ON_CTXSW mean that switch_mm will run with interrupts
disabled by default?

> So, we're weren't - and still aren't - ready for any of these changes.

Once the interrupt stuff is sorted out I can rebase the ASID stuff on top of it
and we should be ready to go.

Cheers,

Will
