From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 10 Feb 2016 07:42:02 -0600
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <56BB2D79.6090402@arm.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <56BB2D79.6090402@arm.com>
Message-ID: <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 6:30 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> just a ping:
>
> Are we really OK with breaking existing DTs in 4.6? (per the code in
> -next: f7d372ba54ea04d528a291b8dbe34716507bb60b, which is this patch).

I only warn and make sure people are aware of the issue. I leave that
up to platform maintainers to decide. It depends on the maturity of
the platform and users. If people complain about it then it's their
mess. For platforms supported in distros such as debian or fedora, I
would strongly recommend against breaking compatibility. They do ship
dtbs, but it's a chicken and egg problem. If dtbs were stable and
provided by firmware, then they wouldn't have to provide them. If dtbs
are unstable, then they have no choice.

> Also I think one needs ACKs from DT maintainers before merging something
> in the respective directories, which I don't see here.

It can go in with subsystem maintainers ack, but there are problems
with this one regardless of compatibility.

> As I am somewhat blocked on that patch, I'd like to have some discussion
> on the list.
>
> Thanks,
> Andre.
>
> On 05/02/16 17:59, Andre Przywara wrote:
>> Hi Maxime,
>>
>> just found this while looking at your current git branch, so sorry for
>> the late reply.
>>
>> CC:ing DT people, since you touch both existing DTs(!) and the binding doc.
>>
>> On 01/02/16 20:20, Maxime Ripard wrote:
>>> Remove the fixed dividers from the PLL6 driver to be able to have a
>>> reusable driver that can be used across several SoCs that share the same
>>> controller, but don't have the same set of dividers for this clock, and to
>>> also be reused multiple times in the same SoC, since we're droping the
>>> clock name.

Removing a compatible name or not has nothing to do with sharing code.

>>>
>>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>
>>> Changes from v3:
>>>   - Fixed the documentation
>>>   - Added pll6d2 back
>>>
>>> Changes from v2:
>>>   - Rebased and converted over to the new factors refactoring. Fixed the
>>>     retrieved rate
>>>
>>>  Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
>>>  arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 +++++++++++-----------
>>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 ++++++++++-----
>>>  arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
>>>  arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +--
>>>  arch/arm/boot/dts/sun8i-h3.dtsi                   | 37 ++++++++++++++---------
>>
>> So are you really breaking all those systems by changing the DT and the
>> driver in an incompatible way?
>> Please correct me if this assessment is wrong, but to me it looks like
>> any user out there is either stuck with 4.5 at best _or_ will only be
>> able to run 4.6 and later (depending on which version of the DT she is
>> using)? And no, switching DTs along with the kernel is _not_ an option.
>> That is not how I understand DT.
>> Also this totally ignores any other DT user (U-Boot, FreeBSD, you name it).
>>
>> I actually appreciate this rework, it's more flexible now and looks
>> better, but you really can't do this in a way to breaks compatibility
>> with existing DTs.
>>
>> Jean-Francois came up with another solution for the pll8 clock [1], so
>> could this be considered at least?
>> I think changing the H3 PLL8 clock from dummy to something real is a
>> different story in terms of compatibility (since it never really worked
>> before and this wouldn't change for any old-DT user).
>>
>> Cheers,
>> Andre.
>>
>> [1]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/405104.html
>>
>>>  drivers/clk/sunxi/clk-sunxi.c                     | 32 ++++++++++----------
>>>  7 files changed, 78 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>>> index e59f57b24777..f82850c0f6a5 100644
>>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>>> @@ -86,7 +86,7 @@ Required properties for all clocks:
>>>  - #clock-cells : from common clock binding; shall be set to 0 except for
>>>      the following compatibles where it shall be set to 1:
>>>      "allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
>>> -    "allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
>>> +    "allwinner,sun4i-pll6-clk",
>>>      "allwinner,*-usb-clk", "allwinner,*-mmc-clk",
>>>      "allwinner,*-mmc-config-clk"
>>>  - clock-output-names : shall be the corresponding names of the outputs.
>>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>>> index b6ad7850fac6..05fe3d1aa328 100644
>>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>>> @@ -65,7 +65,7 @@
>>>                      compatible = "allwinner,simple-framebuffer",
>>>                                   "simple-framebuffer";
>>>                      allwinner,pipeline = "de_be0-lcd0-hdmi";
>>> -                    clocks = <&pll6 0>;
>>> +                    clocks = <&pll6>;
>>>                      status = "disabled";
>>>              };
>>>
>>> @@ -73,7 +73,7 @@
>>>                      compatible = "allwinner,simple-framebuffer",
>>>                                   "simple-framebuffer";
>>>                      allwinner,pipeline = "de_be0-lcd0";
>>> -                    clocks = <&pll6 0>;
>>> +                    clocks = <&pll6>;
>>>                      status = "disabled";
>>>              };
>>>      };
>>> @@ -201,11 +201,11 @@
>>>              };
>>>
>>>              pll6: clk at 01c20028 {
>>> -                    #clock-cells = <1>;
>>> +                    #clock-cells = <0>;
>>>                      compatible = "allwinner,sun6i-a31-pll6-clk";

The name is removed, but remains here?
