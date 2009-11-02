From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Nov 2009 12:12:39 +0100
Subject: msm_sdcc.c: add missing include, fix compilation
In-Reply-To: <20091022185126.GA4401@n2100.arm.linux.org.uk>
References: <20091022072119.GA3285@elf.ucw.cz>
	<20091022185126.GA4401@n2100.arm.linux.org.uk>
Message-ID: <20091102111239.GB26989@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Add missing include for	msm_sdcc compilation.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> I don't think this is the right solution - why should MSM have a
> platform specific include in the ARM generic include files?
> 
> (If anything, we should be getting rid of any non-shared platform
> specific includes in the arch/arm/include/asm/mach directory.)

Ok.

---

Add missing include for msm_sdcc compilation, and remove pwrsink
support that is not mainline, yet.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-msm/include/mach/mmc.h b/arch/arm/mach-msm/include/mach/mmc.h
new file mode 100644
index 0000000..8948dec
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/mmc.h
@@ -0,0 +1,26 @@
+/*
+ *  arch/arm/include/asm/mach/mmc.h
+ */
+#ifndef ASMARM_MACH_MMC_H
+#define ASMARM_MACH_MMC_H
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/sdio_func.h>
+
+struct embedded_sdio_data {
+        struct sdio_cis cis;
+        struct sdio_cccr cccr;
+        struct sdio_embedded_func *funcs;
+        int num_funcs;
+};
+
+struct mmc_platform_data {
+	unsigned int ocr_mask;			/* available voltages */
+	u32 (*translate_vdd)(struct device *, unsigned int);
+	unsigned int (*status)(struct device *);
+	struct embedded_sdio_data *embedded_sdio;
+	int (*register_status_notify)(void (*callback)(int card_present, void *dev_id), void *dev_id);
+};
+
+#endif
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index dba4600..b31946e 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -38,10 +38,9 @@
 #include <asm/div64.h>
 #include <asm/sizes.h>
 
-#include <asm/mach/mmc.h>
+#include <mach/mmc.h>
 #include <mach/msm_iomap.h>
 #include <mach/dma.h>
-#include <mach/htc_pwrsink.h>
 
 #include "msm_sdcc.h"
 
@@ -775,13 +774,11 @@ msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		htc_pwrsink_set(PWRSINK_SDCARD, 0);
 		break;
 	case MMC_POWER_UP:
 		pwr |= MCI_PWR_UP;
 		break;
 	case MMC_POWER_ON:
-		htc_pwrsink_set(PWRSINK_SDCARD, 100);
 		pwr |= MCI_PWR_ON;
 		break;
 	}


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
