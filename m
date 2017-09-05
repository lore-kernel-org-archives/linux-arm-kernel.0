From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Tue, 5 Sep 2017 10:20:12 +0800
Subject: [RFC PATCH v1 2/3] apei: add ghes param for
 arch_apei_report_mem_error
In-Reply-To: <20170901111526.plpslddmrjerkxtv@pd.tnic>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
 <1504261921-39308-3-git-send-email-xiexiuqi@huawei.com>
 <20170901111526.plpslddmrjerkxtv@pd.tnic>
Message-ID: <98147131-acb6-0a9f-2fd6-043cb2ff410e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 2017/9/1 19:15, Borislav Petkov wrote:
> n Fri, Sep 01, 2017 at 06:32:00PM +0800, Xie XiuQi wrote:
>> Add ghes param for arch_apei_report_mem_error, with which
>> we could do more arch-specific processing.
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> ---
>>  arch/x86/kernel/acpi/apei.c   | 2 +-
>>  drivers/acpi/apei/apei-base.c | 4 +++-
>>  drivers/acpi/apei/ghes.c      | 2 +-
>>  include/acpi/apei.h           | 4 +++-
>>  include/acpi/ghes.h           | 3 ++-
>>  5 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
>> index ea3046e..1bf1c9b 100644
>> --- a/arch/x86/kernel/acpi/apei.c
>> +++ b/arch/x86/kernel/acpi/apei.c
>> @@ -46,7 +46,7 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
>>  	return 1;
>>  }
>>  
>> -void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>> +void arch_apei_report_mem_error(struct ghes *ghes, int sev, struct cper_sec_mem_err *mem_err)
>>  {
>>  #ifdef CONFIG_X86_MCE
>>  	apei_mce_report_mem_error(sev, mem_err);
>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
>> index da370e1..317169b 100644
>> --- a/drivers/acpi/apei/apei-base.c
>> +++ b/drivers/acpi/apei/apei-base.c
>> @@ -38,6 +38,8 @@
>>  #include <linux/debugfs.h>
>>  #include <asm/unaligned.h>
>>  
>> +#include <acpi/ghes.h>
>> +
>>  #include "apei-internal.h"
>>  
>>  #define APEI_PFX "APEI: "
>> @@ -770,7 +772,7 @@ int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
>>  }
>>  EXPORT_SYMBOL_GPL(arch_apei_enable_cmcff);
>>  
>> -void __weak arch_apei_report_mem_error(int sev,
>> +void __weak arch_apei_report_mem_error(struct ghes *ghes, int sev,
>>  				       struct cper_sec_mem_err *mem_err)
>>  {
>>  }
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index fa9400d..996d16c4 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -483,7 +483,7 @@ static void ghes_do_proc(struct ghes *ghes,
>>  
>>  			ghes_edac_report_mem_error(ghes, sev, mem_err);
>>  
>> -			arch_apei_report_mem_error(sev, mem_err);
>> +			arch_apei_report_mem_error(ghes, sev, mem_err);
> 
> And next time you want to pass something else, you'll have to touch all
> those files again...
> 
> Instead, make that a notifier to which consumers register and define
> a separate struct mem_err or ghes_err or whatnot and populate it with
> cper_sec_mem_err data and whatever else is needed by the consumers.
> Instead of passing that struct ghes * which consumers don't need to
> know.

OK, I'll add a notify chain here, thanks.

> 
> Thx.
> 

-- 
Thanks,
Xie XiuQi
