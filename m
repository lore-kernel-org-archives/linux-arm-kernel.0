From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 17 May 2018 12:16:33 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au>
 <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
Message-ID: <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilad,

On Thu, May 17, 2018 at 10:01 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Wed, May 16, 2018 at 10:43 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Tue, May 15, 2018 at 04:50:44PM +0200, Geert Uytterhoeven wrote:
>>> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>>> > Add bindings for CryptoCell instance in the SoC.
>>> >
>>> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>>>
>>> Thanks for your patch!
>>>
>>> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> > @@ -528,6 +528,14 @@
>>> >                         status = "disabled";
>>> >                 };
>>> >
>>> > +               arm_cc630p: crypto at e6601000 {
>>> > +                       compatible = "arm,cryptocell-630p-ree";
>>> > +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>>> > +                       #interrupt-cells = <2>;
>>>
>>> I believe the #interrupt-cells property is not needed.
>>>
>>> > +                       reg = <0x0 0xe6601000 0 0x1000>;
>>> > +                       clocks = <&cpg CPG_MOD 229>;

Missing "power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;", as
the Secure Engine is part of the CPG/MSSR clock domain (see below [*]).

>>> > +               };
>>>
>>> The rest looks good, but I cannot verify the register block.
>>>
>>> > +
>>> >                 i2c3: i2c at e66d0000 {
>>> >                         #address-cells = <1>;
>>> >                         #size-cells = <0>;
>>
>> Thanks, I have applied this after dropping the #interrupt-cells property.
>
> Thanks you!
>
> Alas, it will not work without the clk patch (the previous one in the
> series) so they need to be
> taken or dropped together.

Indeed. From a quick glance, it looks like drivers/crypto/ccree/cc_driver.c
does not distinguish between the absence of the clock property, and an
actual error in getting the clock, and never considers any error a failure
(incl. -PROBE_DEFER).

As of_clk_get() returns -ENOENT for both a missing clock property and a
missing clock, you should use (devm_)clk_get() instead, and distinguish
between NULL (no clock property) and IS_ERR() (actual failure -> abort).

Hence in the absence of the clock patch, the driver accesses the crypto
engine while its module clock is turned off, leading to:

    ccree e6601000.crypto: Invalid CC signature: SIGNATURE=0x00000000
!= expected=0xDCC63000

You must be lucky, though, usually you get an imprecise external abort
later, crashing the whole system ;-)

So I think this patch should be dropped for now.

However, even with your clock patch, the signature checking fails for me,
on both R-Car H3 ES1.0 and ES2.0.
Does this need changes to the ARM Trusted Firmware, to allow Linux to
access the public SCEG module?

[*] More on the subject of clock control:
At least for Renesas SoCs, where the module is part of a clock domain, and
can be controlled automatically by Runtime PM, you could drop the explicit
clock control, and use Runtime PM instead
(pm_runtime_{enable,get_sync,put,disable}()).  That would allow the driver
to work on systems with any kind of PM Domains, too.
Depending on the other platforms that include a CryptoCell and their
(non)reliance on PM Domains, you may have to keep the explicit clock
handling, in addition to Runtime PM.

To decrease power consumption, I suggest to move the clock and/or Runtime
PM handling to the routines that actually use the hardware, instead of
powering the module in the probe routine.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
