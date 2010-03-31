From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Tue, 30 Mar 2010 18:14:12 -0700
Subject: [PATCH 1/4] arm: msm: gpio support
In-Reply-To: <0D753D10438DA54287A00B027084269763691C346E@AUSP01VMBX24.collaborationhost.net>
References: <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
	<0D753D10438DA54287A00B027084269763691C346E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <d6200be21003301814m538a5902s649415d6cc7ec8fa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 4:58 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Tuesday, March 30, 2010 4:12 PM, Daniel Walker wrote:
>> From: Daniel Walker <c_dwalke@quicinc.com>
...
>> +
>> +static void msm_gpio_irq_ack(unsigned int irq)
>> +{
>> + ? ? unsigned long irq_flags;
>> + ? ? struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
>> + ? ? unsigned b;
>> +
>> + ? ? spin_lock_irqsave(&msm_chip->lock, irq_flags);
>> +
>> + ? ? b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
>
> Urk... That's a bit confusing...
>
> You might want to make this a macro or an inline function with some kind
> of comment.
>

On a related note, why did you inline msm_gpio_clear_detect_status? It
is used from two other functions.

>> +
>> +#if MSM_GPIO_BROKEN_INT_CLEAR
>> + ? ? /* Save interrupts that already triggered before we loose them. */
>> + ? ? /* Any interrupt that triggers between the read of int_status */
>> + ? ? /* and the write to int_clear will still be lost though. */
>> + ? ? msm_chip->int_status_copy |= readl(msm_chip->regs.int_status);
>> + ? ? msm_chip->int_status_copy &= ~b;
>> +#endif
>> + ? ? writel(b, msm_chip->regs.int_clear);
>> +
>> + ? ? msm_gpio_update_both_edge_detect(msm_chip);
>> + ? ? spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
>> +}
>> +
...

-- 
Arve Hj?nnev?g
