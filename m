From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 18 Oct 2017 13:00:44 +0800
Subject: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
In-Reply-To: <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
Message-ID: <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 2017/10/18 1:06, Borislav Petkov wrote:
> On Tue, Oct 17, 2017 at 04:02:21PM +0800, Dongjiu Geng wrote:
>> ARMv8.2 requires implementation of the RAS extension, in
>> this extension it adds SEI(SError Interrupt) notification
>> type, this patch adds new GHES error source SEI handling
>> functions. Because this error source parsing and handling
>> methods are similar with the SEA. So share some SEA handling
>> functions with the SEI
>>
>> Expose one API ghes_notify_abort() to external users. External
>> modules can call this exposed API to parse and handle the
>> SEA or SEI.
>>
>> Note: For the SEI(SError Interrupt), it is asynchronous external
>> abort, the error address recorded by firmware may be not accurate.
>> If not accurate, EL3 firmware needs to identify the address to a
>> invalid value.
>>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> Tested-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  arch/arm64/mm/fault.c     |  4 +--
>>  drivers/acpi/apei/Kconfig | 15 ++++++++++
>>  drivers/acpi/apei/ghes.c  | 71 ++++++++++++++++++++++++++++++++++-------------
>>  include/acpi/ghes.h       |  2 +-
>>  4 files changed, 70 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 2509e4f..c98c1b3 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -585,7 +585,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  		if (interrupts_enabled(regs))
>>  			nmi_enter();
>>  
>> -		ret = ghes_notify_sea();
>> +		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
>>  
>>  		if (interrupts_enabled(regs))
>>  			nmi_exit();
>> @@ -682,7 +682,7 @@ int handle_guest_sea(phys_addr_t addr, unsigned int esr)
>>  	int ret = -ENOENT;
>>  
>>  	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
>> -		ret = ghes_notify_sea();
>> +		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
>>  
>>  	return ret;
>>  }
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index de14d49..47fcb0c 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -54,6 +54,21 @@ config ACPI_APEI_SEA
>>  	  option allows the OS to look for such hardware error record, and
>>  	  take appropriate action.
>>  
>> +config ACPI_APEI_SEI
>> +	bool "APEI Asynchronous SError Interrupt logging/recovering support"
> 
> What is "SError" ?
SError is System Error, which is a asynchronous exception in the Internal CPU.

In the ARM RAS Extension, there are mainly two type abort for CPU:
SEA(Synchronous External Abort)
SEI(SError Interrupt)

> 
>> +	depends on ARM64 && ACPI_APEI_GHES
>> +	default y
>> +	help
>> +	  This option should be enabled if the system supports
>> +	  firmware first handling of SEI (asynchronous SError interrupt).
>> +
>> +	  SEI happens with asynchronous external abort for errors on device
>> +	  memory reads on ARMv8 systems. If a system supports firmware first
>> +	  handling of SEI, the platform analyzes and handles hardware error
>> +	  notifications from SEI, and it may then form a HW error record for
>> +	  the OS to parse and handle. This option allows the OS to look for
>> +	  such hardware error record, and take appropriate action.
>> +
>>  config ACPI_APEI_MEMORY_FAILURE
>>  	bool "APEI memory error recovering support"
>>  	depends on ACPI_APEI && MEMORY_FAILURE
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3eee30a..24b4233 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -815,43 +815,67 @@ static struct notifier_block ghes_notifier_hed = {
>>  
>>  #ifdef CONFIG_ACPI_APEI_SEA
>>  static LIST_HEAD(ghes_sea);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI_APEI_SEI
>> +static LIST_HEAD(ghes_sei);
>> +#endif
>>  
>> +#if defined(CONFIG_ACPI_APEI_SEA) || defined(CONFIG_ACPI_APEI_SEI)
>>  /*
>> - * Return 0 only if one of the SEA error sources successfully reported an error
>> - * record sent from the firmware.
>> + * Return 0 only if one of the SEA or SEI error sources successfully
>> + * reported an error record sent from the firmware.
>>   */
>> -int ghes_notify_sea(void)
>> +int ghes_notify_abort(u8 type)
> 
> Adding "abort" everywhere makes it worse: what does this function now
> do, notify or abort or both?
This function is used to notify APEI driver to parse APEI table and do some
recovery, such as calling memrory_failure() to identify the address to a
poisoned memory and deliver SIGBUS to related application.

> 
> Ditto for the remaining ones. Please think of a better name.
Ok, thanks for your good suggestion, I will consider to use a better name.

> 
> 
> ghes_notify_sei() sounds much better to me, for example. And then you
> can add a whole set of *_sei() functions similar to the *_sea() ones and
> then you don't have to do all that checking of the type but simply call
> the proper function set. They're not huge so that the duplication of
> code should be minimal.

Thanks for your suggestion again. I will flowing that and add a whole set
of *sei() functions.

> 
