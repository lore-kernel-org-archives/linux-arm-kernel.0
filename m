From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Mar 2014 10:37:19 +0000
Subject: [RFC PATCH 1/1] arm64: Add boot time configuration of
 Intermediate Physical Address size
In-Reply-To: <CAC8NTUVjMGKXWxVWqa0=CS0EDxRwD1yfB_VoMHE0FSOHD7dNeg@mail.gmail.com>
References: <1393830037-25499-1-git-send-email-mohun106@gmail.com>
 <1393830037-25499-2-git-send-email-mohun106@gmail.com>
 <CAC8NTUVjMGKXWxVWqa0=CS0EDxRwD1yfB_VoMHE0FSOHD7dNeg@mail.gmail.com>
Message-ID: <20140306103719.GB5202@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 06:06:07AM +0000, Radha Mohan wrote:
> Hi all,
> 
> Any comments?

[...]

> > diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> > index 2b0244d..642fec9 100644
> > --- a/arch/arm64/kvm/hyp-init.S
> > +++ b/arch/arm64/kvm/hyp-init.S
> > @@ -68,6 +68,13 @@ __do_hyp_init:
> >         msr     tcr_el2, x4
> >
> >         ldr     x4, =VTCR_EL2_FLAGS
> > +       /*
> > +        * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
> > +        * VTCR_EL2.
> > +        */
> > +       mrs     x5, ID_AA64MMFR0_EL1
> > +       ubfiz   x5, x5, #16, #3
> > +       orr     x4, x4, x5

Can you use BFI instead of UBFIZ + ORR?

Will
