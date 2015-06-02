From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Jun 2015 09:40:33 -0600
Subject: [PATCH 02/21] ARM: tegra: Add gpio-ranges property
In-Reply-To: <CACRpkdbtCDQLaPhWFT0a7NdJmxYzRvhU_efgUh2ZXhbc+FHg3g@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<1432565608-26036-3-git-send-email-tomeu.vizoso@collabora.com>	<5564CC84.1030700@wwwdotorg.org>
 <CACRpkdbtCDQLaPhWFT0a7NdJmxYzRvhU_efgUh2ZXhbc+FHg3g@mail.gmail.com>
Message-ID: <556DCE71.7050108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2015 05:28 AM, Linus Walleij wrote:
> On Tue, May 26, 2015 at 9:41 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/25/2015 08:53 AM, Tomeu Vizoso wrote:
>>>
>>> Specify how the GPIOs map to the pins in T124, so the dependency is
>>> explicit.
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> ---
>>>    arch/arm/boot/dts/tegra124.dtsi | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/tegra124.dtsi
>>> b/arch/arm/boot/dts/tegra124.dtsi
>>> index 13cc7ca..5d1d35f 100644
>>> --- a/arch/arm/boot/dts/tegra124.dtsi
>>> +++ b/arch/arm/boot/dts/tegra124.dtsi
>>> @@ -254,6 +254,7 @@
>>>                  gpio-controller;
>>>                  #interrupt-cells = <2>;
>>>                  interrupt-controller;
>>> +               gpio-ranges = <&pinmux 0 0 250>;
>>
>>
>> We should be consistent between SoCs. Why not make the same change for all
>> Tegra SoCs?
>
> Agreed.
>
>> I think this change will cause the GPIO subsystem to call into the pinctrl
>> subsystem and create/add/register a new GPIO<->pinctrl range structure. The
>> pinctrl driver already does this, so I think we'll end up with two duplicate
>> entries in the pinctrl device's gpio_ranges list. This probably won't cause
>> a problem, but I wanted to make sure you'd thought about it to make sure.
>
> That sounds like duplication indeed, I would expect that first a patch
> adds the ranges to the dts[i] files and then a second patch delete the
> same ranges from the pinctrl driver then, if these shall come in from
> the device tree.

We can't delete the gpio-range-registration code from the Tegra pinmux 
driver, or old DTs won't work correctly. We could make it conditional 
based upon whether the DT contains the property or not.
