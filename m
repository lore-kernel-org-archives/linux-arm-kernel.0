From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed,  4 Mar 2015 18:58:42 +0800
Subject: [PATCH v7 1/7] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <1425466722-30603-1-git-send-email-vincent.yang@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The MB86S7X is a bigLITTLE configuration of 2xCA7 & 2xCA15 under Linux.
And the remote master firmware (called SCB) running on CM3. Linux asks
for things to be done over Mailbox API, to SCB which controls most of
the important things. variations S70 & S73 are supported.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
---
 Documentation/devicetree/bindings/arm/mb86s7x.txt  |   8 +
 .../devicetree/bindings/soc/mb86s7x/scb_mhu.txt    |  35 ++
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/mach-mb86s7x/Kconfig                      |  19 +
 arch/arm/mach-mb86s7x/Makefile                     |   1 +
 arch/arm/mach-mb86s7x/board.c                      |  23 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mb86s7x/Makefile                       |   4 +
 drivers/soc/mb86s7x/scb_mhu.c                      | 517 +++++++++++++++++++++
 include/soc/mb86s7x/scb_mhu.h                      |  97 ++++
 12 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mb86s7x.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile
 create mode 100644 arch/arm/mach-mb86s7x/board.c
 create mode 100644 drivers/soc/mb86s7x/Makefile
 create mode 100644 drivers/soc/mb86s7x/scb_mhu.c
 create mode 100644 include/soc/mb86s7x/scb_mhu.h

