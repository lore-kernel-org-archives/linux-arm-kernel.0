From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Wed, 14 Nov 2012 09:36:09 +0100
Subject: usb clock not found on imx27 when using dt
In-Reply-To: <50A2B0E8.2040603@yahoo.fr>
References: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
 <20121112075411.GO10369@pengutronix.de> <50A15966.8040204@yahoo.fr>
 <20121113073812.GZ10369@pengutronix.de> <50A2B0E8.2040603@yahoo.fr>
Message-ID: <20121114083609.GK10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 09:43:20PM +0100, trem wrote:
> On 13/11/12 08:38, s.hauer at pengutronix.de wrote:
> >>>Please investigate in using the chipidea driver. This will be the way
> >>>forward for i.MX.
> >>
> >>I use the chipidea driver for the usb.
> >>
> >>The main issue is that the chipidea driver don't found the clock :
> >>
> >>[    0.761693] imx_usb mxc-ehci.0: Failed to get clock, err=-2
> >>[    0.767620] imx_usb: probe of mxc-ehci.0 failed with error -2
> >>
> >>The driver ci13xxx_imx request the clock in the probe function
> >>in the following line:
> >>data->clk = devm_clk_get(&pdev->dev, NULL);
> >>calling: clk = clk_get(dev, id);
> >>calling: clk_get_sys(dev_id, con_id);
> >>calling: clk_find(dev_id, con_id);
> >>with dev_id = mxc-ehci.0 and con_id = NULL
> >>This last function fail to found a clock.
> >>
> >>In the function mx27_clocks_init, several mxc-ehci.0
> >>clocks are registered, but all with a con_id.
> >>
> >>So the function clk_find fails.
> >>
> >>As I'm not really sure of the dts, I don't know if the problem
> >>is in the dts or in the driver (maybe both).
> >
> >You have to register the lookups for the chipidea driver with
> >clk_register_clkdev(). The lookups are only what the name suggests:
> >lookups. They are no clocks by themselves. This means that you have to
> >add another lookup which matches the device name.
> 
> Thanks for this help, I've added three "clocks" for the chipidea driver :
> clk_register_clkdev(clk[usb_div], NULL, "mxc-ehci.0");

That does not fit to the chipidea driver. The third argument has to
match the device name (which is the output of dev_name), so in your case
it must be something like 'imx_usb.0' (I don't know if that's correct,
please just add a printk("%s\n", dev_name(dev)); to the chipidea driver
to get the correct string)

Other than that I suggest that you read through drivers/clk/clkdev.c
to see how clock lookups are matched against devices, specifically:

/*
 * Find the correct struct clk for the device and connection ID.
 * We do slightly fuzzy matching here:
 *  An entry with a NULL ID is assumed to be a wildcard.
 *  If an entry has a device ID, it must match
 *  If an entry has a connection ID, it must match
 * Then we take the most specific entry - with the following
 * order of precedence: dev+con > dev only > con only.
 */

/**
 * clk_register_clkdev - register one clock lookup for a struct clk
 * @clk: struct clk to associate with all clk_lookups
 * @con_id: connection ID string on device
 * @dev_id: format string describing device name
 *
 * con_id or dev_id may be NULL as a wildcard, just as in the rest of
 * clkdev.
 */


> [    0.754044] usbserial: USB Serial support registered for pl2303
> [    0.762611] Unhandled fault: external abort on non-linefetch (0x008) at 0xf4424100
> [    0.770227] Internal error: : 8 [#1] PREEMPT ARM
> [    0.774861] Modules linked in:
> [    0.777950] CPU: 0    Not tainted  (3.7.0-rc5-ge917a67 #2)
> [    0.783469] PC is at ci_hdrc_probe+0xcc/0x430
> [    0.787853] LR is at devm_kzalloc+0x4c/0x64

This seems to be something else. Are you sure you are beyond the clk_get
point? I can't imagine this given the lookup you registered.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
