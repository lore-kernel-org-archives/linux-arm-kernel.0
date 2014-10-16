From: treding@nvidia.com (Thierry Reding)
Date: Thu, 16 Oct 2014 15:40:30 +0200
Subject: Latest build test randconfig errors
In-Reply-To: <20141016083120.GN27405@n2100.arm.linux.org.uk>
References: <20141016083120.GN27405@n2100.arm.linux.org.uk>
Message-ID: <20141016134029.GA27411@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 09:31:20AM +0100, Russell King - ARM Linux wrote:
> The cause seems to be a missing dependency between the Tegra DRM
> code and COMMON_CLK, caused by:
> 
> commit 158b50aefa14ba18ee94b691f83a7e5d30539433
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Wed Nov 20 20:39:35 2013 +0100
> 
>     drm/tegra: Increase compile test coverage
> 
> ARCH_MULTIPLATFORM would have selected COMMON_CLK, and ARCH_TEGRA
> requires ARCH_MULTIPLATFORM to be set so that part was redundant
> in the original dependencies:
> 
> menuconfig ARCH_TEGRA
>         bool "NVIDIA Tegra" if ARCH_MULTI_V7

I've queued the following fix for this. As I understand that should fix
this particular issue.

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 354ddb29231f..74d9d621453d 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -1,6 +1,7 @@
 config DRM_TEGRA
 	tristate "NVIDIA Tegra DRM"
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
+	depends on COMMON_CLK
 	depends on DRM
 	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/8dd80525/attachment.sig>
