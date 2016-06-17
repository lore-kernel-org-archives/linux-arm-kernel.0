From: bp@alien8.de (Borislav Petkov)
Date: Fri, 17 Jun 2016 18:51:31 +0200
Subject: [PATCHv3 2/7] EDAC, altera: Add panic flag check to A10 IRQ
In-Reply-To: <1465852752-11018-3-git-send-email-tthayer@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160617165131.GE3912@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:19:07PM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> In preparation for additional memory module ECCs, the
> IRQ function will check a panic flag before doing a
> kernel panic on double bit errors. ECCs on buffers
> will not cause a kernel panic on DBERRs.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  New patch. Add panic flag to IRQ function.
> v3  No change
> ---
>  drivers/edac/altera_edac.c |    4 +++-
>  drivers/edac/altera_edac.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 926bcaf..a9d8fa7 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -897,7 +897,8 @@ static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
>  		writel(ALTR_A10_ECC_DERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
>  		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> -		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> +		if (dci->data->panic)
> +			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>  
>  		return IRQ_HANDLED;
>  	}
> @@ -936,6 +937,7 @@ const struct edac_device_prv_data a10_ocramecc_data = {
>  	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
>  	.ecc_irq_handler = altr_edac_a10_ecc_irq,
>  	.inject_fops = &altr_edac_a10_device_inject_fops,
> +	.panic = true,

So I could use a bit more detailed explanation here why OCRAM must panic
and the others don't. Consider me an external guy who doesn't know the
hardware and is looking at the driver and is wondering why this IP must
panic on double-bit errors and the others don't.

:-)

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
