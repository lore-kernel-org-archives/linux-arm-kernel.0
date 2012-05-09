From: Russ.Dill@ti.com (Russ Dill)
Date: Wed, 9 May 2012 09:58:07 -0700
Subject: [PATCH] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
In-Reply-To: <20120509163649.GN5088@atomide.com>
References: <87zk9ijp86.fsf@ti.com>
 <1336531746-29027-1-git-send-email-Russ.Dill@ti.com>
 <20120509155555.GL5088@atomide.com>
 <CA+Bv8XZ4FYu+djvOMxhr6MbP8QYn4OL1PTc6TDJt42CpiESYDQ@mail.gmail.com>
 <20120509163649.GN5088@atomide.com>
Message-ID: <CA+Bv8XbScXOhEz9Fc=JkXG-MyMrM5BkRbfH1usFEcxjzqtd5ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 9:36 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Russ Dill <Russ.Dill@ti.com> [120509 09:29]:
>> On Wed, May 9, 2012 at 8:55 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > Hi Tomi,
>> >
>> > * Russ Dill <Russ.Dill@ti.com> [120508 19:52]:
>> >> This removes several boot warnings from board-omap3beagle.c:
>> >>
>> >> ?- gpio_request: gpio--22 (DVI reset) status -22
>> >> ?- Unable to get DVI reset GPIO
>> >>
>> >> There is a combination of leftover code and revision confusion.
>> >> Additionally, xM support is currently a hack.
>> >>
>> >> For original Beagleboard this removes the double initialization of GPIO
>> >> 170, properly configures it as an output, and wraps the initialization
>> >> in an if block so that xM does not attempt to request it.
>> >>
>> >> For Beagleboard xM it removes reference to GPIO 129 which was part
>> >> of rev A1 and A2 designs, but never functioned. It then properly assigns
>> >> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
>> >> hack of initializing it high. Additionally, it uses
>> >> gpio_set_value_cansleep since this GPIO is connected through i2c.
>> >>
>> >> Unfortunately, there is no way to tell the difference between xM A2 and
>> >> A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
>> >> GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
>> >> problems created by this fix.
>> >
>> > Can you check if this needs updates for your clean up patches?
>>
>> I'm not sure what you mean, can you be more specific?
>
> Tomi has a DSS clean-up series posted that affects the board-*.c
> files.

Yes, it conflicts pretty bad but, it's fairly straightforward to
fixup. Additionally, the 'OMAPDSS: panel-dvi: add PD gpio handling'
needs to be changed to use gpio_set_value_cansleep (replied to patch
in separate email).
