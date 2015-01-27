From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 27 Jan 2015 09:48:09 +0100
Subject: [PATCH repost] ARM: shmobile: r8a7794: Correct SDHI base address,
 clock labels and output-names
In-Reply-To: <20150127005859.GC29710@verge.net.au>
References: <20150122022559.GC31170@verge.net.au>
 <20150127005859.GC29710@verge.net.au>
Message-ID: <CAMuHMdXMuJzJ6C-Wv4fGj4mXaU8jkJpS6Vf22y6uNMXOJpss3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Jan 27, 2015 at 1:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jan 22, 2015 at 11:25:59AM +0900, Simon Horman wrote:
>> * Correct base address of SD3 div6 clk.
>> * Update div6 labels and MSTP output names
>>   There appears to have been some inconsistency and confusion here as on
>>   the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
>>   the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
>>
>> This has no run-time affect as the clock nodes are not currently used.
>>
>> Fixes: 8e181633e6ca96049 ("ARM: shmobile: r8a7794: Add SDHI clocks to device tree")
>> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Geert,
>
> could you find a moment to look over this.
> Its a follow-up to an earlier patch which you gave me some
> feedback on.

Sorry, it fell through the cracks.

>> ---
>> * A similar change to update the div6 clock node names and labels,
>>   and the MSTP clock output-names is required for the r8a7791.
>>   The base addresses appear to be correct there.
>> ---
>>  arch/arm/boot/dts/r8a7794.dtsi | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
>> index 8f78da5..b98534e 100644
>> --- a/arch/arm/boot/dts/r8a7794.dtsi
>> +++ b/arch/arm/boot/dts/r8a7794.dtsi
>> @@ -294,16 +294,16 @@
>>                                            "lb", "qspi", "sdh", "sd0", "z";
>>               };
>>               /* Variable factor clocks */
>> -             sd1_clk: sd2_clk at e6150078 {
>> +             sd2_clk: sd2_clk at e6150078 {
>>                       compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>>                       reg = <0 0xe6150078 0 4>;
>>                       clocks = <&pll1_div2_clk>;
>>                       #clock-cells = <0>;
>>                       clock-output-names = "sd1";

I think these should be "sd2"...

>>               };
>> -             sd2_clk: sd3_clk at e615007c {
>> +             sd3_clk: sd3_clk at e615026c {
>>                       compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>> -                     reg = <0 0xe615007c 0 4>;
>> +                     reg = <0 0xe615026c 0 4>;
>>                       clocks = <&pll1_div2_clk>;
>>                       #clock-cells = <0>;
>>                       clock-output-names = "sd2";

... and "sd3", as they refer to the clock signals from the clock generator,
and thus should match the register and label names.

(Note: The (old) R-Car E2 v0.1 datasheet does call them SD1 and SD2 :-(

>> @@ -518,7 +518,7 @@
>>               mstp3_clks: mstp3_clks at e615013c {
>>                       compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
>>                       reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>> -                     clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
>> +                     clocks = <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
>>                                <&mmc0_clk>, <&rclk_clk>, <&hp_clk>, <&hp_clk>;
>>                       #clock-cells = <1>;
>>                       clock-indices = <
>> @@ -527,7 +527,7 @@
>>                               R8A7794_CLK_USBDMAC0 R8A7794_CLK_USBDMAC1
>>                       >;
>>                       clock-output-names =
>> -                             "sdhi2", "sdhi1", "sdhi0",
>> +                             "sdhi3", "sdhi2", "sdhi0",

These are disputable: the MSTP docs indeed call them SDHI3, SDHI2, and
SDHI0 (in the latest R-Car Gen2 family datasheet revision).
But for all(?) other MSTP clocks they match the actual module instances
that are driven by the clocks.
So I think these should stay "sdhi2", "sdhi1", and "sdhi0", as they refer to
the SDHI instances, not the parent clocks.

At least we should be consistent with the R8A7794_CLK_SDHIx indices,
which are 2, 1, and 0, not 3, 2, 0.

>>                               "mmcif0", "cmt1", "usbdmac0", "usbdmac1";
>>               };
>>               mstp7_clks: mstp7_clks at e615014c {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
