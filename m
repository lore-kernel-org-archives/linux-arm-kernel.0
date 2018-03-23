From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 23 Mar 2018 18:08:31 +0000
Subject: [PATCH v2] arm64/sve: Document firmware support requirements in
 Kconfig
Message-ID: <1521828511-30946-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of SVE by EL2 and below requires explicit support in the
firmware.  There is no means to hide the presence of SVE from EL2,
so a kernel configured with CONFIG_ARM64_SVE=y will typically not
work correctly on SVE capable hardware unless the firmware does
include the appropriate support.

This is not expected to pose a problem in the wild, since platform
integrators are responsible for ensuring that they ship up-to-date
firmware to support their hardware.  However, developers may hit
the issue when using mismatched compoments.

In order to draw attention to the issue and how to solve it, this
patch adds some Kconfig text giving a brief explanation and details
of compatible firmware versions.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---

Changes since v1:

 * Fixed a typo ("firware") reported by Suzuki
---
 arch/arm64/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb..4fc7057 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1104,6 +1104,23 @@ config ARM64_SVE
 
 	  To enable use of this extension on CPUs that implement it, say Y.
 
+	  Note that for architectural reasons, firmware _must_ implement SVE
+	  support when running on SVE capable hardware.  The required support
+	  is present in:
+
+	    * version 1.5 and later of the ARM Trusted Firmware
+	    * the AArch64 boot wrapper since commit 5e1261e08abf
+	      ("bootwrapper: SVE: Enable SVE for EL2 and below").
+
+	  For other firmware implementations, consult the firmware documentation
+	  or vendor.
+
+	  If you need the kernel to boot on SVE-capable hardware with broken
+	  firmware, you may need to say N here until you get your firmware
+	  fixed.  Otherwise, you may experience firmware panics or lockups when
+	  booting the kernel.  If unsure and you are not observing these
+	  symptoms, you should assume that it is safe to say Y.
+
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
-- 
2.1.4
