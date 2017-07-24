From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 15:48:54 +0800
Subject: [PATCH 3/4] arm: sunxi: Add AXP20X_ADC
In-Reply-To: <be7d4295-8759-f57e-a600-358c7344251c@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
 <20170721162005.18892-3-maxime.ripard@free-electrons.com>
 <CAGb2v64tx6M1CJSKr_wgD4LM+-ER+Yqpj-hUftptj41PVhbBBA@mail.gmail.com>
 <be7d4295-8759-f57e-a600-358c7344251c@free-electrons.com>
Message-ID: <CAGb2v64zOTtRJkej2j4vMrN42GibzGEe7YfQGbNKzoDST8ZTzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 2:43 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi all,
>
> I've been Cc'ed by Chen-Yu I think, thanks for the heads-up.
>
> On 22/07/2017 04:19, Chen-Yu Tsai wrote:
>> On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>> The APX20X_POWER option, that is a dependency of the USB controllers
>>> depends on IIO and AXP20X_ADC. Add it so that we can get a working USB
>>> back.
>>
>> The statement is only half true. AXP20X_POWER can fall back to reading
>> the ADC registers directly if AXP20X_ADC is not enabled.
>
> For any PMIC using "x-powers,axp202-usb-power-supply" compatible, that
> is true, the others imperatively use IIO channels as there was no prior
> support to this driver.
>
> The switch between reading IIO channels or directly reading the
> registers is done at probe by checking IS_ENABLED(AXP20X_ADC)
> (IS_ENABLED returns 1 when Kconfig is set to y or m). The goal was to
> not break the existing system when users would update to a newer kernel
> (as they may not have selected AXP20X_ADC).
>
> Since there is no hard dependency between AXP20X_ADC and AXP20X_POWER, I
> think we may have a problem when AXP20X_ADC is built as a module. Then
> AXP20X_POWER probing is deferred since it waits for the IIO channels.
> Also, if you do a modprobe on AXP20X_POWER it'll not probe AXP20X_ADC
> because the dependency is not declared. I don't know if there is a way
> to declare this dependency programatically only when AXP20X_ADC is built
> as a module?

There's request_module(), which actually asks the kernel to load a
module, or MODULE_SOFTDEP, which looks like an additional tag for
modprobe. The former gives you more control. The latter doesn't seem
to be used a lot.

>
>> Is there a plan
>> to remove this feature?
>>
>
> As said above (and in the commit log[1]), I added the condition for
> backward compatibility so anyone could still use AXP20X_POWER without
> the ADC, but maybe that is irrelevant? This could solve a bit of the
> "complexity" of the driver, now that we know we want to enforce
> AXP20X_ADC to be built with AXP20X_POWER. I'm obviously okay to remove
> this feature if my point of backward compatibility is irrelevant.

It was a good idea, considering we haven't added the new symbols to
any of the defconfigs. Alternatively, we could have all the AXP20X
sub-drivers have "default MFD_AXP20X". This way no one forgets to
enable new drivers.

>
> But now, we still have the problem that AXP20X_ADC is not needed for
> AXP20X_POWER for AXP22X (and those that don't have voltage/current
> sensing). We don't really need to force AXP20X_ADC to be built when the
> user want AXP20X_POWER.
>
> 1) We force AXP20X_ADC to be built whenever AXP20X_POWER is built, even
> for PMICs that don't have any voltage/current sensing. This way, we can
> enforce the dependency in Kconfig and everything's easy,
>
> 2) We programmatically set the dependency between AXP20X_ADC and
> AXP20X_POWER depending on the compatible used (AXP20X set the
> dependency, not AXP22X).

We could also look at it this way: does the user need/want the additional
voltage/current information? If not, then even IIO is not a requirement.
We could wrap all the related blocks in "if (IS_ENABLED(CONFIG_IIO))",
and also trim the exposed power supply properties along with.

The hard dependency can then be dropped to a soft "implies".

I have to say your first option is easier.

Regards
ChenYu

>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33863c938caa2538397170f1a355885f1ea1564e
>
> Thanks,
> Quentin
>
>> Also, AXP20X_ADC is only really needed if the hardware is AXP20x, and
>> not the later ones that don't have voltage/current sensing. I would
>> like to change the hard dependency on AXP20X_ADC to the "imply"
>> keyword in Kconfig for the AC and battery power supply drivers.
>> That is another discussion though.
>>
>> So I think the description should be something like
>>
>>     AXP20X_POWER depends on IIO. Even though it does not depend on
>>     AXP20X_ADC, it is the new, preferred way of getting power supply
>>     readings. The other AXP power supply drivers use it as well.
>>
>>     Enable both options.
>>
>> ChenYu
>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>  arch/arm/configs/sunxi_defconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
>>> index 400eb9366a66..456988dd7b0e 100644
>>> --- a/arch/arm/configs/sunxi_defconfig
>>> +++ b/arch/arm/configs/sunxi_defconfig
>>> @@ -127,6 +127,8 @@ CONFIG_DMADEVICES=y
>>>  CONFIG_DMA_SUN6I=y
>>>  # CONFIG_IOMMU_SUPPORT is not set
>>>  CONFIG_EXTCON=y
>>> +CONFIG_IIO=y
>>> +CONFIG_AXP20X_ADC=y
>>>  CONFIG_PWM=y
>>>  CONFIG_PWM_SUN4I=y
>>>  CONFIG_PHY_SUN4I_USB=y
>>> --
>>> 2.13.3
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
