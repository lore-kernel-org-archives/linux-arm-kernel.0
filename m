From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 12 Oct 2015 09:01:02 +0200
Subject: [Intel-gfx] [PATCH 09/20] i915: switch from acpi_os_ioremap to
 memremap
In-Reply-To: <20151009221625.32203.74117.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221625.32203.74117.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151012070102.GV26718@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 06:16:25PM -0400, Dan Williams wrote:
> i915 expects the OpRegion to be cached (i.e. not __iomem), so explicitly
> map it with memremap rather than the implied cache setting of
> acpi_os_ioremap().
> 
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: intel-gfx at lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Assuming you've run sparse over this to make sure you've caught them all,
and with the nit below addressed this is

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Feel free to pull v2 into whatever tree you think it's suitable for (but
you can also resend and I'll pick it up).

> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
> index e2ab3f6ed022..c8444d5f549f 100644
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -387,7 +387,7 @@ intel_panel_detect(struct drm_device *dev)
>  
>  	/* Assume that the BIOS does not lie through the OpRegion... */
>  	if (!i915.panel_ignore_lid && dev_priv->opregion.lid_state) {
> -		return ioread32(dev_priv->opregion.lid_state) & 0x1 ?
> +		return *(dev_priv->opregion.lid_state) & 0x1 ?

() are redundant now here.
-Daniel

>  			connector_status_connected :
>  			connector_status_disconnected;
>  	}
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
