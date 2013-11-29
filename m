From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:42:53 +0100
Subject: [PATCH 09/31] drm/tegra: use reset framework
In-Reply-To: <1384548866-13141-10-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-10-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129134252.GW22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:04PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Terje Bergstr?m <tbergstrom@nvidia.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/gpu/drm/tegra/Kconfig |  1 +
>  drivers/gpu/drm/tegra/dc.c    |  9 ++++++++-
>  drivers/gpu/drm/tegra/drm.h   |  3 +++
>  drivers/gpu/drm/tegra/gr3d.c  | 16 ++++++++++++++++
>  drivers/gpu/drm/tegra/hdmi.c  | 14 +++++++++++---
>  5 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 8961ba6a34b8..8db9b3bce001 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -2,6 +2,7 @@ config DRM_TEGRA
>  	bool "NVIDIA Tegra DRM"
>  	depends on ARCH_TEGRA || ARCH_MULTIPLATFORM
>  	depends on DRM
> +	depends on RESET_CONTROLLER

Is this really needed? ARCH_TEGRA already selects RESET_CONTROLLER and
we depend on ARCH_TEGRA. Or perhaps you need this because it might also
be that ARCH_MULTIPLATFORM is selected without ARCH_TEGRA support? In
either case I guess a good thing would be to add dummies for the reset
API so that we don't have this additional compile-time dependency.

>  	select TEGRA_HOST1X
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_FB_HELPER
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index ae1cb31ead7e..c3be92879bea 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
> +#include <linux/reset.h>

You should be able to drop linux/clk/tegra.h now.

> diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
> index 4cec8f526af7..f629e38b00e4 100644
> --- a/drivers/gpu/drm/tegra/gr3d.c
> +++ b/drivers/gpu/drm/tegra/gr3d.c
> @@ -11,6 +11,7 @@
>  #include <linux/host1x.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>

I was going to say "Same here", but interestingly this driver doesn't
use the old Tegra-specific reset API. It's actually handled internally
by the tegra_powergate_sequence_power_up() function and I think that'll
be handled by a separate patch in your series if I recall correctly.

> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index 0cd9bc2056e8..f3aad49633d6 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -12,6 +12,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/hdmi.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>

But here the linux/clk/tegra.h include can again be dropped.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/f826b445/attachment.sig>
