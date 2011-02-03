From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 3 Feb 2011 17:34:40 +0530
Subject: [PATCH 1/2] omap3sdp: Fix regulator mapping for ads7846 TS
	controller
In-Reply-To: <20110203115613.GK23561@legolas.emea.dhcp.ti.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
	<1296732705-12818-2-git-send-email-rnayak@ti.com>
	<20110203115613.GK23561@legolas.emea.dhcp.ti.com>
Message-ID: <1dd409cd6dfe29ecf4459c6defc2bd8a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi at ti.com]
> Sent: Thursday, February 03, 2011 5:26 PM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; tony at atomide.com;
linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] omap3sdp: Fix regulator mapping for ads7846 TS
controller
>
> Hi,
>
> On Thu, Feb 03, 2011 at 05:01:44PM +0530, Rajendra Nayak wrote:
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
> > index d4e41ef..dcdc718 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -427,6 +427,10 @@ static struct twl4030_madc_platform_data
sdp3430_madc_data = {
> >  	.irq_line	= 1,
> >  };
> >
> > +/* ads7846 on SPI */
> > +static struct regulator_consumer_supply sdp3430_vaux3_supply =
> > +	REGULATOR_SUPPLY("vcc", "spi1.0");
> > +
> >  /*
> >   * Apply all the fixed voltages since most versions of U-Boot
> >   * don't bother with that initialization.
> > @@ -469,6 +473,8 @@ static struct regulator_init_data sdp3430_vaux3 =
{
> >  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> >  					| REGULATOR_CHANGE_STATUS,
> >  	},
> > +	.num_consumer_supplies		= 1,
> > +	.consumer_supplies		= &sdp3430_vaux3_supply,
> >  };
>
> this is not the expected way of using the regulator framework, you
> should have:
>
> static struct regulator_consumer_supply sdp3430_vaux3_supplies[] =
> 	{ REGULATOR_SUPPLY("vcc", "spi1.0"), },
> };
>
> ...
>
> .num_consume_supplies	= ARRAY_SIZE(sdp3430_vaux3_supplies),
> .consumer_supplies	= sdp3430_vaux3_supplies,

Yup, makes sense. Will fix that and repost.

>
> or something similar. (completely untested though).
>
> --
> balbi
