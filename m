From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Thu, 26 Apr 2018 09:42:55 -0500
Subject: [PATCH 2/3] edac: altera: Add support for Stratix10 SDRAM EDAC
In-Reply-To: <2d310ff0-fa0e-e432-ae11-ba34080b4f6e@kernel.org>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
 <1524594959-5259-3-git-send-email-thor.thayer@linux.intel.com>
 <2d310ff0-fa0e-e432-ae11-ba34080b4f6e@kernel.org>
Message-ID: <c66406a5-a73f-944c-ddc4-356795f8fdca@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2018 09:14 PM, Dinh Nguyen wrote:
> 
> 
> On 04/24/2018 01:35 PM, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add support for SDRAM ECC on the Stratix10 platform to
>> the EDAC device driver. Although Stratix10 is very similar
>> to the Arria10, hypervisor support for Stratix10 SDRAM ECC
>> requires the use of SMC calls to a higher priority
>> exception level to handle some register reads/writes.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   drivers/edac/Kconfig       |   2 +-
>>   drivers/edac/altera_edac.c | 459 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/edac/altera_edac.h | 114 +++++++++++
> 
> Does it make sense to have the support for this in separate files?
> 
>>   3 files changed, 574 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 3c4017007647..3c66b02b2473 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -379,7 +379,7 @@ config EDAC_THUNDERX
>>   
>>   config EDAC_ALTERA
>>   	bool "Altera SOCFPGA ECC"
>> -	depends on EDAC=y && ARCH_SOCFPGA
>> +	depends on EDAC=y && (ARCH_SOCFPGA || ARM64)
> 
> Should the ARM64 dependency just be ARCH_STRATIX10?
> 
Yes, I will update this.

>>   	help
>>   	  Support for error detection and correction on the
>>   	  Altera SOCs. This must be selected for SDRAM ECC.
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index 11d6419788c2..7ed885379719 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>> @@ -1,4 +1,5 @@
>>   /*
>> + *  Copyright (C) 2017-2018, Intel Corporation
> 
> If you're updating the license header, would it make sense to convert to
> SPDX?
> 
Yes, I can do that.

> Dinh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-edac" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
