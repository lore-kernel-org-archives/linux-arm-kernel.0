From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 11 Jan 2018 11:48:13 +0000
Subject: [linux-sunxi] [PATCH 1/7] pinctrl: sunxi: add support for pin
 controllers without bus gate
In-Reply-To: <20180111104100.j5rwitma3wgtdivm@flea.lan>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <2ca1ee96-8dc6-c80b-ae11-45895d6a8484@arm.com>
 <CAGb2v64E-XOHVJG0Q-uZeCAdxF37QSVCDfiYmqtv7ydvseQwrw@mail.gmail.com>
 <ba83f00d-c1e5-6f6a-84df-04169860c7eb@arm.com>
 <20180111104100.j5rwitma3wgtdivm@flea.lan>
Message-ID: <cc84e3f9-84da-4642-fdf3-bd9679a7f79b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/01/18 10:41, Maxime Ripard wrote:
> On Thu, Jan 11, 2018 at 10:23:52AM +0000, Andre Przywara wrote:
>> Hi,
>>
>> On 11/01/18 10:14, Chen-Yu Tsai wrote:
>>> On Thu, Jan 11, 2018 at 6:08 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>>>> Hi,
>>>>
>>>> On 06/01/18 04:23, Icenowy Zheng wrote:
>>>>> The Allwinner H6 pin controllers (both the main one and the CPUs one)
>>>>> have no bus gate clocks.
>>>>>
>>>>> Add support for this kind of pin controllers.
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>>> ---
>>>>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 30 ++++++++++++++++++++----------
>>>>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
>>>>>  2 files changed, 21 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>>>> index 4b6cb25bc796..68cd505679d9 100644
>>>>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>>>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>>>> @@ -1182,7 +1182,12 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
>>>>>       unsigned int hosc_div, losc_div;
>>>>>       struct clk *hosc, *losc;
>>>>>       u8 div, src;
>>>>> -     int i, ret;
>>>>> +     int i, ret, clk_count;
>>>>> +
>>>>> +     if (pctl->desc->without_bus_gate)
>>>>> +             clk_count = 2;
>>>>> +     else
>>>>> +             clk_count = 3;
>>>>>
>>>>>       /* Deal with old DTs that didn't have the oscillators */
>>>>>       if (of_count_phandle_with_args(node, "clocks", "#clock-cells") != 3)
>>>>> @@ -1360,15 +1365,19 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>>>>>                       goto gpiochip_error;
>>>>>       }
>>>>>
>>>>> -     clk = devm_clk_get(&pdev->dev, NULL);
>>>>> -     if (IS_ERR(clk)) {
>>>>> -             ret = PTR_ERR(clk);
>>>>> -             goto gpiochip_error;
>>>>> -     }
>>>>> +     if (!desc->without_bus_gate) {
>>>>
>>>> Do we really need explicit support for that case?
>>>> Can't we have something that works automatically?
>>>>
>>>> if (node has clock-names property)              (A)
>>>>         use clocks as enumerated and named there
>>>
>>> You still need to know if the hardware has a bus gate or not.
>>> If it's missing, and it's disabled, you end up with unusable
>>> hardware.
>>
>> Yes. So what? If you have a broken DT, it will not work. Just don't do
>> it. I don't understand why we want to defend against this case.
> 
> This is not the point, but rather: if we have a way to detect easily
> that the device tree is missing a property that is missing in our
> binding, why shouldn't we do it?
> 
> We're already doing it for reg and interrupts for example, why not for
> the clocks?
> 
>>> Unless you are fully trusting the device tree to be correct.
>>
>> Sorry, but what else do we trust?
>>
>>> IMHO that makes for hard to find bugs during SoC bringup.
>>
>> I am not sure if that is really an issue. I would expect people
>> doing SoC bringup to be able to cope with those kinds of problems.
> 
> Riiiight, because it worked so well in the past. We definitely didn't
> overlooked some clocks used for debouncing in this particular driver,
> or some to get the timekeeping right in the RTC.

I think that's a different issue, because debouncing is an optional
feature. How would those kind of explicit molly guards here have
prevented this omission in the past, when we only discovered that later?

> The argument that "anyone who codes in the kernel should just know
> better" doesn't work, on multiple levels. Because anyone that actually
> knows better can make a mistake or overlook some feature (because you
> didn't have your morning coffee yet, or because it was undocumented)
> and because you just make someone that doesn't feel bad.

I agree to that. But: If something doesn't work, checking clocks and
reset would be my first impulse. And Icenowy did exactly that and
quickly found it.
Plus this only protects against known pitfalls.

> So, yes, we cannot not trust the device tree. But if we have a way to
> detect simple mistakes in the binding, we should also do it.

I totally honour that, I am just wondering what price we pay for that.
This kind of: "We need three clocks here, or wait, two clock in this
particular case" sounds a bit dodgy and little future proof to me.
Which is somewhat confirmed by the fact that we need to adjust this
check now. So I suggest we remove it, as we have more, actual checks
afterwards anyway. That should cover future extensions without further ado:
The clock-names property should cater nicely for those cases, hence my
suggestion to rely on it. Plus we need to support the legacy DTs with
just a single clock and no clock-names. Done.
So I think we should change the devm_get_clk(..., NULL) to
devm_get_clk(..., "apb"), and then check for just a single unnamed clock
if that fails (older DTs), or no clock at all, if we need to support
future SoCs without debouncing.

Looking deeper I actually think we are not binding compliant at the
moment, as we rely on the "apb" clock to be the first one, however
clock-names = "hosc", "losc", "apb" would be perfectly legal as well, as
we don't document a certain order of the clock - which is not necessary
with clock-names.

I can make a patch if we agree on that.

Cheers,
Andre.
