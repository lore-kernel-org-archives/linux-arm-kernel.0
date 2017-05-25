From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 25 May 2017 11:30:45 -0400
Subject: [PATCH] drm/rockchip: Don't allow zero sized gem buffer
In-Reply-To: <1495521583-29151-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1495521583-29151-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170525153045.7svkkmfsqbqkfacp@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 02:39:43PM +0800, Jeffy Chen wrote:
> The system would crash when trying to alloc zero sized gem buffer:
> [    6.712435] Unable to handle kernel NULL pointer dereference at virtual address 00000010 <--ZERO_SIZE_PTR
> ...
> [    6.757502] PC is at sg_alloc_table_from_pages+0x170/0x1ec

It's unfortunate that you didn't include the entire stack trace. From code
inspection, it seems like the 0 size comes from the fb_probe path? Is there
somewhere in the helpers that you could check the mode is sane so all drivers
can benefit?

Sean

> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index df9e570..8917922 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -315,6 +315,11 @@ struct rockchip_gem_object *
>  	struct drm_gem_object *obj;
>  	int ret;
>  
> +	if (!size) {
> +		DRM_ERROR("gem buffer size is zero\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	size = round_up(size, PAGE_SIZE);
>  
>  	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
