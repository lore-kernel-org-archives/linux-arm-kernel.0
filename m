From: Russ.Dill@ti.com (Russ Dill)
Date: Mon, 21 May 2012 09:12:31 -0700
Subject: [PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
In-Reply-To: <1337616478.2717.13.camel@deskari>
References: <20120509163649.GN5088@atomide.com>
 <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
 <1337616478.2717.13.camel@deskari>
Message-ID: <CA+Bv8XZvgNws2_Eer7MwEZGVdxHFYnkvOZVHYs0kT2=8r3f5sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 9:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-05-09 at 15:15 -0700, Russ Dill wrote:
>> This removes several boot warnings from board-omap3beagle.c:
>>
>> ?- gpio_request: gpio--22 (DVI reset) status -22
>> ?- Unable to get DVI reset GPIO
>>
>> There is a combination of leftover code and revision confusion.
>> Additionally, xM support is currently a hack.
>>
>> For original Beagleboard this removes the double initialization of GPIO
>> 170, properly configures it as an output, and wraps the initialization
>> in an if block so that xM does not attempt to request it.
>>
>> For Beagleboard xM it removes reference to GPIO 129 which was part
>> of rev A1 and A2 designs, but never functioned. It then properly assigns
>> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
>> hack of initializing it high. Additionally, it uses
>> gpio_set_value_cansleep since this GPIO is connected through i2c.
>>
>> Unfortunately, there is no way to tell the difference between xM A2 and
>> A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
>> GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
>> problems created by this fix.
>>
>> v4
>> ?- Rebase onto git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5
>> ?- Use dvi_pd_gpio instead of reset_gpio to match with new naming
>
> Hmm, was this rebased correctly? It doesn't apply to for-l-o-3.5 branch.

It sits on top of for-l-o-3.5 and '[OMAP] Mark Beagleboard-xM MMC bus
as 4-bit'. You can cherry-pick 1afb82e4 before applying, or I can drop
that patch from the series and resend.
