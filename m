From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Oct 2011 11:18:18 -0700
Subject: [PATCH] [3.3] ARM: tegra: use APB DMA for accessing APB devices
Message-ID: <1318961898-21254-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mayo <jmayo@nvidia.com>

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

Signed-off-by: Jon Mayo <jmayo@nvidia.com>
[olof: hooked up init calls to dma init, minor cleanups]
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Makefile |    1 +
 arch/arm/mach-tegra/apbio.c  |  149 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/apbio.h  |   22 ++++++
 arch/arm/mach-tegra/dma.c    |    4 +
 4 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/apbio.c
 create mode 100644 arch/arm/mach-tegra/apbio.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 91a07e1..7d4070d 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,5 +1,6 @@
 obj-y                                   += common.o
 obj-y                                   += devices.o
+obj-y                                   += apbio.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
new file mode 100644
index 0000000..e4e6715
--- /dev/null
+++ b/arch/arm/mach-tegra/apbio.c
@@ -0,0 +1,149 @@
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
+#ifdef CONFIG_TEGRA_SYSTEM_DMA
+static struct tegra_dma_channel *tegra_apb_dma;
+static u32 *tegra_apb_bb;
+static dma_addr_t tegra_apb_bb_phys;
+static DECLARE_COMPLETION(tegra_apb_wait);
+
+static void apb_dma_complete(struct tegra_dma_req *req)
+{
+	complete(&tegra_apb_wait);
+}
+
+static inline u32 apb_readl(unsigned long offset)
+{
+	struct tegra_dma_req req;
+	int ret;
+
+	if (!tegra_apb_dma)
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
+static inline void apb_writel(u32 value, unsigned long offset)
+{
+	struct tegra_dma_req req;
+	int ret;
+
+	if (!tegra_apb_dma) {
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
+#else
+static inline u32 apb_readl(unsigned long offset)
+{
+	return readl(IO_TO_VIRT(offset));
+}
+
+static inline void apb_writel(u32 value, unsigned long offset)
+{
+	writel(value, IO_TO_VIRT(offset));
+}
+#endif
+
+u32 tegra_apb_readl(unsigned long offset)
+{
+	return apb_readl(offset);
+}
+
+void tegra_apb_writel(u32 value, unsigned long offset)
+{
+	apb_writel(value, offset);
+}
+
+void tegra_init_apb_dma(void)
+{
+#ifdef CONFIG_TEGRA_SYSTEM_DMA
+	tegra_apb_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT |
+		TEGRA_DMA_SHARED);
+	if (!tegra_apb_dma) {
+		pr_err("%s: can not allocate dma channel\n", __func__);
+		return;
+	}
+
+	tegra_apb_bb = dma_alloc_coherent(NULL, sizeof(u32),
+		&tegra_apb_bb_phys, GFP_KERNEL);
+	if (!tegra_apb_bb) {
+		pr_err("%s: can not allocate bounce buffer\n", __func__);
+		tegra_dma_free_channel(tegra_apb_dma);
+		tegra_apb_dma = NULL;
+		return;
+	}
+#endif
+}
diff --git a/arch/arm/mach-tegra/apbio.h b/arch/arm/mach-tegra/apbio.h
new file mode 100644
index 0000000..4cfee00
--- /dev/null
+++ b/arch/arm/mach-tegra/apbio.h
@@ -0,0 +1,22 @@
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
+u32 tegra_apb_readl(unsigned long offset);
+void tegra_apb_writel(u32 value, unsigned long offset);
+void tegra_init_apb_dma(void);
+#endif
diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index c0cf967..b7b6957 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -33,6 +33,8 @@
 #include <mach/iomap.h>
 #include <mach/suspend.h>
 
+#include "apbio.h"
+
 #define APB_DMA_GEN				0x000
 #define GEN_ENABLE				(1<<31)
 
@@ -735,6 +737,8 @@ int __init tegra_dma_init(void)
 
 	tegra_dma_initialized = true;
 
+	tegra_init_apb_dma();
+
 	return 0;
 fail:
 	writel(0, addr + APB_DMA_GEN);
-- 
1.7.4.1
