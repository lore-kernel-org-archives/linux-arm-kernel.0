From: matthew@mattleach.net (Matthew Leach)
Date: Wed, 22 Jun 2016 17:57:02 +0100
Subject: [PATCH v2 2/3] tty: serial: samsung: fixup accessors for endian
In-Reply-To: <20160622165703.7775-1-matthew@mattleach.net>
References: <20160622165703.7775-1-matthew@mattleach.net>
Message-ID: <20160622165703.7775-3-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the serial access code to deal with kernels built for big endian
operation.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
Acked-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial at vger.kernel.org
CC: linux-kernel at vger.kernel.org
---
 drivers/tty/serial/samsung.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index fc5deaa..8f96b71 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -117,10 +117,10 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
-#define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
+#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
+#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
-#define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
-#define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
+#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
 #endif
-- 
2.8.3
