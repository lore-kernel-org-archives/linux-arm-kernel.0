From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 29 Oct 2016 10:05:24 +0800
Subject: [PATCH v2 3/4] arm64: arch_timer: Work around Erratum
 Hisilicon-161601
In-Reply-To: <20161028160000.GB1076@arm.com>
References: <1477553651-13428-1-git-send-email-dingtianhong@huawei.com>
 <1477553651-13428-3-git-send-email-dingtianhong@huawei.com>
 <20161028160000.GB1076@arm.com>
Message-ID: <431cffd1-0b14-ee5b-d349-e0e613f92ef0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/29 0:00, Will Deacon wrote:
> Hi Ding,
> 
> On Thu, Oct 27, 2016 at 03:34:10PM +0800, Ding Tianhong wrote:
>> Erratum Hisilicon-161601 says that the ARM generic timer counter "has the
>> potential to contain an erroneous value when the timer value changes".
>> Accesses to TVAL (both read and write) are also affected due to the implicit counter
>> read.  Accesses to CVAL are not affected.
>>
>> The workaround is to reread the system count registers until the value of the second
>> read is larger than the first one by less than 32, the system counter can be guaranteed
>> not to return wrong value twice by back-to-back read and the error value is always larger
>> than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.
>>
>> The workaround is enabled if the hisilicon,erratum-161601 property is found in
>> the timer node in the device tree.  This can be overridden with the
>> clocksource.arm_arch_timer.hisilicon-161601 boot parameter, which allows KVM
>> users to enable the workaround until a mechanism is implemented to
>> automatically communicate this information.
>>
>> Fix some description for fsl erratum a008585.
>>
>> v2: Significant rework based on feedback, including seperate the fsl erratum a008585
>>     to another patch, update the erratum name and remove unwanted code.
>>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> ---
> 
> [...]
> 
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 8a753fd..4aafb6a 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -312,8 +312,20 @@ config FSL_ERRATUM_A008585
>>  	help
>>  	  This option enables a workaround for Freescale/NXP Erratum
>>  	  A-008585 ("ARM generic timer may contain an erroneous
>> -	  value").  The workaround will only be active if the
>> +	  value").  The workaround will be active if the
>>  	  fsl,erratum-a008585 property is found in the timer node.
>> +	  This can be overridden with the clocksource.arm_arch_timer.fsl-a008585
>> +	  boot parameter.
>> +
>> +config HISILICON_ERRATUM_161601
>> +	bool "Workaround for Hisilicon Erratum 161601"
>> +	default y
>> +	depends on ARM_ARCH_TIMER && ARM64
>> +	help
>> +	  This option enables a workaround for Hisilicon Erratum
>> +	  161601. The workaround will be active if the hisilicon,erratum-161601
>> +	  property is found in the timer node. This can be overridden with
>> +	  the clocksource.arm_arch_timer.hisilicon-161601 boot parameter.
> 
> I'm really not keen on having a kernel commandline parameter for this.
> It's not something we've done for other, similar errata (e.g. CNTFRQ
> reporting the wrong value) and I think it's a slippery slope to having
> more of these workarounds controlled at boot-time. If you have a board
> that is affected by this, it's always going to need the workaround. Why
> would you turn it off?
> 

OK, miss it.

> Will
> 
> .
> 
