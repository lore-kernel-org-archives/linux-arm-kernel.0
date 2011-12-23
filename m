From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Dec 2011 16:17:41 -0800
Subject: [PATCH 2/9] arm/tegra: use APB DMA for accessing APB devices
In-Reply-To: <1324599468-12845-1-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
Message-ID: <1324599468-12845-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra2 hangs if APB registers are accessed from the cpu during an
apb dma operation. The workaround is to use apb dma to read/write the
registers instead.

There is a dependency loop between fuses, clocks, and APBDMA.  If dma
is enabled, fuse reads must go through APBDMA to avoid corruption due
to a hw bug.  APBDMA requires a clock to be enabled.  Clocks must read
a fuse to determine allowable cpu frequencies.

Separate out the fuse DMA initialization, and allow the fuse read
and write functions to be called without using DMA before the DMA
initialization has been completed.  Access to the fuses before APBDMA
is initialized won't hit the hardware bug because nothing else can be
using DMA.

Original fuse registar access code from Varun Wadekar
<vwadekar@nvidia.com>, improved by Colin Cross <ccross@android.com>
and later moved to separate driver by Jon Mayo <jmayo@nvidia.com>.

Major refactoring/cleanup by Olof Johansson <olof@lixom.net>.

From: Jon Mayo <jmayo@nvidia.com>.
Signed-off-by: Jon Mayo <jmayo@nvidia.com>.
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Makefile |    2 +-
 arch/arm/mach-tegra/apbio.c  |  140 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/apbio.h  |   39 ++++++++++++
 arch/arm/mach-tegra/dma.c    |    2 +
 4 files changed, 182 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/apbio.c
 create mode 100644 arch/arm/mach-tegra/apbio.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e120ff5..23d15fb 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pinmux-tegra30-tables.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
-obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
+obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o apbio.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-$(CONFIG_USB_SUPPORT)		+= usb_phy.o
diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
new file mode 100644
index 0000000..7af9a4e
--- /dev/null
+++ b/arch/arm/mach-tegra/apbio.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2010 NVIDIA Corporation.
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/sched.h>
+#include <linux/mutex.h>
+
+#include <mach/dma.h>
+#include <mach/iomap.h>
+
+#include "apbio.h"
+
+static DEFINE_MUTEX(tegra_apb_dma_lock);
+
+static struct tegra_dma_channel *tegra_apb_dma;
+static u32 *tegra_apb_bb;
+static dma_addr_t tegra_apb_bb_phys;
+static DECLARE_COMPLETION(tegra_apb_wait);
+
+bool tegra_apb_init(void)
+{
+	struct tegra_dma_channel *ch;
+
+	mutex_lock(&tegra_apb_dma_lock);
+
+	/* Check to see if we raced to setup */
+	if (tegra_apb_dma)
+		goto out;
+
+	ch = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT |
+		TEGRA_DMA_SHARED);
+
+	if (!ch)
+		goto out_fail;
+
+	tegra_apb_bb = dma_alloc_coherent(NULL, sizeof(u32),
+		&tegra_apb_bb_phys, GFP_KERNEL);
+	if (!tegra_apb_bb) {
+		pr_err("%s: can not allocate bounce buffer\n", __func__);
+		tegra_dma_free_channel(ch);
+		goto out_fail;
+	}
+
+	tegra_apb_dma = ch;
+out:
+	mutex_unlock(&tegra_apb_dma_lock);
+	return true;
+
+out_fail:
+	mutex_unlock(&tegra_apb_dma_lock);
+	return true;
+}
+
+static void apb_dma_complete(struct tegra_dma_req *req)
+{
+	complete(&tegra_apb_wait);
+}
+
+u32 tegra_apb_readl(unsigned long offset)
+{
+	struct tegra_dma_req req;
+	int ret;
+
+	if (!tegra_apb_dma && !tegra_apb_init())
+		return readl(IO_TO_VIRT(offset));
+
+	mutex_lock(&tegra_apb_dma_lock);
+	req.complete = apb_dma_complete;
+	req.to_memory = 1;
+	req.dest_addr = tegra_apb_bb_phys;
+	req.dest_bus_width = 32;
+	req.dest_wrap = 1;
+	req.source_addr = offset;
+	req.source_bus_width = 32;
+	req.source_wrap = 4;
+	req.req_sel = 0;
+	req.size = 4;
+
+	INIT_COMPLETION(tegra_apb_wait);
+
+	tegra_dma_enqueue_req(tegra_apb_dma, &req);
+
+	ret = wait_for_completion_timeout(&tegra_apb_wait,
+		msecs_to_jiffies(50));
+
+	if (WARN(ret == 0, "apb read dma timed out"))
+		*(u32 *)tegra_apb_bb = 0;
+
+	mutex_unlock(&tegra_apb_dma_lock);
+	return *((u32 *)tegra_apb_bb);
+}
+
+void tegra_apb_writel(u32 value, unsigned long offset)
+{
+	struct tegra_dma_req req;
+	int ret;
+
+	if (!tegra_apb_dma && !tegra_apb_init()) {
+		writel(value, IO_TO_VIRT(offset));
+		return;
+	}
+
+	mutex_lock(&tegra_apb_dma_lock);
+	*((u32 *)tegra_apb_bb) = value;
+	req.complete = apb_dma_complete;
+	req.to_memory = 0;
+	req.dest_addr = offset;
+	req.dest_wrap = 4;
+	req.dest_bus_width = 32;
+	req.source_addr = tegra_apb_bb_phys;
+	req.source_bus_width = 32;
+	req.source_wrap = 1;
+	req.req_sel = 0;
+	req.size = 4;
+
+	INIT_COMPLETION(tegra_apb_wait);
+
+	tegra_dma_enqueue_req(tegra_apb_dma, &req);
+
+	ret = wait_for_completion_timeout(&tegra_apb_wait,
+		msecs_to_jiffies(50));
+
+	mutex_unlock(&tegra_apb_dma_lock);
+}
diff --git a/arch/arm/mach-tegra/apbio.h b/arch/arm/mach-tegra/apbio.h
new file mode 100644
index 0000000..8b49e8c
--- /dev/null
+++ b/arch/arm/mach-tegra/apbio.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2010 NVIDIA Corporation.
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_APBIO_H
+#define __MACH_TEGRA_APBIO_H
+
+#ifdef CONFIG_TEGRA_SYSTEM_DMA
+
+u32 tegra_apb_readl(unsigned long offset);
+void tegra_apb_writel(u32 value, unsigned long offset);
+
+#else
+#include <asm/io.h>
+#include <mach/io.h>
+
+static inline u32 tegra_apb_readl(unsigned long offset)
+{
+        return readl(IO_TO_VIRT(offset));
+}
+
+static inline void tegra_apb_writel(u32 value, unsigned long offset)
+{
+        writel(value, IO_TO_VIRT(offset));
+}
+#endif
+
+#endif
diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index 98b33c8..122e467 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -33,6 +33,8 @@
 #include <mach/iomap.h>
 #include <mach/suspend.h>
 
+#include "apbio.h"
+
 #define APB_DMA_GEN				0x000
 #define GEN_ENABLE				(1<<31)
 
-- 
1.7.8.GIT
