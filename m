From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Thu, 13 Oct 2016 17:34:08 -0600
Subject: [PATCH V3 06/10] acpi: apei: panic OS with fatal error status
 block
In-Reply-To: <bf911628-71be-0dca-f1c7-c12e681bd37f@arm.com>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-7-git-send-email-tbaicar@codeaurora.org>
 <bf911628-71be-0dca-f1c7-c12e681bd37f@arm.com>
Message-ID: <18205aac-02ae-bd45-2d2d-aa01cf845ae7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Suzuki,

On 10/13/2016 7:00 AM, Suzuki K Poulose wrote:
> On 07/10/16 22:31, Tyler Baicar wrote:
>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>
>> Even if an error status block's severity is fatal, the kernel does not
>> honor the severity level and panic.
>>
>> With the firmware first model, the platform could inform the OS about a
>> fatal hardware error through the non-NMI GHES notification type. The OS
>> should panic when a hardware error record is received with this
>> severity.
>>
>> Call panic() after CPER data in error status block is printed if
>> severity is fatal, before each error section is handled.
>>
>> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> ---
>>  drivers/acpi/apei/ghes.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 28d5a09..36894c8 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -141,6 +141,8 @@ static unsigned long ghes_estatus_pool_size_request;
>>  static struct ghes_estatus_cache 
>> *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>>  static atomic_t ghes_estatus_cache_alloced;
>>
>> +static int ghes_panic_timeout __read_mostly = 30;
>> +
>>  static int ghes_ioremap_init(void)
>>  {
>>      ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
>> @@ -715,6 +717,12 @@ static int ghes_proc(struct ghes *ghes)
>>          if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
>>              ghes_estatus_cache_add(ghes->generic, ghes->estatus);
>>      }
>> +    if (ghes_severity(ghes->estatus->error_severity) >= 
>> GHES_SEV_PANIC) {
>> +        if (panic_timeout == 0)
>> +            panic_timeout = ghes_panic_timeout;
>> +        panic("Fatal hardware error!");
>
> I think there is a chance that we might miss the o/p of 
> ghes_print_estatus() as we use
> no pfx, and it could default to the normal loglevel and would never 
> get printed
> if panic() is encountered before it. On the other hand, there is 
> already a
> __ghes_panic() which does similar stuff. Is there a way we could reuse
> (may be even parts of) it ? Or at least use KERN_EMERG for the 
> ghes_print_estatus(),
> if the severity could result in panic() ?
__ghes_panic() does additional handling which we do not want to do here. 
I could make the following a helper function so it is not duplicated though:

if (panic_timeout == 0)
     panic_timeout = ghes_panic_timeout;
panic("Fatal hardware error!");

The pfx is actually being calculated already in __ghes_print_estatus():

         if (pfx == NULL) {
                 if (ghes_severity(estatus->error_severity) <=
                     GHES_SEV_CORRECTED)
                         pfx = KERN_WARNING;
                 else
                         pfx = KERN_ERR;
         }

 From ghes.h:

enum {
         GHES_SEV_NO = 0x0,
         GHES_SEV_CORRECTED = 0x1,
         GHES_SEV_RECOVERABLE = 0x2,
         GHES_SEV_PANIC = 0x3,
};

This will make the pfx KERN_ERR for the case of a panic.

Thanks,
Tyler
>
> Cheers
> Suzuki
>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
