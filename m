From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 10:12:17 -0700
Subject: [PATCH] ARM: autcpu12: Fix config check in autcpu12_init_late()
In-Reply-To: <1364016140.352883792@f399.i.mail.ru>
References: <1363988123.3728.45.camel@deadeye.wl.decadent.org.uk>
 <1364016140.352883792@f399.i.mail.ru>
Message-ID: <20130402171217.GE25867@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 09:22:20AM +0400, Alexander Shiyan wrote:
> > The 'CONFIG_' prefix is not implicit in IS_ENABLED().
> > 
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Cc: Alexander Shiyan <shc_work@mail.ru>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Paul Bolle <pebolle@tiscali.nl>
> > Cc: <stable@vger.kernel.org> # 3.8+
> > ---
> > Found by inspection.  This is not even compile-tested.
> > 
> > Ben.
> > 
> >  arch/arm/mach-clps711x/board-autcpu12.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
> > index f385847..8138523 100644
> > --- a/arch/arm/mach-clps711x/board-autcpu12.c
> > +++ b/arch/arm/mach-clps711x/board-autcpu12.c
> > @@ -158,7 +158,8 @@ static void __init autcpu12_init(void)
> >  
> >  static void __init autcpu12_init_late(void)
> >  {
> > -	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
> > +	if (IS_ENABLED(CONFIG_MTD_NAND_GPIO) &&
> > +	    IS_ENABLED(CONFIG_GPIO_GENERIC_PLATFORM)) {
> >  		/* We are need both drivers to handle NAND */
> >  		platform_device_register(&autcpu12_nand_pdev);
> >  	}
> 
> Oops. Right.
> And I think checks can be removed completely.

Seems reasonable -- there's no reason to hold off registering the device just
because the driver isn't enabled.

Who'll repost a patch to just remove the tests? Ben? Alexander?


-Olof
