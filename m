From: mturquette@linaro.org (Mike Turquette)
Date: Mon,  8 Sep 2014 23:11:26 -0700
Subject: [PATCH 2/2] asm-generic: COMMON_CLK defines __clk_{get,put}
In-Reply-To: <1410242868-14750-1-git-send-email-mturquette@linaro.org>
References: <1410242868-14750-1-git-send-email-mturquette@linaro.org>
Message-ID: <1410243086-14925-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_COMMON_CLK is selected then __clk_get and __clk_put are
defined in drivers/clk/clk.c and declared in include/linux/clkdev.h.

Sylwester's series[0] to properly support clk_{get,put} in the common
clock framework made changes to the asm-specific clkdev.h headers, but
not the asm-generic version. Tomeu's recent changes[1] to introduce a
provider/consumer split in the clock framework uncovered this problem,
causing the following build error on any architecture using the
asm-generic clkdev.h (e.g. x86 architecture and the ACPI LPSS driver):

In file included from drivers/acpi/acpi_lpss.c:15:0:
include/linux/clkdev.h:59:5: error: conflicting types for ?__clk_get?
 int __clk_get(struct clk_core *clk);
     ^
In file included from arch/x86/include/generated/asm/clkdev.h:1:0,
                 from include/linux/clkdev.h:15,
                 from drivers/acpi/acpi_lpss.c:15:
include/asm-generic/clkdev.h:20:19: note: previous definition of ?__clk_get? was here
 static inline int __clk_get(struct clk *clk) { return 1; }
                   ^

Fixed by only declarating  __clk_get and __clk_put when
CONFIG_COMMON_CLK is set.

[0] http://lkml.kernel.org/r/<1386177127-2894-5-git-send-email-s.nawrocki@samsung.com>
[1] http://lkml.kernel.org/r/<1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 include/asm-generic/clkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
index 90a32a6..4ff33474 100644
--- a/include/asm-generic/clkdev.h
+++ b/include/asm-generic/clkdev.h
@@ -15,10 +15,12 @@
 
 #include <linux/slab.h>
 
+#ifndef CONFIG_COMMON_CLK
 struct clk;
 
 static inline int __clk_get(struct clk *clk) { return 1; }
 static inline void __clk_put(struct clk *clk) { }
+#endif
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
-- 
1.8.3.2
