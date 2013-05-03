From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 3 May 2013 15:45:39 +0200
Subject: [PATCH, RFC 06/22] gpu/drm: host1x: add dependency on Tegra
In-Reply-To: <1367507786-505303-7-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-7-git-send-email-arnd@arndb.de>
Message-ID: <20130503134539.GA18652@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 05:16:10PM +0200, Arnd Bergmann wrote:
> While we try to make drivers platform independent, this driver currently
> calls into an exported interface that is only provided on its own
> platform, so we have to add the dependency.
> 
> drivers/built-in.o: In function `tegra_crtc_prepare':
>  drivers/gpu/host1x/drm/dc.c:650: undefined reference to `tegra_periph_reset_deassert'
> drivers/built-in.o: In function `tegra_output_hdmi_disable':
>  drivers/gpu/host1x/drm/hdmi.c:840: undefined reference to `tegra_periph_reset_assert'
> drivers/built-in.o: In function `tegra_output_hdmi_enable':
>  drivers/gpu/host1x/drm/hdmi.c:651: undefined reference to `tegra_periph_reset_assert'
>  drivers/gpu/host1x/drm/hdmi.c:653: undefined reference to `tegra_periph_reset_deassert'
> 
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Arto Merilainen <amerilainen@nvidia.com>
> Cc: Terje Bergstrom <tbergstrom@nvidia.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/host1x/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/host1x/drm/Kconfig b/drivers/gpu/host1x/drm/Kconfig
> index 69853a4..5a6a5cd 100644
> --- a/drivers/gpu/host1x/drm/Kconfig
> +++ b/drivers/gpu/host1x/drm/Kconfig
> @@ -1,6 +1,7 @@
>  config DRM_TEGRA
>  	bool "NVIDIA Tegra DRM"
>  	depends on DRM
> +	depends on ARCH_TEGRA
>  	select DRM_KMS_HELPER
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA

This was solved by a patch that went into Dave's DRM pull request for
3.10 by adding:

	depends on ARCH_TEGRA || ARCH_MULTIPLATFORM

to the Kconfig entry for TEGRA_HOST1X. The plan was to eventually remove
ARCH_TEGRA from that condition after 3.10 since ARCH_MULTIPLATFORM will
include ARCH_TEGRA anyway. I'm not sure why that patch hasn't made it
into linux-next yet, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/9a34437b/attachment.sig>
