From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 17 Feb 2016 16:43:42 +0000
Subject: [PATCH] ARM64: Don't set the default console to ttyAMA0
Message-ID: <1455727422-10733-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting Tegra210 with a minimal rootfs it may not be necessary to
specify any boot parameters via the kernel command line as information
for console is described via the "stdout-path" node the device-tree
blob. However, when there are no boot parameter specified, no output is
seen on the console in the case of Tegra210 and this is because the
default command line in the ARM64 defconfig specifies the console as
ttyAMA0 which takes precedence over the "stdout-path" node from
device-tree.

ttyAMAx is used for AMBA PL011 serial ports, but not all ARM64 platforms
use this serial driver. Therefore, remove the default command line
entry from the ARM64 defconfig to ensure that ttyAMA0 does not get set
as the default console if no kernel command line is specified.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d21631760ec7..caecb66188be 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -64,7 +64,6 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
-CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.1.4
