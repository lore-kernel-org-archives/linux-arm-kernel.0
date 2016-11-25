From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 01:54:32 +0100
Subject: [PATCH v2 2/2] firmware: arm_scpi: check the payload length in
 scpi_send_message
In-Reply-To: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125005432.1205-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a sanity check to ensure we're not writing data beyond the
end of our rx_buf and tx_buf. Currently we are still far from reaching
this limit, so this is a non-critical fix.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/firmware/arm_scpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 8c183d8..78ea8c7 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -538,6 +538,11 @@ static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
 			scpi_info->num_chans;
 	scpi_chan = scpi_info->channels + chan;
 
+	if (tx_len > scpi_chan->max_payload_len)
+		return -EINVAL;
+	if (rx_len > scpi_chan->max_payload_len)
+		return -EINVAL;
+
 	msg = get_scpi_xfer(scpi_chan);
 	if (!msg)
 		return -ENOMEM;
-- 
2.10.2
