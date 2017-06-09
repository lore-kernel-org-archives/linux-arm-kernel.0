From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri,  9 Jun 2017 15:39:34 -0700
Subject: [PATCH v13 1/6] fpga: Add flag to indicate SPI bitstream is
 bit-reversed
Message-ID: <03e591707dc72f4c2b5e63a1272060956294ea51.1497047816.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anatolij Gustschin <agust@denx.de>

Add a flag that is passed to the write_init() callback,
indicating that the SPI bitstream starts with LSB first.
SPI controllers usually send data with MSB first. If an
FPGA expects bitstream data as LSB first, the data must
be reversed either by the SPI controller or by the driver.

Alternatively the bitstream could be prepared as bit-reversed
to avoid the bit-swapping while sending. This flag indicates
such bit-reversed SPI bitstream. The low-level driver will
deal with the flag and perform bit-reversing if needed.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---

Changes since v12:
- Change "depends on SPI || COMPILE_TEST" to "depends on SPI" in patch 3

 include/linux/fpga/fpga-mgr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index b4ac24c4411d..01c348ca38b7 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,10 +67,12 @@ enum fpga_mgr_states {
  * FPGA Manager flags
  * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
  * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
+ * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
+#define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.11.0
