From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Sep 2015 12:02:09 -0700
Subject: [PATCH v2 1/3] lib: iomap_copy: Add __ioread32_copy()
In-Reply-To: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1442516531-16071-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers need to read data out of iomem areas 32-bits at a
time. Add an API to do this.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/io.h |  1 +
 lib/iomap_copy.c   | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index de64c1e53612..72c35e0a41d1 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -29,6 +29,7 @@ struct device;
 struct resource;
 
 __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
+void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
 #ifdef CONFIG_MMU
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 4527e751b5e0..b8f1d6cbb200 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -42,6 +42,27 @@ void __attribute__((weak)) __iowrite32_copy(void __iomem *to,
 EXPORT_SYMBOL_GPL(__iowrite32_copy);
 
 /**
+ * __ioread32_copy - copy data from MMIO space, in 32-bit units
+ * @to: destination (must be 32-bit aligned)
+ * @from: source, in MMIO space (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ *
+ * Copy data from MMIO space to kernel space, in units of 32 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+void __ioread32_copy(void *to, const void __iomem *from, size_t count)
+{
+	u32 *dst = to;
+	const u32 __iomem *src = from;
+	const u32 __iomem *end = src + count;
+
+	while (src < end)
+		*dst++ = __raw_readl(src++);
+}
+EXPORT_SYMBOL_GPL(__ioread32_copy);
+
+/**
  * __iowrite64_copy - copy data to MMIO space, in 64-bit or 32-bit units
  * @to: destination, in MMIO space (must be 64-bit aligned)
  * @from: source (must be 64-bit aligned)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
