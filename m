From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 8 Mar 2012 07:13:24 +0100
Subject: [PATCH 5/6] ARM: at91: add ram controller DT support
In-Reply-To: <4F57BDCE.1050708@gmail.com>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <1330718048-9314-5-git-send-email-plagnioj@jcrosoft.com>
 <4F57BDCE.1050708@gmail.com>
Message-ID: <20120308061324.GE27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5.h b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> > index a297a77..88e43d5 100644
> > --- a/arch/arm/mach-at91/include/mach/at91sam9x5.h
> > +++ b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> > @@ -55,11 +55,6 @@
> >  #define AT91SAM9X5_BASE_USART2	0xf8024000
> >  
> >  /*
> > - * System Peripherals
> > - */
> > -#define AT91SAM9X5_BASE_DDRSDRC0	0xffffe800
> > -
> > -/*
> >   * Base addresses for early serial code (uncompress.h)
> >   */
> >  #define AT91_DBGU	AT91_BASE_DBGU0
> > diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> > index 3e48b59..f86450d 100644
> > --- a/arch/arm/mach-at91/setup.c
> > +++ b/arch/arm/mach-at91/setup.c
> > @@ -315,12 +315,33 @@ static void at91_dt_rstc(void)
> >  	of_node_put(np);
> >  }
> >  
> > +static struct of_device_id ramc_ids[] = {
> > +	{ .compatible = "atmel,at91sam9260-sdramc" },
> > +	{ .compatible = "atmel,at91sam9g45-ddramc" },
> > +	{ /*sentinel*/ }
> > +};
> > +
> > +static void at91_dt_ramc(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_matching_node(NULL, ramc_ids);
> > +	if (!np)
> > +		panic("unable to find compatible ram conroller node in dtb\n");
> 
> You really can't boot if this fails? A WARN is better if it allows you
> to boot until at least your console is actually up.
if the restart is called you will have a oops so no it's a basic mandatory
device on at91

Best Regards,
J.
