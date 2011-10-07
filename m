From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Fri, 7 Oct 2011 09:01:38 +0530
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20111004233504.GD3009@ponder.secretlab.ca>
References: <20110922184614.25419.84606.stgit@ponder>
	<20111004145148.GA8021@manju-desktop>
	<CACxGe6tXEx1A+ZuBTUdi8jjfx_hOCaX6eSpUOOhNH9us+Mnczg@mail.gmail.com>
	<20111004183516.GB8021@manju-desktop>
	<20111004233504.GD3009@ponder.secretlab.ca>
Message-ID: <20111007033138.GB28361@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 05:35:04PM -0600, Grant Likely wrote:
> On Wed, Oct 05, 2011 at 12:05:16AM +0530, G, Manjunath Kondaiah wrote:
> > On Tue, Oct 04, 2011 at 09:58:10AM -0600, Grant Likely wrote:
> > > On Tue, Oct 4, 2011 at 8:51 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> > > > On Thu, Sep 22, 2011 at 12:51:23PM -0600, Grant Likely wrote:
> > > >> Hi Manjunath,
> > > >>
> > > >> Here's the current state of the patch. ?The major think that needs to
> > > >> be done is to convert it to use a separate workqueue as described in
> > > >> the TODO above. ?It also needs some users adapted to it. ?One of the
> > > >> gpio drivers would work; preferably one of the newer drivers that
> > > >> doesn't have a lot of drivers depending on the early_initcall()
> > > >> behaviour yet.
> > > >
> > > > I have tested this patch on omap3 beagle board by making:
> > > > 1. omap-gpio driver init as late_initcall instead of postcore_initcall
> > > > 2. mmc driver probe will request gpio through gpio_request and gpio driver
> > > > returns -EDEFER_PROBE which in turn makes mmc driver to request deferral probe.
> > > > 3. When deferral probe gets activated, it scans driver entries and it will not
> > > > find any match for mmc driver probe.
> > > 
> > > Looks like drivers/mmc/host/omap.c is using platform_driver_probe()
> > > instead of platform_driver_register().  Add the probe hook to the
> > > platform_driver structure and change it to call
> > > platform_driver_register() and it should work.  Don't forget to change
> > > mmc_omap_probe from __init to __devinit.
> > 
> > Yes. After changing it into platform_driver_register, I can see mmc probe is
> > getting completed from deferred probe list. But, MMC upper layer will check 
> > probe and it waits for ever since probe_count is not getting incremented.
> > 
> > Log:
> > 
> > [    1.807830] platform omap_hsmmc.0: Driver omap_hsmmc requests probe deferral
> > 
> > ...
> > 
> > [    1.948760] omap_device: omap_gpio.0: new worst case activate latency 0:30517
> > [    1.959259] OMAP GPIO hardware version 2.5
> > 
> > ...
> > 
> > [    2.000488] platform omap_hsmmc.0: Retrying from deferred list
> > [    2.008026] omap_device: omap_hsmmc.0: new worst case activate latency 0:244140
> > [    2.020080] input: gpio-keys as /devices/platform/gpio-keys/input/input1
> > [    2.035827] omap_hsmmc omap_hsmmc.0: Probe success...
> > [    2.042083] twl_rtc twl_rtc: setting system clock to 2000-01-01 01:06:35 UTC
> > (946688795)
> > [    2.056030] Waiting for root device /dev/mmcblk0p2...
> > [    2.061492] driver_probe_done: probe_count = 0
> > [    2.168518] driver_probe_done: probe_count = 0
> > [    2.277832] driver_probe_done: probe_count = 0
> > [    2.387207] driver_probe_done: probe_count = 0
> > [    2.496582] driver_probe_done: probe_count = 0
> > 
> > Waits for ever in init/do_mount.c:
> > 	if ((ROOT_DEV == 0) && root_wait) {
> > 		printk(KERN_INFO "Waiting for root device %s...\n",
> > 			saved_root_name);
> > 		while (driver_probe_done() != 0 ||
> > 			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
> > 			msleep(100);
> > 		async_synchronize_full();
> > 	}
> 
> Okay, it looks like the driver deferral workqueue needs to get kicked
> off before the kernel starts waiting for the root filesystem.  Check
> the initcall level that is being used by do_mount, and make sure the
> deferred probe starts before that...
> 
> Hmmm.... wait, that doesn't make sense because the probe is still
> successful.  What triggers the exit conditions in that while loop?
> How would it be different from when the driver can probe successfully
> without deferral?

Looks like OMAP MMC uses TWL GPIO for card detect. I manually changed this 
twl gpio to omap gpio for testing purpose which is causing this problem. 
I have not tried to root cause further, I reverted back to twl gpio and requested
omap gpio in mmc driver probe. With omap gpio request and making gpio driver
init as lateinit, deferral probe works fine for MMC driver.

I will post updated patch series.

-Manjunath
