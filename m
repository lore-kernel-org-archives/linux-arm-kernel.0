From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 15 Dec 2015 20:34:59 -0800
Subject: [PATCH -next] of: Move of_io_request_and_map prototype to correct
 context
Message-ID: <1450240499-17474-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_io_request_and_map() is defined in of/address.c, which is compiled
if CONFIG_OF_ADDRESS is configured. However, it is defined in the context
of CONFIG_OF. This results in the following build errors for
sparc:allmodconfig (which defines CONFIG_OF but not CONFIG_OF_ADDRESS).

drivers/built-in.o: In function `meson6_timer_init':
	meson6_timer.c:(.init.text+0x62a8):
		undefined reference to `of_io_request_and_map'
drivers/built-in.o: In function `mtk_timer_init':
	mtk_timer.c:(.init.text+0x6e70):
		undefined reference to `of_io_request_and_map'
drivers/built-in.o: In function `asm9260_timer_init':
	asm9260_timer.c:(.init.text+0x6fcc):
		undefined reference to `of_io_request_and_map'

Move function prototype and dummy function into the CONFIG_OF_ADDRESS
conditional to fix the problem.

Exposed by commit bec8c4617611 ("clocksource/drivers/mediatek: Add the
COMPILE_TEST option").

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/of_address.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 507daad0bc8d..b5324c0553bd 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -56,6 +56,8 @@ extern struct of_pci_range *of_pci_range_parser_one(
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 				u64 *paddr, u64 *size);
 extern bool of_dma_is_coherent(struct device_node *np);
+void __iomem *of_io_request_and_map(struct device_node *device,
+					int index, const char *name);
 #else /* CONFIG_OF_ADDRESS */
 
 static inline u64 of_translate_address(struct device_node *np,
@@ -106,18 +108,22 @@ static inline bool of_dma_is_coherent(struct device_node *np)
 {
 	return false;
 }
+
+#include <linux/io.h>
+
+static inline void __iomem *of_io_request_and_map(struct device_node *device,
+					int index, const char *name)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_OF
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
 void __iomem *of_iomap(struct device_node *node, int index);
-void __iomem *of_io_request_and_map(struct device_node *device,
-					int index, const char *name);
 #else
 
-#include <linux/io.h>
-
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
 {
@@ -129,11 +135,6 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 	return NULL;
 }
 
-static inline void __iomem *of_io_request_and_map(struct device_node *device,
-					int index, const char *name)
-{
-	return IOMEM_ERR_PTR(-EINVAL);
-}
 #endif
 
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
-- 
2.1.4
