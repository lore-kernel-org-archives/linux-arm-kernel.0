From: tj@kernel.org (Tejun Heo)
Date: Fri, 5 Feb 2016 11:41:22 -0500
Subject: [PATCH v3 1/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
In-Reply-To: <1454620826-22554-2-git-send-email-stripathi@apm.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
 <1454620826-22554-2-git-send-email-stripathi@apm.com>
Message-ID: <20160205164122.GB4401@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Feb 05, 2016 at 02:50:24AM +0530, suman Tripathi wrote:
...
> @@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int irq = hpriv->irq;
>  	int rc;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
> 
> +	ahci_irq_handler = hpriv->ahci_irq_intr;
> +
> +	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
> +		if (!ahci_irq_handler)
> +			rc = ahci_host_activate_multi_irqs(host, sht);
> +		else
> +			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
> +				 and custom irq handler implemented\n");
> +
> +	} else {
> +		if (!ahci_irq_handler) {
> +			ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
> +			 		    ahci_single_edge_irq_intr :
> +					    ahci_single_level_irq_intr);
> +		}
> +	}

I wrote this before but can't we do this in save_initial_config the
same way ->start_engine override is handled?

-- 
tejun
