From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Tue, 13 Nov 2012 08:38:12 +0100
Subject: usb clock not found on imx27 when using dt
In-Reply-To: <50A15966.8040204@yahoo.fr>
References: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
 <20121112075411.GO10369@pengutronix.de> <50A15966.8040204@yahoo.fr>
Message-ID: <20121113073812.GZ10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:17:42PM +0100, trem wrote:
> On 12/11/12 08:54, s.hauer at pengutronix.de wrote:
> >On Sun, Nov 11, 2012 at 08:34:34PM +0000, Philippe Reynes wrote:
> >>Hi all,
> >>
> >>I try to add the support of usb on my armadeus apf27,
> >>but there is a problem when try to reclaim the clock.
> >>imx_usb mxc-ehci.0: Failed to get clock, err=-2
> >>
> >>To avoid adding too many attachment to this mail,
> >>I've put all the information on a website. You can
> >>found them here:  http://ryu.zarb.org/~trem/armadeus/
> >>
> >>
> >>The initial issue is in the directory : 20121110
> >>
> >>boot-3.7-rc4.log : boot log with the issue
> >>linux-3.7-rc4.config : the configuration file for the kernel
> >>investifation.txt : the description of my investigation.
> >
> >You should really post the relevant bits on the mailing list. Nobody
> >visits websites for investigating your issue. Besides, it will not be
> >in the mailing list archives so people will not find it later.
> 
> You're right, I add an archive with all log as attachment.
> 
> >>
> >>
> >>I've tried to fix the clock issue, but another issue occurs.
> >>The information about this "fix" is in : 20121111
> >>boot-3.7-rc4.log : boot log with the new issue
> >>issue.txt : the description of the change done on the kernel
> >>
> >>I've got severals questions :
> >>- does my dts correct with usb change ?
> >>- does someone has already tested usb on imx27 with dt ?
> >
> >Please investigate in using the chipidea driver. This will be the way
> >forward for i.MX.
> 
> I use the chipidea driver for the usb.
> 
> The main issue is that the chipidea driver don't found the clock :
> 
> [    0.761693] imx_usb mxc-ehci.0: Failed to get clock, err=-2
> [    0.767620] imx_usb: probe of mxc-ehci.0 failed with error -2
> 
> The driver ci13xxx_imx request the clock in the probe function
> in the following line:
> data->clk = devm_clk_get(&pdev->dev, NULL);
> calling: clk = clk_get(dev, id);
> calling: clk_get_sys(dev_id, con_id);
> calling: clk_find(dev_id, con_id);
> with dev_id = mxc-ehci.0 and con_id = NULL
> This last function fail to found a clock.
> 
> In the function mx27_clocks_init, several mxc-ehci.0
> clocks are registered, but all with a con_id.
> 
> So the function clk_find fails.
> 
> As I'm not really sure of the dts, I don't know if the problem
> is in the dts or in the driver (maybe both).

You have to register the lookups for the chipidea driver with
clk_register_clkdev(). The lookups are only what the name suggests:
lookups. They are no clocks by themselves. This means that you have to
add another lookup which matches the device name.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
