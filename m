From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 14 Mar 2018 11:39:27 +0530
Subject: [PATCH v5 11/36] drm/bridge: analogix_dp: Wait for HPD signal
 before configuring link
In-Reply-To: <20180309222327.18689-12-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-12-enric.balletbo@collabora.com>
Message-ID: <636d85d6-64bb-5387-912d-1ec09e47f0ef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> According to DP spec v1.3 chap 3.5.1.2 Link Training, Link Policy Maker
> must first detect that the HPD signal is asserted high by the Downstream
> Device before establishing a link with it.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: St?phane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index c81733b8185e..92fb9a072cb6 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1169,6 +1169,17 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   	if (ret)
>   		goto out_dp_init;
>   
> +	/*
> +	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
> +	 * We should first make sure the HPD signal is asserted high by device
> +	 * when we want to establish a link with it.
> +	 */
> +	ret = analogix_dp_detect_hpd(dp);
> +	if (ret) {
> +		DRM_ERROR("failed to get hpd single ret = %d\n", ret);
> +		goto out_dp_init;
> +	}
> +
>   	ret = analogix_dp_commit(dp);
>   	if (ret)
>   		goto out_dp_init;
> 
