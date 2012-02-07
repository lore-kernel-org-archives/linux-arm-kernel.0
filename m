From: yong.zhang0@gmail.com (Yong Zhang)
Date: Tue, 7 Feb 2012 17:03:05 +0800
Subject: [BUG] genirq: Race condition in ONESHOT IRQ handler disabling
 IRQ forever
In-Reply-To: <20271.35831.227679.177366@ipc1.ka-ro>
References: <20271.35831.227679.177366@ipc1.ka-ro>
Message-ID: <20120207090305.GB32736@zhy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 09:14:47AM +0100, =?utf-8?Q?Lothar_Wa=C3=9Fmann?= wrote:
> Hi,
> 
> I already sent this to <linux-kernel@vger.kernel.org> on Feb. 1, 2012
> but did not get any response there. So resending to a wider audience
> with improved subject line:
> 
> there is a race condition in the threaded IRQ handler code for oneshot
> interrupts that may lead to disabling an IRQ indefinitely. IRQs are
> masked before calling the hard-irq handler and are unmasked only after
> the soft-irq handler has been run. Thus if the hard-irq handler
> returns IRQ_HANDLED instead of IRQ_WAKE_THREAD, meaning the soft-irq
> will not be called, the interrupt will remain masked forever.
> 
> This can happen due to a short pulse on the interrupt line, that
> triggers the interrupt logic, but goes undetected by the hard-irq
> handler. The problem can be reproduced with the TSC2007 touch
> controller driver that uses ONESHOT interrupts.

Isn't it the responsibility of the driver (say TSC2007)?

In this case, TSC2007 should return IRQ_WAKE_THREAD IMHO.

Thanks,
Yong


> 
> The problem arises also with interrupt controllers that latch a level
> triggered IRQ until it is acknowledged (like the i.MX28 does).
> In this case the IRQ status bit will remain asserted after the
> soft-irq finishes and retrigger the interrupt while the interrupt line
> is already deasserted.
> 
> The following patch would solve the problem, but I'm not sure whether
> it's the Right Thing(TM) to do. Especially wrt. shared interrupts.
> 
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 470d08c..93beadb 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -146,6 +146,11 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
>  			/* Fall through to add to randomness */
>  		case IRQ_HANDLED:
>  			random |= action->flags;
> +			/* unmask the IRQ that has been left masked
> +			 * due to race condition
> +			 */
> +			if (res == IRQ_HANDLED && (action->flags & IRQF_ONESHOT))
> +				unmask_irq(desc);
>  			break;
>  
>  		default:
> 
> Best regards,
> 
> Lothar Wassmann
> -- 
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Only stand for myself
