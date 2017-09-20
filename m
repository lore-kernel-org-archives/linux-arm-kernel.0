From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 21 Sep 2017 00:32:39 +0800
Subject: [PATCH 2/5] nvmem: mtk-efuse: use stack for nvmem_config
 instead of malloc'ing it
In-Reply-To: <1505134864-11975-3-git-send-email-yamada.masahiro@socionext.com>
References: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
 <1505134864-11975-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1505925159.17049.12.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Masahiro

For maintainability, I felt it's better if we use the same way to
register nvmem as that most drivers does under nvmem usually using
static structure. Otherwise, they should also be changed to use the
one-time data in stack to avoid extra bytes to keep them.

	Sean


On Mon, 2017-09-11 at 22:01 +0900, Masahiro Yamada wrote:
> nvmem_register() copies all the members of nvmem_config to
> nvmem_device.  So, nvmem_config is one-time use data during
> probing.  There is no point to keep it until the driver detach.
> Using stack should be no problem because nvmem_config is pretty
> small.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/nvmem/mtk-efuse.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 32fd572..fa7a0f6 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -49,7 +49,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	struct nvmem_device *nvmem;
> -	struct nvmem_config *econfig;
> +	struct nvmem_config econfig = {};
>  	void __iomem *base;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -57,19 +57,15 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
> -	if (!econfig)
> -		return -ENOMEM;
> -
> -	econfig->stride = 4;
> -	econfig->word_size = 4;
> -	econfig->reg_read = mtk_reg_read;
> -	econfig->reg_write = mtk_reg_write;
> -	econfig->size = resource_size(res);
> -	econfig->priv = base;
> -	econfig->dev = dev;
> -	econfig->owner = THIS_MODULE;
> -	nvmem = nvmem_register(econfig);
> +	econfig.stride = 4;
> +	econfig.word_size = 4;
> +	econfig.reg_read = mtk_reg_read;
> +	econfig.reg_write = mtk_reg_write;
> +	econfig.size = resource_size(res);
> +	econfig.priv = base;
> +	econfig.dev = dev;
> +	econfig.owner = THIS_MODULE;
> +	nvmem = nvmem_register(&econfig);
>  	if (IS_ERR(nvmem))
>  		return PTR_ERR(nvmem);
>  
