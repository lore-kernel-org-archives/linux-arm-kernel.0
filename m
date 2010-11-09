From: bpringle@sympatico.ca (bpringle at sympatico.ca)
Date: Tue, 9 Nov 2010 11:42:17 -0500
Subject: IMX Spi and 24bit data.
Message-ID: <BLU0-SMTP84E35E9219EF44BAE164F4B8300@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below is a 'example' patch to the imx SPI driver.  The issue is that
soc-cache.c for 24bit SPI values only creates byte arrays of size
three.  The IMX SPI driver examines memory that is 32 bits for this
case and could possibly cause a trap if the final byte of the array is
at a unmapped location.  (also, the data is possibly not aligned).

I guess the main question is the 'spi.h' interface expecting a padding
to 32bits for 24bit values.  In this case, soc-cache is wrong.  But I
suspect that the spi systems is expecting packed data.

Also, I looked in little_endian.h for some thing appropriate.  Do we
have a 24bit extraction macro somewhere?.  I guess soc-core would be
using this if we did.

Sorry, if this is a known issue.

Regards,
Bill Pringlemeir.

I see my tabs are all messed up too.  I just want to know if this is
the approriate way to handle this.  My byte order may be messed up as
I haven't tested this...  I have just padded soc-core.c for now.

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 7972e90..54c6a5a 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -116,6 +116,31 @@ MXC_SPI_BUF_TX(u16)
 MXC_SPI_BUF_RX(u32)
 MXC_SPI_BUF_TX(u32)
 
+static void spi_imx_buf_rx_u24(struct spi_imx_data *spi_imx)
+{
+       unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
+       if (spi_imx->rx_buf) {
+        u8 *data = (u8 *)spi_imx->rx_buf;
+        data[0] = (val >> 16) & 0xff;
+        data[1] = (val >> 8) & 0xff;
+        data[2] = val & 0xff;
+               spi_imx->rx_buf += 3;
+       }
+}
+
+static void spi_imx_buf_tx_u24(struct spi_imx_data *spi_imx)
+{
+       u32 val = 0;
+
+       if (spi_imx->tx_buf) {
+        u8 *data = (u8 *)spi_imx->rx_buf;
+               val = data[0] << 16 | data[1] << 8 | data[0];
+               spi_imx->tx_buf += 3;
+       }
+       spi_imx->count -= 3;
+       writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
 /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
  * (which is currently not the case in this driver)
  */
@@ -433,6 +458,11 @@ static int spi_imx_setupxfer(struct spi_device *spi,
        } else if (config.bpw <= 16) {
                spi_imx->rx = spi_imx_buf_rx_u16;
                spi_imx->tx = spi_imx_buf_tx_u16;
+#if 0
+       } else if (config.bpw <= 24) {
+               spi_imx->rx = spi_imx_buf_rx_u24;
+               spi_imx->tx = spi_imx_buf_tx_u24;
+#endif
        } else if (config.bpw <= 32) {
                spi_imx->rx = spi_imx_buf_rx_u32;
                spi_imx->tx = spi_imx_buf_tx_u32;
