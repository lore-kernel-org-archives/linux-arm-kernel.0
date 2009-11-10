From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 10 Nov 2009 16:24:43 +0800
Subject: enabling EXT_WAKEUP interrupts on PXA3xx
In-Reply-To: <4AF920E4.2070803@compulab.co.il>
References: <4AF91498.3060503@compulab.co.il>
	<20091110072818.GN14091@buzzloop.caiaq.de>
	<f17812d70911092334l545dd53ev8e2980abca1293ed@mail.gmail.com>
	<f17812d70911092335v3e198921u878f406a8c59ffda@mail.gmail.com>
	<4AF920E4.2070803@compulab.co.il>
Message-ID: <f17812d70911100024x420c3612u9586fab07399f72e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 4:14 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Eric Miao wrote:
>> On Tue, Nov 10, 2009 at 3:34 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> On Tue, Nov 10, 2009 at 3:28 PM, Daniel Mack <daniel@caiaq.de> wrote:
>>>> On Tue, Nov 10, 2009 at 09:22:00AM +0200, Mike Rapoport wrote:
>>>>> We need to enable EXT_WAKEUP interrupts on PXA3xx and I wonder what would be the
>>>>> best way to do it.
>>>>> I see two possibilities:
>>>>> 1) add 'if (irq == IRQ_WAKEUPx)' statements to pxa_{un}mask_irq functions in
>>>>> arch/arm/mach-pxa/irq.c
>>>>> 2) register additional irq_chip in arch/arm/mach-pxa/pxa3xx.c that will be
>>>>> responsible for handling EXT_WAKEUP (and probably other pxa3xx specific) interrupts.
>>>>>
>>>>> What do you prefer?
>>>> I'm just calling
>>>>
>>>> ?enable_irq_wake(IRQ_WAKEUP0);
>>>>
>>>> from my board support code, and it works fine - no need to change
>>>> anything else.
>>>>
>>> Daniel,
>>>
>>> I think Mike is talking about "interrupt" on EXT_WAKEUP0, which involves
>>> register PECR.
>>>
>>> My POV is the 2nd way to go, should be better and cleaner, but I'm always
>>> wondering where to add these additional two interrupts, possibly before
>>> the GPIO IRQs or after.
>>>
>>
>> Well, my second thought on this would be after GPIO IRQs and treat
>> them as board specific ones.
>>
>
> Currently we have
> #define IRQ_WAKEUP0 ? ? PXA_IRQ(49) ? ? /* EXT_WAKEUP0 */
> #define IRQ_WAKEUP1 ? ? PXA_IRQ(50) ? ? /* EXT_WAKEUP1 */
> so probably we'll just treat them in a way similar to IRQ_GPIO[0,1]:
>

Ah, right that's it, almost forgot. The code below looks OK to me,
and I think it would be better to put them into pxa3xx.c, as well
as the registration into pxa3xx_init_irq(). Feel free to file a patch
for this.

Thanks.

> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index d694ce2..bfc57e6 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -118,6 +118,24 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
> ? ? ? ?pxa_low_gpio_chip.set_wake = fn;
> ?}
>
> +static struct irq_chip pxa_ext_wakeup_chip = {
> + ? ? ? .name ? ? ? ? ? = "EXT-WAKEUP",
> + ? ? ? .ack ? ? ? ? ? ?= pxa_ack_ext_wakeup,
> + ? ? ? .mask ? ? ? ? ? = pxa_mask_ext_wakeup,
> + ? ? ? .unmask ? ? ? ? = pxa_unmask_ext_wakeup,
> +};
> +
> +static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
> +{
> + ? ? ? for (irq = IRQ_WAKEUP0; irq <= IRQ_WAKEUP1; irq++) {
> + ? ? ? ? ? ? ? set_irq_chip(irq, &pxa_ext_wakeup_chip);
> + ? ? ? ? ? ? ? set_irq_handler(irq, handle_edge_irq);
> + ? ? ? ? ? ? ? set_irq_flags(irq, IRQF_VALID);
> + ? ? ? }
> +
> + ? ? ? pxa_ext_wakeup_chip.set_wake = fn;
> +}
> +
> ?void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> ?{
> ? ? ? ?int irq, i;
> @@ -146,6 +164,9 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
>
> ? ? ? ?pxa_internal_irq_chip.set_wake = fn;
> ? ? ? ?pxa_init_low_gpio_irq(fn);
> +
> + ? ? ? if (cpu_is_pxa3xx())
> + ? ? ? ? ? ? ? pxa_init_ext_wakeup_irq(fn);
> ?}
>
>
>
> --
> Sincerely yours,
> Mike.
>
>
