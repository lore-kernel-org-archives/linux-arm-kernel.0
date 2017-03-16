From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:28 +0100
Subject: [PATCH v2 1/7] mfd: syscon: atmel-smc: Add new helpers to ease SMC
 regs manipulation
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These new helpers + macro definitions are meant to replace the old ones
which are unpractical to use.

Note that the macros and function prefixes have been intentionally
changed to ATMEL_[H]SMC_XX and atmel_[h]smc_ to reflect the fact that
this IP is also embedded in avr32 SoCs (and not only in at91 ones).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mfd/Kconfig                  |   4 +
 drivers/mfd/Makefile                 |   1 +
 drivers/mfd/atmel-smc.c              | 314 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon/atmel-smc.h |  87 ++++++++++
 4 files changed, 406 insertions(+)
 create mode 100644 drivers/mfd/atmel-smc.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 55ecdfb74d31..2e2eac7db9f3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -121,6 +121,10 @@ config MFD_ATMEL_HLCDC
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ATMEL_SMC
+	bool
+	select MFD_SYSCON
+
 config MFD_BCM590XX
 	tristate "Broadcom BCM590xx PMUs"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 31ce07611a6f..edd821bc8e80 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
+obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
new file mode 100644
index 000000000000..954cf0f66a31
--- /dev/null
+++ b/drivers/mfd/atmel-smc.c
@@ -0,0 +1,314 @@
+/*
+ * Atmel SMC (Static Memory Controller) helper functions.
+ *
+ * Copyright (C) 2017 Atmel
+ * Copyright (C) 2017 Free Electrons
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mfd/syscon/atmel-smc.h>
+
+/**
+ * atmel_smc_cs_conf_init - initialize a SMC CS conf
+ * @conf: the SMC CS conf to initialize
+ *
+ * Set all fields to 0 so that one can start defining a new config.
+ */
+void atmel_smc_cs_conf_init(struct atmel_smc_cs_conf *conf)
+{
+	memset(conf, 0, sizeof(*conf));
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_init);
+
+/**
+ * atmel_smc_cs_encode_ncycles - encode a number of MCK clk cycles in the
+ *				 format expected by the SMC engine
+ * @ncycles: number of MCK clk cycles
+ * @msbpos: position of the MSB part of the timing field
+ * @msbwidth: width of the MSB part of the timing field
+ * @msbfactor: factor applied to the MSB
+ * @encodedval: param used to store the encoding result
+ *
+ * This function encodes the @ncycles value as described in the datasheet
+ * (section "SMC Setup/Pulse/Cycle/Timings Register"). This is a generic
+ * helper which called with different parameter depending on the encoding
+ * scheme.
+ *
+ * If the @ncycles value is too big to be encoded, -ERANGE is returned and
+ * the encodedval is contains the maximum val. Otherwise, 0 is returned.
+ */
+static int atmel_smc_cs_encode_ncycles(unsigned int ncycles,
+				       unsigned int msbpos,
+				       unsigned int msbwidth,
+				       unsigned int msbfactor,
+				       unsigned int *encodedval)
+{
+	unsigned int lsbmask = GENMASK(msbpos - 1, 0);
+	unsigned int msbmask = GENMASK(msbwidth - 1, 0);
+	unsigned int msb, lsb;
+	int ret = 0;
+
+	msb = ncycles / msbfactor;
+	lsb = ncycles % msbfactor;
+
+	if (lsb > lsbmask) {
+		lsb = 0;
+		msb++;
+	}
+
+	/*
+	 * Let's just put the maximum we can if the requested setting does
+	 * not fit in the register field.
+	 * We still return -ERANGE in case the caller cares.
+	 */
+	if (msb > msbmask) {
+		msb = msbmask;
+		lsb = lsbmask;
+		ret = -ERANGE;
+	}
+
+	*encodedval = (msb << msbpos) | lsb;
+
+	return ret;
+}
+
+/**
+ * atmel_smc_cs_conf_set_timing - set the SMC CS conf Txx parameter to a
+ *				  specific value
+ * @conf: SMC CS conf descriptor
+ * @shift: the position of the Txx field in the TIMINGS register
+ * @ncycles: value (expressed in MCK clk cycles) to assign to this Txx
+ *	     parameter
+ *
+ * This function encodes the @ncycles value as described in the datasheet
+ * (section "SMC Timings Register"), and then stores the result in the
+ * @conf->timings field at @shift position.
+ *
+ * Returns -EINVAL if shift is invalid, -ERANGE if ncycles does not fit in
+ * the field, and 0 otherwise.
+ */
+int atmel_smc_cs_conf_set_timing(struct atmel_smc_cs_conf *conf,
+				 unsigned int shift, unsigned int ncycles)
+{
+	unsigned int val;
+	int ret;
+
+	if (shift != ATMEL_HSMC_TIMINGS_TCLR_SHIFT &&
+	    shift != ATMEL_HSMC_TIMINGS_TADL_SHIFT &&
+	    shift != ATMEL_HSMC_TIMINGS_TAR_SHIFT &&
+	    shift != ATMEL_HSMC_TIMINGS_TRR_SHIFT &&
+	    shift != ATMEL_HSMC_TIMINGS_TWB_SHIFT)
+		return -EINVAL;
+
+	/*
+	 * The formula described in atmel datasheets (section "HSMC Timings
+	 * Register"):
+	 *
+	 * ncycles = (Txx[3] * 64) + Txx[2:0]
+	 */
+	ret = atmel_smc_cs_encode_ncycles(ncycles, 3, 1, 64, &val);
+	conf->timings &= ~GENMASK(shift + 3, shift);
+	conf->timings |= val << shift;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_timing);
+
+/**
+ * atmel_smc_cs_conf_set_setup - set the SMC CS conf xx_SETUP parameter to a
+ *				 specific value
+ * @conf: SMC CS conf descriptor
+ * @shift: the position of the xx_SETUP field in the SETUP register
+ * @ncycles: value (expressed in MCK clk cycles) to assign to this xx_SETUP
+ *	     parameter
+ *
+ * This function encodes the @ncycles value as described in the datasheet
+ * (section "SMC Setup Register"), and then stores the result in the
+ * @conf->setup field at @shift position.
+ *
+ * Returns -EINVAL if @shift is invalid, -ERANGE if @ncycles does not fit in
+ * the field, and 0 otherwise.
+ */
+int atmel_smc_cs_conf_set_setup(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles)
+{
+	unsigned int val;
+	int ret;
+
+	if (shift != ATMEL_SMC_NWE_SHIFT && shift != ATMEL_SMC_NCS_WR_SHIFT &&
+	    shift != ATMEL_SMC_NRD_SHIFT && shift != ATMEL_SMC_NCS_RD_SHIFT)
+		return -EINVAL;
+
+	/*
+	 * The formula described in atmel datasheets (section "SMC Setup
+	 * Register"):
+	 *
+	 * ncycles = (128 * xx_SETUP[5]) + xx_SETUP[4:0]
+	 */
+	ret = atmel_smc_cs_encode_ncycles(ncycles, 5, 1, 128, &val);
+	conf->setup &= ~GENMASK(shift + 7, shift);
+	conf->setup |= val << shift;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_setup);
+
+/**
+ * atmel_smc_cs_conf_set_pulse - set the SMC CS conf xx_PULSE parameter to a
+ *				 specific value
+ * @conf: SMC CS conf descriptor
+ * @shift: the position of the xx_PULSE field in the PULSE register
+ * @ncycles: value (expressed in MCK clk cycles) to assign to this xx_PULSE
+ *	     parameter
+ *
+ * This function encodes the @ncycles value as described in the datasheet
+ * (section "SMC Pulse Register"), and then stores the result in the
+ * @conf->setup field at @shift position.
+ *
+ * Returns -EINVAL if @shift is invalid, -ERANGE if @ncycles does not fit in
+ * the field, and 0 otherwise.
+ */
+int atmel_smc_cs_conf_set_pulse(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles)
+{
+	unsigned int val;
+	int ret;
+
+	if (shift != ATMEL_SMC_NWE_SHIFT && shift != ATMEL_SMC_NCS_WR_SHIFT &&
+	    shift != ATMEL_SMC_NRD_SHIFT && shift != ATMEL_SMC_NCS_RD_SHIFT)
+		return -EINVAL;
+
+	/*
+	 * The formula described in atmel datasheets (section "SMC Pulse
+	 * Register"):
+	 *
+	 * ncycles = (256 * xx_PULSE[6]) + xx_PULSE[5:0]
+	 */
+	ret = atmel_smc_cs_encode_ncycles(ncycles, 6, 1, 256, &val);
+	conf->pulse &= ~GENMASK(shift + 7, shift);
+	conf->pulse |= val << shift;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_pulse);
+
+/**
+ * atmel_smc_cs_conf_set_cycle - set the SMC CS conf xx_CYCLE parameter to a
+ *				 specific value
+ * @conf: SMC CS conf descriptor
+ * @shift: the position of the xx_CYCLE field in the CYCLE register
+ * @ncycles: value (expressed in MCK clk cycles) to assign to this xx_CYCLE
+ *	     parameter
+ *
+ * This function encodes the @ncycles value as described in the datasheet
+ * (section "SMC Pulse Register"), and then stores the result in the
+ * @conf->setup field at @shift position.
+ *
+ * Returns -EINVAL if @shift is invalid, -ERANGE if @ncycles does not fit in
+ * the field, and 0 otherwise.
+ */
+int atmel_smc_cs_conf_set_cycle(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles)
+{
+	unsigned int val;
+	int ret;
+
+	if (shift != ATMEL_SMC_NWE_SHIFT && shift != ATMEL_SMC_NRD_SHIFT)
+		return -EINVAL;
+
+	/*
+	 * The formula described in atmel datasheets (section "SMC Cycle
+	 * Register"):
+	 *
+	 * ncycles = (xx_CYCLE[8:7] * 256) + xx_CYCLE[6:0]
+	 */
+	ret = atmel_smc_cs_encode_ncycles(ncycles, 7, 2, 256, &val);
+	conf->cycle &= ~GENMASK(shift + 15, shift);
+	conf->cycle |= val << shift;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_cycle);
+
+/**
+ * atmel_smc_cs_conf_apply - apply an SMC CS conf
+ * @regmap: the SMC regmap
+ * @cs: the CS id
+ * @conf the SMC CS conf to apply
+ *
+ * Applies an SMC CS configuration.
+ * Only valid on at91sam9/avr32 SoCs.
+ */
+void atmel_smc_cs_conf_apply(struct regmap *regmap, int cs,
+			     const struct atmel_smc_cs_conf *conf)
+{
+	regmap_write(regmap, ATMEL_SMC_SETUP(cs), conf->setup);
+	regmap_write(regmap, ATMEL_SMC_PULSE(cs), conf->pulse);
+	regmap_write(regmap, ATMEL_SMC_CYCLE(cs), conf->cycle);
+	regmap_write(regmap, ATMEL_SMC_MODE(cs), conf->mode);
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_apply);
+
+/**
+ * atmel_hsmc_cs_conf_apply - apply an SMC CS conf
+ * @regmap: the HSMC regmap
+ * @cs: the CS id
+ * @conf the SMC CS conf to apply
+ *
+ * Applies an SMC CS configuration.
+ * Only valid on post-sama5 SoCs.
+ */
+void atmel_hsmc_cs_conf_apply(struct regmap *regmap, int cs,
+			      const struct atmel_smc_cs_conf *conf)
+{
+	regmap_write(regmap, ATMEL_HSMC_SETUP(cs), conf->setup);
+	regmap_write(regmap, ATMEL_HSMC_PULSE(cs), conf->pulse);
+	regmap_write(regmap, ATMEL_HSMC_CYCLE(cs), conf->cycle);
+	regmap_write(regmap, ATMEL_HSMC_TIMINGS(cs), conf->timings);
+	regmap_write(regmap, ATMEL_HSMC_MODE(cs), conf->mode);
+}
+EXPORT_SYMBOL_GPL(atmel_hsmc_cs_conf_apply);
+
+/**
+ * atmel_smc_cs_conf_get - retrieve the current SMC CS conf
+ * @regmap: the SMC regmap
+ * @cs: the CS id
+ * @conf: the SMC CS conf object to store the current conf
+ *
+ * Retrieve the SMC CS configuration.
+ * Only valid on at91sam9/avr32 SoCs.
+ */
+void atmel_smc_cs_conf_get(struct regmap *regmap, int cs,
+			   struct atmel_smc_cs_conf *conf)
+{
+	regmap_read(regmap, ATMEL_SMC_SETUP(cs), &conf->setup);
+	regmap_read(regmap, ATMEL_SMC_PULSE(cs), &conf->pulse);
+	regmap_read(regmap, ATMEL_SMC_CYCLE(cs), &conf->cycle);
+	regmap_read(regmap, ATMEL_SMC_MODE(cs), &conf->mode);
+}
+EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_get);
+
+/**
+ * atmel_hsmc_cs_conf_get - retrieve the current SMC CS conf
+ * @regmap: the HSMC regmap
+ * @cs: the CS id
+ * @conf: the SMC CS conf object to store the current conf
+ *
+ * Retrieve the SMC CS configuration.
+ * Only valid on post-sama5 SoCs.
+ */
+void atmel_hsmc_cs_conf_get(struct regmap *regmap, int cs,
+			    struct atmel_smc_cs_conf *conf)
+{
+	regmap_read(regmap, ATMEL_HSMC_SETUP(cs), &conf->setup);
+	regmap_read(regmap, ATMEL_HSMC_PULSE(cs), &conf->pulse);
+	regmap_read(regmap, ATMEL_HSMC_CYCLE(cs), &conf->cycle);
+	regmap_read(regmap, ATMEL_HSMC_TIMINGS(cs), &conf->timings);
+	regmap_read(regmap, ATMEL_HSMC_MODE(cs), &conf->mode);
+}
+EXPORT_SYMBOL_GPL(atmel_hsmc_cs_conf_get);
diff --git a/include/linux/mfd/syscon/atmel-smc.h b/include/linux/mfd/syscon/atmel-smc.h
index be6ebe64eebe..00e6e3c8ee6f 100644
--- a/include/linux/mfd/syscon/atmel-smc.h
+++ b/include/linux/mfd/syscon/atmel-smc.h
@@ -69,6 +69,93 @@
 #define AT91_SMC_PS_16			(2 << 28)
 #define AT91_SMC_PS_32			(3 << 28)
 
