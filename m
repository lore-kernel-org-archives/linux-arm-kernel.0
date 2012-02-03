From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:33:30 +0000
Subject: [PATCH 07/17] ARM: sa11x0: neponset: shuffle some code around
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOt0-0001Bx-99@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the IRQ handler along side the rest of the IRQ code, and rearrange
the include files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |  202 +++++++++++++++++++-------------------
 1 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 10be07e..8fcd542 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -2,24 +2,24 @@
  * linux/arch/arm/mach-sa1100/neponset.c
  *
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/tty.h>
 #include <linux/ioport.h>
-#include <linux/serial_core.h>
+#include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/serial_core.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/serial_sa1100.h>
-#include <mach/assabet.h>
-#include <mach/neponset.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/sizes.h>
 
+#include <mach/hardware.h>
+#include <mach/assabet.h>
+#include <mach/neponset.h>
+
 void neponset_ncr_frob(unsigned int mask, unsigned int val)
 {
 	unsigned long flags;
@@ -29,6 +29,64 @@ void neponset_ncr_frob(unsigned int mask, unsigned int val)
 	local_irq_restore(flags);
 }
 
+static void neponset_set_mctrl(struct uart_port *port, u_int mctrl)
+{
+	u_int mdm_ctl0 = MDM_CTL_0;
+
+	if (port->mapbase == _Ser1UTCR0) {
+		if (mctrl & TIOCM_RTS)
+			mdm_ctl0 &= ~MDM_CTL0_RTS2;
+		else
+			mdm_ctl0 |= MDM_CTL0_RTS2;
+
+		if (mctrl & TIOCM_DTR)
+			mdm_ctl0 &= ~MDM_CTL0_DTR2;
+		else
+			mdm_ctl0 |= MDM_CTL0_DTR2;
+	} else if (port->mapbase == _Ser3UTCR0) {
+		if (mctrl & TIOCM_RTS)
+			mdm_ctl0 &= ~MDM_CTL0_RTS1;
+		else
+			mdm_ctl0 |= MDM_CTL0_RTS1;
+
+		if (mctrl & TIOCM_DTR)
+			mdm_ctl0 &= ~MDM_CTL0_DTR1;
+		else
+			mdm_ctl0 |= MDM_CTL0_DTR1;
+	}
+
+	MDM_CTL_0 = mdm_ctl0;
+}
+
+static u_int neponset_get_mctrl(struct uart_port *port)
+{
+	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
+	u_int mdm_ctl1 = MDM_CTL_1;
+
+	if (port->mapbase == _Ser1UTCR0) {
+		if (mdm_ctl1 & MDM_CTL1_DCD2)
+			ret &= ~TIOCM_CD;
+		if (mdm_ctl1 & MDM_CTL1_CTS2)
+			ret &= ~TIOCM_CTS;
+		if (mdm_ctl1 & MDM_CTL1_DSR2)
+			ret &= ~TIOCM_DSR;
+	} else if (port->mapbase == _Ser3UTCR0) {
+		if (mdm_ctl1 & MDM_CTL1_DCD1)
+			ret &= ~TIOCM_CD;
+		if (mdm_ctl1 & MDM_CTL1_CTS1)
+			ret &= ~TIOCM_CTS;
+		if (mdm_ctl1 & MDM_CTL1_DSR1)
+			ret &= ~TIOCM_DSR;
+	}
+
+	return ret;
+}
+
+static struct sa1100_port_fns neponset_port_fns __devinitdata = {
+	.set_mctrl	= neponset_set_mctrl,
+	.get_mctrl	= neponset_get_mctrl,
+};
+
 /*
  * Install handler for Neponset IRQ.  Note that we have to loop here
  * since the ETHERNET and USAR IRQs are level based, and we need to
@@ -89,64 +147,6 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void neponset_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	u_int mdm_ctl0 = MDM_CTL_0;
-
-	if (port->mapbase == _Ser1UTCR0) {
-		if (mctrl & TIOCM_RTS)
-			mdm_ctl0 &= ~MDM_CTL0_RTS2;
-		else
-			mdm_ctl0 |= MDM_CTL0_RTS2;
-
-		if (mctrl & TIOCM_DTR)
-			mdm_ctl0 &= ~MDM_CTL0_DTR2;
-		else
-			mdm_ctl0 |= MDM_CTL0_DTR2;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		if (mctrl & TIOCM_RTS)
-			mdm_ctl0 &= ~MDM_CTL0_RTS1;
-		else
-			mdm_ctl0 |= MDM_CTL0_RTS1;
-
-		if (mctrl & TIOCM_DTR)
-			mdm_ctl0 &= ~MDM_CTL0_DTR1;
-		else
-			mdm_ctl0 |= MDM_CTL0_DTR1;
-	}
-
-	MDM_CTL_0 = mdm_ctl0;
-}
-
-static u_int neponset_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-	u_int mdm_ctl1 = MDM_CTL_1;
-
-	if (port->mapbase == _Ser1UTCR0) {
-		if (mdm_ctl1 & MDM_CTL1_DCD2)
-			ret &= ~TIOCM_CD;
-		if (mdm_ctl1 & MDM_CTL1_CTS2)
-			ret &= ~TIOCM_CTS;
-		if (mdm_ctl1 & MDM_CTL1_DSR2)
-			ret &= ~TIOCM_DSR;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		if (mdm_ctl1 & MDM_CTL1_DCD1)
-			ret &= ~TIOCM_CD;
-		if (mdm_ctl1 & MDM_CTL1_CTS1)
-			ret &= ~TIOCM_CTS;
-		if (mdm_ctl1 & MDM_CTL1_DSR1)
-			ret &= ~TIOCM_DSR;
-	}
-
-	return ret;
-}
-
-static struct sa1100_port_fns neponset_port_fns __devinitdata = {
-	.set_mctrl	= neponset_set_mctrl,
-	.get_mctrl	= neponset_get_mctrl,
-};
-
 /*
  * Yes, we really do not have any kind of masking or unmasking
  */
