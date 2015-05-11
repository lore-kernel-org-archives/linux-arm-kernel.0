From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 May 2015 11:53:47 +0100
Subject: [PATCH 02/12] clocksource: sti: Provide support for the ST LPC
 Clocksource IP
In-Reply-To: <55506B87.3070807@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
 <55506B87.3070807@linaro.org>
Message-ID: <20150511105347.GA20742@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 May 2015, Daniel Lezcano wrote:

> On 05/07/2015 03:38 PM, Lee Jones wrote:
> >This IP is shared with Watchdog and RTC functionality.  Only one of
> >these IPs can be used at the same time.  We use the device-driver
> >model combined with a DT 'mode' property to enforce this.
> >
> >The ST LPC Clocksource IP can be used as the system (tick) timer.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  drivers/clocksource/Kconfig         |   8 +++
> >  drivers/clocksource/Makefile        |   1 +
> >  drivers/clocksource/clksrc_st_lpc.c | 123 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 132 insertions(+)
> >  create mode 100644 drivers/clocksource/clksrc_st_lpc.c
> >
> >diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >index 68161f7..ac424cf 100644
> >--- a/drivers/clocksource/Kconfig
> >+++ b/drivers/clocksource/Kconfig
> >@@ -250,4 +250,12 @@ config CLKSRC_PXA
> >  	help
> >  	  This enables OST0 support available on PXA and SA-11x0
> >  	  platforms.
> >+
> >+config CLKSRC_ST_LPC
> >+	bool
> >+	depends on ARCH_STI
> >+	select CLKSRC_OF if OF
> >+	help
> >+	  Enable this option to use the Low Power controller timer
> >+	  as clocksource.
> >  endmenu
> >diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> >index 752d5c7..e08da4d 100644
> >--- a/drivers/clocksource/Makefile
> >+++ b/drivers/clocksource/Makefile
> >@@ -51,3 +51,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
> >  obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
> >  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
> >  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
> >+obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
> >diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
> >new file mode 100644
> >index 0000000..18a7dcd0
> >--- /dev/null
> >+++ b/drivers/clocksource/clksrc_st_lpc.c
> >@@ -0,0 +1,123 @@
> >+/*
> >+ * Clocksource using the Low Power Timer found in the Low Power Controller (LPC)
> >+ *
> >+ * Copyright (C) 2015 STMicroelectronics ? All Rights Reserved
> >+ *
> >+ * Author(s): Francesco Virlinzi <francesco.virlinzi@st.com>
> >+ *	      Ajit Pal Singh <ajitpal.singh@st.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License as published by
> >+ * the Free Software Foundation; either version 2 of the License, or
> >+ * (at your option) any later version.
> >+ */
> >+
> >+#include <linux/clk.h>
> >+#include <linux/clocksource.h>
> >+#include <linux/init.h>
> >+#include <linux/of_address.h>
> >+#include <linux/slab.h>
> >+
> >+#include <dt-bindings/mfd/st-lpc.h>
> >+
> >+/* Low Power Timer */
> >+#define LPC_LPT_LSB_OFF		0x400
> >+#define LPC_LPT_MSB_OFF		0x404
> >+#define LPC_LPT_START_OFF	0x408
> >+
> >+static struct st_clksrc_ddata {
> >+	struct clk		*clk;
> >+	void __iomem		*base;
> >+} ddata;
> >+
> >+static void st_clksrc_reset(void)
> >+{
> >+	writel_relaxed(0, ddata.base + LPC_LPT_START_OFF);
> >+	writel_relaxed(0, ddata.base + LPC_LPT_MSB_OFF);
> >+	writel_relaxed(0, ddata.base + LPC_LPT_LSB_OFF);
> >+	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
> >+}
> >+
> >+static int __init st_clksrc_init(void)
> >+{
> >+	unsigned long rate;
> >+	int ret;
> >+
> >+	st_clksrc_reset();
> >+
> >+	rate = clk_get_rate(ddata.clk);
> >+
> >+	ret = clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
> >+				    "clksrc-st-lpc", rate, 300, 32,
> >+				    clocksource_mmio_readl_up);
> >+	if (ret) {
> >+		pr_err("clksrc-st-lpc: Failed to register clocksource\n");
> >+		return ret;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int st_clksrc_setup_clk(struct device_node *np)
> >+{
> >+	struct clk *clk;
> >+	int ret;
> >+
> >+	clk = of_clk_get(np, 0);
> >+	if (IS_ERR(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to get LPC clock\n");
> >+		ret = PTR_ERR(clk);
> >+		return ret;
> 
> return PTR_ERR(clk);
> 
> so you can get rid of the 'int ret' variable.

Absolutely.  Good spot.

> >+	}
> >+
> >+	if (clk_prepare_enable(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to enable LPC clock\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (!clk_get_rate(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to get LPC clock rate\n");
> >+		clk_disable_unprepare(clk);
> >+		return -EINVAL;
> >+	}
> >+
> >+	ddata.clk = clk;
> >+
> >+	return 0;
> >+}
> >+
> >+static void __init st_clksrc_of_register(struct device_node *np)
> >+{
> >+	int ret;
> >+	uint32_t mode;
> >+
> >+	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> >+	if (ret) {
> >+		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
> >+		return;
> >+	}
> >+
> >+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> >+	if (mode != ST_LPC_MODE_CLKSRC)
> >+		return;
> 
> I am confused with this patch description + comment and the patch
> 1's description.
> 
> For the former, I understand the LPC could be in RTC or WDT mode and
> used as a clocksource (clksrc + rtc / clksrc + wdt), for the latter
> I understand there are three modes clocksource, rtc and watchdog
> (mutually exclusive). Could you clarify ?

They are all mutually exclusive.  I will fix-up the commit log to
re-enforce this.

> >+
> >+	ddata.base = of_iomap(np, 0);
> >+	if (!ddata.base) {
> >+		pr_err("clksrc-st-lpc: Unable to map iomem\n");
> >+		return;
> >+	}
> >+
> >+	if (st_clksrc_setup_clk(np)) {
> >+		iounmap(ddata.base);
> >+		return;
> >+	}
> >+
> >+	if (st_clksrc_init()) {
> >+		iounmap(ddata.base);
> >+		return;
> >+	}
> >+
> >+	pr_info("clksrc-st-lpc: clocksource initialised - running @ %luHz\n",
> >+		clk_get_rate(ddata.clk));
> >+}
> >+CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_register);
> >
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
