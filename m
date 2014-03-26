From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:20 +0000
Subject: [PATCH 06/15] mtd: st_spi_fsm: Add support for Macronix MX25L3255E
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395851969-13520-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Angus Clark <angus.clark@st.com>

This patch adds support for the Macronix MX25L3255E device.  Unlike the other
Macronix devices we have seen, this device supports WRITE_1_4_4 at reasonable
frequencies.  Rather than masking out WRITE_1_4_4 support altogether, we now
rely on the table parameters to indicate whether or not WRITE_1_4_4 should be
used.

Signed-off-by: Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 148c86f..8c56b94 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -372,14 +372,20 @@ static struct flash_info flash_types[] = {
 	{ "m25px32", 0x207116, 0,  64 * 1024,  64, M25PX_FLAG, 75, NULL },
 	{ "m25px64", 0x207117, 0,  64 * 1024, 128, M25PX_FLAG, 75, NULL },
 
+	/* Macronix MX25xxx
+	 *     - Support for 'FLASH_FLAG_WRITE_1_4_4' is omitted for devices
+	 *       where operating frequency must be reduced.
+	 */
 #define MX25_FLAG (FLASH_FLAG_READ_WRITE       |	\
 		   FLASH_FLAG_READ_FAST         |	\
 		   FLASH_FLAG_READ_1_1_2        |	\
 		   FLASH_FLAG_READ_1_2_2        |	\
 		   FLASH_FLAG_READ_1_1_4        |	\
-		   FLASH_FLAG_READ_1_4_4        |	\
 		   FLASH_FLAG_SE_4K             |	\
 		   FLASH_FLAG_SE_32K)
+	{ "mx25l3255e",  0xc29e16, 0, 64 * 1024, 64,
+	  (MX25_FLAG | FLASH_FLAG_WRITE_1_4_4), 86,
+	  stfsm_mx25_config},
 	{ "mx25l25635e", 0xc22019, 0, 64*1024, 512,
 	  (MX25_FLAG | FLASH_FLAG_32BIT_ADDR | FLASH_FLAG_RESET), 70,
 	  stfsm_mx25_config },
-- 
1.8.3.2
