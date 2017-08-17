From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 17 Aug 2017 10:19:54 +0100
Subject: [PATCH v3 3/5] reset: stm32: use the reset-simple driver
In-Reply-To: <d46ad9ea-4bf5-5ceb-cfc8-0c1efa48bb02@adaptrum.com>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-4-p.zabel@pengutronix.de>
 <edbdf06c-fb1e-63f1-d6b2-17193c86385a@adaptrum.com>
 <338608e8-9e83-fc0f-8d8a-18a336e94860@suse.de>
 <d46ad9ea-4bf5-5ceb-cfc8-0c1efa48bb02@adaptrum.com>
Message-ID: <74144e84-cd37-511a-9702-ceb590f37bf0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/08/17 21:55, Alexandru Gagniuc wrote:
> 
> 
> On 08/16/2017 01:52 PM, Andreas F?rber wrote:
>> Am 16.08.2017 um 22:50 schrieb Alexandru Gagniuc:
>>> On 08/16/2017 02:46 AM, Philipp Zabel wrote:
>>>> The reset-simple driver can be used without changes.
>>>>
>>>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>>
>>> Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>
>>>
>>>> ---
>>>>  drivers/reset/Kconfig        |  11 ++---
>>>>  drivers/reset/Makefile       |   1 -
>>>>  drivers/reset/reset-simple.c |   1 +
>>>>  drivers/reset/reset-stm32.c  | 108
>>>> -------------------------------------------
>>>>  4 files changed, 4 insertions(+), 117 deletions(-)
>>>>  delete mode 100644 drivers/reset/reset-stm32.c
>>>>
>>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>>> index 78a8f6057985b..29f4487c290fc 100644
>>>> --- a/drivers/reset/Kconfig
>>>> +++ b/drivers/reset/Kconfig
>>>> @@ -70,19 +70,14 @@ config RESET_PISTACHIO
>>>>
>>>>  config RESET_SIMPLE
>>>>      bool "Simple Reset Controller Driver" if COMPILE_TEST
>>>> -    default ARCH_SOCFPGA || ARCH_SUNXI
>>>> +    default ARCH_SOCFPGA || ARCH_STM32 || ARCH_SUNXI
>>>
>>> If this series gets respun, could you please look into removing the
>>> ARCH_ dependency here?
>>
>> Why?
> 
> Because the driver has to keep track of all its users, which is a
> layering violation.

"keep track of all its users": not necessarily, this is mostly for
convenience reasons to get automatic coverage for those SoCs without
changing various defconfigs - or distribution .configs, for that matter.
Especially the latter may prove to be nasty and introduce regressions.

But I see that this list may grow big and this is a bit beyond the scope
of the otherwise neat "default ARCH_xxx" trick.

So given the generic nature of this driver, can't we make this simply:
"default ARM || ARM64"
That would enable it everywhere automatically, but people can still
disable this if they know what they do.

Alternatively for ARM64 this is actually a candidate for the (one and
only) defconfig.

Cheers,
Andre.

>> It's not a dependency, just the default. Doing it here decouples it
>> from having to do Kconfig changes in the arm-soc tree as well.
> 
> Doing it here allows this list to grow without bounds.
> 
>> Regards,
>> Andreas
>>
