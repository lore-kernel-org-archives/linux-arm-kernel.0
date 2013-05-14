From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:38 +0100
Subject: [PATCH 2/8] ARM: mpu: add header for MPU register layouts and region
 data
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds definitions relevant to the ARM v7 PMSA compliant MPU.

The register layouts and region configuration data is made accessible to asm
as well as C-code so that it can be used in early bring-up of the MPU.

The mpu region information structs assume that the properties for the I/D side
are the same, though the implementation could be trivially extended for future
platforms where this is no-longer true.

The MPU_*_REGION defines are used for the basic, static MPU region setup.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/mpu.h |   72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 arch/arm/include/asm/mpu.h

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
new file mode 100644
index 0000000..bd48c0c
--- /dev/null
+++ b/arch/arm/include/asm/mpu.h
@@ -0,0 +1,72 @@
+#ifndef __ARM_MPU_H
+#define __ARM_MPU_H
+
+#ifdef CONFIG_ARM_MPU
+
+/* MPUIR layout */
+#define MPUIR_nU		1
+#define MPUIR_DREGION		8
+#define MPUIR_IREGION		16
+#define MPUIR_DREGION_SZMASK	(0xFF << MPUIR_DREGION)
+#define MPUIR_IREGION_SZMASK	(0xFF << MPUIR_IREGION)
+
+/* ID_MMFR0 data relevant to MPU */
+#define MMFR0_PMSA		(0xF << 4)
+#define MMFR0_PMSAv7		(3 << 4)
+
+/* MPU D/I Size Register fields */
+#define MPU_RSR_SZ		1
+#define MPU_RSR_EN		0
+
+/* The D/I RSR value for an enabled region spanning the whole of memory */
+#define MPU_RSR_ALL_MEM		63
+
+/* Individual bits in the DR/IR ACR */
+#define MPU_ACR_XN		(1 << 12)
+#define MPU_ACR_SHARED		(1 << 2)
+
+/* C, B and TEX[2:0] bits only have semantic meanings when grouped */
+#define MPU_RGN_CACHEABLE	0xB
+#define MPU_RGN_SHARED_CACHEABLE (MPU_RGN_CACHEABLE | MPU_ACR_SHARED)
+#define MPU_RGN_STRONGLY_ORDERED 0
+
+/* Main region should only be shared for SMP */
+#ifdef CONFIG_SMP
+#define MPU_RGN_NORMAL		(MPU_RGN_CACHEABLE | MPU_ACR_SHARED)
+#else
+#define MPU_RGN_NORMAL		MPU_RGN_CACHEABLE
+#endif
+
+/* Access permission bits of ACR (only define those that we use)*/
+#define MPU_AP_PL1RW_PL0RW	(0x3 << 8)
+#define MPU_AP_PL1RW_PL0R0	(0x2 << 8)
+#define MPU_AP_PL1RW_PL0NA	(0x1 << 8)
+
+/* For minimal static MPU region configurations */
+#define MPU_PROBE_REGION	0
+#define MPU_BG_REGION		1
+#define MPU_RAM_REGION		2
+
+/* Maximum number of regions Linux is interested in */
+#define MPU_MAX_REGIONS		16
+
+#ifndef __ASSEMBLY__
+
+struct mpu_rgn {
+	/* Assume same attributes for d/i-side  */
+	u32 drbar;
+	u32 drsr;
+	u32 dracr;
+};
+
+struct mpu_rgn_info {
+	u32 mpuir;
+	struct mpu_rgn rgns[MPU_MAX_REGIONS];
+};
+extern struct mpu_rgn_info mpu_rgn_info;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_ARM_MPU */
+
+#endif
-- 
1.7.9.5
