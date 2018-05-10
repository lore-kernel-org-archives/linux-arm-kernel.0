From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 10 May 2018 09:13:16 +0200
Subject: [PATCH v2 25/26] drm/bridge: require the owner .odev to be
 filled in on drm_bridge_add/attach
In-Reply-To: <20180504135212.26977-26-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135352epcas5p48cd98762cd4476621f98b0356b891f7e@epcas5p4.samsung.com>
 <20180504135212.26977-26-peda@axentia.se>
Message-ID: <6278e7a4-c67a-6198-364e-526042acc393@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.05.2018 15:52, Peter Rosin wrote:
> The .odev owner device will be handy to have around.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
> ---
>  drivers/gpu/drm/drm_bridge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index df084db33494..78d186b6831b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -70,6 +70,9 @@ static LIST_HEAD(bridge_list);
>   */
>  void drm_bridge_add(struct drm_bridge *bridge)
>  {
> +	if (WARN_ON(!bridge->odev))
> +		return;
> +
>  	mutex_lock(&bridge_lock);
>  	list_add_tail(&bridge->list, &bridge_list);
>  	mutex_unlock(&bridge_lock);
> @@ -115,6 +118,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (!encoder || !bridge)
>  		return -EINVAL;
>  
> +	if (WARN_ON(!bridge->odev))
> +		return -EINVAL;
> +
>  	if (previous && (!previous->dev || previous->encoder != encoder))
>  		return -EINVAL;
>  
