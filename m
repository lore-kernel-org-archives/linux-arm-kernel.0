From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 08 Jul 2014 09:19:17 +0200
Subject: socfpga/sockit ethernet problems
In-Reply-To: <20140707214340.GA29061@amd.pavel.ucw.cz>
References: <20140507104518.GB18139@amd.pavel.ucw.cz>
 <20140703093548.GA9937@amd.pavel.ucw.cz>
 <1404764751.14294.3.camel@linux-builds1>
 <20140707214340.GA29061@amd.pavel.ucw.cz>
Message-ID: <737g3ogvwq.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

Pavel Machek <pavel@denx.de> writes:
> Hi!
>
>> > I made this, but ethernet problems I currently see are not frequent
>> > enough to allow easy debugging. If link takes long to  estabilish for
>> > you, could you test the patch below?
>
>> > +static int ksz9021rn_phy_fixup(struct phy_device *phydev)
>> > +{
>> > +        if (IS_BUILTIN(CONFIG_PHYLIB)) {
>> > +		printk("------------- running phy fixup\n");
>> > +
>> > +                /* min rx data delay */
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
>> > +			  0x8000 | MICREL_KSZ9021_RGMII_RX_DATA_PAD_SKEW);
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0x0000);
>> > +
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
>> > +			  0x8000 | MICREL_KSZ9021_RGMII_TX_DATA_PAD_SKEW);
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0x0000);
>> > +
>> > +                /* max rx/tx clock delay, min rx/tx control delay */
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
>> > +			  0x8000 | MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SKEW);
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0xf0f0);
>> > +                phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
>> > +			  MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SKEW);
>> > +        }
>> > +
>> > +        return 0;
>> > +}
>> > +
>> 
>> All of this stuff is not needed as it's already taken care of by the
>> Micrel phy driver. The clock skew values are now represented in the DTS.
>> Please look at:
>> 
>> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
>
> Aah, thanks for the pointer. 
>
> At least socfpga_cyclone5_socrates.dts is in the mainline, but it does
> not have any skew configuration. That may explain why the board seems
> to have problems with ethernet... (or not).
>

The socrates does not have these values, because it does not have a
Micrel PHY...

> Are there suitable default values?
>
> u-boot uses these defaults:
>
> include/configs/socfpga_common.h:#define CONFIG_KSZ9021_CLK_SKEW_VAL
> 0xf0f0
> include/configs/socfpga_common.h:#define CONFIG_KSZ9021_DATA_SKEW_VAL
> 0x0
>
> ...that should correspond to txc-skew-ps == rxc-skew-ps == 3000, all
> other skew values == 0?
>
> Could someone with socrates board and network problems test if this
> makes any difference?
>

...so, would this even apply to the socrates then?

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
