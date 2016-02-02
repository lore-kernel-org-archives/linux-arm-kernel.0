From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Feb 2016 18:09:59 +0800
Subject: [PATCH 05/11] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <20160202100046.GM4652@lukather>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-6-git-send-email-andre.przywara@arm.com>
 <20160201182754.GA14737@excalibur.cnev.de>
 <56AFE0EC.8080207@arm.com> <20160202100046.GM4652@lukather>
Message-ID: <CAGb2v66JGbuQJUh5k6guhKrN4GqMmomyBFtqgcH09Zm-pVGxPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 6:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Andre,
>
> On Mon, Feb 01, 2016 at 10:49:16PM +0000, Andr? Przywara wrote:
>> On 01/02/16 18:27, Karsten Merker wrote:
>>
>> Hi Karsten,
>>
>> thank you very much for your feedback!
>>
>> > On Mon, Feb 01, 2016 at 05:39:24PM +0000, Andre Przywara wrote:
>> >> Based on the Allwinner A64 user manual and on the previous sunxi
>> >> pinctrl drivers this introduces the pin multiplex assignments for
>> >> the ARMv8 Allwinner A64 SoC.
>> >> Port A is apparently used for the fixed function DRAM controller, so
>> >> the ports start at B here (the manual mentions "n from 1 to 7", so
>> >> not starting at 0).
>> >>
>> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> >> ---
>> >>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>> >>  arch/arm64/Kconfig.platforms                       |   1 +
>> >>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>> >>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>> >>  drivers/pinctrl/sunxi/pinctrl-a64.c                | 606 +++++++++++++++++++++
>> >>  5 files changed, 613 insertions(+)
>> >>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-a64.c
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> >> index 9213b27..9050002 100644
>> >> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> >> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> >> @@ -21,6 +21,7 @@ Required properties:
>> >>    "allwinner,sun9i-a80-r-pinctrl"
>> >>    "allwinner,sun8i-a83t-pinctrl"
>> >>    "allwinner,sun8i-h3-pinctrl"
>> >> +  "allwinner,a64-pinctrl"
>> >
>> > Hello,
>> >
>> > on all other Allwinner SoCs we use the SoC family as part of the
>> > compatible, as well as in the names of the Kconfig options. To
>> > keep things consistent, I would like to propose doing the same on
>> > Arm64, i.e. using allwinner,sun50i-a64-pinctrl instead of
>> > allwinner,a64-pinctrl.
>>
>> Yes, I have been told this already. However I don't like this idea so
>> much, for the following reasons:
>> a) It is mostly redundant. The actual SoC (marketing) name is unique,
>> there is no sun6i-a20 or sun7i-a23.
>
> At the same time, the family name is mostly valid too.
>
> We do share some DTSI across some SoCs already by their family name
> (sun5i.dtsi for the A10s/A13/R8, sun8i-a23-a33.dtsi for the A23 and
> A33, etc.)
>
>> b) It is not even helpful. If I got Maxime correctly, then the newer
>> sunxi generation numbers depend on the ARM _cores_ used in the SoC,
>> which is frankly the least interesting part from a Linux support
>> perspective. I would see some sense if it would reflect the generation
>> of IP blocks used, but so it is even more confusing to see that
>> sun7i-a20 and sun8i-a23 are related, but sun8i-h3 is a completely
>> different beast. The Allwinner marketing name tells you that, but the
>> sunxi one does not.
>
> The opposite can be said too.
>
> The A31 is quite different from the A33, while the A83 is much closer
> to the H3 than it is to the A80. Their marketing scheme is messy. In
> all aspects. We have a scheme that worked, I'd really like to stick
> with it.
>
>> c) It is very confusing for people not dealing with it everyday. Just
>> because I own a BananaPi I know that the A20 is sun7i, but I am totally
>> lost when it comes to all the other names. And even now it took me about
>> a minute to find the appropriate Wiki page which explains part of that
>> story.
>> d) Most importantly ;-): It kills TAB completion, unless you know the
>> sunxi number, which is mostly not true as pointed out in c)
>
> Both of these are true, but are about the DT filenames, and not the
> compatibles. I'd agree with you on this one now that we have
> per-vendor subfolders in boot/dts, but it was not the case before, and
> I'm pretty sure that to anyone that is not aware of the Allwinner SoCs
> names, having an A<number>.dtsi in arch/arm/boot/dts, it would be
> about a Cortex-A<number>, and definitely not an SoC from some random
> vendor.
>
> So, droping it in the filenames, why not. But I'd really like to keep
> the same compatible scheme.

If we do end up dropping it from the filenames, can you (Andr?) update
MAINTAINERS to add "arch/arm64/boot/dts/sunxi/" to the sunxi entry?

Thanks.
ChenYu
