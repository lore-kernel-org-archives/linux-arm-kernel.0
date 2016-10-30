From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 30 Oct 2016 12:53:02 +0100
Subject: [PATCH] drm/sun4i: Fix error handling
In-Reply-To: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
References: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
Message-ID: <c15282b4-e88a-06b1-527d-96aedce8b7eb@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

BTW, memory allocation in 'sun4i_layers_init()' looks spurious, 
especially the use of 'layer' in the for loop.
Just my 2 cents.


I also forgot to say that we could propagate the error code returned by 
sun4i_layers_init instead of returning -EINVAL unconditionally

CJ




Le 30/10/2016 ? 09:49, Christophe JAILLET a ?crit :
> 'sun4i_layers_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET<christophe.jaillet@wanadoo.fr>
> ---
>   drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 9776f0305834..628712e6edd6 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -143,7 +143,7 @@ static int sun4i_drv_bind(struct device *dev)
>   
>   	/* Create our layers */
>   	drv->layers = sun4i_layers_init(drm);
> -	if (!drv->layers) {
> +	if (IS_ERR(drv->layers)) {
>   		dev_err(drm->dev, "Couldn't create the planes\n");
>   		ret = -EINVAL;
>   		goto free_drm;
