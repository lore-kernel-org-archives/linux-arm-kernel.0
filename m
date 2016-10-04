From: fthain@telegraphics.com.au (Finn Thain)
Date: Tue,  4 Oct 2016 01:40:50 -0400 (EDT)
Subject: [PATCH 10/12] scsi/ncr5380: Expedite register polling
In-Reply-To: <cover.1475559357.git.fthain@telegraphics.com.au>
References: <cover.1475559357.git.fthain@telegraphics.com.au>
Message-ID: <18f2460c95886331e7f8501c4409704d6890d8da.1475559357.git.fthain@telegraphics.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the call to NCR5380_poll_politely2() when possible. The call is
easily short-circuited on the PIO fast path, using the inline wrapper.
This requires that the NCR5380_read macro be made available before
any #include "NCR5380.h" so a few declarations have to be moved too.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.h      | 3 +++
 drivers/scsi/arm/cumana_1.c | 4 ++++
 drivers/scsi/atari_scsi.c   | 6 +++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/NCR5380.h b/drivers/scsi/NCR5380.h
index 2950bc0..2024566 100644
--- a/drivers/scsi/NCR5380.h
+++ b/drivers/scsi/NCR5380.h
@@ -310,6 +310,9 @@ static inline int NCR5380_poll_politely(struct NCR5380_hostdata *hostdata,
                                         unsigned int reg, u8 bit, u8 val,
                                         unsigned long wait)
 {
+	if ((NCR5380_read(reg) & bit) == val)
+		return 0;
+
 	return NCR5380_poll_politely2(hostdata, reg, bit, val,
 	                                        reg, bit, val, wait);
 }
diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
index ae1d4c6..fb7600d 100644
--- a/drivers/scsi/arm/cumana_1.c
+++ b/drivers/scsi/arm/cumana_1.c
@@ -29,6 +29,10 @@
 #define NCR5380_implementation_fields	\
 	unsigned ctrl
 
+struct NCR5380_hostdata;
+static u8 cumanascsi_read(struct NCR5380_hostdata *, unsigned int);
+static void cumanascsi_write(struct NCR5380_hostdata *, unsigned int, u8);
+
 #include "../NCR5380.h"
 
 #define CTRL	0x16fc
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index aed69ac..f77c311 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -57,6 +57,9 @@
 
 #define NCR5380_implementation_fields   /* none */
 
+static u8 (*atari_scsi_reg_read)(unsigned int);
+static void (*atari_scsi_reg_write)(unsigned int, u8);
+
 #define NCR5380_read(reg)               atari_scsi_reg_read(reg)
 #define NCR5380_write(reg, value)       atari_scsi_reg_write(reg, value)
 
@@ -126,9 +129,6 @@ static inline unsigned long SCSI_DMA_GETADR(void)
 
 static void atari_scsi_fetch_restbytes(void);
 
-static u8 (*atari_scsi_reg_read)(unsigned int);
-static void (*atari_scsi_reg_write)(unsigned int, u8);
-
 static unsigned long	atari_dma_residual, atari_dma_startaddr;
 static short		atari_dma_active;
 /* pointer to the dribble buffer */
-- 
2.7.3
