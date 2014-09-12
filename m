From: tj@kernel.org (Tejun Heo)
Date: Sat, 13 Sep 2014 02:50:14 +0900
Subject: [PATCH] ahci_xgene: Fix the error print invalid resource for APM
 X-Gene SoC AHCI SATA Host Controller driver.
In-Reply-To: <1410508448-25111-2-git-send-email-stripathi@apm.com>
References: <1410508448-25111-1-git-send-email-stripathi@apm.com>
 <1410508448-25111-2-git-send-email-stripathi@apm.com>
Message-ID: <20140912175014.GA6298@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 01:24:08PM +0530, Suman Tripathi wrote:
> This patch fixes the error print invalid resource for the APM X-Gene
> SoC AHCI SATA Host Controller driver. This print was due to the fact
> that the controller 3 don't have a mux resource. This didn't result
> in any errors but the print seems like meaningless.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/ata/ahci_xgene.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 40d0a76..9404db0c 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -434,7 +434,7 @@ static int xgene_ahci_mux_select(struct xgene_ahci_context *ctx)
>  	u32 val;
> 
>  	/* Check for optional MUX resource */
> -	if (IS_ERR(ctx->csr_mux))
> +	if (!ctx->csr_mux)
>  		return 0;

Hmmm?  So, if devm_ioremap_resource() call actually fails, now the
function tries to operation on ERR_PTR() value as a real pointer?

Thanks.

-- 
tejun
