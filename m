From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Feb 2012 00:07:45 +0200
Subject: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <4F2B078B.1040709@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-2-git-send-email-tarun.kanti@ti.com>
 <20120202184106.GC29215@legolas.emea.dhcp.ti.com>
 <20120202191630.GT15343@ponder.secretlab.ca>
 <20120202194545.GA29351@legolas.emea.dhcp.ti.com>
 <4F2AF68D.1000505@ti.com>
 <20120202214907.GA22888@legolas.emea.dhcp.ti.com>
 <20120202215350.GB22888@legolas.emea.dhcp.ti.com>
 <4F2B078B.1040709@ti.com>
Message-ID: <20120202220744.GA23092@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 02, 2012 at 11:00:43PM +0100, Cousson, Benoit wrote:
> On 2/2/2012 10:53 PM, Felipe Balbi wrote:
> >Hi again,
> >
> >On Thu, Feb 02, 2012 at 11:49:08PM +0200, Felipe Balbi wrote:
> >>>In fact the driver already handled the 6 GPIOS banks as individual devices:
> >>>
> >>>[    0.185638] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> >>>[    0.185882] OMAP GPIO hardware version 0.1
> >>>[    0.186767] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> >>>[    0.187744] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> >>>[    0.188751] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> >>>[    0.189819] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
> >>>[    0.190917] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
> >>
> >>yeah, but you can get all of that for free from driver core. Just add
> >>one platform_device for each bank and make the omap-gpio.c only
> >>understand one bank. No tricks.
> >>
> >>What I'm trying to say is to remove the Bank array or list_head and make
> >>probe() get called 6 times by creating 6 omap_gpio platform_devices.
> >>
> >> From probe you cann gpiochip_add() once and only once.
> >		^^^^
> >		 call
> >
> >I actually just took the time to go over the driver and that's what it
> >does. So the list_head is only there fo the nasty cpuidle stuff below:
> 
> Yes, that was my point :-)

:-) my bad

> >>>That list is only used to iterate over all the instances during CPU idle:
> >>>
> >>>void omap2_gpio_prepare_for_idle(int pwr_mode)
> >>>{
> >>>	struct gpio_bank *bank;
> >>>
> >>>	list_for_each_entry(bank,&omap_gpio_list, node) {
> >>>		if (!bank->mod_usage || !bank->loses_context)
> >>>			continue;
> >>>
> >>>		bank->power_mode = pwr_mode;
> >>>
> >>>		pm_runtime_put_sync_suspend(bank->dev);
> >>>	}
> >>>}
> >>>
> >>>void omap2_gpio_resume_after_idle(void)
> >>>{
> >>>	struct gpio_bank *bank;
> >>>
> >>>	list_for_each_entry(bank,&omap_gpio_list, node) {
> >>>		if (!bank->mod_usage || !bank->loses_context)
> >>>			continue;
> >>>
> >>>		pm_runtime_get_sync(bank->dev);
> >>>	}
> >>>}
> >>
> >>that's the thing which is unnecessary, actually :-)
> >>
> >>Why do we even have this omap2_gpio_resume_after_idle() ? Can't the gpio
> >>driver handle its own PM or listen to cpuidle notificaitons for that ?
> >>
> >>I would like to understand why do we need this hack for pm runtime.
> >>Can't you just use ->prepare() and ->complete() from dev_pm_ops ?
> >
> >This question remains. Why do we need those funtions ?
> 
> These functions are called from the CPUIdle path so outside the scope
> of the GPIO driver. These are part of a bunch of nasty PM hacks we
> are doing in the CPU idle loop. We are in the process of getting rid
> of most of them, but it looks like some are still needed.

Too bad. I can see that the gpio pm implementation seems a bit
"peculiar". I mean, pm does reference counting and yet the driver has
checks to prevent multiple gets and puts on a single bank (meaning that
pm counter will be either 0 or 1 at any point in time).

To me it looks like those functions are there in order to forcefully put
PER power domain in OFF because drivers are always holding a reference
to their gpios (drivers generally gpio_request() on probe() and
gpio_free() on remove()).

Looks like the entire pm implementation on OMAP gpio driver has always
considered only the fact that gpios can be requested and freed, but
never that we want the system to go to OFF even while gpios are
requested, because we have I/O PAD wakeups. At some point that has to be
sorted out because that HACK is quite ugly :-)

I'll see if I find some time to go over the interactions between
gpio-omap.c and pm24x.c and pm34xx.c any of these days, but I can't
promise anything ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120203/8eb65e06/attachment.sig>
