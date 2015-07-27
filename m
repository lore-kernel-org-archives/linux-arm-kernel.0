From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 27 Jul 2015 09:50:50 +0200
Subject: [Intel-gfx] [PATCH v2 12/25] i915: switch from acpi_os_ioremap
 to ioremap
In-Reply-To: <20150725023904.8664.84461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023904.8664.84461.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150727075050.GK16722@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:39:04PM -0400, Dan Williams wrote:
> acpi_os_ioremap uses cached mappings, however it appears that i915
> wants to read dynamic platform state.  Switch to ioremap() to prevent it
> reading stale state from cache.
> 
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: intel-gfx at lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/gpu/drm/i915/intel_opregion.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
> index 481337436f72..16ba7c67410d 100644
> --- a/drivers/gpu/drm/i915/intel_opregion.c
> +++ b/drivers/gpu/drm/i915/intel_opregion.c
> @@ -863,7 +863,7 @@ int intel_opregion_setup(struct drm_device *dev)
>  	INIT_WORK(&opregion->asle_work, asle_work);
>  #endif
>  
> -	base = acpi_os_ioremap(asls, OPREGION_SIZE);
> +	base = ioremap(asls, OPREGION_SIZE);

OpRegion is cached memory shared with the firmware afaik, we probably want
a memremap here and switch away from the ioread/write stuff. We have a
similar confusion going on for the vbt parsing (which on anything but
really old machines is also just normal memory).

Same holds for gma500, which is just a copy of i915 for some special
platforms.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
