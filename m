From: tj@kernel.org (Tejun Heo)
Date: Thu, 14 Jan 2016 15:31:26 -0500
Subject: [PATCH v1 1/2] libahci: Implement the capability to override the
 generic ahci interrupt handler
In-Reply-To: <1452749424-28919-2-git-send-email-stripathi@apm.com>
References: <1452749424-28919-1-git-send-email-stripathi@apm.com>
 <1452749424-28919-2-git-send-email-stripathi@apm.com>
Message-ID: <20160114203126.GB3520@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Suman.

Your mails ended up in spam again and it looks to be from SPF failure.

  Received-SPF: softfail (google.com: domain of transitioning stripath at apm.com does not designate 198.145.29.136 as permitted sender) client-ip=198.145.29.136;
  Authentication-Results: mx.google.com;
	 spf=softfail (google.com: domain of transitioning stripath at apm.com does not designate 198.145.29.136 as permitted sender) smtp.mailfrom=stripath at apm.com;
	 dmarc=fail (p=QUARANTINE dis=NONE) header.from=apm.com

Can you please look into it?

On Thu, Jan 14, 2016 at 11:00:23AM +0530, Suman Tripathi wrote:
>  static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance)
>  {
> @@ -2517,16 +2518,21 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>  {
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int irq = hpriv->irq;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>  	int rc;
> 
>  	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
>  		rc = ahci_host_activate_multi_irqs(host, irq, sht);
> -	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
> -		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
> -				       IRQF_SHARED, sht);
> -	else
> -		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
> +	else {
> +		ahci_irq_handler = hpriv->ahci_irq_intr ? hpriv->ahci_irq_intr :
> +				   (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
> +				   ahci_single_edge_irq_intr :
> +				   ahci_single_level_irq_intr);
> +
> +		rc = ata_host_activate(host, irq, ahci_irq_handler,
>  				       IRQF_SHARED, sht);
> +	}
> +

So, if we have ->ahci_irq_intr, we don't need AHCI_HFLAG_EDGE_IRQ at
all, right?  Just initialize ->ahci_irq_intr to
ahci_single_level_irq_intr and let specific drivers overrie it?

Thanks.

-- 
tejun
