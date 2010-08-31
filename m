From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 31 Aug 2010 09:44:15 -0700
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1283257116.28248.20.camel@e102109-lin.cambridge.arm.com>
References: <1282926826.5075.21.camel@m0nster>
	<1282927746.26355.74.camel@e102109-lin.cambridge.arm.com>
	<1282938790.5075.25.camel@m0nster>
	<1283257116.28248.20.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1283273055.11790.0.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-31 at 13:18 +0100, Catalin Marinas wrote:
> On Fri, 2010-08-27 at 20:53 +0100, Daniel Walker wrote:
> > On Fri, 2010-08-27 at 17:49 +0100, Catalin Marinas wrote:
> > 
> > > > So your saying it makes more sense to change the msm entry into the
> > > > default entry, and make the current default into the
> > > > ARM11MPCore/Cortex-A9 entry?
> > >
> > > So my opinion is to not add any specific msm code but make the
> > > __v7_setup skip the ACTLR bit setting. Then add an entry for Cortex-A9
> > > to set those bits.
> > >
> > 
> > how about this? Naming is of course flexible ..
> 
> I cc'ed Santosh as well. I'm not sure whether TI are using a Cortex-A9
> but with different manufacturer field (I suspect it's still 0x41).
> 
> > ScorpionMP does not have the SMP/nAMP and TLB ops broadcasting bits in
> > ACTLR. These bits are only used on ARM11MPCore and Cortex-A9 from arm.
> > This patch just makes it so no other arm core ends up getting these
> > bits set.
> > 
> > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> > 
> > ---
> >  arch/arm/mm/proc-v7.S |   26 +++++++++++++++++++++++++-
> >  1 files changed, 25 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 7aaf88a..e1b5492 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -189,13 +189,14 @@ cpu_v7_name:
> >   *     It is assumed that:
> >   *     - cache type register is implemented
> >   */
> > -__v7_setup:
> > +__v7_armmp_setup:
> 
> Maybe __v7_ca9mp_setup. Future MP processors from ARM may not need this
> bit set.

Ok ..

> > +__v7_armmp_proc_info:
> > +       .long   0x410f0000              @ Required ID value
> > +       .long   0xff0f0000              @ Mask for ID
> 
> We could restrict it to:
> 
> 	.long	0x410fc090
> 	.long	0xff0ffff0
> 
> Otherwise the patch looks fine. Thanks.

Ok, I'll add this.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
