From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 09:50:18 -0600
Subject: [PATCH 02/21] ARM: tegra: Add gpio-ranges property
In-Reply-To: <CAAObsKB-ayRd7OB1W9nYBJzvBDK0RZk1U56Gqxn08sHPT5FvzA@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-3-git-send-email-tomeu.vizoso@collabora.com>
 <5564CC84.1030700@wwwdotorg.org>
 <CAAObsKD7YbZX01A=SS7z_PxAMPweHy6sw5ut=50h50C=j9y0zA@mail.gmail.com>
 <5565D96F.3000600@wwwdotorg.org>
 <CAAObsKB-ayRd7OB1W9nYBJzvBDK0RZk1U56Gqxn08sHPT5FvzA@mail.gmail.com>
Message-ID: <5567393A.6000901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 02:26 AM, Tomeu Vizoso wrote:
> On 27 May 2015 at 16:49, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/27/2015 08:18 AM, Tomeu Vizoso wrote:
>>>
>>> On 26 May 2015 at 21:41, Stephen Warren <swarren@wwwdotorg.org> wrote:
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
>>>>
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
>>> Actually, I have checked and see that gpio-tegra.c registers 256
>>> gpios, but pinctrl-tegra124.c adds a range of only 251. I don't really
>>> remember where I got the 250 value from, sorry :(
>>>
>>> I don't see how that would cause any concrete problems, but maybe we
>>> should have a single authoritative source (not sure we can do so
>>> without breaking DT ABI though).
>>>
>>>> Right now, I think we get lucky and pinctrl ends up probing first (or at
>>>> least very early) anyway. Somewhat related to this series, I wonder if we
>>>> shouldn't add pinctrl client properties to every node in the Tegra DT
>>>> that
>>>> describes a controller that makes use of external pins that are affected
>>>> by
>>>> the pinmux. Such a change would guarantee this desired probing order. In
>>>> order to preserve the "program the entire pinmux at once" semantics,
>>>> these
>>>> new pinctrl client properties would all need to reference empty states,
>>>> yet
>>>> would still need to exist to represent the dependency.
>>>
>>>
>>> I think so, but aren't almost all those pins used as gpios? If so,
>>> then such a controller's driver will request the gpio it wants which
>>> will cause the gpio driver to be registered (and hopefully probed) if
>>> needed, which in turn will check that the corresponding pinctrl device
>>> has been registered. Or am I missing something?
>>
>>
>> As you say this probably works out fine for pins that are used as GPIOs. I
>> was thinking more about SFIOs. Take an I2C controller, which doesn't use any
>> GPIOs itself. The pinctrl device should be probed before the I2C device, so
>> that the I2C driver can initiate transactions on the I2C bus during its
>> probe if it wanted to (or at least, clients could initiate transactions at
>> any completely arbitrary time as soon as probe was complete).
>
> What is using the SFIO in this case, the I2C master or the I2C client?

The I2C controller a/k/a the I2C master.

> In any case, is the problem you are referring to that ICs may rely on

s/ICs/drivers/ I think.

> a specific pinmux configuration but that's not currently reflected on
> the DT because pinmux configuration happened so early that things just
> worked?

Yes; the dependency of some nodes on pinctrl isn't explicitly called out 
in the DT. It's probably not a good idea to have such implicit 
dependencies, although I suppose for something so central as pinmux, 
maybe it's not terrible, since almost everything depends on it and it's 
pretty obvious.
