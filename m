From: robherring2@gmail.com (Rob Herring)
Date: Tue, 17 Jan 2012 10:24:38 -0600
Subject: [RFC PATCH 05/10] sh: intc: remove dependency on NR_IRQS
In-Reply-To: <CABMQnV+e90OdoK+bMQ16H1PLtBRt9n=QxdCCOT=SZN060Ys+cw@mail.gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-6-git-send-email-robherring2@gmail.com>
 <CABMQnVKfitZu01_sKeVoC94y3GjbfTHqFEZ8ANWF4PCqA6F-Ug@mail.gmail.com>
 <4F14DEF3.5020907@gmail.com>
 <CABMQnV+e90OdoK+bMQ16H1PLtBRt9n=QxdCCOT=SZN060Ys+cw@mail.gmail.com>
Message-ID: <4F15A0C6.9000901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2012 11:09 PM, Nobuhiro Iwamatsu wrote:
> 2012/1/17 Rob Herring <robherring2@gmail.com>:
>> On 01/16/2012 07:54 PM, Nobuhiro Iwamatsu wrote:
>>> Hi,
>>>
>>> 2012/1/14 Rob Herring <robherring2@gmail.com>:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> SH intc has a compile time dependency on NR_IRQS. Make this dependency a
>>>> local define so that shmobile (and ARM in general) can have run-time
>>>> NR_IRQS setting. SH has NR_IRQS set to 512 and shmobile has NR_IRQS set to
>>>> 1024, so we are using the maximum.
>>>>
>>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>>> ---
>>>>  drivers/sh/intc/balancing.c |    2 +-
>>>>  drivers/sh/intc/core.c      |    2 +-
>>>>  drivers/sh/intc/handle.c    |    2 +-
>>>>  drivers/sh/intc/internals.h |    9 +++++++++
>>>>  drivers/sh/intc/virq.c      |    2 +-
>>>>  5 files changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/sh/intc/balancing.c b/drivers/sh/intc/balancing.c
>>>> index cec7a96..bc78080 100644
>>>> --- a/drivers/sh/intc/balancing.c
>>>> +++ b/drivers/sh/intc/balancing.c
>>>> @@ -9,7 +9,7 @@
>>>>  */
>>>>  #include "internals.h"
>>>>
>>>> -static unsigned long dist_handle[NR_IRQS];
>>>> +static unsigned long dist_handle[INTC_NR_IRQS];
>>>>
>>>>  void intc_balancing_enable(unsigned int irq)
>>>>  {
>>>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>>>> index e53e449..2fde897 100644
>>>> --- a/drivers/sh/intc/core.c
>>>> +++ b/drivers/sh/intc/core.c
>>>> @@ -42,7 +42,7 @@ unsigned int nr_intc_controllers;
>>>>  * - this needs to be at least 2 for 5-bit priorities on 7780
>>>>  */
>>>>  static unsigned int default_prio_level = 2;    /* 2 - 16 */
>>>> -static unsigned int intc_prio_level[NR_IRQS];  /* for now */
>>>> +static unsigned int intc_prio_level[INTC_NR_IRQS];     /* for now */
>>>>
>>>>  unsigned int intc_get_dfl_prio_level(void)
>>>>  {
>>>> diff --git a/drivers/sh/intc/handle.c b/drivers/sh/intc/handle.c
>>>> index 057ce56..f461d53 100644
>>>> --- a/drivers/sh/intc/handle.c
>>>> +++ b/drivers/sh/intc/handle.c
>>>> @@ -13,7 +13,7 @@
>>>>  #include <linux/spinlock.h>
>>>>  #include "internals.h"
>>>>
>>>> -static unsigned long ack_handle[NR_IRQS];
>>>> +static unsigned long ack_handle[INTC_NR_IRQS];
>>>>
>>>>  static intc_enum __init intc_grp_id(struct intc_desc *desc,
>>>>                                    intc_enum enum_id)
>>>> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
>>>> index b0e9155..469f092 100644
>>>> --- a/drivers/sh/intc/internals.h
>>>> +++ b/drivers/sh/intc/internals.h
>>>> @@ -6,6 +6,15 @@
>>>>  #include <linux/radix-tree.h>
>>>>  #include <linux/device.h>
>>>>
>>>> +#define INTC_NR_IRQS   1024
>>>
>>> On SH, INTC_NR_IRQS ( NR_IRQS )  is using to by arch/sh/kernel/machvec.c.
>>> And, this is defined by arch/sh/include/asm/irq.h.
>>> You need to remove or rename from these.
>>>
>>
>> machvec.c will still pickup NR_IRQS from arch/sh/include/asm/irq.h, so
>> there is no change there. The value here is increased from 512 for SH to
>> 1024, but that should not have any functional impact only array storage
>> space. Where it is used is a bit of a hack as the comment indicates. The
>> only other easy way to fix it I see is with an #ifdef CONFIG_SH or
>> CONFIG_ARM here. I welcome patches if you've got better ideas.
>>
> 
> I also cared about the problem from which array increases in SH.
> Since drivers/sh/intc/internals.h is referred to only from intc function,
> it needs to define INTC_NR_IRQS as other places.
> 
> How is it that defines by Kconfig?
> I created a patch on your patch. Could you give comment?
> 
> Best regards,
>   Nobuhiro
> 
> ------
> diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
> index 45d08b6..9278bb0 100644
> --- a/arch/sh/include/asm/irq.h
> +++ b/arch/sh/include/asm/irq.h
> @@ -9,7 +9,6 @@
>   * advised to cap this at the hard limit that they're interested in
>   * through the machvec.
>   */
> -#define NR_IRQS			512
>  #define NR_IRQS_LEGACY		8	/* Legacy external IRQ0-7 */
> 
>  /*
> diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
> index 3d722e4..e6b12b4 100644
> --- a/arch/sh/kernel/machvec.c
> +++ b/arch/sh/kernel/machvec.c
> @@ -123,5 +123,5 @@ void __init sh_mv_setup(void)
>  	mv_set(mem_init);
> 
>  	if (!sh_mv.mv_nr_irqs)
> -		sh_mv.mv_nr_irqs = NR_IRQS;
> +		sh_mv.mv_nr_irqs = CONFIG_SH_NR_IRQS;
>  }
> diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
> index c88cbcc..38d51f1 100644
> --- a/drivers/sh/intc/Kconfig
> +++ b/drivers/sh/intc/Kconfig
> @@ -33,3 +33,9 @@ config INTC_MAPPING_DEBUG
>  	  between system IRQs and the per-controller id tables.
> 
>  	  If in doubt, say N.
> +
> +config SH_NR_IRQS
> +	int
> +	depends on ARCH_SHMOBILE || SUPERH
> +	default 1024 if ARCH_SHMOBILE
> +	default 512 if SUPERH
> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
> index 469f092..076c286 100644
> --- a/drivers/sh/intc/internals.h
> +++ b/drivers/sh/intc/internals.h
> @@ -6,7 +6,7 @@
>  #include <linux/radix-tree.h>
>  #include <linux/device.h>
> 
> -#define INTC_NR_IRQS	1024
> +#define INTC_NR_IRQS	CONFIG_SH_NR_IRQS
> 
>  #ifndef evt2irq
>  #define evt2irq(evt)            (((evt) >> 5) - 16)
> 

If we went this route I wonder if it would be better for this to be more
generic and have CONFIG_NR_IRQS like powerpc. However, I don't see
having CONFIG_NR_IRQS as being that useful in the SPARSE_IRQ case. Plus
it would be a much more invasive. I think I'll just add this to
linux/sh_intc.h:

#ifdef CONFIG_SUPERH
#define INTC_NR_IRQS   512
#else
#define INTC_NR_IRQS   1024
#endif

Rob