@@ -161,6 +161,43 @@ static struct irq_chip nochip = {
 	.irq_unmask = nochip_noop,
 };
 
+static struct resource sa1111_resources[] = {
+	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
+	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SA1111),
+};
+
+static struct sa1111_platform_data sa1111_info = {
+	.irq_base	= IRQ_BOARD_END,
+};
+
+static u64 sa1111_dmamask = 0xffffffffUL;
+
+static struct platform_device sa1111_device = {
+	.name		= "sa1111",
+	.id		= 0,
+	.dev		= {
+		.dma_mask = &sa1111_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+		.platform_data = &sa1111_info,
+	},
+	.num_resources	= ARRAY_SIZE(sa1111_resources),
+	.resource	= sa1111_resources,
+};
+
+static struct resource smc91x_resources[] = {
+	[0] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS, 0x02000000, "smc91x-regs"),
+	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SMC9196),
+	[2] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
+			0x02000000, "smc91x-attrib"),
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
 static int __devinit neponset_probe(struct platform_device *dev)
 {
 	sa1100_register_uart_fns(&neponset_port_fns);
@@ -249,43 +286,6 @@ static struct platform_device neponset_device = {
 	.resource	= neponset_resources,
 };
 
-static struct resource sa1111_resources[] = {
-	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
-	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SA1111),
-};
-
-static struct sa1111_platform_data sa1111_info = {
-	.irq_base	= IRQ_BOARD_END,
-};
-
-static u64 sa1111_dmamask = 0xffffffffUL;
-
-static struct platform_device sa1111_device = {
-	.name		= "sa1111",
-	.id		= 0,
-	.dev		= {
-		.dma_mask = &sa1111_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-		.platform_data = &sa1111_info,
-	},
-	.num_resources	= ARRAY_SIZE(sa1111_resources),
-	.resource	= sa1111_resources,
-};
-
-static struct resource smc91x_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS, 0x02000000, "smc91x-regs"),
-	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SMC9196),
-	[2] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
-			0x02000000, "smc91x-attrib"),
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
 static struct platform_device *devices[] __initdata = {
 	&neponset_device,
 	&sa1111_device,
-- 
1.7.4.4
