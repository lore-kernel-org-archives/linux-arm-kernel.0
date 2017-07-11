From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Tue, 11 Jul 2017 09:43:43 +0300
Subject: [PATCH] gpu: host1x: Free the IOMMU domain when there is no
 device to attach
In-Reply-To: <20170710193305.5987-1-contact@paulk.fr>
References: <20170710193305.5987-1-contact@paulk.fr>
Message-ID: <09ecbf74-ac5d-a7f5-c6bd-53f4f84a0de5@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the patch, didn't consider this case. I really need to get 
together some system to automatically test on multiple platforms.. :)

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 10.07.2017 22:33, Paul Kocialkowski wrote:
> When there is no device to attach to the IOMMU domain, as may be the
> case when the device-tree does not contain the proper iommu node, it is
> best to keep going without IOMMU support rather than failing.
> This allows the driver to probe and function instead of taking down
> all of the tegra drm driver, leading to missing display support.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/host1x/dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index ac65f52850a6..f296738d0de8 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -186,8 +186,13 @@ static int host1x_probe(struct platform_device *pdev)
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
> @@ -198,6 +203,7 @@ static int host1x_probe(struct platform_device *pdev)
>  		host->iova_end = geometry->aperture_end;
>  	}
>
> +iommu_skip:
>  	err = host1x_channel_list_init(host);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to initialize channel list\n");
>
