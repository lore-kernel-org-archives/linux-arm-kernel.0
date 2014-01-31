From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 31 Jan 2014 11:46:44 +0100
Subject: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP
 SoCs
In-Reply-To: <20140126083210.2998ef12@skate>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
 <20140126083210.2998ef12@skate>
Message-ID: <20140131104643.GC10250@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 08:32:10AM +0100, Thomas Petazzoni wrote:
> Dear Simon Guinot,

Hi Thomas,

> 
> On Tue, 14 Jan 2014 15:50:06 +0100, Simon Guinot wrote:
> 
> > +			if (hpriv->hp_flags & MV_HP_FIX_LP_PHY_CTL) {
> > +				void __iomem *lp_phy_addr =
> > +					mv_ap_base(link->ap) + LP_PHY_CTL;
> > +				/*
> > +				 * Set PHY speed according to SControl speed.
> > +				 */
> > +				if ((val & 0xf0) == 0x10)
> > +					writelfl(0x7, lp_phy_addr);
> > +				else
> > +					writelfl(0x227, lp_phy_addr);
> > +			}
> 
> I think we could do a little bit better than these magical values.
> 
> The datasheet says:
> 
>  * bits 12:9, PIN_PHY_GEN_RX. Value 0x0 => 1.5 Gbps, value 0x1 => 3 Gbps
>  * bits 8:5, PIN_PHY_GEN_TX. Value 0x0 => 1.5 Gbps, value 0x1 => 3 Gbps
>  * bit 2, PIN_PU_TX. Value 0x0 => Power down, value 0x1 => Power up.
>  * bit 1, PIN_PU_RX. Value 0x0 => Power down, value 0x1 => Power up.
>  * bit 0, PIN_PU_PLL. Value 0x0 => Power down, value 0x1 => Power up.

I missed this section in the datasheet...

> 
> So maybe something like:
> 
> #define PIN_PHY_GEN_1_5		0
> #define PIN_PHY_GEN_3		1
> 
> #define PIN_PHY_GEN_RX(gen)	((gen) << 9)
> #define PIN_PHY_GEN_TX(gen)	((gen) << 5)
> #define PIN_PU_TX		BIT(2)
> #define PIN_PU_RX		BIT(1)
> #define PIN_PU_PLL		BIT(0)
> 
> 
> 		u32 sata_gen;
> 
> 		if ((val & 0xf0) == 0x10)
> 			sata_gen = PIN_PHY_GEN_1_5;
> 		else
> 			sata_gen = PIN_PHY_GEN_3;
> 
> 		writelfl(PIN_PHY_GEN_RX(sata_gen) |
> 			 PIN_PHY_GEN_TX(sata_gen) |
> 			 PIN_PU_TX | PIN_PU_RX | PIN_PU_PLL,
> 			 lp_phy_addr);

Yes, it is much more understandable.

> 
> 
> > +	/*
> > +	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
> > +	 * updated in the LP_PHY_CTL register.
> > +	 */
> > +	if (pdev->dev.of_node &&
> > +		of_device_is_compatible(pdev->dev.of_node,
> > +					"marvell,armada-370-xp-sata"))
> 
> Testing whether pdev->dev.of_node is not NULL does not seems to be
> useful. A quick read of of_device_is_compatible() and the function it's
> calling seem to indicate that of_device_is_compatible will return false
> if the passed struct device_node * is NULL.

I see.

It seems to me, you already have a patch ready to send. Isn't it ?
Or do you want me to do the update ?

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/1e4dc2f0/attachment.sig>
