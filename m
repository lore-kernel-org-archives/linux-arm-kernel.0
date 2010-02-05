From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 05 Feb 2010 20:15:33 +0900
Subject: [PATCH 06/06] sh-sci: SuperH Mobile ARM support V2
In-Reply-To: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
References: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
Message-ID: <20100205111533.17065.88602.sendpatchset@rxone.opensource.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SuperH Mobile ARM support to the sh-sci driver. (V2)
Also remove the SCLSR register that is missing on sh772x,
sh7705 and SH-Mobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of the sci_rxd_in() cleanup patch

 Changes since V1:
 - rewrote the patch

 drivers/serial/Kconfig  |    2 +-
 drivers/serial/sh-sci.h |   23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

--- 0001/drivers/serial/Kconfig
+++ work/drivers/serial/Kconfig	2010-02-05 16:07:02.000000000 +0900
@@ -1013,7 +1013,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || H8300)
+	depends on HAVE_CLK && (SUPERH || H8300 || ARCH_SHMOBILE)
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
--- 0007/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2010-02-05 16:42:18.000000000 +0900
@@ -30,9 +30,9 @@
  */
 # define SCSCR_INIT(port) (port->mapbase == SCIF2) ? 0xF3 : 0xF0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7721)
+      defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SHMOBILE)
 # define SCSCR_INIT(port)  0x0030 /* TIE=0,RIE=0,TE=1,RE=1 */
-# define SCIF_ORER	   0x0200   /* overrun error bit */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7750)  || \
       defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
       defined(CONFIG_CPU_SUBTYPE_SH7750S) || \
@@ -166,7 +166,8 @@
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
+    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SHMOBILE)
 # define SCIF_ORER    0x0200
 # define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK | SCIF_ORER)
 # define SCIF_RFDC_MASK 0x007f
@@ -199,7 +200,8 @@
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
+    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SHMOBILE)
 # define SCxSR_RDxF_CLEAR(port)	 (sci_in(port, SCxSR) & 0xfffc)
 # define SCxSR_ERROR_CLEAR(port) (sci_in(port, SCxSR) & 0xfd73)
 # define SCxSR_TDxE_CLEAR(port)	 (sci_in(port, SCxSR) & 0xffdf)
@@ -294,7 +296,7 @@
     SCI_OUT(sci_size, sci_offset, value);				\
   }
 
-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_ARCH_SHMOBILE)
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) || defined(CONFIG_CPU_SUBTYPE_SH7712)
 #define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size, sh4_sci_offset, sh4_sci_size, \
 		                sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size, \
@@ -304,7 +306,8 @@
 	  CPU_SCIF_FNS(name, sh4_scif_offset, sh4_scif_size)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7721)
+      defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SHMOBILE)
 #define SCIF_FNS(name, scif_offset, scif_size) \
   CPU_SCIF_FNS(name, scif_offset, scif_size)
 #else
@@ -339,7 +342,8 @@
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
+    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SHMOBILE)
 
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x04,  8)
@@ -351,7 +355,7 @@ SCIF_FNS(SCFCR,  0x18, 16)
 SCIF_FNS(SCFDR,  0x1c, 16)
 SCIF_FNS(SCxTDR, 0x20,  8)
 SCIF_FNS(SCxRDR, 0x24,  8)
-SCIF_FNS(SCLSR,  0x24, 16)
+SCIF_FNS(SCLSR,  0x00,  0)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
       defined(CONFIG_CPU_SUBTYPE_SH7724)
 SCIx_FNS(SCSMR,  0x00, 16, 0x00, 16)
@@ -521,7 +525,8 @@ static inline int sci_rxd_in(struct uart
 #define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7721)
+      defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SHMOBILE)
 #define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
       defined(CONFIG_CPU_SUBTYPE_SH7724)
