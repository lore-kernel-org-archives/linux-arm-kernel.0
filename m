From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 14:24:20 +0000
Subject: [linux-sunxi] Re: [PATCH 05/11] drivers: pinctrl: add driver for
 Allwinner A64 SoC
In-Reply-To: <20160202035852.6984db63@i7>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-6-git-send-email-andre.przywara@arm.com>
 <20160201182754.GA14737@excalibur.cnev.de> <56AFE0EC.8080207@arm.com>
 <20160202035852.6984db63@i7>
Message-ID: <56B0BC14.8060007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 01:58, Siarhei Siamashka wrote:
> On Mon, 1 Feb 2016 22:49:16 +0000
> Andr? Przywara <andre.przywara@arm.com> wrote:
> 
>> On 01/02/16 18:27, Karsten Merker wrote:
>>
>> Hi Karsten,
>>
>> thank you very much for your feedback!
>>
>>> On Mon, Feb 01, 2016 at 05:39:24PM +0000, Andre Przywara wrote:  
>>>> Based on the Allwinner A64 user manual and on the previous sunxi
>>>> pinctrl drivers this introduces the pin multiplex assignments for
>>>> the ARMv8 Allwinner A64 SoC.
>>>> Port A is apparently used for the fixed function DRAM controller, so
>>>> the ports start at B here (the manual mentions "n from 1 to 7", so
>>>> not starting at 0).
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>>>>  arch/arm64/Kconfig.platforms                       |   1 +
>>>>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>>>>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>>>>  drivers/pinctrl/sunxi/pinctrl-a64.c                | 606 +++++++++++++++++++++
>>>>  5 files changed, 613 insertions(+)
>>>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-a64.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>>>> index 9213b27..9050002 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>>>> @@ -21,6 +21,7 @@ Required properties:
>>>>    "allwinner,sun9i-a80-r-pinctrl"
>>>>    "allwinner,sun8i-a83t-pinctrl"
>>>>    "allwinner,sun8i-h3-pinctrl"
>>>> +  "allwinner,a64-pinctrl"  
>>>
>>> Hello,
>>>
>>> on all other Allwinner SoCs we use the SoC family as part of the
>>> compatible, as well as in the names of the Kconfig options. To
>>> keep things consistent, I would like to propose doing the same on
>>> Arm64, i.e. using allwinner,sun50i-a64-pinctrl instead of
>>> allwinner,a64-pinctrl.  
>>
>> Yes, I have been told this already. However I don't like this idea so
>> much, for the following reasons:
>> a) It is mostly redundant. The actual SoC (marketing) name is unique,
>> there is no sun6i-a20 or sun7i-a23.
>> b) It is not even helpful. If I got Maxime correctly, then the newer
>> sunxi generation numbers depend on the ARM _cores_ used in the SoC,
>> which is frankly the least interesting part from a Linux support
>> perspective. I would see some sense if it would reflect the generation
>> of IP blocks used, but so it is even more confusing to see that
>> sun7i-a20 and sun8i-a23 are related, but sun8i-h3 is a completely
>> different beast. The Allwinner marketing name tells you that, but the
>> sunxi one does not.
>> c) It is very confusing for people not dealing with it everyday. Just
>> because I own a BananaPi I know that the A20 is sun7i, but I am totally
>> lost when it comes to all the other names. And even now it took me about
>> a minute to find the appropriate Wiki page which explains part of that
>> story.
>> d) Most importantly ;-): It kills TAB completion, unless you know the
>> sunxi number, which is mostly not true as pointed out in c)
>>
>> So while I see that just a<somenumber> is not really very specific, I'd
>> rather do away with current naming scheme for the future. In this
>> particular case we have the vendor name as a name space identifier
>> already, so there is no possible confusion with ARM Cortex naming, for
>> instance.
>>
>> Also as this is now moving into the arm64 world, I'd like to use the
>> opportunity to fix things that are not really optimal, the naming is one
>> of them.
> 
> One of the problems is that A64 name is not unique. We have reasons
> to believe that there are also H64 and R18 out there using exactly
> the same die, but possibly available in different packaging (a different
> ball grid pitch? or maybe a different set of peripherals routed to the
> outside?). Early prototypes of the Pine64 board were using Allwinner R18
> and the Jide Remix Mini HTPC box is using Allwinner H64.

So if the differences are actually hidden from software, why would we
care? See below for an example on using DT to cover this.

> The bootloader sources from Allwinner are also referring to A64 as
> AW1689, which makes some sense because it is the chip id number that
> is accessible for runtime identification via reading the SRAM_VER_REG
> hardware register:
> 
>     http://linux-sunxi.org/SRAM_Controller_Register_Guide#SRAM_VER_REG
> 
> So would it be a good idea to use "aw1689" as a compatible property
> in the DT instead of "a64"? Or maybe have "aw1689-a64" and
> "aw1689-h64", which would be similar to the existing "sun5i-a13"
> and "sun5i-a10s" naming convention?

I would be fine with that if it really reflects something in the
hardware. And I like it more than the rather arbitrary sun50i name. But
on the other hand it seems to be completely unknown so far (Google just
turns up this email and your sunxi-fel setup, basically). So I am not
sure we should introduce yet another naming scheme.

So looking at the compatible definition in the DT, this looks like a
perfect example of a fall-back name to me:
For the Pine64 we use "allwinner,a64", any other board could use say a:
"allwinner,h64", "allwinner,a64" compatible naming.
So as long as we don't need any h64 specifics, going with the A64
support code is fine. Should later the need arise to fix something for
the H64 only, we can add this easily and be covered automatically.

FWIW, I just have received this Remix Mini PC thing, which I ordered to
see what's with the H64 and to make sure the SoC/board abstraction is
right. So let me see what this version register looks like there and how
it behaves with the proposed kernel patches (should I be able to hack it).

Cheers,
Andre.
