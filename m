From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Nov 2014 13:06:20 +0000
Subject: [PATCH] ARM: warn if bad IRQ was scheduled
In-Reply-To: <1416574366-27182-1-git-send-email-dbaryshkov@gmail.com>
References: <1416574366-27182-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141121130619.GT4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 03:52:46PM +0300, Dmitry Eremin-Solenikov wrote:
> If somebody causes an unexpected bad IRQ, this even will be unnoticed in
> both dmesg and system logs. If the "bad" IRQ is stuck, the device will
> just hang silently w/o reporting anything. Compare this to the generic
> behaviour (from include/asm-generic/hardirq.h) which prints a message
> with critical level. So to help everybody, include the same message into
> ARM-specific ack_bad_irq().
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/include/asm/hw_irq.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
> index a71b417..b1fa129 100644
> --- a/arch/arm/include/asm/hw_irq.h
> +++ b/arch/arm/include/asm/hw_irq.h
> @@ -8,6 +8,7 @@ static inline void ack_bad_irq(int irq)
>  {
>  	extern unsigned long irq_err_count;
>  	irq_err_count++;
> +	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);

pr_crit please.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
