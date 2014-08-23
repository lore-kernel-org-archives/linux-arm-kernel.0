From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 23 Aug 2014 22:43:57 +0400
Subject: [PATCH v8 2/3] ahci_xgene: Skip the PHY and clock initialization
 if already configured by the firmware.
In-Reply-To: <1408819047-17224-3-git-send-email-stripathi@apm.com>
References: <1408819047-17224-1-git-send-email-stripathi@apm.com>
 <1408819047-17224-3-git-send-email-stripathi@apm.com>
Message-ID: <53F8E0ED.6030802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/23/2014 10:37 PM, Suman Tripathi wrote:

> This patch implements the feature to skip the PHY and clock
> initialization if it is already configured by the firmware.

> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   drivers/ata/ahci_xgene.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index f416495..fd9c137 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -145,6 +145,15 @@ static unsigned int xgene_ahci_qc_issue(struct ata_queued_cmd *qc)
>   	return rc;
>   }
>
> +static bool xgene_ahci_is_memram_inited(struct xgene_ahci_context *ctx)
> +{
> +	void __iomem *diagcsr = ctx->csr_diag;
> +
> +	return (readl(diagcsr + CFG_MEM_RAM_SHUTDOWN) == 0 &&
> +	        readl(diagcsr + BLOCK_MEM_RDY) == 0xFFFFFFFF) ?
> +		true : false;

    Just return the result of &&, that should be enough.

WBR, Sergei
