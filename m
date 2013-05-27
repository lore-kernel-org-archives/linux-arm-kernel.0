From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 27 May 2013 10:09:09 +0200
Subject: [PATCH v2] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <20130525200557.GO24476@game.jcrosoft.org>
References: <1369467542-25519-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20130525200557.GO24476@game.jcrosoft.org>
Message-ID: <20130527080909.GB2919@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 10:05:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:39 Sat 25 May     , Alexandre Belloni wrote:
> > Fixes:
> > arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
> > :(.text+0x1174): undefined reference to `mdiobus_write'
> > :(.text+0x1188): undefined reference to `mdiobus_write'
> > :(.text+0x119c): undefined reference to `mdiobus_write'
> > :(.text+0x11b0): undefined reference to `mdiobus_write'
> > arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
> > :(.init.text+0x1e34): undefined reference to `phy_register_fixup_for_uid'
> > 
> > when CONFIG_PHYLIB is not selected.

Signed-off-by missing.

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> > ---
> > Changes in v2:
> > 	use IS_BUILTIN
> > 	use CONFIG_PHYLIB and not CONFIG_PHY
> > 
> 
> I do not like this, I prefer we just drop the fixup by adding the dt support
> to the micrel phy as done for broadcom
> 

Yes it will be a better solution but we don't have it. Even if we add dt
support for micrel phy it won't go into 3.10 so it has to be fixed before the
release.

> if !PHYLIB just add an inline declaration of 
> phy_register_fixup_for_uid
> 
> so gcc will drop ksz9021rn_phy_fixup automatically
> 
> Best Regards,
> J.
> > 
> >  arch/arm/mach-at91/board-dt-sama5.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> > index 705305e..e9ce541 100644
> > --- a/arch/arm/mach-at91/board-dt-sama5.c
> > +++ b/arch/arm/mach-at91/board-dt-sama5.c
> > @@ -47,22 +47,24 @@ static int ksz9021rn_phy_fixup(struct phy_device *phy)
> >  #define GMII_ERCR	11
> >  #define GMII_ERDWR	12
> >  
> > -	/* Set delay values */
> > -	value = GMII_RCCPSR | 0x8000;
> > -	phy_write(phy, GMII_ERCR, value);
> > -	value = 0xF2F4;
> > -	phy_write(phy, GMII_ERDWR, value);
> > -	value = GMII_RRDPSR | 0x8000;
> > -	phy_write(phy, GMII_ERCR, value);
> > -	value = 0x2222;
> > -	phy_write(phy, GMII_ERDWR, value);
> > +	if (IS_BUILTIN(CONFIG_PHYLIB)) {
> > +		/* Set delay values */
> > +		value = GMII_RCCPSR | 0x8000;
> > +		phy_write(phy, GMII_ERCR, value);
> > +		value = 0xF2F4;
> > +		phy_write(phy, GMII_ERDWR, value);
> > +		value = GMII_RRDPSR | 0x8000;
> > +		phy_write(phy, GMII_ERCR, value);
> > +		value = 0x2222;
> > +		phy_write(phy, GMII_ERDWR, value);
> > +	}
> >  
> >  	return 0;
> >  }
> >  
> >  static void __init sama5_dt_device_init(void)
> >  {
> > -	if (of_machine_is_compatible("atmel,sama5d3xcm"))
> > +	if (of_machine_is_compatible("atmel,sama5d3xcm") && IS_BUILTIN(CONFIG_PHYLIB))
> >  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
> >  			ksz9021rn_phy_fixup);
> >  
> > -- 
> > 1.8.1.2
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
