From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 05:25:39 +0200
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <20120522031709.GH8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-8-git-send-email-richard.zhao@freescale.com>
 <20120522031709.GH8140@S2101-09.ap.freescale.net>
Message-ID: <201205220525.39660.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Apart from my comments below, we really need to know Rob and Grant's
> opinion on this.

Hm ... so why don't you actually write per-board driver ? :-) That'd handle 
every single board very well, you'd configure the GPIOs there, every single 
additional necessary thing that has to be configured would sink there too etc.

> On Mon, May 21, 2012 at 05:23:52PM +0800, Richard Zhao wrote:
> > Sometimes, boards have gpios that don't own by any driver or owner
> > by a generic driver that don't like hacks. Such gpios is normally
> > output and need setup once on boot. So I introduce the config-on-boot
> > gpios.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |    7 ++++++
> >  arch/arm/mach-imx/mach-imx6q.c        |   35
> >  +++++++++++++++++++++++++++++++++ 2 files changed, 42 insertions(+), 0
> >  deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > b/arch/arm/boot/dts/imx6q-sabrelite.dts index e0ec929..1dd2261 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -17,6 +17,13 @@
> > 
> >  	model = "Freescale i.MX6 Quad SABRE Lite Board";
> >  	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> > 
> > +	config-on-boot {
> > +		output-gpios = <
> > +				&gpio3 22 0>;	/* vbus reset */
> > +		output-gpio-values = <
> > +				1>;		/* vbus reset */
> > +	};
> > +
> 
> So it looks like something not specific to imx board but generic to
> other boards.  If so, we may need to come up with a generic binding
> document for this.
> 
> Is this only used to configure output pin?  Will there be any pin that
> needs to be configured as input but not owned by any driver?  Hopefully
> not.
> 
> >  	memory {
> >  	
> >  		reg = <0x10000000 0x40000000>;
> >  	
> >  	};
> > 
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c
> > b/arch/arm/mach-imx/mach-imx6q.c index b47e98b..577cf19 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -19,6 +19,7 @@
> > 
> >  #include <linux/irqdomain.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > 
> > +#include <linux/of_gpio.h>
> > 
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pinctrl/machine.h>
> > 
> > @@ -113,6 +114,38 @@ static void __init imx6q_sabrelite_init(void)
> > 
> >  	imx6q_sabrelite_cko1_setup();
> >  
> >  }
> > 
> > +static void __init imx6q_config_on_boot(void)
> 
> Do you intend to make this function non-gpio-config only.  Otherwise,
> we may need to have "gpio" in the function name, as well as the
> "config-on-boot" node name.
> 
> Also, if we define the binding as generic one, we may need to find a
> common place to implement the function.
> 
> > +{
> > +	struct device_node *np;
> > +	struct property *pp;
> > +	int cnt, len, i;
> > +	int gpio;
> > +
> > +	np = of_find_node_by_path("/config-on-boot");
> > +	if (!np)
> > +		return;
> > +	cnt = of_gpio_named_count(np, "output-gpios");
> > +	pp = of_find_property(np, "output-gpio-values", &len);
> > +	if (!pp || cnt != len / sizeof(u32)) {
> > +		pr_err("Invalid config-on-boot gpios!\n");
> > +		of_node_put(np);
> > +		return;
> > +	}
> > +	for (i = 0; i < cnt; i++) {
> > +		gpio = of_get_named_gpio(np, "output-gpios", i);
> > +		if (gpio_is_valid(gpio))
> > +			gpio_request_one(gpio, GPIOF_OUT_INIT_HIGH,
> > +					"config-on-boot");
> 
> So all the gpios will use the same name.
> 
> And doesn't the reset generally need a pulse or edge signal, e.g. pull
> down for a msec and pull up?
> 
> Regards,
> Shawn
> 
> > +	}
> > +
> > +	of_node_put(np);
> > +}
> > +
> > +static void __init imx6q_post_populate(void)
> > +{
> > +	imx6q_config_on_boot();
> > +}
> > +
> > 
> >  static void __init imx6q_init_machine(void)
> >  {
> >  
> >  	/*
> > 
> > @@ -126,6 +159,8 @@ static void __init imx6q_init_machine(void)
> > 
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > 
> > +	imx6q_post_populate();
> > +
> > 
> >  	imx6q_pm_init();
> >  
> >  }

Best regards,
Marek Vasut
