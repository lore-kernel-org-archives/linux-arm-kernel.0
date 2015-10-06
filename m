From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 23:24:28 +0200
Subject: [PATCH] scsi: advansys: fix big-endian builds
Message-ID: <5468884.cIlSBUgeTB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the advansys driver in a big-endian configuration such as
ARM allmodconfig shows a warning:

 drivers/scsi/advansys.c: In function 'adv_build_req':
 include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]
  #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
 drivers/scsi/advansys.c:7806:22: note: in expansion of macro 'cpu_to_le32'
   scsiqp->sense_len = cpu_to_le32(SCSI_SENSE_BUFFERSIZE);

It turns out that the commit that introduced this used the cpu_to_le32()
incorrectly on an 8-bit field, which results in the sense_len to always
be set to zero, as the SCSI_SENSE_BUFFERSIZE value gets moved to upper
byte of the 32-bit intermediate.

This removes the cpu_to_le32() call to restore the original version.

I found this only by looking at the compiler output and have not done
a full review for possible further endianess bugs in the same driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 811ddc057aac ("advansys: use DMA-API for mapping sense buffer")
---
Using willy at linux.intel.com, as the address listed in MAINTAINERS
failed:

Failed to transport message. Message sending failed since the following recipients were rejected by the server: matthew at wil.cx (The server responded: Requested action not taken: mailbox unavailable invalid DNS MX or A/AAAA resource record)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 4305178e4e01..1c1cd657c380 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -7803,7 +7803,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 		return ASC_BUSY;
 	}
 	scsiqp->sense_addr = cpu_to_le32(sense_addr);
-	scsiqp->sense_len = cpu_to_le32(SCSI_SENSE_BUFFERSIZE);
+	scsiqp->sense_len = SCSI_SENSE_BUFFERSIZE;
 
 	/* Build ADV_SCSI_REQ_Q */
 
