From: thara@ti.com (Gopinath, Thara)
Date: Sat, 24 Jul 2010 12:13:56 +0530
Subject: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C2A5@dbde02.ent.ti.com>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
	<20100702152930.6221.32877.stgit@localhost.localdomain>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C2A5@dbde02.ent.ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323C3F32F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>>-----Original Message-----
>>From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of
>>Gopinath, Thara
>>Sent: Thursday, July 15, 2010 10:56 AM
>>To: Paul Walmsley; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>Cc: Kevin Hilman
>>Subject: RE: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
>>
>>
>>
>>>>-----Original Message-----
>>>>From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Paul
>>>>Walmsley
>>>>Sent: Friday, July 02, 2010 9:00 PM
>>>>To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>>>Cc: Kevin Hilman
>>>>Subject: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
>>>>
>>>>From: Kevin Hilman <khilman@deeprootsystems.com>
>>>>
>>>>Create simple omap_devices for the main processors and busses.
>>>>
>>>>This is required to support the forth-coming device-based OPP
>>>>approach, where OPPs are managed and tracked at the device level.
>>>>
>>>>Also, move these common PM init functions into a common_pm_init call
>>>>that is called as a device_initcall().  The PM init is done at this level
>>>>to ensure that the driver core is initialized before initialized.
>>>>
>>>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>>>[paul at pwsan.com: sparse warnings cleaned up; newly-created functions moved
>>>> from mach-omap2/io.c to mach-omap2/pm.c; newly-created functions renamed
>>>> to start with "omap2" rather than "omap"]
>>>>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>>>---
>>>> arch/arm/mach-omap2/Makefile             |    2 -
>>>> arch/arm/mach-omap2/io.c                 |    2 -
>>>> arch/arm/mach-omap2/pm.c                 |   84 ++++++++++++++++++++++++++++++
>>>> arch/arm/plat-omap/include/plat/common.h |    4 +
>>>> 4 files changed, 90 insertions(+), 2 deletions(-)
>>>> create mode 100644 arch/arm/mach-omap2/pm.c
>>>>
>>>>diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>>>index 2fa3418..213f1df 100644
>>>>--- a/arch/arm/mach-omap2/Makefile
>>>>+++ b/arch/arm/mach-omap2/Makefile
>>>>@@ -3,7 +3,7 @@
>>>> #
>>>>
>>>> # Common support
>>>>-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
>>>>+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
>>>>
>>>> omap-2-3-common				= irq.o sdrc.o
>>>> hwmod-common				= omap_hwmod.o \
>>>>diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>>>>index 05c9cdb..2b983ac 100644
>>>>--- a/arch/arm/mach-omap2/io.c
>>>>+++ b/arch/arm/mach-omap2/io.c
>>>>@@ -44,6 +44,7 @@
>>>>
>>>> #include <plat/clockdomain.h>
>>>> #include "clockdomains.h"
>>>>+
>>>> #include <plat/omap_hwmod.h>
>>>>
>>>> /*
>>>>@@ -346,7 +347,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>>>> 	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
>>>> 		omap_hwmod_late_init(skip_setup_idle);
>>>>
>>>>-	omap_pm_if_init();
>>>> 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>>>> 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>>>> 		_omap2_init_reprogram_sdrc();
>>>>diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>>>new file mode 100644
>>>>index 0000000..68f9f2e
>>>>--- /dev/null
>>>>+++ b/arch/arm/mach-omap2/pm.c
>>>>@@ -0,0 +1,84 @@
>>>>+/*
>>>>+ * pm.c - Common OMAP2+ power management-related code
>>>>+ *
>>>>+ * Copyright (C) 2010 Texas Instruments, Inc.
>>>>+ * Copyright (C) 2010 Nokia Corporation
>>>>+ *
>>>>+ * This program is free software; you can redistribute it and/or modify
>>>>+ * it under the terms of the GNU General Public License version 2 as
>>>>+ * published by the Free Software Foundation.
>>>>+ */
>>>>+
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/init.h>
>>>>+#include <linux/io.h>
>>>>+#include <linux/err.h>
>>>>+
>>>>+#include <plat/omap-pm.h>
>>>>+#include <plat/omap_device.h>
>>>>+#include <plat/common.h>
>>>>+
>>>>+static struct omap_device_pm_latency *pm_lats;
>>>>+
>>>>+static struct device *mpu_dev;
>>>>+static struct device *dsp_dev;
>>>>+static struct device *l3_dev;
>>>>+
>>>>+struct device *omap2_get_mpuss_device(void)
>>>>+{
>>>>+	WARN_ON_ONCE(!mpu_dev);
>>>>+	return mpu_dev;
>>>>+}
>>>>+
>>>>+struct device *omap2_get_dsp_device(void)
>>>>+{
>>>>+	WARN_ON_ONCE(!dsp_dev);
>>>>+	return dsp_dev;
>>>>+}
>>First of all, apologies for so late posting of the comment. IMHO it would be good to rename this API
>>as omap2_get_iva_device. This is because OMAP4 has separate IVA and DSP devices and we will need to
>>build the omap_device for both. If we could rename this as omap2_get_iva_device, we could introduce
>>another API omap4_get_iva_device until bridge starts doing a omap_device_build for all these devices.

Hello Paul,

Any thoughts on this one?

Regards
Thara
