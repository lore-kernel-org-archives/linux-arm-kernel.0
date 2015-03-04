From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 04 Mar 2015 12:18:59 +0000
Subject: [PATCH 4/5] arm-cci: Split the code for PMU vs driver support
In-Reply-To: <54F5D914.7030705@arm.com>
References: <1425295754-13376-1-git-send-email-suzuki.poulose@arm.com>
 <1425295754-13376-5-git-send-email-suzuki.poulose@arm.com>
 <54F5D914.7030705@arm.com>
Message-ID: <54F6F833.1030906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 15:53, Sudeep Holla wrote:
>
>
> On 02/03/15 11:29, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> This patch separates the PMU driver code from the low level
>> CCI driver code.
>>
>> Introduces config options for both.
>>
>>    ARM_CCI400_PORT_CTRL	- controls the low level driver code for
>> 			  CCI400 ports.
>>    ARM_CCI400_PMU 	- controls the PMU driver code
>>    ARM_CCI400_COMMON 	- Common defintions for CCI400
>>
>> Also the ARM_CCI400_PORT_CTRL cannot be enabled by user. This
>> should be selected by platforms which need it.
>>
>> This patch also changes:
>>    ARM_CCI - common code for probing the CCI devices. This can be
>>      used for adding support for newer CCI versions(e.g, CCI-500).
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>    arch/arm/mach-exynos/Kconfig   |    2 +-
>>    arch/arm/mach-vexpress/Kconfig |    4 ++--
>>    drivers/bus/Kconfig            |   27 +++++++++++++++++++++++----
>>    drivers/bus/arm-cci.c          |   24 ++++++++++++++++++++----
>>    include/linux/arm-cci.h        |    7 ++++++-
>>    5 files changed, 52 insertions(+), 12 deletions(-)
>>
>
> [...]
>
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index b99729e..bdc189f 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -43,12 +43,31 @@ config OMAP_INTERCONNECT
>>    	help
>>    	  Driver to enable OMAP interconnect error handling driver.
>>
>> -config ARM_CCI
>> -	bool "ARM CCI driver support"
>> +config ARM_CCI400_PORT_CTRL
>> +	bool
>>    	depends on ARM && OF && CPU_V7
>> +	select ARM_CCI400_COMMON
>> +	help
>> +	  Low level power management driver for CCI400 cache coherent
>> +	  interconnect for ARM platforms.
>> +
>> +config ARM_CCI400_PMU
>> +	bool "ARM CCI400 PMU support"
>> +	depends on ARM || ARM64
>> +	depends on HW_PERF_EVENTS
>> +	select ARM_CCI400_COMMON
>>    	help
>> -	  Driver supporting the CCI cache coherent interconnect for ARM
>> -	  platforms.
>> +	  Support for PMU events monitoring on the ARM CCI cache coherent
>> +	  interconnect.
>> +
>> +	  If unsure, say N
>
> Just a query rather than comment. Before this change all platforms
> having ARM_CCI and HW_PERF_EVENTS had CCI PMU enabled by default.
> With this change, one has to select this option explicitly. I assume
> that's fine, else this needs to be default 'y'

Yes, that makes sense. Now that we decide if we can access the CCI 
safely at runtime, it is safe to make this default.

Regards
Suzuki
