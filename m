From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jan 2012 20:37:39 -0600
Subject: [RFC PATCH 05/10] sh: intc: remove dependency on NR_IRQS
In-Reply-To: <CABMQnVKfitZu01_sKeVoC94y3GjbfTHqFEZ8ANWF4PCqA6F-Ug@mail.gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-6-git-send-email-robherring2@gmail.com>
 <CABMQnVKfitZu01_sKeVoC94y3GjbfTHqFEZ8ANWF4PCqA6F-Ug@mail.gmail.com>
Message-ID: <4F14DEF3.5020907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2012 07:54 PM, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> 2012/1/14 Rob Herring <robherring2@gmail.com>:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> SH intc has a compile time dependency on NR_IRQS. Make this dependency a
>> local define so that shmobile (and ARM in general) can have run-time
>> NR_IRQS setting. SH has NR_IRQS set to 512 and shmobile has NR_IRQS set to
>> 1024, so we are using the maximum.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  drivers/sh/intc/balancing.c |    2 +-
>>  drivers/sh/intc/core.c      |    2 +-
>>  drivers/sh/intc/handle.c    |    2 +-
>>  drivers/sh/intc/internals.h |    9 +++++++++
>>  drivers/sh/intc/virq.c      |    2 +-
>>  5 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/sh/intc/balancing.c b/drivers/sh/intc/balancing.c
>> index cec7a96..bc78080 100644
>> --- a/drivers/sh/intc/balancing.c
>> +++ b/drivers/sh/intc/balancing.c
>> @@ -9,7 +9,7 @@
>>  */
>>  #include "internals.h"
>>
>> -static unsigned long dist_handle[NR_IRQS];
>> +static unsigned long dist_handle[INTC_NR_IRQS];
>>
>>  void intc_balancing_enable(unsigned int irq)
>>  {
>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>> index e53e449..2fde897 100644
>> --- a/drivers/sh/intc/core.c
>> +++ b/drivers/sh/intc/core.c
>> @@ -42,7 +42,7 @@ unsigned int nr_intc_controllers;
>>  * - this needs to be at least 2 for 5-bit priorities on 7780
>>  */
>>  static unsigned int default_prio_level = 2;    /* 2 - 16 */
>> -static unsigned int intc_prio_level[NR_IRQS];  /* for now */
>> +static unsigned int intc_prio_level[INTC_NR_IRQS];     /* for now */
>>
>>  unsigned int intc_get_dfl_prio_level(void)
>>  {
>> diff --git a/drivers/sh/intc/handle.c b/drivers/sh/intc/handle.c
>> index 057ce56..f461d53 100644
>> --- a/drivers/sh/intc/handle.c
>> +++ b/drivers/sh/intc/handle.c
>> @@ -13,7 +13,7 @@
>>  #include <linux/spinlock.h>
>>  #include "internals.h"
>>
>> -static unsigned long ack_handle[NR_IRQS];
>> +static unsigned long ack_handle[INTC_NR_IRQS];
>>
>>  static intc_enum __init intc_grp_id(struct intc_desc *desc,
>>                                    intc_enum enum_id)
>> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
>> index b0e9155..469f092 100644
>> --- a/drivers/sh/intc/internals.h
>> +++ b/drivers/sh/intc/internals.h
>> @@ -6,6 +6,15 @@
>>  #include <linux/radix-tree.h>
>>  #include <linux/device.h>
>>
>> +#define INTC_NR_IRQS   1024
> 
> On SH, INTC_NR_IRQS ( NR_IRQS )  is using to by arch/sh/kernel/machvec.c.
> And, this is defined by arch/sh/include/asm/irq.h.
> You need to remove or rename from these.
> 

machvec.c will still pickup NR_IRQS from arch/sh/include/asm/irq.h, so
there is no change there. The value here is increased from 512 for SH to
1024, but that should not have any functional impact only array storage
space. Where it is used is a bit of a hack as the comment indicates. The
only other easy way to fix it I see is with an #ifdef CONFIG_SH or
CONFIG_ARM here. I welcome patches if you've got better ideas.

>> +
>> +#ifndef evt2irq
>> +#define evt2irq(evt)            (((evt) >> 5) - 16)
>> +#endif
>> +#ifndef irq2evt
>> +#define irq2evt(irq)            (((irq) + 16) << 5)
>> +#endif
>> +
> 
> These are defined in arch/arm/mach-shmobile/include/mach/irqs.h and
> arch/sh/include/asm/irq.h.
> 
> I propose that linux/sh_intc.h defines these.
> 

Agreed. I will combine both versions there.

Rob

> Best regards,
>   Nobuhiro
> 
