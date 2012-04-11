From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Apr 2012 18:35:48 -0600
Subject: [PATCH v4 07/12] ARM: OMAP: OCM RAM: use memset_io() when clearing
 SRAM
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Message-ID: <20120411003545.27059.70446.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently treat the OCM RAM memory as memory that hangs off an
I/O bus, so use memset_io() to clear it rather than memset().
This also takes care of this sparse warning:

arch/arm/plat-omap/sram.c:199:9: warning: cast removes address space of expression

There is still one SRAM-related sparse warning, but it appears that
fixing it correctly will take some time and thought.

N.B., at some point, the OCM RAM IP block interface code should probably
be reimplemented as an MTD device or something similar under drivers/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/sram.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index eec98af..6beb79c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -196,8 +196,8 @@ static void __init omap_map_sram(void)
 	 * Looks like we need to preserve some bootloader code at the
 	 * beginning of SRAM for jumping to flash for reboot to work...
 	 */
-	memset((void *)omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
-	       omap_sram_size - SRAM_BOOTLOADER_SZ);
+	memset_io(omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
+		  omap_sram_size - SRAM_BOOTLOADER_SZ);
 }
 
 /*
