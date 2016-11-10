From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2016 08:11:49 -0700
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <621758ce-dd3f-41ad-d9b8-b8e34538700e@redhat.com>
References: <20161109192301.GS26979@atomide.com>
 <621758ce-dd3f-41ad-d9b8-b8e34538700e@redhat.com>
Message-ID: <20161110151149.GB27724@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hans de Goede <hdegoede@redhat.com> [161110 01:35]:
> Hi,
> 
> On 09-11-16 20:23, Tony Lindgren wrote:
> > Hi,
> > 
> > Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> > the sysfs brightness attr for changes.") breaks runtime PM for me.
> > 
> > On my omap dm3730 based test system, idle power consumption is over 70
> > times higher now with this patch! It goes from about 6mW for the core
> > system to over 440mW during idle meaning there's some busy timer now
> > active.
> 
> Do you have any blinking LEDs or LED triggers defined on the system ?

There are some configured in the dts file:

$ grep -i led arch/arm/boot/dts/*torpedo*.dts*

And the gpio controlled led1 is configured to blink with
linux,default-trigger = "cpu0".

> > Reverting this patch fixes the issue. Any ideas?
> 
> All I can think of is something calling led_set_brightness quite often,
> the patch in question makes led_set_brightness somewhat more expensive,
> but it should not cause such a big difference unless something is
> really calling led_set_brightness quite often maybe something is calling
> it with the same value all the time ?

I don't think this one has any brightness control.

Regards,

Tony
