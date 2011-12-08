From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 08 Dec 2011 10:37:45 +0100
Subject: [PATCH v2] irqdomain: protect macro variable in domain iterators
In-Reply-To: <20111202134458.GD2892@localhost.localdomain>
References: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
 <1322832609-24956-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202134458.GD2892@localhost.localdomain>
Message-ID: <4EE08569.3070009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2011 02:44 PM, Dave Martin :
> On Fri, Dec 02, 2011 at 02:30:09PM +0100, Nicolas Ferre wrote:
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>
> Looks OK to me:
>
> Acked-by: Dave Martin<dave.martin@linaro.org>

Rob,

Do you want a different implementation for this. I think it is the 
simplest way to write this macro...

If it is ok for you, it will be interesting to include this patch 
quickly so that I will be able to queue my own patches on top of it.
(Cc: stable can be a good idea also).

Best regards,

>> ---
>> v2: add brackets to each macro variable.
>>
>>   include/linux/irqdomain.h |   10 ++++++----
>>   1 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index bd4272b..e535063 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -82,12 +82,14 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
>>   }
>>
>>   #define irq_domain_for_each_hwirq(d, hw) \
>> -	for (hw = d->hwirq_base; hw<  d->hwirq_base + d->nr_irq; hw++)
>> +	for ((hw) = (d)->hwirq_base; \
>> +	     (hw)<  (d)->hwirq_base + (d)->nr_irq; \
>> +	     (hw)++)
>>
>>   #define irq_domain_for_each_irq(d, hw, irq) \
>> -	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
>> -	     hw<  d->hwirq_base + d->nr_irq; \
>> -	     hw++, irq = irq_domain_to_irq(d, hw))
>> +	for ((hw) = (d)->hwirq_base, (irq) = irq_domain_to_irq((d), (hw)); \
>> +	     (hw)<  (d)->hwirq_base + (d)->nr_irq; \
>> +	     (hw)++, (irq) = irq_domain_to_irq((d), (hw)))
>>
>>   extern void irq_domain_add(struct irq_domain *domain);
>>   extern void irq_domain_del(struct irq_domain *domain);
>> --
>> 1.7.5.4
>>
>


-- 
Nicolas Ferre
