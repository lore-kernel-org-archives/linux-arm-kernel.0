From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Mar 2017 10:49:06 +0100
Subject: [PATCH v2 1/6] ARM: dts: r8a73a4: Add INTC-SYS clock to device
 tree
In-Reply-To: <183720b2-003c-efb6-e4b6-5e6151da46fe@cogentembedded.com>
References: <1488819491-26097-1-git-send-email-geert+renesas@glider.be>
 <1488819491-26097-2-git-send-email-geert+renesas@glider.be>
 <183720b2-003c-efb6-e4b6-5e6151da46fe@cogentembedded.com>
Message-ID: <CAMuHMdWt+Kka=4qaW9Z0-zp6rPEBOO_13BxTy331-5x5mHFx9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Mar 7, 2017 at 10:27 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 3/6/2017 7:58 PM, Geert Uytterhoeven wrote:
>> Link the ARM GIC to the INTC-SYS module clock and the C4 power domain,
>> so it can be power managed using that clock in the future.
>>
>> Note that currently the GIC-400 driver doesn't support module clocks nor
>> Runtime PM, so this must be handled as a critical clock.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - Add missing "power-domains" property,
>>   - Add clock-names property,
>>   - Drop RFC status,
>>   - Change one-line summary prefix to match current arm-soc practices,
>>   - s/GIC driver/GIC-400 driver/,
>>   - Document critical clock dependency.
>> ---
>>  arch/arm/boot/dts/r8a73a4.dtsi            | 13 +++++++++----
>>  include/dt-bindings/clock/r8a73a4-clock.h |  1 +
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi
>> b/arch/arm/boot/dts/r8a73a4.dtsi
>> index 6fb7eaba91262edf..1f5c9f6dddba9366 100644
>> --- a/arch/arm/boot/dts/r8a73a4.dtsi
>> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
>> @@ -467,6 +467,9 @@
>>                         <0 0xf1004000 0 0x2000>,
>>                         <0 0xf1006000 0 0x2000>;
>>                 interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>;
>> +               clocks = <&mstp4_clks R8A73A4_CLK_INTC_SYS>;
>> +               clock-names = "clk";
>
>    Do we really need such "clock-names"?

Yes. The ARM/GIC maintainers objected against not using clock-names, as
some GIC variants have multiple clocks.
Hence commit afbbd23381767aec ("irqchip/gic: Document optional Clock and
Power Domain properties") was born...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
