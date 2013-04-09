From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 9 Apr 2013 08:07:37 +0000
Subject: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <20130408172936.GQ10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Monday, April 08, 2013 11:00 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; khilman at linaro.org; paul at pwsan.com;
> Nayak, Rajendra; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter
> for debugSS module control
> 
> Hi,
> 
> * hvaibhav at ti.com <hvaibhav@ti.com> [130304 03:40]:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Currently there is no clean mechanism to control debugSS module and
> > you have to always keep clocks enabled, either,
> >
> >     - By enabling it during boot as part of clk_init function.
> >     Or
> >     - By having HWMOD_INIT_NO_IDLE flag in hwmod data.
> >
> > Based on the discussion,
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg81771.html
> >
> > This patch introduces new kernel parameter "omap_debugss_en",
> > which will allow user to control debugSS module enable/disable
> > part during boot-time.
> 
> I suggest you just make this part into a standard DT only
> device driver. That way the command line parsing and clock
> enabling can happen the normal way.
> 

That?s good idea, as we are moving towards DT only boot support.
Also, are you suggesting to have both command-line param and DT
Property for this?


> Is there any reason why this could not be a loadable module?
> 

Because we want to keep it enabled before late_initcall. As part of late_initcall
Clock/hwmod framework will start disabling unused modules, which will impact the
Debugs as well. Consider the case where this debugss is loaded as a module, the user
Will loose the JTAG connection until the module is loaded; and once module is
Loaded, he has to again re-connect to the debugss.


With only DT option the code will look like below, is this what you also have in your mind -

arch/arm/boot/dts/am33xx.dtsi:

	debugss: debugss at 4b000000 {
		compatible = "ti,debugss";
		ti,hwmods = "debugss";
		reg = <0x4b000000 1000000>;
		status = "disabled";	/* User need to enable it if he need JTAG connectivity*/
	};


arch/arm/mach-omap2/debugss.c:

	static int __init _omap2_debugss_enable(void)
	{
		struct device_node *np;
	
		np = of_find_matching_node(oh_name);
		if (!node || ! of_device_is_available()) {
			pr_err("debugss device is not found\n");
			return -ENODEV;
		}
		...
		hwmod lookup./setup/enable along with optional clock enable.
		...

	}
	device_initcall(_omap2_debugss_enable);

Thanks,
Vaibhav
