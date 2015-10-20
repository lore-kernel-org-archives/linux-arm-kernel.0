From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 13:18:05 +0900
Subject: [PATCH v4 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <5625B92C.10505@samsung.com>
References: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
 <1445255206-11148-7-git-send-email-pankaj.dubey@samsung.com>
 <56258683.7070204@samsung.com> <5625B92C.10505@samsung.com>
Message-ID: <5625C07D.4030706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 12:46, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> On Tuesday 20 October 2015 05:40 AM, Krzysztof Kozlowski wrote:
>> On 19.10.2015 20:46, Pankaj Dubey wrote:
>>> This patch adds Exynos SROM controller driver which will handle
>>> save restore of SROM registers during S2R.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>   drivers/soc/Kconfig               |   1 +
>>>   drivers/soc/Makefile              |   1 +
>>>   drivers/soc/samsung/Kconfig       |  13 +++
>>>   drivers/soc/samsung/Makefile      |   1 +
>>>   drivers/soc/samsung/exynos-srom.c | 179
>>> ++++++++++++++++++++++++++++++++++++++
>>>   drivers/soc/samsung/exynos-srom.h |  51 +++++++++++
>>>   6 files changed, 246 insertions(+)
>>>   create mode 100644 drivers/soc/samsung/Kconfig
>>>   create mode 100644 drivers/soc/samsung/Makefile
>>>   create mode 100644 drivers/soc/samsung/exynos-srom.c
>>>   create mode 100644 drivers/soc/samsung/exynos-srom.h
>>>
>>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>>> index 96ddecb..69107c9 100644
>>> --- a/drivers/soc/Kconfig
>>> +++ b/drivers/soc/Kconfig
>>> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>>>
>>>   source "drivers/soc/mediatek/Kconfig"
>>>   source "drivers/soc/qcom/Kconfig"
>>> +source "drivers/soc/samsung/Kconfig"
>>>   source "drivers/soc/sunxi/Kconfig"
>>>   source "drivers/soc/ti/Kconfig"
>>>   source "drivers/soc/versatile/Kconfig"
>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>>> index 0b12d77..a623616 100644
>>> --- a/drivers/soc/Makefile
>>> +++ b/drivers/soc/Makefile
>>> @@ -5,6 +5,7 @@
>>>   obj-$(CONFIG_MACH_DOVE)        += dove/
>>>   obj-$(CONFIG_ARCH_MEDIATEK)    += mediatek/
>>>   obj-$(CONFIG_ARCH_QCOM)        += qcom/
>>> +obj-$(CONFIG_SOC_SAMSUNG)    += samsung/
>>>   obj-$(CONFIG_ARCH_SUNXI)    += sunxi/
>>>   obj-$(CONFIG_ARCH_TEGRA)    += tegra/
>>>   obj-$(CONFIG_SOC_TI)        += ti/
>>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>>> new file mode 100644
>>> index 0000000..ea4bc2a
>>> --- /dev/null
>>> +++ b/drivers/soc/samsung/Kconfig
>>> @@ -0,0 +1,13 @@
>>> +#
>>> +# SAMSUNG SoC drivers
>>> +#
>>> +menu "Samsung SOC driver support"
>>> +
>>> +config SOC_SAMSUNG
>>> +    bool
>>> +
>>> +config EXYNOS_SROM
>>> +    bool
>>> +    depends on ARM && ARCH_EXYNOS
>>
>> When !PM then the driver will... do nothing, right? So maybe make it
>> depending on PM so tiny configs would benefit?
>>
> 
> Yes. Currently driver will do nothing if !PM. But as we know Fedin, has
> a plan to extend this driver for auxiliary H/W IP hooked to SROM. So in
> that case this dependency will not be valid as those functionality may
> not be dependent on PM, and we may need to remove it later. So I feel
> better not to add it at first place itself.

AFAIR Fedin was talking about missing functionality, not about adding
the contribution by himself. So he might add it or he might not. I did
not receive any commitments from him. The driver should be "proper" for
the time being (which could mean !PM dependency). If there is a need,
then the dependency will be removed.

> 
>>> +static int exynos_srom_remove(struct platform_device *pdev)
>>> +{
>>> +    struct exynos_srom *srom = platform_get_drvdata(pdev);
>>> +
>>> +    kfree(srom->reg_offset);
>>> +    iounmap(srom->reg_base);
>>> +    srom->reg_base = NULL;
>>> +    srom->reg_offset = NULL;
>>
>> There is no need anymore for these two NULL-s. It made sense only in
>> previous code when these were global variables. At this point the device
>> callbacks cannot be accessed so NULL-ifying does not change anything.
>>
> 
> Agreed. Will update.
> 

Thanks,
Krzysztof
