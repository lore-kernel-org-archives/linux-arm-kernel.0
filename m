From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 11 Jul 2017 11:49:47 +0300
Subject: [PATCH] gpu: host1x: Free the IOMMU domain when there is no
 device to attach
In-Reply-To: <20170710193305.5987-1-contact@paulk.fr>
References: <20170710193305.5987-1-contact@paulk.fr>
Message-ID: <1499762987.1340.10.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-07-10 at 21:33 +0200, Paul Kocialkowski wrote:
> When there is no device to attach to the IOMMU domain, as may be the
> case when the device-tree does not contain the proper iommu node, it
> is
> best to keep going without IOMMU support rather than failing.
> This allows the driver to probe and function instead of taking down
> all of the tegra drm driver, leading to missing display support.

Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/host1x/dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index ac65f52850a6..f296738d0de8 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -186,8 +186,13 @@ static int host1x_probe(struct platform_device
> *pdev)
>  			return -ENOMEM;
>  
>  		err = iommu_attach_device(host->domain, &pdev->dev);
> -		if (err)
> +		if (err == -ENODEV) {
> +			iommu_domain_free(host->domain);
> +			host->domain = NULL;
> +			goto iommu_skip;
> +		} else if (err) {
>  			goto fail_free_domain;
> +		}
>  
>  		geometry = &host->domain->geometry;
>  
> @@ -198,6 +203,7 @@ static int host1x_probe(struct platform_device
> *pdev)
>  		host->iova_end = geometry->aperture_end;
>  	}
>  
> +iommu_skip:
>  	err = host1x_channel_list_init(host);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to initialize channel
> list\n");
-- 
Paul Kocialkowski,

developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
