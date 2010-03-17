From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Mar 2010 08:52:39 -0700
Subject: [PATCH 2/6] davinci: da8xx/omap-l1: fix build error when
	CONFIG_DAVINCI_MUX is undefined
In-Reply-To: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1268841163-5868-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The da8xx/omap-l1 boards refuse to build when CONFIG_DAVINCI_MUX is undefined
because arch/arm/mach-davinci/mux.c:da8xx_pinmux_setup() is not defined.

This patch fixes this issue. This is build tested with davinci_all_defconfig
and da8xx_omapl_defconfig and boot tested on DA830 EVM.

Reported-by: Shanmuga Sundaram Mahendran <shanmuga@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cc9be7f..b87a6ba 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -144,6 +144,10 @@ extern const short da850_mmcsd0_pins[];
 extern const short da850_nand_pins[];
 extern const short da850_nor_pins[];
 
+#ifdef CONFIG_DAVINCI_MUX
 int da8xx_pinmux_setup(const short pins[]);
+#else
+static inline int da8xx_pinmux_setup(const short pins[]) { return 0; }
+#endif
 
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
-- 
1.7.0.2
