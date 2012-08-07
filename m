From: matt@genesi-usa.com (Matt Sealey)
Date: Tue,  7 Aug 2012 17:45:14 -0500
Subject: [PATCH 2/2] ARM: only build ssi-fiq.S et al if
 CONFIG_SND_IMX_SOC_PCM_FIQ is selected
In-Reply-To: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
References: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
Message-ID: <1344379514-30076-3-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Further to the previous patch, a custom configuration may be used based on the
imx_v6_v7_defconfig which removes the board depending on the audio driver pulling
this support code. However, since it is built dependent on CONFIG_SND_IMX_SOC
it is enabled in the build for all i.MX processors which enable any audio drivers.

Correct this by only building the SSI FIQ support code when the more specific
CONFIG_SND_IMX_SOC_PCM_FIQ is enabled. Since it's enabled in the imx_v6_v7_defconfig
anyway by the Eukrea board, nothing changes using the defconfig, so this is just
a convenience for people reconfiguring their kernels more sparsely than the default.

Signed-off-by: Matt Sealey <matt@genesi-usa.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 6ac7200..89927f5 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 obj-$(CONFIG_CPU_IDLE) += cpuidle.o
-ifdef CONFIG_SND_IMX_SOC
+ifdef CONFIG_SND_IMX_SOC_PCM_FIQ
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
-- 
1.7.9.5
