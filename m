From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 13 Dec 2017 18:31:53 +0900
Subject: [PATCH] nvmem: uniphier: change access unit from 32bit to 8bit
In-Reply-To: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20171213183152.A835.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Srinivas,

This patch was already reviewed and tested for all UniPhier SoCs:
https://patchwork.kernel.org/patch/10069557/

Do you have any comments, or would you please pick it up?

Thank you,

On Wed, 22 Nov 2017 14:14:59 +0900 Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> The efuse on UniPhier allows 8bit access according to the specification.
> Since bit offset of nvmem is limited to 0-7, it is desiable to change
> access unit of nvmem to 8bit.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/nvmem/uniphier-efuse.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
> index 2bb45c4..fac3122 100644
> --- a/drivers/nvmem/uniphier-efuse.c
> +++ b/drivers/nvmem/uniphier-efuse.c
> @@ -27,11 +27,11 @@ static int uniphier_reg_read(void *context,
>  			     unsigned int reg, void *_val, size_t bytes)
>  {
>  	struct uniphier_efuse_priv *priv = context;
> -	u32 *val = _val;
> +	u8 *val = _val;
>  	int offs;
>  
> -	for (offs = 0; offs < bytes; offs += sizeof(u32))
> -		*val++ = readl(priv->base + reg + offs);
> +	for (offs = 0; offs < bytes; offs += sizeof(u8))
> +		*val++ = readb(priv->base + reg + offs);
>  
>  	return 0;
>  }
> @@ -53,8 +53,8 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  
> -	econfig.stride = 4;
> -	econfig.word_size = 4;
> +	econfig.stride = 1;
> +	econfig.word_size = 1;
>  	econfig.read_only = true;
>  	econfig.reg_read = uniphier_reg_read;
>  	econfig.size = resource_size(res);
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi
