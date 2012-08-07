From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Aug 2012 10:44:04 +0800
Subject: [PATCH 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <20120806144100.GD9329@pengutronix.de>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120803131230.GB23791@S2101-09.ap.freescale.net>
 <20120806144100.GD9329@pengutronix.de>
Message-ID: <20120807024401.GC24289@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 04:41:00PM +0200, Uwe Kleine-K?nig wrote:
> > > +		nand at bb000000 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +
> > > +			compatible = "fsl,imx35-nand", "fsl,imx25-nand";
> > > +			reg = <0xbb000000 0x2000>;
> > > +			interrupts = <33>;
> > > +			status = "disabled";
> > > +		};
> > 
> > Why nand device isn't under any bus but soc directly?
> I copied that from imx27.dtsi (where I introduced it myself before).
> It's not obvious to me which bus this is a part of from reading the
> hardware manual. Neither for i.MX27 nor i.MX35.

See i.MX35 RM "Chapter 17 External Memory Interface (EMI)",
"Memory Map/Register Definition" section.

> > > +	select HAVE_CAN_FLEXCAN if CAN
> > 
> > Move it to "config SOC_IMX35".
> hmm, do we want CAN_FLEXCAN to be selectable for machines that don't
> have can although they are based on i.MX35?
> 
I just recall it has been done by commit 610578a (ARM: imx: enable
flexcan on imx25, imx35, imx53, imx6q).

> > 
> > > +	select IMX_HAVE_PLATFORM_MXC_NAND
> > > +	select IMX_HAVE_PLATFORM_SPI_IMX
> > > +	select IMX_HAVE_PLATFORM_IMX2_WDT
> > 
> > These are unreasonable.
> These are needed to be able to select the corresponding drivers.
> 
The driver Kconfig needs fixing then.

> > 
> > > +	select PINCTRL
> > 
> > Need to select PINCTRL_IMX35 also?
> good idea.
> 
> > And they should be under "config SOC_IMX35".
> Even though currently the pincontrol driver isn't used for them?
>  
No pressure for now.  But in the end, it will be like that.

> > > +static const struct of_device_id imx35_of_mixed_devices_match[] __initconst = {
> > > +	{ /* END OF LIST */ }
> > > +};
> > > +
> > > +static void __init of_mixed_device_hook(void)
> > > +{
> > > +	struct device_node *np;
> > > +	const struct of_device_id *of_id;
> > > +
> > > +	np = of_find_matching_node(NULL, imx35_of_mixed_devices_match);
> > > +	if (np) {
> > > +		void (*func)(void);
> > > +
> > > +		of_id = of_match_node(imx35_of_mixed_devices_match, np);
> > > +		func = of_id->data;
> > > +		func();
> > > +	}
> > > +}
> > 
> > We have this on other imx DT machines for hooking the IOMUX setup done
> > in non-DT board files.  Since you have imx35 pinctrl support in place.
> > What is above hook for then?
> I need it to configure and export some gpios.
> 
Add it when you add users?  So that we can know it's really the only
way to go.

> > > +extern int mx35_clocks_init_dt(void);
> > 
> > It does not necessarily belong this driver.
> I cannot parse this sentence. Can you please try to explain again your
> objections here?
> 
I see neither the implementation nor the users for mx35_clocks_init_dt().

-- 
Regards,
Shawn
