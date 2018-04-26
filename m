From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 26 Apr 2018 13:57:00 -0500
Subject: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
In-Reply-To: <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-8-jeremy.linton@arm.com>
 <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
Message-ID: <48bd3299-a95a-8aa6-524d-b3aa01dd9ef2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/26/2018 06:05 AM, Sudeep Holla wrote:
> 
> 
> On 26/04/18 00:31, Jeremy Linton wrote:
>> Call ACPI cache parsing routines from base cacheinfo code if ACPI
>> is enable. Also stub out cache_setup_acpi() so that individual
>> architectures can enable ACPI topology parsing.
>>
> 
> [...]
> 
>> +#ifndef CONFIG_ACPI
>> +static inline int acpi_find_last_cache_level(unsigned int cpu)
>> +{
>> +	/* ACPI kernels should be built with PPTT support */
> 
> This sounds incorrect for x86. But I understand why you have it there.
> Does it makes sense to change above to .. ?
> 
> #if !defined(CONFIG_ACPI) || (defined(CONFIG_ACPI) && !(CONFIG_ACPI_PPTT))
> 
I'm not sure what that buys us, if anything you want more non-users of 
the function to be falling through to the function prototype rather than 
the static inline. The only place any of this matters (as long as the 
compiler/linker is tossing the static inline) is arm64 because its the 
only arch making a call to acpi_find_last_cache_level(). ACPI_PPTT is 
also only visible on arm64 at the moment due to being wrapped in a if 
ARM64 in the Kconfig

Put another way, I wouldn't expect an arch to have a 'user' visible 
option to enable/disable parsing the PPTT. If an arch can handle 
ACPI/PPTT topology then I would expect it to be fixed to the CONFIG_ACPI 
state. What happens when acpi_find_last_cache_level() is called should 
only be dependent on whether ACPI is enabled, the PPTT parser itself 
will handle the cases of a missing table.
