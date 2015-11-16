From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 16 Nov 2015 17:41:02 +0000
Subject: [PATCH 12/12] tty: amba-pl011: switch to using relaxed IO accessors
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <E1ZyNm2-0003kQ-Oh@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using relaxed IO accessors allows GCC to better optimise this code
as we eliminate the heavy memory barriers - for example, GCC can now
cache the address of a register across a read-modify-write sequence,
rather than reloading the base address, offset and access size flag.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 54c6c88a71a3..a7d7ab05dc64 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -262,7 +262,7 @@ static unsigned int pl011_read(const struct uart_amba_port *uap,
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
-	return uap->access_32b ? readl(addr) : readw(addr);
+	return uap->access_32b ? readl_relaxed(addr) : readw_relaxed(addr);
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
@@ -271,9 +271,9 @@ static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
 	if (uap->access_32b)
-		writel(val, addr);
+		writel_relaxed(val, addr);
 	else
-		writew(val, addr);
+		writew_relaxed(val, addr);
 }
 
 /*
-- 
2.1.0
