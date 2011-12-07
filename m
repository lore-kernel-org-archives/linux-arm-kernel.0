From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 7 Dec 2011 22:34:19 +0530
Subject: [PATCH 2/4] arm: exynos4: add irq_domain support for wakeup
 interrupts
In-Reply-To: <4EDF9344.7040003@gmail.com>
References: <1323266392-28330-1-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-2-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-3-git-send-email-thomas.abraham@linaro.org>
 <4EDF9344.7040003@gmail.com>
Message-ID: <CAJuYYwTtFaEfxETCrKofG3zX_8=rMT6FFBtWfKopJVOALCvw1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 7 December 2011 21:54, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,
>
> On 12/07/2011 07:59 AM, Thomas Abraham wrote:
>> Add irq_domain support for the 32 wakeup interrupt sources.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/mach-exynos/include/mach/regs-gpio.h | ? ?4 +-
>> ?arch/arm/mach-exynos/irq-eint.c ? ? ? ? ? ? ? | ? 69 ++++++++++++++++---------
>> ?2 files changed, 46 insertions(+), 27 deletions(-)
>>
>
> [snip]
>
>> @@ -193,22 +199,35 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
>>
>> ?int __init exynos4_init_irq_eint(void)
>> ?{
>> - ? ? int irq;
>> + ? ? int irq, hwirq;
>> + ? ? struct irq_domain *domain = &exynos4_eint_irq_domain;
>> +
>> + ? ? domain->irq_base = irq_alloc_descs(IRQ_EINT(0), IRQ_EINT(0),
>
> Can this be dynamic and remove any compile time knowledge of the irq base?

There are macros in the mach-exynos code that define linux irq numbers
for specific uses. For instance, linux interrupt number for wakeup
interrupt 0 is defined as IRQ_EINT(0) and maps to one of the linux irq
number. Consumer using this interrupt would use IRQ_EINT(0) in
request_irq or setup_irq.

Since the linux irq numbers are currently assigned to specific uses
like this, I am not sure how to make irq_alloc_descs dynamic and still
be able to use the dynamic irq base in the rest of the mach-exynos
code with no other code changes. Is there any way to handle this case?

Thanks,
Thomas.

>
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EXYNOS4_EINT_NR, 0);
>> + ? ? if (domain->irq_base < 0) {
>> + ? ? ? ? ? ? pr_err("exynos4_init_irq_eint: Failed to alloc irq descs\n");
>> + ? ? ? ? ? ? return -EBUSY;
>
> You will hit this error with sparse irq unless you set nr_irq in mach
> desc to NR_IRQ_LEGACY (16).

[...]