+#define ATMEL_SMC_SETUP(cs)			(((cs) * 0x10))
+#define ATMEL_HSMC_SETUP(cs)			(0x600 + ((cs) * 0x14))
+#define ATMEL_SMC_PULSE(cs)			(((cs) * 0x10) + 0x4)
+#define ATMEL_HSMC_PULSE(cs)			(0x600 + ((cs) * 0x14) + 0x4)
+#define ATMEL_SMC_CYCLE(cs)			(((cs) * 0x10) + 0x8)
+#define ATMEL_HSMC_CYCLE(cs)			(0x600 + ((cs) * 0x14) + 0x8)
+#define ATMEL_SMC_NWE_SHIFT			0
+#define ATMEL_SMC_NCS_WR_SHIFT			8
+#define ATMEL_SMC_NRD_SHIFT			16
+#define ATMEL_SMC_NCS_RD_SHIFT			24
+
+#define ATMEL_SMC_MODE(cs)			(((cs) * 0x10) + 0xc)
+#define ATMEL_HSMC_MODE(cs)			(0x600 + ((cs) * 0x14) + 0x10)
+#define ATMEL_SMC_MODE_READMODE_MASK		BIT(0)
+#define ATMEL_SMC_MODE_READMODE_NCS		(0 << 0)
+#define ATMEL_SMC_MODE_READMODE_NRD		(1 << 0)
+#define ATMEL_SMC_MODE_WRITEMODE_MASK		BIT(1)
+#define ATMEL_SMC_MODE_WRITEMODE_NCS		(0 << 1)
+#define ATMEL_SMC_MODE_WRITEMODE_NWE		(1 << 1)
+#define ATMEL_SMC_MODE_EXNWMODE_MASK		GENMASK(5, 4)
+#define ATMEL_SMC_MODE_EXNWMODE_DISABLE		(0 << 4)
+#define ATMEL_SMC_MODE_EXNWMODE_FROZEN		(2 << 4)
+#define ATMEL_SMC_MODE_EXNWMODE_READY		(3 << 4)
+#define ATMEL_SMC_MODE_BAT_MASK			BIT(8)
+#define ATMEL_SMC_MODE_BAT_SELECT		(0 << 8)
+#define ATMEL_SMC_MODE_BAT_WRITE		(1 << 8)
+#define ATMEL_SMC_MODE_DBW_MASK			GENMASK(13, 12)
+#define ATMEL_SMC_MODE_DBW_8			(0 << 12)
+#define ATMEL_SMC_MODE_DBW_16			(1 << 12)
+#define ATMEL_SMC_MODE_DBW_32			(2 << 12)
+#define ATMEL_SMC_MODE_TDF_MASK			GENMASK(19, 16)
+#define ATMEL_SMC_MODE_TDF(x)			(((x) - 1) << 16)
+#define ATMEL_SMC_MODE_TDF_MAX			16
+#define ATMEL_SMC_MODE_TDF_MIN			1
+#define ATMEL_SMC_MODE_TDFMODE_OPTIMIZED	BIT(20)
+#define ATMEL_SMC_MODE_PMEN			BIT(24)
+#define ATMEL_SMC_MODE_PS_MASK			GENMASK(29, 28)
+#define ATMEL_SMC_MODE_PS_4			(0 << 28)
+#define ATMEL_SMC_MODE_PS_8			(1 << 28)
+#define ATMEL_SMC_MODE_PS_16			(2 << 28)
+#define ATMEL_SMC_MODE_PS_32			(3 << 28)
+
+#define ATMEL_HSMC_TIMINGS(cs)			(0x600 + ((cs) * 0x14) + 0xc)
+#define ATMEL_HSMC_TIMINGS_OCMS			BIT(12)
+#define ATMEL_HSMC_TIMINGS_RBNSEL(x)		((x) << 28)
+#define ATMEL_HSMC_TIMINGS_NFSEL		BIT(31)
+#define ATMEL_HSMC_TIMINGS_TCLR_SHIFT		0
+#define ATMEL_HSMC_TIMINGS_TADL_SHIFT		4
+#define ATMEL_HSMC_TIMINGS_TAR_SHIFT		8
+#define ATMEL_HSMC_TIMINGS_TRR_SHIFT		16
+#define ATMEL_HSMC_TIMINGS_TWB_SHIFT		24
+
+/**
+ * struct atmel_smc_cs_conf - SMC CS config as described in the datasheet.
+ * @setup: NCS/NWE/NRD setup timings (not applicable to at91rm9200)
+ * @pulse: NCS/NWE/NRD pulse timings (not applicable to at91rm9200)
+ * @cycle: NWE/NRD cycle timings (not applicable to at91rm9200)
+ * @timings: advanced NAND related timings (only applicable to HSMC)
+ * @mode: all kind of config parameters (see the fields definition above).
+ *	  The mode fields are different on at91rm9200
+ */
+struct atmel_smc_cs_conf {
+	u32 setup;
+	u32 pulse;
+	u32 cycle;
+	u32 timings;
+	u32 mode;
+};
+
+void atmel_smc_cs_conf_init(struct atmel_smc_cs_conf *conf);
+int atmel_smc_cs_conf_set_timing(struct atmel_smc_cs_conf *conf,
+				 unsigned int shift,
+				 unsigned int ncycles);
+int atmel_smc_cs_conf_set_setup(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles);
+int atmel_smc_cs_conf_set_pulse(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles);
+int atmel_smc_cs_conf_set_cycle(struct atmel_smc_cs_conf *conf,
+				unsigned int shift, unsigned int ncycles);
+void atmel_smc_cs_conf_apply(struct regmap *regmap, int cs,
+			     const struct atmel_smc_cs_conf *conf);
+void atmel_hsmc_cs_conf_apply(struct regmap *regmap, int cs,
+			      const struct atmel_smc_cs_conf *conf);
+void atmel_smc_cs_conf_get(struct regmap *regmap, int cs,
+			   struct atmel_smc_cs_conf *conf);
+void atmel_hsmc_cs_conf_get(struct regmap *regmap, int cs,
+			    struct atmel_smc_cs_conf *conf);
 
 /*
  * This function converts a setup timing expressed in nanoseconds into an
-- 
2.7.4
