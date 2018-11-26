From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 26 Nov 2018 09:21:03 +0100
Subject: [PATCH] media: cedrus: Fix a NULL vs IS_ERR() check
In-Reply-To: <20181126081044.yz5tenssdbt7mugb@kili.mountain>
References: <20181126081044.yz5tenssdbt7mugb@kili.mountain>
Message-ID: <7adca9862d2dafdc7cac10c878ff314eb7bc0c03.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-11-26 at 11:10 +0300, Dan Carpenter wrote:
> The devm_ioremap_resource() function doesn't return NULL pointers, it
> returns error pointers.

Good catch and thanks for the patch!

> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> index 32adbcbe6175..07520a2ce179 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -255,10 +255,10 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	res = platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
>  	dev->base = devm_ioremap_resource(dev->dev, res);
> -	if (!dev->base) {
> +	if (IS_ERR(dev->base)) {
>  		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
>  
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(dev->base);
>  		goto err_sram;
>  	}
>  
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/59cf55ee/attachment.sig>
