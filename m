From: james.morse@arm.com (James Morse)
Date: Mon, 22 Jan 2018 19:32:41 +0000
Subject: [PATCH v6 03/13] arm64: cpufeature: Detect CPU RAS Extentions
In-Reply-To: <78d4374a-f75c-6860-38ab-6373ffae3eee@huawei.com>
References: <20180115193906.30053-1-james.morse@arm.com>
 <20180115193906.30053-4-james.morse@arm.com>
 <78d4374a-f75c-6860-38ab-6373ffae3eee@huawei.com>
Message-ID: <5A663C59.6030205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 16/01/18 11:17, gengdongjiu wrote:
> Hi James,
> 
> On 2018/1/16 3:38, James Morse wrote:
>> From: Xie XiuQi <xiexiuqi@huawei.com>
>>
>> ARM's v8.2 Extentions add support for Reliability, Availability and
>> Serviceability (RAS). On CPUs with these extensions system software
>> can use additional barriers to isolate errors and determine if faults
>> are pending. Add cpufeature detection.
>>
>> Platform level RAS support may require additional firmware support.

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 664fadc2aa2e..1d51c8edf34b 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1062,6 +1062,22 @@ config ARM64_PMEM
>>  	  operations if DC CVAP is not supported (following the behaviour of
>>  	  DC CVAP itself if the system does not define a point of persistence).
>>  
>> +config ARM64_RAS_EXTN
>> +	bool "Enable support for RAS CPU Extensions"
>> +	default y
>> +	help
>> +	  CPUs that support the Reliability, Availability and Serviceability
>> +	  (RAS) Extensions, part of ARMv8.2 are able to track faults and
>> +	  errors, classify them and report them to software.
>> +
>> +	  On CPUs with these extensions system software can use additional
>> +	  barriers to determine if faults are pending and read the
>> +	  classification from a new set of registers.
>> +
>> +	  Selecting this feature will allow the kernel to use these barriers
>> +	  and access the new registers if the system supports the extension.
>> +	  Platform RAS features may additionally depend on firmware support.
>> +
>>  endmenu
>>  
> it seems this "CONFIG_ARM64_RAS_EXTN" is not enabled in the "arch/arm64/configs/defconfig",
> if not, I want to enable this config to enable RAS feature in the defconfig. do you agree?

Sure. This series doesn't do a lot on its own, it expects firmware-first or
kernel-first support, which may in turn depend-on this feature. It means we
don't panic() when notified of corrected errors, until we get the
{firmware,kernel}-first support.

Don't defconfig changes get collected by arm-soc? (I'm not sure how these get
picked up...)


James
