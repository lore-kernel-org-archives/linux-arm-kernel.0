From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 15 Jul 2014 10:28:52 -0700
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <20140714140526.GK2197@dragon>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140714070341.GC2197@dragon>
 <CA+sos7_quvZo6j9rFPvgCdYsEx6RoUNPUyvxE74K4vaNWDkGyg@mail.gmail.com>
 <20140714140526.GK2197@dragon>
Message-ID: <CAJ+vNU071i=fb5r-mq_GXz_r41N1XyafCeGEiuayhbwVmQ5jAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 7:05 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, Jul 14, 2014 at 02:56:06PM +0200, Beno?t Th?baudeau wrote:
>> > So the question comes down to, for an output GPIO, whether the value in
>> > GPIO_DR register is always identical to what we see on the pad.  If yes,
>> > your patch makes sense to me.  Otherwise, we have to set SION bit to
>> > read the value of an output GPIO from GPIO_PSR.
>>
>> Both are not always the same. They should be the same only for sane
>> hardware. GPIO_DR indicates the level that the output pad tries to
>> drive, while GPIO_PSR indicates the level sensed on the pad. Thus,
>> they may differ if there is an external level conflict on the pin.
>> This difference may be useful in order to test if the board is
>> behaving as expected or if there is anything going wrong, which is
>> typically useful for board prototyping.
>>
>> The software "knows" what it has set on the output pad, so having a
>> get accessor for GPIO_PSR is more useful than for GPIO_DR, and it
>> better fits the actual meaning of this function. GPIO_DR would
>> correspond to the non-existing gpio_get_set_value() function.
>
> Thanks for the input, Beno?t.  That's helpful.
>
> Shawn

Great - thanks for the clarification everyone. I will not submit such
a patch and instead work this from the pinmux perspective setting SION
on GPIO outputs.

That said, can anyone shed light on the subject of what is 'proper'
for GPIO pinmux in the bootloader vs the kernel device-tree? I see
that among the various imx6qdl*.dtsi files, some boards configure
MX6QDL_PAD_GPIO* as 0x80000000 (no config, keeping power-on or
bootloader settings) instead of manually configuring them. Perhaps
there is some rule of thumb that should be followed?

The boards I maintain have several GPIO's that fall under the categories:
 a) go to a connector for off-board use as GPIO
 b) used for a chip enable that no driver may use (like an i2c buffer
for expanding/isolating i2c to an off-board connector for example)
 c) user leds (which 'are' configured for use by the gpio-led driver)
 d) USB hub reset (which the bootloader configures and de-asserts)
 e) probably a few more less-used cases (see
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi#n348
for a good example)

Thanks,

Tim
