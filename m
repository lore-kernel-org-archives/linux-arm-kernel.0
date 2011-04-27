From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 27 Apr 2011 16:05:05 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Add hx4700 LED support
In-Reply-To: <1303898152.5063.27.camel@flow>
Message-ID: <323465.41879.qm@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Wed, 27/4/11, Philipp Zabel <philipp.zabel@gmail.com> wrote:

> thanks for working on this! I have to offer my opinion on
> the overall
> structure of the patch and hx4700 LED support:
OK.

> The patch should be split in three parts, to be sent to the
> respective
> subsystem maintainers - the necessary modifications to the
> asic3 driver
> (mfd), the new leds-asic3 driver (led subsystem) and
> finally the hookup
> in hx4700.c (pxa).
OK, will do.

> I think exporting the asic3_read/write_register() and
> asic3_clk_enable/disable() should be avoided, eventually.
> You can get rid of the asic3_read/write_register() exports
> by
> implementing the leds-asic3 driver as a mfd_cell,
> symmetrical to how
> ds1wm and tmio_mmc are hooked up to asic3.
> The asic3_clk_enable/disable() exports we have to live with
> until people
> agree on a clock framework with a common struct clk
> implementation, but
> we should look forward to get rid of those, too.
OK, will look into the read/write case.

> I would like to keep #ifdefs to a minimum in hx4700.c. It
> shouldn't be
> necessary to compile this conditionally.
I added that flexibility in case anyone needed it. Will remove.

> That one's not needed.
I know, it's there purely as documentation, particularly since all the other fields are initialised. Will remove.

> This would be the same for all platforms using ASIC3 and
> thus should be
> set up inside asic3.c.
It seemed tidier to group all LED-specific configuration parameters into one place. Will split up.

> Please do not hard-code the timebase, periodtime, dutytime
> and
> autostopcount parameters in platform data. This should be
> hooked up to
> led_blink_set(), really.
I just kept things simple. Will look into it.

> asic3_led_info should be hooked into asic3_platform_data,
> and leds-asic3
> created from asic3.c as a mfd cell...
> ... and then this wouldn't be needed.
OK, will look into it.

> Are they?
See later response.

> I'd like to avoid this.
Per earlier response.

> And this.
Ditto.

> And this was meant to mimic clk_enable(struct clk *clk). I
> guess this is
> fine for now. Let's keep in mind that eventually this is
> going return to
> a static function taking a struct clk * once the common
> struct clk is in
> place.
OK.

> This will have to be reverted once there is a common struct
> clk.
> And this.
> And this.
> And this.
> And this.
> And this.
OK.

> Is this relevant to the led support?
No, but it helps to confirm the mapping between platform and asic3 GPIOs. Other mfd drivers define the label so why not asic3? If you're saying that this should be submitted as a separate patch then fair enough.

> Where did you get this information? I don't have
> WinCE+HaRET installed
> right now, but I'm pretty sure that my old notes say that
> these were
> configured as low outputs by default, and I believe the SDG
> Systems code
> even triggered them as if to power the LEDs, although I'm
> not sure of
> that right now.
I got it from observation. Writing the 3 LED GPIOs had no effect despite the options I tried. Reading them was a different story however; it always returned the current on/off state.
For example:
# echo 162 > /sys/class/gpio/export    # platform #162 = asic3 #34
# cat /sys/class/gpio/gpio162/value
0
# echo 1 > /sys/class/gpio/gpio162/value    # has no effect
# cat /sys/class/gpio/gpio162/value
0
# echo 1 > /sys/class/leds/hx4700:blue/brightness    # turn on
# cat /sys/class/gpio/gpio162/value
1
# echo 0 > /sys/class/gpio/gpio162/value    # has no effect
# cat /sys/class/gpio/gpio162/value
1
# 
A more compelling illustration that the 3 LED GPIOs are configured as inputs comes from the amber LED, which blinks on / off for about one second each:
# echo 160 > /sys/class/gpio/export    # platform #160 = asic3 #32
# echo 1 > /sys/class/leds/hx4700:amber/brightness    # start blinking
# while true; do cat /sys/class/gpio/gpio160/value; sleep 1; done
1
0
1
0
1
0
1
0
etc...
If anyone can demonstrate how the 3 LED GPIOs can be used as outputs then I'll be happy to revisit this.

Regards,
Paul
