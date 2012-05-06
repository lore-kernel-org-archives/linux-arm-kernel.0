From: cjb@laptop.org (Chris Ball)
Date: Sun, 06 May 2012 12:09:40 -0400
Subject: [PATCH 4/9] mmc: mxs-mmc: adopt pinctrl support
In-Reply-To: <1336318505-27043-5-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Sun, 6 May 2012 23:35:00 +0800")
References: <1336318505-27043-1-git-send-email-shawn.guo@linaro.org>
 <1336318505-27043-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <87zk9lqojf.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patch looks fine -- perhaps you could copy the explanation about the
dummy pinctrl state for non-DT boards from your series introduction
into this commit message, since the commit messages go into git and
the series description doesn't?  Thanks.

On Sun, May 06 2012, Shawn Guo wrote:
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index e3f5af9..bb03ddd 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -39,6 +39,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  #include <linux/fsl/mxs-dma.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <mach/mxs.h>
>  #include <mach/common.h>
> @@ -682,6 +683,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	struct mmc_host *mmc;
>  	struct resource *iores, *dmares, *r;
>  	struct mxs_mmc_platform_data *pdata;
> +	struct pinctrl *pinctrl;
>  	int ret = 0, irq_err, irq_dma;
>  	dma_cap_mask_t mask;
>  
> @@ -719,6 +721,12 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	host->irq = irq_err;
>  	host->sdio_irq_en = 0;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		ret = PTR_ERR(pinctrl);
> +		goto out_iounmap;
> +	}
> +
>  	host->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(host->clk)) {
>  		ret = PTR_ERR(host->clk);

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
