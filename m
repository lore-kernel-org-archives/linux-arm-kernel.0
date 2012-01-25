From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 25 Jan 2012 10:59:25 -0700
Subject: [RFC 1/2] irq_domain: Create common xlate functions that device
 drivers can use
In-Reply-To: <CACxGe6s3R0fcBSf_YHTpXp15gtEBHRQg5-YM=cDO5UfY9cRGrQ@mail.gmail.com>
References: <1327450719-25590-1-git-send-email-grant.likely@secretlab.ca>
 <4F1F5FE0.9090901@gmail.com>
 <CACxGe6s3R0fcBSf_YHTpXp15gtEBHRQg5-YM=cDO5UfY9cRGrQ@mail.gmail.com>
Message-ID: <CACxGe6tgGqQSThzVVEzwOdtYkjKHT1uQhZBOkCTwkutyKXDCAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 10:35 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, Jan 24, 2012 at 6:50 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>>
>> On 01/24/2012 06:18 PM, Grant Likely wrote:
>>> Rather than having each interrupt controller driver creating its own barely
>>> unique .xlate function for irq_domain, create a library of translators which
>>> any driver can use directly.
>>>
>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>> index e7379a3..5e497a0 100644
>>> --- a/include/linux/irqdomain.h
>>> +++ b/include/linux/irqdomain.h
>>> @@ -110,6 +110,9 @@ struct irq_domain {
>>> ? ? ? void *host_data;
>>> ? ? ? irq_hw_number_t inval_irq;
>>>
>>> + ? ? /* Data for common irq xlate functions */
>>> + ? ? unsigned int xlate_type;
>>> +
>>
>> How does this get set? Do we want interrupt controllers messing with the
>> domain struct directly long term?
>
> It defaults to IRQ_TYPE_NONE in the alloc function and drivers can
> override it. ?Alternately it could be made part of the
> irq_domain_add() arguments, but I'm not thrilled with adding a whole
> bunch of arguments to the function prototype.

Do you like this better (built on top of this patch)?

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ef2b1fe..7856c04 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -701,12 +701,10 @@ int irq_domain_xlate_onecell(struct irq_domain
*d, struct device_node *ctrlr,
 			     const u32 *intspec, unsigned int intsize,
 			     unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 1, "Bad intspec for %s: intsize=%i < 1\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 1))
 		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = d->xlate_type;
-	return 0;
+	return irq_domain_xlate_onetwocell(d, ctrlr, intspec, 1,
+					   out_hwirq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);

@@ -721,12 +719,10 @@ int irq_domain_xlate_twocell(struct irq_domain
*d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 2, "Bad intspec for %s: intsize=%i < 2\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 2))
 		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+	return irq_domain_xlate_onetwocell(d, ctrlr, intspec, intsize,
+					   out_hwirq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);

@@ -746,8 +742,7 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 1, "Bad intspec for %s: intsize=%i < 1\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 1))
 		return -EINVAL;
 	*out_hwirq = intspec[0];
 	*out_type = d->xlate_type;
