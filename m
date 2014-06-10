From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Jun 2014 18:32:27 +0200
Subject: [PATCH 1/2] misc: atmel-ssc: support to read ssc version
In-Reply-To: <1402040495-10320-1-git-send-email-voice.shen@atmel.com>
References: <1402040495-10320-1-git-send-email-voice.shen@atmel.com>
Message-ID: <5397331B.1040903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 09:41, Bo Shen :
> Read SSC IP version to check whether it supports frame sync
> length extension feature.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

No. We already have 2 compatible versions for the DT or id table. Simply
add one.
Please use this infrastructure to describe such features, I don't want
to mix the approaches: "compatible string" xor "IP revision".

The DT of the product will then describe on which version of the IP it
can rely to have this feature.

Best regards,

> ---
> 
>  drivers/misc/atmel-ssc.c  | 7 +++++++
>  include/linux/atmel-ssc.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index 22de137..9f49bcb 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -136,6 +136,7 @@ static int ssc_probe(struct platform_device *pdev)
>  	struct resource *regs;
>  	struct ssc_device *ssc;
>  	const struct atmel_ssc_platform_data *plat_dat;
> +	u32 version;
>  
>  	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
>  	if (!ssc) {
> @@ -173,8 +174,14 @@ static int ssc_probe(struct platform_device *pdev)
>  	clk_prepare_enable(ssc->clk);
>  	ssc_writel(ssc->regs, IDR, -1);
>  	ssc_readl(ssc->regs, SR);
> +	version = ssc_readl(ssc->regs, VERSION);
>  	clk_disable_unprepare(ssc->clk);
>  
> +	if (version >= 0x300)
> +		ssc->has_fslen_ext = 1;
> +	else
> +		ssc->has_fslen_ext = 0;
> +
>  	ssc->irq = platform_get_irq(pdev, 0);
>  	if (!ssc->irq) {
>  		dev_dbg(&pdev->dev, "could not get irq\n");
> diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
> index 571a12e..9ee1b68 100644
> --- a/include/linux/atmel-ssc.h
> +++ b/include/linux/atmel-ssc.h
> @@ -19,6 +19,7 @@ struct ssc_device {
>  	int			user;
>  	int			irq;
>  	bool			clk_from_rk_pin;
> +	int			has_fslen_ext;
>  };
>  
>  struct ssc_device * __must_check ssc_request(unsigned int ssc_num);
> @@ -258,6 +259,8 @@ void ssc_free(struct ssc_device *ssc);
>  #define SSC_IMR_TXSYN_SIZE			 1
>  #define SSC_IMR_TXSYN_OFFSET			10
>  
> +#define SSC_VERSION			0x000000fc
> +
>  /* SSC PDC Receive Pointer Register */
>  #define SSC_PDC_RPR			0x00000100
>  
> 


-- 
Nicolas Ferre
