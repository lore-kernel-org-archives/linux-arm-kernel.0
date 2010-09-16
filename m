From: thara@ti.com (Gopinath, Thara)
Date: Thu, 16 Sep 2010 16:10:06 +0530
Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
In-Reply-To: <1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>>-----Original Message-----
>>From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Thursday, September 16, 2010 3:27 AM
>>To: linux-omap at vger.kernel.org
>>Cc: linux-arm-kernel at lists.infradead.org
>>Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>
>>From: Paul Walmsley <paul@pwsan.com>
>>
>>The OPP layer code should be independent of the PMIC,
>>introduce the TWL/TPS-specific code out to its own file.

Hello Kevin,

I have been using this code for a while now. I really do not think wee need a separate
file for implementing the vsel to voltage in (uV) and vice versa formulas. Today only voltage
layer is interested in these conversions. Voltage layer has a structure that can be populated with
the information required from the PMIC. We only need to add two more function pointers to this structure. This info can then be passed from the actual PMIC driver file. This will make it much
more simpler for OMAP4 where we have different formulas between different revisions of PMIC. Also
in the omap voltage code we will no longer have to hard code omap_twl_vsel_to_uv and omap_twl_uv_to_vsel. So please consider dropping this patch from this series.

Regards
Thara

>>
>>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>Signed-off-by: Romit Dasgupta <romit@ti.com>
>>Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>> arch/arm/plat-omap/Makefile                   |    1 +
>> arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 +++++++++++++
>> arch/arm/plat-omap/opp_twl_tps.c              |   41 +++++++++++++++++++++++++
>> 3 files changed, 63 insertions(+), 0 deletions(-)
>> create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
>> create mode 100644 arch/arm/plat-omap/opp_twl_tps.c
>>
>>diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>>index c718a0a..a88879c 100644
>>--- a/arch/arm/plat-omap/Makefile
>>+++ b/arch/arm/plat-omap/Makefile
>>@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>> # OPP support in (OMAP3+ only at the moment)
>> ifdef CONFIG_PM
>> obj-$(CONFIG_ARCH_OMAP3) += opp.o
>>+obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
>> endif
>>
>> # omap_device support (OMAP2+ only at the moment)
>>diff --git a/arch/arm/plat-omap/include/plat/opp_twl_tps.h b/arch/arm/plat-
>>omap/include/plat/opp_twl_tps.h
>>new file mode 100644
>>index 0000000..8784e5f
>>--- /dev/null
>>+++ b/arch/arm/plat-omap/include/plat/opp_twl_tps.h
>>@@ -0,0 +1,21 @@
>>+/*
>>+ * opp_twl_tps.h - TWL/TPS-specific headers for the OPP code
>>+ *
>>+ * Copyright (C) 2009 Texas Instruments Incorporated.
>>+ *	Nishanth Menon
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License version 2 as
>>+ * published by the Free Software Foundation.
>>+ *
>>+ * XXX This code belongs as part of some other TWL/TPS code.
>>+ */
>>+#ifndef _ARCH_ARM_PLAT_OMAP_OPP_TWL_TPS_H
>>+#define _ARCH_ARM_PLAT_OMAP_OPP_TWL_TPS_H
>>+
>>+#include <linux/kernel.h>
>>+
>>+unsigned long omap_twl_vsel_to_uv(const u8 vsel);
>>+u8 omap_twl_uv_to_vsel(unsigned long uV);
>>+
>>+#endif
>>diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
>>new file mode 100644
>>index 0000000..112f106
>>--- /dev/null
>>+++ b/arch/arm/plat-omap/opp_twl_tps.c
>>@@ -0,0 +1,41 @@
>>+/*
>>+ * opp_twl_tps.c - TWL/TPS-specific functions for the OPP code
>>+ *
>>+ * Copyright (C) 2009 Texas Instruments Incorporated.
>>+ * Nishanth Menon
>>+ * Copyright (C) 2009 Nokia Corporation
>>+ * Paul Walmsley
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License version 2 as
>>+ * published by the Free Software Foundation.
>>+ *
>>+ * XXX This code should be part of some other TWL/TPS code.
>>+ */
>>+
>>+#include <plat/opp_twl_tps.h>
>>+
>>+/**
>>+ * omap_twl_vsel_to_vdc - convert TWL/TPS VSEL value to microvolts DC
>>+ * @vsel: TWL/TPS VSEL value to convert
>>+ *
>>+ * Returns the microvolts DC that the TWL/TPS family of PMICs should
>>+ * generate when programmed with @vsel.
>>+ */
>>+unsigned long omap_twl_vsel_to_uv(const u8 vsel)
>>+{
>>+	return (((vsel * 125) + 6000)) * 100;
>>+}
>>+
>>+/**
>>+ * omap_twl_uv_to_vsel - convert microvolts DC to TWL/TPS VSEL value
>>+ * @uv: microvolts DC to convert
>>+ *
>>+ * Returns the VSEL value necessary for the TWL/TPS family of PMICs to
>>+ * generate an output voltage equal to or greater than @uv microvolts DC.
>>+ */
>>+u8 omap_twl_uv_to_vsel(unsigned long uv)
>>+{
>>+	/* Round up to higher voltage */
>>+	return DIV_ROUND_UP(uv - 600000, 12500);
>>+}
>>--
>>1.7.2.1
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo at vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
