From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Feb 2012 23:49:08 +0200
Subject: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <4F2AF68D.1000505@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-2-git-send-email-tarun.kanti@ti.com>
 <20120202184106.GC29215@legolas.emea.dhcp.ti.com>
 <20120202191630.GT15343@ponder.secretlab.ca>
 <20120202194545.GA29351@legolas.emea.dhcp.ti.com>
 <4F2AF68D.1000505@ti.com>
Message-ID: <20120202214907.GA22888@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 02, 2012 at 09:48:13PM +0100, Cousson, Benoit wrote:
> On 2/2/2012 8:45 PM, Felipe Balbi wrote:
> >On Thu, Feb 02, 2012 at 12:16:30PM -0700, Grant Likely wrote:
> >>On Thu, Feb 02, 2012 at 08:41:07PM +0200, Felipe Balbi wrote:
> >>>Hi,
> >>>
> >>>On Thu, Feb 02, 2012 at 11:00:27PM +0530, Tarun Kanti DebBarma wrote:
> >>>>diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >>>>index 0b05629..6ea7390 100644
> >>>>--- a/drivers/gpio/gpio-omap.c
> >>>>+++ b/drivers/gpio/gpio-omap.c
> >>>>@@ -28,7 +28,10 @@
> >>>>  #include<asm/gpio.h>
> >>>>  #include<asm/mach/irq.h>
> >>>>
> >>>>+static LIST_HEAD(omap_gpio_list);
> >>>
> >>>I guess it's now too late because patch is acked and everything, but I
> >>>think if you make the driver handle one bank alone and just instantiate
> >>>it multiple times (omap_gpio.0, omap_gpio.1, omap_gpio.3, etc) driver
> >>>would be faaaaaar simpler.
> >>
> >>Is there any shared state between the banks?  On my very cursory glance it
> >>looked like banks still have some interaction between them.  If not, then
> >>yes I agree that multiple instances would be better.
> >
> >A quick glance at the TRM shows that banks have separate address spaces
> >and IRQ lines. I think it's done this way because we can handoff one (or
> >more) bank to other cores on the SoC, so they need to be pretty
> >independent.
> >
> >I could be missing something though.
> 
> In fact the driver already handled the 6 GPIOS banks as individual devices:
> 
> [    0.185638] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> [    0.185882] OMAP GPIO hardware version 0.1
> [    0.186767] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> [    0.187744] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> [    0.188751] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> [    0.189819] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
> [    0.190917] gpiochip_add: registered GPIOs 160 to 191 on device: gpio

yeah, but you can get all of that for free from driver core. Just add
one platform_device for each bank and make the omap-gpio.c only
understand one bank. No tricks.

What I'm trying to say is to remove the Bank array or list_head and make
probe() get called 6 times by creating 6 omap_gpio platform_devices.

>From probe you cann gpiochip_add() once and only once.

> That list is only used to iterate over all the instances during CPU idle:
> 
> void omap2_gpio_prepare_for_idle(int pwr_mode)
> {
> 	struct gpio_bank *bank;
> 
> 	list_for_each_entry(bank, &omap_gpio_list, node) {
> 		if (!bank->mod_usage || !bank->loses_context)
> 			continue;
> 
> 		bank->power_mode = pwr_mode;
> 
> 		pm_runtime_put_sync_suspend(bank->dev);
> 	}
> }
> 
> void omap2_gpio_resume_after_idle(void)
> {
> 	struct gpio_bank *bank;
> 
> 	list_for_each_entry(bank, &omap_gpio_list, node) {
> 		if (!bank->mod_usage || !bank->loses_context)
> 			continue;
> 
> 		pm_runtime_get_sync(bank->dev);
> 	}
> }

that's the thing which is unnecessary, actually :-)

Why do we even have this omap2_gpio_resume_after_idle() ? Can't the gpio
driver handle its own PM or listen to cpuidle notificaitons for that ?

I would like to understand why do we need this hack for pm runtime.
Can't you just use ->prepare() and ->complete() from dev_pm_ops ?

> I don't know if there is some reason to not use driver_for_each_device.

driver_for_each_device() is already handled by driver core. So your
omap_device_build() would have a loop creating N omap_devices, one for
each gpio bank. Each bank would receive one IRQ line and one address
base. And they would only understand that. Every instance of the driver
handles the GPIOs connected on one bank.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/a68f94f9/attachment.sig>
