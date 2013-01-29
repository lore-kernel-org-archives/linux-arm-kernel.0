From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Jan 2013 15:32:21 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <51082C4E.5050903@gmail.com>
References: <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
Message-ID: <20130129203221.GG7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:08:46PM +0100, Sebastian Hesselbarth wrote:
> On 01/29/2013 08:42 PM, Simon Baatz wrote:
> >On Mon, Jan 28, 2013 at 07:48:24PM -0500, Jason Cooper wrote:
> >>On Mon, Jan 28, 2013 at 11:31:48PM +0100, Simon Baatz wrote:
> >>>Nothing special here. My config originally based on a Debian config
> >>>for a Kirkwood kernel.  Thus, amongst other drivers, mv643xx_eth is
> >>>build as a module and is loaded from an initrd.
> >>>Because all relevant drivers are loaded as modules, I need my
> >>>runit patch to boot at all.
> >>
> >>Let's back up.  If you config early printk and COMMON_CLK_DEBUG and a
> >>vanilla v3.8-rc5 with your current config, what happens?
> >
> >I thought it's clear what happens. "runit" is requested in the dts by
> >serial, spi, watchdog, nand, i2c.  Each of these are either not built
> >or built as a module in my config, except serial.
> 
> Simon,
> 
> it is clear what happens but just to blindly disable clock gating will
> not help here. What you are suffering are several issues not only one.

Agreed.

> >of_serial.c does the following in of_platform_serial_setup():
> >
> >	if (of_property_read_u32(np, "clock-frequency",&clk)) {
> >
> >		/* Get clk rate through clk driver if present */
> >		info->clk = clk_get(&ofdev->dev, NULL);
> >		if (IS_ERR(info->clk)) {
> >			dev_warn(&ofdev->dev,
> >				"clk or clock-frequency not defined\n");
> >			return PTR_ERR(info->clk);
> >		}
> >
> >		clk_prepare_enable(info->clk);
> >		clk = clk_get_rate(info->clk);
> >	}
> >
> >and since "clock-frequency" is still given in the standard DTS for
> >the IB-NAS 6210, it does not enable the clock.
> >Thus, no driver uses the clock, it gets disabled and the system locks
> >up.
> >The system boots when removing "clock-frequency" from the DTS.
> >
> >Which lead to two questions:
> >- Is it safe to remove "clock-frequency" now that we have the clocks
> >   in place?
> 
> Safe, as long as you replace it with the corresponding clocks=<&..> property.

For serial, this is in kirkwood.dtsi, so we are fine there.

> >- The behavior of of_serial.c looks strange to me, is this really the
> >desired behavior?
> 
> I guess it is, rely on clock-frequency because a lot of boards still use it.
> There was no clocks property in of_serial when we started with kirkwood and
> dove. I think we can switch now to clocks property which will also remove
> all hard coded occurrences of tclk frequency.
> 
> >For the "runit" clock, this means that any time you hit a
> >configuration that does not keep the clock enabled, the system will
> >lockup.  (We have gone through this more than once now. Especially,
> >this hits you hard when you try to support a new board and disable as
> >much as possible in the config/dts for a start...).
> 
> Well, if there is no device/driver using runit it should be safe to disable
> it. If there is a driver using it, we need a clocks property for it. And
> as you already stated, serial is using it. And you want serial in every
> minimal kernel, don't you?
> 
> >Thus, we should keep it enabled even if it is unused, which is
> >exactly the purpose of CLK_IGNORE_UNUSED if I understood this
> >correctly.
> 
> True, but only if it is that important that it should _never_ be gated.
> As long as it is 'only' used by peripheral devices, it should be safe
> to gate it.
> 
> >>Could you also please try kirkwood_defconfig and tell us if it boots?
> >
> >It is very easy to get my system to boot with a stock kernel. Just
> >build one of the drivers I use directly into the kernel and it boots
> >(up to the point where the gbe driver is loaded if built as a module,
> >of course).
> >
> >>>Here are my findings with various patches: ("non-DT" means booting
> >>>the IBNAS6210 with machine ID 1680 ???Marvell DB-88F6281-BP
> >>>Development Board???, which works reasonably well)
> >>>
> >>>3.8-rc5 + runit patch:
> >>>
> >>>DT: Hangs at boot (when loading mv643xx_eth)
> >>>non-DT: Boots ok
> >
> >In the DT case ge0 and ge1 are NULL, and thus, kirkwood_ge0[01]_init()
> >tries to enable NULL clocks, but not the gbe clocks. ->  The clocks
> >get disabled.
> >
> >As described in Sebastian's patch (and also found by Andrew some time
> >ago), this leads to a hanging system when loading the gbe driver.
> 
> If I got all your configs right, this DT case is with serial but no
> clocks property? All other runit "users" are _not_ built into the
> kernel? Maybe it is just a coincidence that it fails when loading
> eth but I guess it hangs because of runit getting gated while serial
> accessing it. When you replace serial's clock-frequency with clocks
> property to "runit" it shouldn't hang.
> 
> (Issue 1: gated runit clock hangs kernel due to serial access)

This can be fixed with a patch removing clock-frequency from all
kirkwood boards (dove, orion, etc?) I'll gin this up and add it to the
havoc ;-)

> >>>3.8-rc5 + runit patch + ge00/ge01 patch:
> >>>
> >>>DT: Boots ok
> >>>non-DT: Boots ok
> >
> >Since the clocks are found now and kept enabled, DT behaves the same
> >as non-DT.
> >
> >>>
> >>>3.8-rc5 + runit + Sebastians get smi clock patch (modified to use
> >>>legacy clock names):
> >>>
> >>>DT: Boots, but no MAC
> >>>non-DT: Boots ok
> >
> >This is the behavior originally found by Andrew. The clock patch
> >eliminates the lockup, but the hardware forgets its MAC address.
> >
> >>>
> >>>3.8-rc5 + runit + using Sebastians patch + clks not ticking at module
> >>>load:
> >>>
> >>>DT: Boots, but no MAC
> >>>non-DT: Boots, but no MAC
> 
> Ok, here my patch for smi clock enables gbe clock before accessing gbe
> registers.
> 
> (Issue 2: gated gbe clock hangs kernel due to smi access)

Here, I'm going to wait for Florian's mvmdio changes to settle out and
then readdress this.  My current understanding is that there will only
be one DT node for this.  iiuc, each board dts will have to say which
gate clocks to consume to prevent the mvmdio node in the dtsi from
consuming both unconditionally.

> >I think non-DT and DT gated clocks behave differently, since the
> >non-DT ones also enable/disable the PHY.  I explicitly removed the
> >clk_prepare_enable() from kirkwood_ge0[01]_init() in order to see if
> >this makes a difference.
> 
> True, DT gated clocks don't disable PHYs (and never will).
> 
> >(Which reminds me, that we wanted to implement the PHY enabling in
> >the driver.)
> >
> >Apparently, it does not make a difference.
> 
> Leaves Issue 3, gbe forgets about its MAC address when gated or powered
> down. That should be done with local-mac-address passed by DT enabled
> u-boot or any other (dirty) ATAG hack ;)

A patch to mv643xx_eth to pull this from DT should solve this.

thx,

Jason.
