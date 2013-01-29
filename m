From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 29 Jan 2013 20:42:43 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130129004824.GB7717@titan.lakedaemon.net>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
Message-ID: <20130129194243.GA30831@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 07:48:24PM -0500, Jason Cooper wrote:
> On Mon, Jan 28, 2013 at 11:31:48PM +0100, Simon Baatz wrote:
> > Hi Jason,
> > 
> > On Sun, Jan 27, 2013 at 10:24:31AM -0500, Jason Cooper wrote:
> > > On Sun, Jan 27, 2013 at 03:53:53PM +0100, Sebastian Hesselbarth wrote:
> > > > On 01/27/2013 03:46 PM, Jason Cooper wrote:
> > > > >>I _cannot_ confirm that gbe is loosing its MAC address on Dove. I will
> > > > >>post a follow-up patch to Jason's cleanup patches that will also
> > > > >>grab a clock for smi. With that patch insmod'ing/rmmod'ing mv643xx_eth
> > > > >>does work just fine here on Dove.
> > > > >
> > > > >I believe Simon's issue is that the mv643xx_eth driver is not loaded at
> > > > >boot, it's clocks get gated, then when he loads the driver, there is no
> > > > >mac address.  Is that correct Simon?  I don't think unloading the driver
> > > > >after boot will trigger this regression.
> > > > 
> > > > Loading and unloading the driver module hangs because of the missing
> > > > clk_prepeare_enable in shared driver part. This should be fixed by the
> > > > patch I sent you.
> > > > 
> > > > Dove and Kirkwood have the same gbe internally and I can boot into Dove
> > > > without mv643xx_eth, load, unload, reload the module and it always finds
> > > > its MAC address.
> > > > 
> > > > I just want Simon to confirm that Kirkwood's gbe is really loosing the
> > > > contents of its MAC address registers during gated clocks, which is from
> > > > a HW point of view very unlikely.
> > > 
> > > Ok, I just wanted to make sure we understood his problem correctly, and
> > > if possible, reproduce it.
> > > 
> > > Simon, can you give us some steps to reproduce this on our side so we
> > > can see exactly what's happening?
> > 
> > Nothing special here. My config originally based on a Debian config
> > for a Kirkwood kernel.  Thus, amongst other drivers, mv643xx_eth is
> > build as a module and is loaded from an initrd.
> > Because all relevant drivers are loaded as modules, I need my
> > runit patch to boot at all.
> 
> Let's back up.  If you config early printk and COMMON_CLK_DEBUG and a
> vanilla v3.8-rc5 with your current config, what happens?


I thought it's clear what happens. "runit" is requested in the dts by
serial, spi, watchdog, nand, i2c.  Each of these are either not built
or built as a module in my config, except serial.

of_serial.c does the following in of_platform_serial_setup():

	if (of_property_read_u32(np, "clock-frequency", &clk)) {

		/* Get clk rate through clk driver if present */
		info->clk = clk_get(&ofdev->dev, NULL);
		if (IS_ERR(info->clk)) {
			dev_warn(&ofdev->dev,
				"clk or clock-frequency not defined\n");
			return PTR_ERR(info->clk);
		}

		clk_prepare_enable(info->clk);
		clk = clk_get_rate(info->clk);
	}

and since "clock-frequency" is still given in the standard DTS for
the IB-NAS 6210, it does not enable the clock.

Thus, no driver uses the clock, it gets disabled and the system locks
up.

The system boots when removing "clock-frequency" from the DTS. 

Which lead to two questions:
- Is it safe to remove "clock-frequency" now that we have the clocks
  in place?
- The behavior of of_serial.c looks strange to me, is this really the
desired behavior?


For the "runit" clock, this means that any time you hit a
configuration that does not keep the clock enabled, the system will
lockup.  (We have gone through this more than once now. Especially,
this hits you hard when you try to support a new board and disable as
much as possible in the config/dts for a start...).

Thus, we should keep it enabled even if it is unused, which is
exactly the purpose of CLK_IGNORE_UNUSED if I understood this
correctly.

 
> Could you also please try kirkwood_defconfig and tell us if it boots?

It is very easy to get my system to boot with a stock kernel. Just
build one of the drivers I use directly into the kernel and it boots
(up to the point where the gbe driver is loaded if built as a module,
of course).

> > Here are my findings with various patches: ("non-DT" means booting
> > the IBNAS6210 with machine ID 1680 ???Marvell DB-88F6281-BP
> > Development Board???, which works reasonably well)
> > 
> > 3.8-rc5 + runit patch:
> > 
> > DT: Hangs at boot (when loading mv643xx_eth)
> > non-DT: Boots ok

In the DT case ge0 and ge1 are NULL, and thus, kirkwood_ge0[01]_init()
tries to enable NULL clocks, but not the gbe clocks. -> The clocks
get disabled.

As described in Sebastian's patch (and also found by Andrew some time
ago), this leads to a hanging system when loading the gbe driver.


> > 3.8-rc5 + runit patch + ge00/ge01 patch:
> > 
> > DT: Boots ok
> > non-DT: Boots ok

Since the clocks are found now and kept enabled, DT behaves the same
as non-DT.


> > 
> > 3.8-rc5 + runit + Sebastians get smi clock patch (modified to use
> > legacy clock names):
> > 
> > DT: Boots, but no MAC
> > non-DT: Boots ok

This is the behavior originally found by Andrew. The clock patch
eliminates the lockup, but the hardware forgets its MAC address.

> > 
> > 3.8-rc5 + runit + using Sebastians patch + clks not ticking at module
> > load:
> > 
> > DT: Boots, but no MAC
> > non-DT: Boots, but no MAC

I think non-DT and DT gated clocks behave differently, since the
non-DT ones also enable/disable the PHY.  I explicitly removed the
clk_prepare_enable() from kirkwood_ge0[01]_init() in order to see if
this makes a difference.

(Which reminds me, that we wanted to implement the PHY enabling in
the driver.)

Apparently, it does not make a difference.


- Simon
