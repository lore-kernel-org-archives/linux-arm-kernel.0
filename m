From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:28 +0100
Subject: [PATCH v3 6/6] spi: pxa2xx: Deal with the leftover garbage in TXFIFO
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-7-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
super-secret and the method described in Armada 16x manual won't work:

  "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset or
  disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> field
  in the SSP Control Register 0)."

  # devmem 0xd4037008           # read SSSR
  0x0000F204
  # devmem 0xd4037000 32 0x07   # SSE off in SSCR0
  # devmem 0xd4037000 32 0x87   # SSE on
  # devmem 0xd4037008
  0x0000F204
         ^ TXFIFO level is still 2. Sigh.

The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
basically throwaway bytes used in response to the messages from the EC.
The OLPC kernel copes with this by power-cycling the hardware. Perhaps
the firmware should do this instead.

Other than that, there's not much we can do other than complain loudly
until the garbage gets drained and discard the actual data... For the
OLPC EC this will work just fine and pushing more data to TXFIFO would
break further transactions.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Fixed a commit message typo (spotted by James Cameron)

 drivers/spi/spi-pxa2xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7e5aab0af501..29e6025f104c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1078,6 +1078,20 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	if (drv_data->ssp_type == MMP2_SSP) {
+		u8 tx_level = (pxa2xx_spi_read(drv_data, SSSR)
+					& SSSR_TFL_MASK) >> 8;
+
+		if (tx_level) {
+			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
+			dev_warn(&spi->dev, "%d bytes of garbage in TXFIFO!\n",
+								tx_level);
+			if (tx_level > transfer->len)
+				tx_level = transfer->len;
+			drv_data->tx += tx_level;
+		}
+	}
+
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
-- 
2.19.1
