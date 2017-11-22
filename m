From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Wed, 22 Nov 2017 15:46:19 +0900
Subject: [PATCH] nvmem: uniphier: change access unit from 32bit to 8bit
In-Reply-To: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <000001d3635d$9a33c9f0$ce9b5dd0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>

Thanks.

-----
Best Regards,
Keiji Hayashibara

> -----Original Message-----
> From: Kunihiko Hayashi [mailto:hayashi.kunihiko at socionext.com]
> Sent: Wednesday, November 22, 2017 2:15 PM
> To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Yamada, Masahiro/?? ?? <yamada.masahiro@socionext.com>; Hayashibara, Keiji/?? ??
> <hayashibara.keiji@socionext.com>; masami.hiramatsu at linaro.org; jaswinder.singh at linaro.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Hayashi, Kunihiko/? ??
> <hayashi.kunihiko@socionext.com>
> Subject: [PATCH] nvmem: uniphier: change access unit from 32bit to 8bit
> 
> The efuse on UniPhier allows 8bit access according to the specification.
> Since bit offset of nvmem is limited to 0-7, it is desiable to change access unit of nvmem to 8bit.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/nvmem/uniphier-efuse.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c index 2bb45c4..fac3122 100644
> --- a/drivers/nvmem/uniphier-efuse.c
> +++ b/drivers/nvmem/uniphier-efuse.c
> @@ -27,11 +27,11 @@ static int uniphier_reg_read(void *context,
>  			     unsigned int reg, void *_val, size_t bytes)  {
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
