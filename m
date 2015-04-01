From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Wed, 01 Apr 2015 14:47:32 +0300
Subject: [PATCH RFC 07/11] drm/edid: add function to help find SADs
In-Reply-To: <E1YcfY0-0002vI-0F@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfY0-0002vI-0F@rmk-PC.arm.linux.org.uk>
Message-ID: <87wq1wrrxn.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Mar 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Add a function to find the start of the SADs in the ELD.  This
> complements the helper to retrieve the SAD count.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I guess version 31 is specific enough to warrant a #define of its own,
but meh.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/drm/drm_edid.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 87d85e81d3a7..c44ad513e0f7 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -346,6 +346,25 @@ static inline int drm_eld_mnl(const uint8_t *eld)
>  }
>  
>  /**
> + * drm_eld_sad - Get ELD SAD structures.
> + * @eld: pointer to an eld memory structure with sad_count set
> + */
> +static inline const uint8_t *drm_eld_sad(const uint8_t *eld)
> +{
> +	unsigned int ver, mnl;
> +
> +	ver = (eld[DRM_ELD_VER] & DRM_ELD_VER_MASK) >> DRM_ELD_VER_SHIFT;
> +	if (ver != 2 && ver != 31)
> +		return NULL;
> +
> +	mnl = drm_eld_mnl(eld);
> +	if (mnl > 16)
> +		return NULL;
> +
> +	return eld + DRM_ELD_CEA_SAD(mnl, 0);
> +}
> +
> +/**
>   * drm_eld_sad_count - Get ELD SAD count.
>   * @eld: pointer to an eld memory structure with sad_count set
>   */
> -- 
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Technology Center
