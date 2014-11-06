From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Nov 2014 16:21:35 +0100
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141106155823.213f8811@free-electrons.com>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141106155823.213f8811@free-electrons.com>
Message-ID: <20141106152135.GC4974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> > index 6478626..894974b 100644
> > --- a/arch/arm/mach-mvebu/board-v7.c
> > +++ b/arch/arm/mach-mvebu/board-v7.c
> > @@ -206,7 +206,6 @@ static const char * const armada_370_xp_dt_compat[] = {
> >  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
> >  	.l2c_aux_val	= 0,
> >  	.l2c_aux_mask	= ~0,
> > -	.smp		= smp_ops(armada_xp_smp_ops),
> >  	.init_machine	= mvebu_dt_init,
> >  	.init_irq       = mvebu_init_irq,
> >  	.restart	= mvebu_restart,
> 
> There is a very good reason to keep this .smp initialization. The
> Device Tree for Armada XP used to *not* have the enable-method
> property, since the SMP enable-method binding did not exist at the
> time we introduced the Armada XP SMP support. Therefore, if we want to
> keep backward compatibility with the old Armada XP DTs and continue to
> have SMP support working with those, we need to keep this .smp
> initialization essentially forever.

Hi Thomas

Any idea what order things are done?

Would it be possible to remove the .smp entry, and then in
mvebu_dt_init() check if there are smp operations set. If not, then
set them to armada_xp_smp_ops?

    Andrew
