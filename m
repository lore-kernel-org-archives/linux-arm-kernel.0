From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jun 2015 14:32:14 -0600
Subject: [PATCH 02/21] ARM: tegra: Add gpio-ranges property
In-Reply-To: <CAAObsKBtmJnBZXcv0UE6xGvphSCShFNWehOG8a-PJg-VqPznRw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-3-git-send-email-tomeu.vizoso@collabora.com>
 <5564CC84.1030700@wwwdotorg.org>
 <CACRpkdbtCDQLaPhWFT0a7NdJmxYzRvhU_efgUh2ZXhbc+FHg3g@mail.gmail.com>
 <556DCE71.7050108@wwwdotorg.org>
 <CAAObsKBtmJnBZXcv0UE6xGvphSCShFNWehOG8a-PJg-VqPznRw@mail.gmail.com>
Message-ID: <558087CE.5070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2015 02:42 AM, Tomeu Vizoso wrote:
> On 2 June 2015 at 17:40, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/02/2015 05:28 AM, Linus Walleij wrote:
>>>
>>> On Tue, May 26, 2015 at 9:41 PM, Stephen Warren <swarren@wwwdotorg.org>
>>> wrote:
>>>>
>>>> On 05/25/2015 08:53 AM, Tomeu Vizoso wrote:
>>>>>
>>>>>
>>>>> Specify how the GPIOs map to the pins in T124, so the dependency is
>>>>> explicit.
>>>>>
>>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>> ---
>>>>>     arch/arm/boot/dts/tegra124.dtsi | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/tegra124.dtsi
>>>>> b/arch/arm/boot/dts/tegra124.dtsi
>>>>> index 13cc7ca..5d1d35f 100644
>>>>> --- a/arch/arm/boot/dts/tegra124.dtsi
>>>>> +++ b/arch/arm/boot/dts/tegra124.dtsi
>>>>> @@ -254,6 +254,7 @@
>>>>>                   gpio-controller;
>>>>>                   #interrupt-cells = <2>;
>>>>>                   interrupt-controller;
>>>>> +               gpio-ranges = <&pinmux 0 0 250>;
>>>>
>>>>
>>>>
>>>> We should be consistent between SoCs. Why not make the same change for
>>>> all
>>>> Tegra SoCs?
>>>
>>>
>>> Agreed.
>>>
>>>> I think this change will cause the GPIO subsystem to call into the
>>>> pinctrl
>>>> subsystem and create/add/register a new GPIO<->pinctrl range structure.
>>>> The
>>>> pinctrl driver already does this, so I think we'll end up with two
>>>> duplicate
>>>> entries in the pinctrl device's gpio_ranges list. This probably won't
>>>> cause
>>>> a problem, but I wanted to make sure you'd thought about it to make sure.
>>>
>>>
>>> That sounds like duplication indeed, I would expect that first a patch
>>> adds the ranges to the dts[i] files and then a second patch delete the
>>> same ranges from the pinctrl driver then, if these shall come in from
>>> the device tree.
>>
>>
>> We can't delete the gpio-range-registration code from the Tegra pinmux
>> driver, or old DTs won't work correctly. We could make it conditional based
>> upon whether the DT contains the property or not.
>
> I've been looking at this and haven't found a good solution. From what
> I see, the pinctrl driver doesn't have a reference to the gpio device
> node so cannot tell if it needs to add the range or not.

Well, we know what the node must be called, so the pinctrl driver could 
search for it by name.

> The gpio driver can tell whether it should add the range or not, but
> if it has to because the gpio-ranges property isn't there, then it
> doesn't have the reference to the pinctrl device to set the range to.
>
> So, given that pinctrl_add_gpio_range is deprecated already, wonder if
> the lesser evil isn't leaving the duplicated entries for now. On newer
> SoC revisions such as T210 we can stop calling pinctrl_add_gpio_range
> at all.
>
> Or, we can accept that nobody is going to boot a newer kernel with an
> older DT on the affected boards and just rely on the presence of the
> gpio-ranges property :)

Isn't the simplest solution to just leave it as it is? Nothing's broken 
is it?

For any new SoCs we add, we can certainly switch to a new scheme if we 
want, but we need to catch/implement that early before the base .dtsi 
file is included in its first kernel release.
