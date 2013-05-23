From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Thu, 23 May 2013 14:42:24 +0200
Subject: [PATCH 1/3] ARM: at91: move at91 aic driver to drivers/irqchip
In-Reply-To: <20130523141344.7a01ce88@skate>
References: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
 <1369299909-10078-2-git-send-email-b.brezillon@overkiz.com>
 <20130523101825.GL18614@n2100.arm.linux.org.uk>
 <20130523141344.7a01ce88@skate>
Message-ID: <519E0EB0.7000502@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2013 14:13, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
>
> On Thu, 23 May 2013 11:18:25 +0100, Russell King - ARM Linux wrote:
>
>> I notice arch/arm/mach-at91/pm.c makes use of some of the register
>> definitions:
>>
>>          at91_irq_suspend();
>>
>>          pr_debug("AT91: PM - wake mask %08x, pm state %d\n",
>>                          /* remember all the always-wake irqs */
>>                          (at91_pmc_read(AT91_PMC_PCSR)
>>                                          | (1 << AT91_ID_FIQ)
>>                                          | (1 << AT91_ID_SYS)
>>                                          | (at91_extern_irq))
>>                                  & at91_aic_read(AT91_AIC_IMR),
>>                          state);
>>
>> at91_irq_suspend() is in arch/arm/mach-at91/irq.c already, so there's no
>> reason that fragment can't be moved there.
>
> The problem is that the goal of the patch set is to move
> arch/arm/mach-at91/irq.c into drivers/irqchip/.
>
> However, if you move that chunk of code to drivers/irqchip/irq-at91.c,
> you are using at91_pmc_read() which is defined in
> arch/arm/mach-at91/include/mach/at91_pmc.h. So,
> drivers/irqchip/irq-at91.c would have to include such an header file,
> which is something we want to avoid since drivers/ code should not
> include something in <mach/...>, as it breaks multiplatform kernels.
>
> So, I'm afraid, simply moving this chunk of code in at91_irq_suspend()
> doesn't make the thing any better.
>
What about keeping the former at91_aic.h in arch/arm/match-at91 and copy 
the definitions we need in drivers/irqchip/irq-at91.c ?

This way we get an aic irqchip driver independant of any specific 
machine headers and keep the non dt boards and pm drivers without any 
change.

> Best regards,
>
> Thomas
>
