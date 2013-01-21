From: rob@ti.com (Rob Clark)
Date: Mon, 21 Jan 2013 11:26:55 -0600
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <1358788568-11137-16-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-16-git-send-email-arnd@arndb.de>
Message-ID: <50FD7A5F.9020702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 11:16 AM, Arnd Bergmann wrote:
> The omapdrm driver is incorrectly flagged to allow building
> on non-omap platforms, when ARCH_MULTIPLATFORM is set.
>
> This does not work, because it unconditionally selects
> the OMAP2_DSS symbol that only works on OMAP.
> The problem was introduced in 5e3b087499 "staging:
> drm/omap: add support for ARCH_MULTIPLATFORM", which this
> patch partly reverts.

Are you sure OMAP2_DSS requires ARCH_OMAP2PLUS?  I don't see this, and 
it at least used to not depend on ARCH_OMAP2PLUS.  If it does now, I 
think the correct fix would be to remove the dependency in OMAP2_DSS.  I 
don't think removing ARCH_MULTIPLATFORM support in omapdrm is the 
correct solution.


> Without this patch, building allyesconfig results in:
>
> warning: (VIDEO_OMAP2_VOUT && DRM_OMAP) selects OMAP2_DSS which has unmet direct dependencies (HAS_IOMEM && ARCH_OMAP2PLUS)
> warning: (VIDEO_OMAP2_VOUT && DRM_OMAP) selects OMAP2_DSS which has unmet direct dependencies (HAS_IOMEM && ARCH_OMAP2PLUS)
> drivers/video/omap2/dss/dss.c: In function 'dss_calc_clock_div':
> drivers/video/omap2/dss/dss.c:572:20: error: 'CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK' undeclared (first use in this function)
> drivers/video/omap2/dss/dss.c:572:20: note: each undeclared identifier is reported only once for each function it appears in
> drivers/staging/omapdrm/omap_connector.c: In function 'omap_connector_dpms':
> drivers/staging/omapdrm/omap_connector.c:116:8: error: 'OMAP_DSS_DISPLAY_SUSPENDED' undeclared (first use in this function)
> drivers/staging/omapdrm/omap_connector.c:116:8: note: each undeclared identifier is reported only once for each function it appears in


This was an unrelated build break which should be fixed in latest master 
after 'staging: drm/omap: use omapdss low level API'

BR,
-R

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Clark <rob@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/staging/omapdrm/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/omapdrm/Kconfig b/drivers/staging/omapdrm/Kconfig
> index b724a41..81a7cba 100644
> --- a/drivers/staging/omapdrm/Kconfig
> +++ b/drivers/staging/omapdrm/Kconfig
> @@ -2,7 +2,7 @@
>   config DRM_OMAP
>   	tristate "OMAP DRM"
>   	depends on DRM && !CONFIG_FB_OMAP2
> -	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
> +	depends on ARCH_OMAP2PLUS
>   	select DRM_KMS_HELPER
>   	select OMAP2_DSS
>   	select FB_SYS_FILLRECT
