From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 5 Feb 2016 17:12:40 +0300
Subject: [PATCH v3 1/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
In-Reply-To: <1454620826-22554-2-git-send-email-stripathi@apm.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
 <1454620826-22554-2-git-send-email-stripathi@apm.com>
Message-ID: <56B4ADD8.1020008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/05/2016 12:20 AM, suman Tripathi wrote:

> From: Suman Tripathi <stripathi@apm.com>
>
> This patch implements the capability to override the generic
> ahci interrupt handler so that the LDD drivers can implement

    AHCI.

> there own custom interrupt handler routines.

    s/there/their/.

> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   drivers/ata/ahci.h    |    2 ++
>   drivers/ata/libahci.c |   32 +++++++++++++++++++++++---------
>   2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index a4faa43..3d883ee 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -360,6 +360,7 @@ struct ahci_host_priv {
>   	 * be overridden anytime before the host is activated.
>   	 */
>   	void			(*start_engine)(struct ata_port *ap);
> +	irqreturn_t 		(*ahci_irq_intr)(int irq, void *dev_instance);

    The 'ahci_irq_intr' name is somewhat tautological.


[...]
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index eda3cf2..5d3035a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
[...]
> @@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>   	struct ahci_host_priv *hpriv = host->private_data;
>   	int irq = hpriv->irq;
>   	int rc;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>
> -	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
> -		rc = ahci_host_activate_multi_irqs(host, sht);
> -	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
> -		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
> -				       IRQF_SHARED, sht);
> -	else
> -		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
> -				       IRQF_SHARED, sht);
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

    Why not *else* *if* on a single line?

[...]

MBR, Sergei
