From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  6 Jun 2015 19:05:51 +0900
Subject: [PATCH] Documentation: ARM: EXYNOS: Describe boot loaders interface
Message-ID: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various boot loaders for Exynos based boards use certain memory
addresses during booting for different purposes. Mostly this is one of
following :
1. as a CPU boot address,
2. for storing magic cookie related to low power mode (AFTR, sleep).

The document, based solely on kernel source code, tries to group the
information scattered over different files. This would help in the
future when adding support for new SoC or when extending features
related to low power modes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 Documentation/arm/Samsung/Bootloader-interface.txt | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/arm/Samsung/Bootloader-interface.txt

diff --git a/Documentation/arm/Samsung/Bootloader-interface.txt b/Documentation/arm/Samsung/Bootloader-interface.txt
new file mode 100644
index 000000000000..b96ead9a6919
--- /dev/null
+++ b/Documentation/arm/Samsung/Bootloader-interface.txt
@@ -0,0 +1,53 @@
+      Interface between kernel and boot loaders on Exynos boards
+      ==========================================================
+
+Author: Krzysztof Kozlowski
+Date  : 6 June 2015
+
+The document tries to describe currently used interface between Linux kernel
+and boot loaders on Samsung Exynos based boards. This is not a definition
+of interface but rather a description of existing state, a reference
+for information purpose only.
+
+In the document "boot loader" means any of following: U-boot, proprietary
+SBOOT or any other firmware for ARMv7 and ARMv8 initializing the board before
+executing kernel.
+
+
+1. Non-Secure mode
+Address:      sysram_ns_base_addr
+Offset        Value                                        Purpose
+=============================================================================
+0x08          exynos_cpu_resume_ns                         System suspend
+0x0c          0x00000bad (Magic cookie)                    System suspend
+0x1c          exynos4_secondary_startup                    Secondary CPU boot
+0x1c + 4*cpu  exynos4_secondary_startup (Exynos4412)       Secondary CPU boot
+0x20          0xfcba0d10 (Magic cookie)                    AFTR
+0x24          exynos_cpu_resume_ns                         AFTR
+0x28 + 4*cpu  0x8 (Magic cookie, Exynos3250)               AFTR
+
+
+2. Secure mode
+Address:      sysram_base_addr
+Offset        Value                                        Purpose
+=============================================================================
+0x00          exynos4_secondary_startup                    Secondary CPU boot
+0x04          exynos4_secondary_startup (Exynos542x)       Secondary CPU boot
+4*cpu         exynos4_secondary_startup (Exynos4412)       Secondary CPU boot
+0x20          exynos_cpu_resume (Exynos4210 r1.0)          AFTR
+0x24          0xfcba0d10 (Magic cookie, Exynos4210 r1.0)   AFTR
+
+Address:      pmu_base_addr
+Offset        Value                                        Purpose
+=============================================================================
+0x0800        exynos_cpu_resume                            AFTR
+0x0814        exynos4_secondary_startup (Exynos4210 r1.1)  Secondary CPU boot
+0x0818        0xfcba0d10 (Magic cookie, Exynos4210 r1.1)   AFTR
+0x081C        exynos_cpu_resume (Exynos4210 r1.1)          AFTR
+
+
+3. Other (regardless of secure/non-secure mode)
+Address:      pmu_base_addr
+Offset        Value                           Purpose
+=============================================================================
+0x0908        Non-zero (only Exynos3250)      Secondary CPU boot up indicator
-- 
2.1.4
