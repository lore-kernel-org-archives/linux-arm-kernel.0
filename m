From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:17 +0000
Subject: [PATCH 03/15] mtd: st_spi_fsm: Update Macronix 'QE' configuration
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395851969-13520-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Angus Clark <angus.clark@st.com>

Update the configuration of the Macronix 'QE' bit, such that
we only set or clear the bit if required.

Signed-off-by: Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 31bbf28..fabba2c 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -1163,12 +1163,27 @@ static int stfsm_mx25_config(struct stfsm *fsm)
 					      CFG_ERASESEC_TOGGLE_32BIT_ADDR);
 	}
 
-	/* For QUAD mode, set 'QE' STATUS bit */
+	/* Check status of 'QE' bit */
+	stfsm_read_status(fsm, FLASH_CMD_RDSR, &sta);
 	data_pads = ((fsm->stfsm_seq_read.seq_cfg >> 16) & 0x3) + 1;
 	if (data_pads == 4) {
-		stfsm_read_status(fsm, FLASH_CMD_RDSR, &sta);
-		sta |= MX25_STATUS_QE;
-		stfsm_write_status(fsm, sta, 1);
+		if (!(sta & MX25_STATUS_QE)) {
+			/* Set 'QE' */
+			sta |= MX25_STATUS_QE;
+
+			stfsm_write_status(fsm, sta, 1);
+
+			stfsm_wait_busy(fsm);
+		}
+	} else {
+		if (sta & MX25_STATUS_QE) {
+			/* Clear 'QE' */
+			sta &= ~MX25_STATUS_QE;
+
+			stfsm_write_status(fsm, sta, 1);
+
+			stfsm_wait_busy(fsm);
+		}
 	}
 
 	return 0;
-- 
1.8.3.2
