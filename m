From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 02 Dec 2011 14:25:12 +0100
Subject: [PATCH] irqdomain: protect macro variable in domain iterators
In-Reply-To: <20111202125932.GB2892@localhost.localdomain>
References: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202125932.GB2892@localhost.localdomain>
Message-ID: <4ED8D1B8.1010009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2011 01:59 PM, Dave Martin :
> On Fri, Dec 02, 2011 at 02:53:17PM +0100, Nicolas Ferre wrote:
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>> ---
>> Error found while using those iterators in an irq controller
>> initialization function.
>>
>> May also need protection around irq and hwirq macro variables
>> but those values are usually plain "int" anyway... Tell me if you
>> feel that it should be done.
>>
>>   include/linux/irqdomain.h |    8 ++++----
>>   1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index 99834e58..a553004 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -82,12 +82,12 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
>>   }
>>
>>   #define irq_domain_for_each_hwirq(d, hw) \
>> -	for (hw = d->hwirq_base; hw<  d->hwirq_base + d->nr_irq; hw++)
>> +	for (hw = (d)->hwirq_base; hw<  (d)->hwirq_base + (d)->nr_irq; hw++)
>>
>>   #define irq_domain_for_each_irq(d, hw, irq) \
>> -	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
>> -	     hw<  d->hwirq_base + d->nr_irq; \
>> -	     hw++, irq = irq_domain_to_irq(d, hw))
>> +	for (hw = (d)->hwirq_base, irq = irq_domain_to_irq((d), hw); \
>> +	     hw<  (d)->hwirq_base + (d)->nr_irq; \
>> +	     hw++, irq = irq_domain_to_irq((d), hw))
>
> I suggest just putting all the brackets in -- if having spotted this
> problem you only half-fix the macros, an opportunity is being missed;
> someone have to come and fix it again later:

Exactly, this is why I added a little comment to the patch:

"May also need protection around irq and hwirq macro variables
but those values are usually plain "int" anyway... Tell me if you
feel that it should be done."

> #define irq_domain_for_each_hwirq(d, hw) \
> 	for ((hw) = (d)->hwirq_base; (hw)<  (d)->hwirq_base + (d)->nr_irq; (hw)++)
>
> #define irq_domain_for_each_irq(d, hw, irq) \
> 	for ((hw) = (d)->hwirq_base, (irq) = irq_domain_to_irq(d, hw); \
> 	     (hw)<  (d)->hwirq_base + (d)->nr_irq; \
> 	     (hw)++, (irq) = irq_domain_to_irq(d, hw))
>
>
> If you feel happier though, you can harmlessly add the extra brackets round
> the arguments to irq_domain_to_irq(), without changing the behaviour.
> Arguably the "always add brackets" rule is simpler to understand.
>
> In fact, where a macro argument is not part of a larger expression, or is an
> operand to a comma-expression, there's no need for extra brackets -- all
> possible operators parse at higher priority than commas.  A macro argument
> which itself is a comma-expression whould have to be explicitly bracketed
> in the macro invocation anyway, so there is no extra risk of the macro
> expansion being parsed in an unexpected way in that case.

Thanks for the detailed explanation. I resend the patch with the "always 
add brackets" corrections.

Best regards,
-- 
Nicolas Ferre
