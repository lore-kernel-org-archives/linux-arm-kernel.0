From: tj@kernel.org (Tejun Heo)
Date: Tue, 5 May 2015 13:04:40 -0400
Subject: [PATCH v4 1/2] libahci: Add support to handle HOST_IRQ_STAT as
 edge trigger latch.
In-Reply-To: <1430838822-17507-2-git-send-email-stripathi@apm.com>
References: <1430838822-17507-1-git-send-email-stripathi@apm.com>
 <1430838822-17507-2-git-send-email-stripathi@apm.com>
Message-ID: <20150505170440.GW1971@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Suman.

Looks pretty.  Some nitpicks.

On Tue, May 05, 2015 at 08:43:41PM +0530, Suman Tripathi wrote:
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 71262e0..2df2237 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -238,6 +238,8 @@ enum {
>  	AHCI_HFLAG_MULTI_MSI		= (1 << 16), /* multiple PCI MSIs */
>  	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
>  	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
> +	AHCI_HFLAG_EDGE_TRIG_IRQ	= (1 << 19), /* HOST_IRQ_STAT behaves as
> +							Edge Triggered */

Let's just name it ahci_HFLAG_EDGE_IRQ.

> +static irqreturn_t ahci_level_trig_intr(int irq, void *dev_instance)

ahci_single_level_irq_intr()

> +{
...
> @@ -1877,13 +1885,51 @@ static irqreturn_t ahci_single_irq_intr(int irq, void *dev_instance)
>  	 * Also, use the unmasked value to clear interrupt as spurious
>  	 * pending event on a dummy port might cause screaming IRQ.
>  	 */
> +

Extra newline which wasn't there before.

> +	writel(irq_stat, mmio + HOST_IRQ_STAT);
> +
> +	spin_unlock(&host->lock);
> +
> +	VPRINTK("EXIT\n");
> +
> +	return IRQ_RETVAL(rc);
> +}
> +
> +static irqreturn_t ahci_edge_trig_intr(int irq, void *dev_instance)

ahci_single_edge_irq_intr()

And let's please separate refactoring of intr routine and addition of
edge irq handling into two patches.

Thanks.

-- 
tejun
