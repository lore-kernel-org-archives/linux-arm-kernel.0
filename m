From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 30 May 2013 18:08:21 +0200
Subject: [PATCH 1/3] ARM: at91: dt: add header to define at_hdmac configuration
In-Reply-To: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1369930103-11963-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

DMA-cell content is a concatenation of several values. In order to keep this
stuff human readable, macros are introduced.

The values for the FIFO configuration are not the same as the ones used in the
configuration register in order to keep backward compatibility. Most devices
use the half FIFO configuration but USART ones have to use the ASAP
configuration. This parameter was not initially planed to be into the at91 dma
dt binding. The third cell will be used to store this parameter, it will
become a concatenation of the FIFO configuration and of the peripheral ID. In
order to keep backward compatibility i.e. FIFO configuration is equal to 0, we
have to perform a translation since the value to put in the register to set
half FIFO is 1.

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 include/dt-bindings/dma/at91.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/dma/at91.h

diff --git a/include/dt-bindings/dma/at91.h b/include/dt-bindings/dma/at91.h
new file mode 100644
index 0000000..e835037
--- /dev/null
+++ b/include/dt-bindings/dma/at91.h
@@ -0,0 +1,27 @@
+/*
+ * This header provides macros for at91 dma bindings.
+ *
+ * Copyright (C) 2013 Ludovic Desroches <ludovic.desroches@atmel.com>
+ *
+ * GPLv2 only
+ */
+
+#ifndef __DT_BINDINGS_AT91_DMA_H__
+#define __DT_BINDINGS_AT91_DMA_H__
+
+/*
+ * Source and/or destination peripheral ID
+ */
+#define AT91_DMA_CFG_PER_ID_MASK	(0xff)
+#define AT91_DMA_CFG_PER_ID(id)		(id & AT91_DMA_CFG_PER_ID_MASK)
+
+/*
+ * FIFO configuration: it defines when a request is serviced.
+ */
+#define AT91_DMA_CFG_FIFOCFG_OFFSET	(8)
+#define AT91_DMA_CFG_FIFOCFG_MASK	(0xf << AT91_DMA_CFG_FIFOCFG_OFFSET)
+#define AT91_DMA_CFG_FIFOCFG_HALF	(0x0 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* half FIFO (default behavior) */
+#define AT91_DMA_CFG_FIFOCFG_ALAP	(0x1 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* largest defined AHB burst */
+#define AT91_DMA_CFG_FIFOCFG_ASAP	(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
+
+#endif /* __DT_BINDINGS_AT91_DMA_H__ */
-- 
1.7.11.3
