From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:01:59 +0100
Subject: [PATCH 7/9] ARM: move NO_DMA definition to ecard.h
In-Reply-To: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
Message-ID: <1455804123-2526139-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NO_DMA macro is only used on the RiscPC ecard bus, and conflicts
with a couple of driver specific macros with the same name:

drivers/scsi/eata.c:571:0: warning: "NO_DMA" redefined
 #define NO_DMA  0xff
In file included from ../drivers/scsi/eata.c:495:0:
arch/arm/include/asm/dma.h:140:0: note: this is the location of the previous definition
 #define NO_DMA 255

This moves the definition out of the asm/dma.h header that is used
by all ISA DMA API users and into the ecard header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/dma.h   | 4 ----
 arch/arm/include/asm/ecard.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index bb4fa67da541..573128481fc4 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -136,10 +136,6 @@ extern void set_dma_speed(unsigned int chan, int cycle_ns);
  */
 extern int  get_dma_residue(unsigned int chan);
 
-#ifndef NO_DMA
-#define NO_DMA	255
-#endif
-
 #endif /* CONFIG_ISA_DMA_API */
 
 #ifdef CONFIG_PCI
diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
index eaea14676d57..d3e16628c792 100644
--- a/arch/arm/include/asm/ecard.h
+++ b/arch/arm/include/asm/ecard.h
@@ -83,6 +83,10 @@
 #define CONST const
 #endif
 
+#ifndef NO_DMA
+#define NO_DMA	255
+#endif
+
 #define MAX_ECARDS	9
 
 struct ecard_id {			/* Card ID structure		*/
-- 
2.7.0
