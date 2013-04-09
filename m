From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Apr 2013 09:34:59 -0700
Subject: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
Message-ID: <20130409163459.GJ10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [130409 01:12]:
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > 
> > I suggest you just make this part into a standard DT only
> > device driver. That way the command line parsing and clock
> > enabling can happen the normal way.
> > 
> 
> That?s good idea, as we are moving towards DT only boot support.
> Also, are you suggesting to have both command-line param and DT
> Property for this?
> 
> 
> > Is there any reason why this could not be a loadable module?
> > 
> 
> Because we want to keep it enabled before late_initcall. As part of late_initcall
> Clock/hwmod framework will start disabling unused modules, which will impact the
> Debugs as well. Consider the case where this debugss is loaded as a module, the user
> Will loose the JTAG connection until the module is loaded; and once module is
> Loaded, he has to again re-connect to the debugss.

It will get run before late_initcall if compiled in. Sounds
like there are no issues also make it work as a loadable module
as needed.
 
> With only DT option the code will look like below, is this what you also have in your mind -
> 
> arch/arm/boot/dts/am33xx.dtsi:
> 
> 	debugss: debugss at 4b000000 {
> 		compatible = "ti,debugss";
> 		ti,hwmods = "debugss";
> 		reg = <0x4b000000 1000000>;
> 		status = "disabled";	/* User need to enable it if he need JTAG connectivity*/
> 	};
>
>
> arch/arm/mach-omap2/debugss.c:
> 
> 	static int __init _omap2_debugss_enable(void)
> 	{
> 		struct device_node *np;
> 	
> 		np = of_find_matching_node(oh_name);
> 		if (!node || ! of_device_is_available()) {
> 			pr_err("debugss device is not found\n");
> 			return -ENODEV;
> 		}
> 		...
> 		hwmod lookup./setup/enable along with optional clock enable.
> 		...
> 
> 	}
> 	device_initcall(_omap2_debugss_enable);

It should be all standard device driver stuff. I'd make it just
regular module_platform_driver and only initialize it earlier if
compiled in.

Regards,

Tony
