From: robherring2@gmail.com (Rob Herring)
Date: Wed,  4 Apr 2012 17:48:04 -0500
Subject: [PATCH v2] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
Message-ID: <1333579684-31466-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
broken. PCMCIA depends on __io() returning a valid i/o address, and most
ARM platforms require IO_SPACE_LIMIT be set to 0xffffffff for PCMCIA. This
needs a better fix with a fixed i/o address mapping, but for now we just
restore things to the previous behavior.

This fixes at91, omap1, pxa and sa11xx. pxa needs io.h if PCI is enabled,
but PCMCIA is not. sa11xx already has IO_SPACE_LIMIT set to 0xffffffff,
so it doesn't need an io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/include/asm/io.h             |    2 +-
 arch/arm/mach-at91/include/mach/io.h  |   27 +++++++++++++++++++
 arch/arm/mach-omap1/include/mach/io.h |   45 +++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig             |    1 +
 arch/arm/mach-pxa/include/mach/io.h   |   17 ++++++++++++
 arch/arm/plat-omap/Kconfig            |    1 +
 7 files changed, 93 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/io.h
 create mode 100644 arch/arm/mach-omap1/include/mach/io.h
 create mode 100644 arch/arm/mach-pxa/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9318084..cf006d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -338,6 +338,7 @@ config ARCH_AT91
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
+	select NEED_MACH_IO_H if PCCARD
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 processors.
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index df0ac0b..9af5563 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -119,7 +119,7 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
 #else
-#define __io(a)		({ (void)(a); __typesafe_io(0); })
+#define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
 #endif
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
new file mode 100644
index 0000000..2d9ca04
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-at91/include/mach/io.h
+ *
+ *  Copyright (C) 2003 SAN People
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_IO_H
+#define __ASM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT		0xFFFFFFFF
+#define __io(a)			__typesafe_io(a)
+
+#endif
diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
new file mode 100644
index 0000000..ce4f800
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/io.h
@@ -0,0 +1,45 @@
+/*
+ * arch/arm/mach-omap1/include/mach/io.h
+ *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+
+#endif
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 109ccd2..fe2d1f8 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -113,6 +113,7 @@ config MACH_ARMCORE
 	select IWMMXT
 	select PXA25x
 	select MIGHT_HAVE_PCI
+	select NEED_MACH_IO_H if PCI
 
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
new file mode 100644
index 0000000..cd78b7f
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/io.h
@@ -0,0 +1,17 @@
+/*
+ * arch/arm/mach-pxa/include/mach/io.h
+ *
+ * Copied from asm/arch/sa1100/io.h
+ */
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+
+#endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ce1e9b9..ad95c7a 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP1
 	select IRQ_DOMAIN
 	select HAVE_IDE
 	select NEED_MACH_MEMORY_H
+	select NEED_MACH_IO_H if PCCARD
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.5.4
