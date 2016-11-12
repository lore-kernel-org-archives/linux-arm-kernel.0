From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sat, 12 Nov 2016 20:24:01 +0100
Subject: [PATCH RFT] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
In-Reply-To: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
References: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <40c3be7e-08c3-955c-746a-6906160e1e0a@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.11.2016 um 18:26 schrieb Stefan Wahren:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
> 
> So enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND
> to let the irqchip core allows and handles the power management.
> 
> This patch has been tested with a MX23 and a MX28 board. Any further
> tests especially with ASM9260 would be appreciated.

Hi, I wont be able to test this patch on ASM9260 until March.
Please roll it out, so far it looks ok for me.


> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/irqchip/irq-mxs.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> index 1730470..05fa9f7 100644
> --- a/drivers/irqchip/irq-mxs.c
> +++ b/drivers/irqchip/irq-mxs.c
> @@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d)
>  	.irq_ack = icoll_ack_irq,
>  	.irq_mask = icoll_mask_irq,
>  	.irq_unmask = icoll_unmask_irq,
> +	.flags = IRQCHIP_MASK_ON_SUSPEND |
> +		 IRQCHIP_SKIP_SET_WAKE,
>  };
>  
>  static struct irq_chip asm9260_icoll_chip = {
>  	.irq_ack = icoll_ack_irq,
>  	.irq_mask = asm9260_mask_irq,
>  	.irq_unmask = asm9260_unmask_irq,
> +	.flags = IRQCHIP_MASK_ON_SUSPEND |
> +		 IRQCHIP_SKIP_SET_WAKE,
>  };
>  
>  asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
> 


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161112/bdb33c52/attachment-0001.sig>