diff --git a/Documentation/devicetree/bindings/arm/mb86s7x.txt b/Documentation/devicetree/bindings/arm/mb86s7x.txt
new file mode 100644
index 0000000..fbaad20
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mb86s7x.txt
@@ -0,0 +1,8 @@
+Fujitsu MB86S7X Device Tree Bindings
+
+Fujitsu has a few closely related platforms that are basically different
+configurations of each others. Like MB86S7{0,1,2,3}.
+
+The EVB boards with S70/S73 have the following property:
+Required root node property:
+	compatible: must contain "fujitsu,mb86s70-evb" or "fujitsu,mb86s73-evb"
diff --git a/Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt b/Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt
new file mode 100644
index 0000000..f466a05
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt
@@ -0,0 +1,35 @@
+Fujitsu SCB (Mailbox's Remote Firmware) bindings
+------------------------------------------------
+
+The firmware (running of a remote Cortex-M3 master) on Fujitsu's MB86S7X
+platforms is named SCB. The SCB owns most of core h/w IPs like Clock,
+CPUFreq/DVFS, CPUIdle/SMP, Thermal, a recovery block device and even an
+I2C controller. Linux has to map all of these functionalities on to
+the Mailbox API and get things done by the remote master.
+ Let the current state of SCB firmware be versioned 1.0.
+
+Required properties :
+- compatible : Shall contain "fujitsu,mb86s70-scb-1.0"
+- reg : Point to SharedMemory used for Mailbox protocol.
+- mboxes : phandle to the mailbox controller:channel node.
+
+The consumer specifies the desired clock pointing to its phandle.
+
+Example:
+
+	mhu: mhu0 at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "arm,mhu";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+		clocks = <&clk 0 2 1>;
+		clock-names = "apb_pclk";
+	};
+
+	mhu_client: scb at 2e000000 {
+		compatible = "fujitsu,mb86s70-scb-1.0";
+		reg = <0 0x2e000000 0x4000>; /* SHM for IPC */
+		mboxes = <&mhu 1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index eaf9996..e8faa31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1127,6 +1127,13 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/MB86S7X SOC SUPPORT
+M:	Vincent Yang <vincent.yang@socionext.com>
+M:	Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-mb86s7x/
+
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..c2da7b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -888,6 +888,8 @@ source "arch/arm/mach-keystone/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-mb86s7x/Kconfig"
+
 source "arch/arm/mach-meson/Kconfig"
 
 source "arch/arm/mach-msm/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7f99cd6..159f678 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,6 +167,7 @@ machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
+machine-$(CONFIG_ARCH_MB86S7X)		+= mb86s7x
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
new file mode 100644
index 0000000..f58b104
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Kconfig
@@ -0,0 +1,19 @@
+config ARCH_MB86S7X
+	bool "Fujitsu MB86S7x platforms" if ARCH_MULTI_V7
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_CCI
+	select ARM_GIC
+	select ARM_TIMER_SP804
+	select BIG_LITTLE
+	select HAVE_ARM_ARCH_TIMER
+	select MAILBOX
+	select PINCTRL
+	select PINCTRL_MB86S7X
+	select PM_OPP
+	select ZONE_DMA if ARM_LPAE
+	help
+	  Support for Fujitsu MB86S7x based platforms
diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
new file mode 100644
index 0000000..97640b6
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_MB86S7X)	+= board.o
diff --git a/arch/arm/mach-mb86s7x/board.c b/arch/arm/mach-mb86s7x/board.c
new file mode 100644
index 0000000..222b63f
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/board.c
@@ -0,0 +1,23 @@
+/*
+ * Support for the Fujitsu's MB86S7x based devices.
+ *
+ * Copyright (C) 2015 Linaro, LTD
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ */
+
+#include <linux/of.h>
+#include <asm/mach/arch.h>
+
+static const char *mb86s7x_dt_match[] __initconst = {
+	"fujitsu,mb86s70-evb",
+	"fujitsu,mb86s73-evb",
+	NULL,
+};
+
+DT_MACHINE_START(MB86S7X_DT, "Fujitsu MB86S7X-based board")
+	.dt_compat	= mb86s7x_dt_match,
+MACHINE_END
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 063113d..fb64bf2 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ARCH_MB86S7X)	+= mb86s7x/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
diff --git a/drivers/soc/mb86s7x/Makefile b/drivers/soc/mb86s7x/Makefile
new file mode 100644
index 0000000..f6b96cf
--- /dev/null
+++ b/drivers/soc/mb86s7x/Makefile
@@ -0,0 +1,4 @@
+#
+# Fujitsu's MB86S7X drivers
+#
+obj-$(CONFIG_ARCH_MB86S7X)	+= scb_mhu.o
diff --git a/drivers/soc/mb86s7x/scb_mhu.c b/drivers/soc/mb86s7x/scb_mhu.c
new file mode 100644
index 0000000..c1d66f4
--- /dev/null
+++ b/drivers/soc/mb86s7x/scb_mhu.c
@@ -0,0 +1,517 @@
+/*
+ * arch/arm/mach-mb86s7x/scb_mhu.c Shim 'server' for Mailbox clients
+ *
+ * Created by: Jassi Brar <jassisinghbrar@gmail.com>
+ * Copyright:	(C) 2013-2015 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/mailbox_client.h>
+#include <linux/platform_device.h>
+
+#include <soc/mb86s7x/scb_mhu.h>
+
+#include <asm/system_misc.h>
+
+#define INTR_STAT_OFS	0x0
+#define INTR_SET_OFS	0x8
+#define INTR_CLR_OFS	0x10
+
+static LIST_HEAD(free_xfers);
+static LIST_HEAD(pending_xfers);
+static DEFINE_SPINLOCK(fsm_lock);
+static struct completion fsm_rsp;
+static struct mbox_client mhu_cl;
+static struct mbox_chan *mhu_chan;
+static mb86s7x_mhu_handler_t handler[MHU_NUM_CMDS];
+
+static void __iomem *mhu_base, *mb86s7x_shm_base;
+static void __iomem *cmd_to_scb, *rsp_to_scb;
+static void __iomem *cmd_from_scb, *rsp_from_scb;
+
+static enum {
+	MHU_PARK = 0,
+	MHU_WRR, /* Waiting to get Remote's Reply */
+	MHU_WRL, /* Waiting to send Reply */
+	MHU_WRRL, /* WAIT_Ra && WAIT_Rb */
+	MHU_INVLD,
+} fsm_state;
+
+enum fsm_event {
+	EV_LC = 0, /* Local sent a command */
+	EV_RC, /* Remote sent a command */
+	EV_RR, /* Remote sent a reply */
+	EV_LR, /* Local sent a reply */
+};
+
+static int mhu_fsm[4][4] = {
+	[MHU_PARK] = {
+		[EV_LC] = MHU_WRR,
+		[EV_RC] = MHU_WRL,
+		[EV_RR] = MHU_INVLD,
+		[EV_LR] = MHU_INVLD,
+	},
+	[MHU_WRR] = {
+		[EV_LC] = MHU_INVLD,
+		[EV_RC] = MHU_WRRL,
+		[EV_RR] = MHU_PARK,
+		[EV_LR] = MHU_INVLD,
+	},
+	[MHU_WRL] = {
+		[EV_LC] = MHU_WRRL,
+		[EV_RC] = MHU_INVLD,
+		[EV_RR] = MHU_INVLD,
+		[EV_LR] = MHU_PARK,
+	},
+	[MHU_WRRL] = {
+		[EV_LC] = MHU_INVLD,
+		[EV_RC] = MHU_INVLD,
+		[EV_RR] = MHU_WRL,
+		[EV_LR] = MHU_WRR,
+	},
+};
+
+static struct mhu_xfer {
+	int len;
+	u32 code;
+	void *buf;
+	struct completion *c;
+	struct list_head node;
+} *ax; /* stages of xfer */
+
+static int mhu_alloc_xfers(int n, struct list_head *list)
+{
+	struct mhu_xfer *x = kcalloc(n, sizeof(struct mhu_xfer), GFP_ATOMIC);
+	int i;
+
+	if (!x)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++)
+		list_add(&x[i].node, &free_xfers);
+
+	return 0;
+}
+
+static void got_data(u32 code)
+{
+	mb86s7x_mhu_handler_t hndlr = NULL;
+	unsigned long flags;
+	int ev;
+
+	if (code & RESP_BIT)
+		ev = EV_RR;
+	else
+		ev = EV_RC;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		pr_err("State-%d EV-%d FSM Broken!\n", fsm_state, ev);
+		return;
+	}
+	fsm_state = mhu_fsm[fsm_state][ev];
+
+	if (code & RESP_BIT) {
+		memcpy_fromio(ax->buf, rsp_from_scb, ax->len);
+		if (ax->c)
+			complete(ax->c);
+		list_move(&ax->node, &free_xfers);
+		ax = NULL;
+	} else {
+		/* Find and dispatch relevant registered handler */
+		if (code < MHU_NUM_CMDS)
+			hndlr = handler[code];
+		if (hndlr)
+			hndlr(code, cmd_from_scb);
+		else
+			pr_err("No handler for CMD_%u\n", code);
+	}
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+}
+
+static int do_xfer(void)
+{
+	unsigned long flags;
+	struct mhu_xfer *x;
+	u32 code;
+	int ev;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (list_empty(&pending_xfers)) {
+		struct mbox_chan *_ch = NULL;
+		int cmd;
+
+		for (cmd = 0; cmd < MHU_NUM_CMDS && !handler[cmd]; cmd++)
+			;
+		/* Don't free channel if any user is listening */
+		if (cmd != MHU_NUM_CMDS) {
+			spin_unlock_irqrestore(&fsm_lock, flags);
+			return 0;
+		}
+
+		if (fsm_state == MHU_PARK) {
+			_ch = mhu_chan;
+			mhu_chan = NULL;
+		}
+
+		spin_unlock_irqrestore(&fsm_lock, flags);
+
+		if (_ch)
+			mbox_free_channel(_ch);
+
+		return 0;
+	}
+
+	x = list_first_entry(&pending_xfers, struct mhu_xfer, node);
+	code = x->code;
+
+	ev = code & RESP_BIT ? EV_LR : EV_LC;
+	if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		return 1;
+	}
+	list_del_init(&x->node);
+
+	/* Layout the SHM */
+	if (code & RESP_BIT)
+		memcpy_toio(rsp_to_scb, x->buf, x->len);
+	else
+		memcpy_toio(cmd_to_scb, x->buf, x->len);
+
+	if (ev == EV_LC)
+		ax = x;
+	else
+		list_move(&x->node, &free_xfers);
+	fsm_state = mhu_fsm[fsm_state][ev];
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	/* Prefer mailbox API */
+	if (!mhu_chan) {
+		struct mbox_chan *_ch;
+
+		_ch = mbox_request_channel(&mhu_cl, 0);
+		if (!IS_ERR(_ch))
+			mhu_chan = _ch;
+	}
+
+	if (mhu_chan) {
+		int ret;
+
+		init_completion(&fsm_rsp);
+
+		/* Send via generic api */
+		ret = mbox_send_message(mhu_chan, (void *)&code);
+		if (ret < 0) {
+			pr_err("%s:%d CMD_%d Send Failed\n",
+			       __func__, __LINE__, code);
+			BUG();
+		}
+		if (!(code & RESP_BIT)) {
+			ret = wait_for_completion_timeout(&fsm_rsp,
+						msecs_to_jiffies(1000));
+			if (!ret) {
+				pr_err("%s:%d CMD_%d Got No Reply\n",
+				       __func__, __LINE__, code);
+				BUG();
+			}
+			got_data(ax->code);
+		}
+	} else {
+		void __iomem *tx_reg = mhu_base + 0x120; /* HP-NonSec */
+		void __iomem *rx_reg = mhu_base + 0x20; /* HP-NonSec */
+		u32 val, count;
+
+		/* Send via early-boot api */
+		val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+		if (val) {
+			pr_err("Last CMD not yet read by SCB\n");
+			writel_relaxed(val, tx_reg + INTR_CLR_OFS);
+		}
+
+		writel_relaxed(x->code, tx_reg + INTR_SET_OFS);
+
+		/* Wait until this message is read */
+		count = 0x1000000;
+		do {
+			cpu_relax();
+			val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+		} while (--count && val);
+		if (val)
+			pr_err("%s:%d SCB not listening!\n",
+			       __func__, __LINE__);
+
+		if (!ax) {
+			/* A quick poll for pending remote cmd */
+			val = readl_relaxed(rx_reg + INTR_STAT_OFS);
+			if (val) {
+				got_data(val);
+				writel_relaxed(val, rx_reg + INTR_CLR_OFS);
+			}
+		} else {
+			do {
+				/* Wait until we get reply */
+				count = 0x1000000;
+				do {
+					cpu_relax();
+					val = readl_relaxed(
+						rx_reg + INTR_STAT_OFS);
+				} while (--count && !val);
+
+				if (val) {
+					got_data(val);
+					writel_relaxed(val,
+						     rx_reg + INTR_CLR_OFS);
+				} else {
+					pr_err("%s:%d SCB didn't reply\n",
+					       __func__, __LINE__);
+					return 1;
+				}
+			} while (!(val & RESP_BIT));
+		}
+		if (list_empty(&pending_xfers))
+			return 0;
+	}
+
+	return do_xfer();
+}
+
+static void mhu_recv(struct mbox_client *cl, void *data)
+{
+	u32 *arg = data;
+
+	if (*arg & RESP_BIT) {
+		/* Now that we got a reply to last TX, that
+		 * must mean the last TX was successful */
+		mbox_client_txdone(mhu_chan, 0);
+
+		ax->code = *arg; /* Save response */
+		complete(&fsm_rsp);
+		return;
+	}
+
+	got_data(*arg);
+}
+
+int mb86s7x_hndlr_set(u32 cmd, mb86s7x_mhu_handler_t hndlr)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+	if (cmd < MHU_NUM_CMDS && !handler[cmd]) {
+		ret = 0;
+		handler[cmd] = hndlr;
+	}
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	if (!mhu_chan) {
+		struct mbox_chan *_ch;
+
+		_ch = mbox_request_channel(&mhu_cl, 0);
+		if (!IS_ERR(_ch))
+			mhu_chan = _ch;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mb86s7x_hndlr_set);
+
+void mb86s7x_hndlr_clr(u32 cmd, mb86s7x_mhu_handler_t hndlr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (cmd < MHU_NUM_CMDS && handler[cmd] == hndlr)
+		handler[cmd] = NULL;
+
+	if (list_empty(&pending_xfers)) {
+		struct mbox_chan *_ch = NULL;
+
+		for (cmd = 0; cmd < MHU_NUM_CMDS && !handler[cmd]; cmd++)
+			;
+		/* Don't free channel if any user is listening */
+		if (cmd != MHU_NUM_CMDS) {
+			spin_unlock_irqrestore(&fsm_lock, flags);
+			return;
+		}
+
+		if (fsm_state == MHU_PARK) {
+			_ch = mhu_chan;
+			mhu_chan = NULL;
+		}
+
+		spin_unlock_irqrestore(&fsm_lock, flags);
+
+		if (_ch)
+			mbox_free_channel(_ch);
+
+		return;
+	}
+	spin_unlock_irqrestore(&fsm_lock, flags);
+}
+EXPORT_SYMBOL_GPL(mb86s7x_hndlr_clr);
+
+static int setup_mhu(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,mhu");
+	mhu_base = of_iomap(node, 0);
+	if (mhu_base == NULL) {
+		pr_err("Can't work without MHU\n");
+		return -ENODEV;
+	}
+
+	node = of_find_compatible_node(NULL, NULL, "fujitsu,mb86s70-scb-1.0");
+	mb86s7x_shm_base = of_iomap(node, 0);
+	if (mb86s7x_shm_base == NULL) {
+		pr_err("Can't work without SHM SRAM\n");
+		return -ENODEV;
+	}
+
+	cmd_from_scb = mb86s7x_shm_base + 0x3800;
+	rsp_from_scb = mb86s7x_shm_base + 0x3900;
+	cmd_to_scb = mb86s7x_shm_base + 0x3a00;
+	rsp_to_scb = mb86s7x_shm_base + 0x3b00;
+
+	return 0;
+}
+
+int mb86s7x_send_packet(u32 code, void *buf, int len)
+{
+	struct completion got_rsp;
+	unsigned long flags;
+	struct mhu_xfer *x;
+	int ret;
+
+	/*
+	 * The first caller could be as early as system clocksource,
+	 * when the platform devices are not populated yet.
+	 */
+	if (unlikely(!mb86s7x_shm_base) && setup_mhu())
+		return -ENODEV;
+
+	if ((code & ~0xff) || ((code & RESP_BIT)
+				&& fsm_state != MHU_WRRL
+				&& fsm_state != MHU_WRL)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	init_completion(&got_rsp);
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (list_empty(&free_xfers) && mhu_alloc_xfers(5, &free_xfers)) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		pr_err("%s:%d OOM\n", __func__, __LINE__);
+		return -EAGAIN;
+	}
+
+	x = list_first_entry(&free_xfers, struct mhu_xfer, node);
+	x->code = code;
+	x->buf = buf;
+	x->len = len;
+	x->c = &got_rsp;
+
+	if (code & RESP_BIT)
+		list_move(&x->node, &pending_xfers);
+	else
+		list_move_tail(&x->node, &pending_xfers);
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	ret = do_xfer();
+	if (ret > 0) {
+		ret = wait_for_completion_timeout(&got_rsp,
+						  msecs_to_jiffies(1000));
+		return ret ? 0 : -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mb86s7x_send_packet);
+
+struct mb86s7x_hard_reset {
+	u32 payload_size;
+	u32 delay;
+};
+
+static void mb86s7x_reboot(u32 delay)
+{
+	void __iomem *tx_reg = mhu_base + 0x120; /* HP-NonSec */
+	struct mb86s7x_hard_reset cmd;
+	u32 val;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.delay = delay;
+
+	val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+	if (val) /* Flush anything pending */
+		writel_relaxed(val, tx_reg + INTR_CLR_OFS);
+
+	memcpy_toio(cmd_to_scb, &cmd, sizeof(cmd));
+	writel_relaxed(CMD_HARD_RESET_REQ, tx_reg + INTR_SET_OFS);
+}
+
+static void
+mb86s7x_restart(enum reboot_mode reboot_mode, const char *unused)
+{
+	/* Reboot immediately (after 50ms) */
+	mb86s7x_reboot(50);
+}
+
+static void mb86s7x_poweroff(void)
+{
+	/* Reboot never, remain dead */
+	mb86s7x_reboot(~0);
+}
+
+static int f_scb_probe(struct platform_device *pdev)
+{
+	mhu_cl.tx_block = true;
+	mhu_cl.knows_txdone = true;
+	mhu_cl.rx_callback = mhu_recv;
+	mhu_cl.dev = &pdev->dev;
+
+	arm_pm_restart = mb86s7x_restart;
+	pm_power_off = mb86s7x_poweroff;
+
+	return 0;
+}
+
+static const struct of_device_id scb_dt_ids[] = {
+	{ .compatible = "fujitsu,mb86s70-scb-1.0" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, scb_dt_ids);
+
+static struct platform_driver f_scb_driver = {
+	.driver		= {
+		.name	= "f_scb",
+		.of_match_table = scb_dt_ids,
+	},
+	.probe = f_scb_probe,
+};
+
+static int __init f_scb_init(void)
+{
+	return platform_driver_register(&f_scb_driver);
+}
+module_init(f_scb_init);
diff --git a/include/soc/mb86s7x/scb_mhu.h b/include/soc/mb86s7x/scb_mhu.h
new file mode 100644
index 0000000..42a1baa
--- /dev/null
+++ b/include/soc/mb86s7x/scb_mhu.h
@@ -0,0 +1,97 @@
+/*
+ * include/soc/mb86s7x/scb_mhu.h
+ *
+ * Created by: Jassi Brar <jassisinghbrar@gmail.com>
+ * Copyright:	(C) 2013-2015 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MB86S7X_SCB_MHU_H
+#define __MB86S7X_SCB_MHU_H
+
+#define CMD_MASK    0x7f    /* 128 possible commands */
+#define RESP_BIT    (1 << 7) /* If it's a response */
+
+#define ENC_CMD(c)  ((c) & CMD_MASK)
+#define DEC_CMD(v)  (((v) & ~CMD_MASK) ? CMD_INVALID : ((v) & CMD_MASK))
+
+#define ENC_REP(r)  (((r) & CMD_MASK) | RESP_BIT)
+
+/* If v is the reply to command c */
+#define IS_A_REP(v, c)  (((v) & RESP_BIT) && (((v) & CMD_MASK) == (c)))
+
+enum {
+	CMD_INVALID = 0,
+	CMD_I2C_XFER_REQ = 1,
+	CMD_PERI_POWER_SET_REQ = 2,
+	CMD_PERI_CLOCK_GATE_SET_REQ = 3,
+	CMD_PERI_CLOCK_GATE_GET_REQ = 4,
+	CMD_PERI_CLOCK_RATE_SET_REQ = 5,
+	CMD_PERI_CLOCK_RATE_GET_REQ = 6,
+	CMD_CPU_CLOCK_GATE_SET_REQ = 7,
+	CMD_CPU_CLOCK_GATE_GET_REQ = 8,
+	CMD_CPU_CLOCK_RATE_SET_REQ = 9,
+	CMD_CPU_CLOCK_RATE_GET_REQ = 0xa,
+	CMD_CLUSTER_OPP_GET_REQ = 0xb,
+	CMD_CLOCK_DSI_PIXEL_REQ = 0xc,
+	CMD_SCB_CAPABILITY_GET_REQ = 0xd,
+	CMD_SYS_RESET_CAUSE_GET_REQ = 0xe,
+	CMD_SYS_SPECIFIC_INFO_GET_REQ = 0xf,
+	CMD_REBOOT_AP_AFTER_REQ = 0x10,
+	CMD_TAIKI_REQ = 0x11,
+	CMD_TAIKI_ASYNC_MSG_REQ = 0x12,
+	CMD_GET_WORD_REQ = 0x13,
+	CMD_HARD_RESET_REQ = 0x14,
+	CMD_MAINTENANCE_MODE_REQ = 0x15,
+	CMD_STG_GET_SIZE_REQ = 0x16,
+	CMD_STG_BLOCK_READ_REQ = 0x17,
+	CMD_STG_BLOCK_WRITE_REQ = 0x18,
+	CMD_MEMORY_LAYOUT_GET_REQ = 0x19,
+	CMD_POWERDOMAIN_GET_REQ = 0x1a,
+	CMD_POWERDOMAIN_SET_REQ = 0x1b,
+	CMD_STG_BLOCK_ERASE_REQ = 0x1c,
+
+	/* Do NOT add new commands below this line */
+	MHU_NUM_CMDS,
+};
+
+#define CMD_I2C_XFER_REP	ENC_REP(CMD_I2C_XFER_REQ)
+#define CMD_PERI_POWER_SET_REP	ENC_REP(CMD_PERI_POWER_SET_REQ)
+#define CMD_PERI_CLOCK_GATE_SET_REP	ENC_REP(CMD_PERI_CLOCK_GATE_SET_REQ)
+#define CMD_PERI_CLOCK_GATE_GET_REP	ENC_REP(CMD_PERI_CLOCK_GATE_GET_REQ)
+#define CMD_PERI_CLOCK_RATE_SET_REP	ENC_REP(CMD_PERI_CLOCK_RATE_SET_REQ)
+#define CMD_PERI_CLOCK_RATE_GET_REP	ENC_REP(CMD_PERI_CLOCK_RATE_GET_REQ)
+#define CMD_CPU_CLOCK_GATE_SET_REP	ENC_REP(CMD_CPU_CLOCK_GATE_SET_REQ)
+#define CMD_CPU_CLOCK_GATE_GET_REP	ENC_REP(CMD_CPU_CLOCK_GATE_GET_REQ)
+#define CMD_CPU_CLOCK_RATE_SET_REP	ENC_REP(CMD_CPU_CLOCK_RATE_SET_REQ)
+#define CMD_CPU_CLOCK_RATE_GET_REP	ENC_REP(CMD_CPU_CLOCK_RATE_GET_REQ)
+#define CMD_CLUSTER_OPP_GET_REP	ENC_REP(CMD_CLUSTER_OPP_GET_REQ)
+#define CMD_CLOCK_DSI_PIXEL_REP	ENC_REP(CMD_CLOCK_DSI_PIXEL_REQ)
+#define CMD_SCB_CAPABILITY_GET_REP	ENC_REP(CMD_SCB_CAPABILITY_GET_REQ)
+#define CMD_SYS_RESET_CAUSE_GET_REP	ENC_REP(CMD_SYS_RESET_CAUSE_GET_REQ)
+#define CMD_SYS_SPECIFIC_INFO_GET_REP	ENC_REP(CMD_SYS_SPECIFIC_INFO_GET_REQ)
+#define CMD_GET_WORD_REP	ENC_REP(CMD_GET_WORD_REQ)
+#define CMD_REBOOT_AP_AFTER_REP	ENC_REP(CMD_REBOOT_AP_AFTER_REQ)
+#define CMD_TAIKI_REP			ENC_REP(CMD_TAIKI_REQ)
+#define CMD_TAIKI_ASYNC_MSG_REP		ENC_REP(CMD_TAIKI_ASYNC_MSG_REQ)
+#define CMD_HARD_RESET_REP		ENC_REP(CMD_HARD_RESET_REQ)
+#define CMD_MAINTENANCE_MODE_REP	ENC_RSP(CMD_MAINTENANCE_MODE_REQ)
+#define CMD_STG_GET_SIZE_REP		ENC_REP(CMD_STG_GET_SIZE_REQ)
+#define CMD_STG_BLOCK_READ_REP		ENC_REP(CMD_STG_BLOCK_READ_REQ)
+#define CMD_STG_BLOCK_WRITE_REP		ENC_REP(CMD_STG_BLOCK_WRITE_REQ)
+#define CMD_MEMORY_LAYOUT_GET_REP	ENC_REP(CMD_MEMORY_LAYOUT_GET_REQ)
+#define CMD_POWERDOMAIN_GET_REP		ENC_REP(CMD_POWERDOMAIN_GET_REQ)
+#define CMD_POWERDOMAIN_SET_REP		ENC_REP(CMD_POWERDOMAIN_SET_REQ)
+#define CMD_STG_BLOCK_ERASE_REP		ENC_REP(CMD_STG_BLOCK_ERASE_REQ)
+
+/* Helper functions to talk to remote */
+int mb86s7x_send_packet(u32 code, void *buf, int len);
+
+typedef void (*mb86s7x_mhu_handler_t)(u32 cmd, u8 rcbuf[]);
+int mb86s7x_hndlr_set(u32 cmd, mb86s7x_mhu_handler_t);
+void mb86s7x_hndlr_clr(u32 cmd, mb86s7x_mhu_handler_t);
+
+#endif /* __MB86S7X_SCB_MHU_H */
-- 
1.9.0
