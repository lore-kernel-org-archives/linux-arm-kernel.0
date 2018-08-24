From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Fri, 24 Aug 2018 12:28:54 +0200
Subject: [PATCH] ARM: u300: add missing check for kmalloc
Message-ID: <1535106534-983-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 kmalloc return for bigrxbuf_virtual was not being checked - in case
of failure set status, cleanup bigtxbuf_virtual and baile out.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")
---

Issue found with experimental coccinelle script

Not sure about the checkpatch message: 
CHECK: Comparison to NULL could be written "!bigrxbuf_virtual"
#32: FILE: arch/arm/mach-u300/dummyspichip.c:67:
+       if (bigrxbuf_virtual == NULL) {
As the current check for bigtxbuf_virtual uses == NULL that 
was retained for consistency here.

Patch was compile tested with: u300_defconfig (implies MACH_U300_SPIDUMMY=y)

Patch is against 4.18 (localversion-next is next-20180824)

 arch/arm/mach-u300/dummyspichip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 68fe986..ff293ee 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -62,7 +62,13 @@ static ssize_t dummy_looptest(struct device *dev,
 		status = -ENOMEM;
 		goto out;
 	}
+
 	bigrxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
+	if (bigrxbuf_virtual == NULL) {
+		kfree(bigtxbuf_virtual);
+		status = -ENOMEM;
+		goto out;
+	}
 
 	/* Fill TXBUF with some happy pattern */
 	memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
-- 
2.1.4
