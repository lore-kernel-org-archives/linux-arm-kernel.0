From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 18 Jun 2018 05:08:21 -0600
Subject: [PATCH 3/5] net: emaclite: update kernel-doc comments
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1529320103-7711-4-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes below kernel-doc warnings:

Function parameter or member 'maxlen' not described in 'xemaclite_recv_data'
Function parameter or member 'address'not described in 'xemaclite_set_mac_address'
Excess function parameter 'addr' description in 'xemaclite_set_mac_address'
No description found for return value of 'xemaclite_interrupt'
No description found for return value of 'xemaclite_mdio_write'
Function parameter or member 'dev' not described in 'xemaclite_mdio_setup'
Excess function parameter 'ofdev' description in 'xemaclite_mdio_setup'
No description found for return value of 'xemaclite_open'
No description found for return value of 'xemaclite_close'
Excess function parameter 'match' description in 'xemaclite_of_probe'

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 8d84f58..0b41cc5 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -369,6 +369,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
  * xemaclite_recv_data - Receive a frame
  * @drvdata:	Pointer to the Emaclite device private data
  * @data:	Address where the data is to be received
+ * @maxlen:    Maximum supported ethernet packet length
  *
  * This function is intended to be called from the interrupt context or
  * with a wrapper which waits for the receive frame to be available.
@@ -488,7 +489,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 /**
  * xemaclite_set_mac_address - Set the MAC address for this device
  * @dev:	Pointer to the network device instance
- * @addr:	Void pointer to the sockaddr structure
+ * @address:	Void pointer to the sockaddr structure
  *
  * This function copies the HW address from the sockaddr strucutre to the
  * net_device structure and updates the address in HW.
@@ -637,6 +638,8 @@ static void xemaclite_rx_handler(struct net_device *dev)
  * @dev_id:	Void pointer to the network device instance used as callback
  *		reference
  *
+ * Return:	IRQ_HANDLED
+ *
  * This function handles the Tx and Rx interrupts of the EmacLite device.
  */
 static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
@@ -770,6 +773,8 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
  *
  * This function waits till the device is ready to accept a new MDIO
  * request and then writes the val to the MDIO Write Data register.
+ *
+ * Return:      0 upon success or a negative error upon failure
  */
 static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 				u16 val)
@@ -803,7 +808,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 /**
  * xemaclite_mdio_setup - Register mii_bus for the Emaclite device
  * @lp:		Pointer to the Emaclite device private data
- * @ofdev:	Pointer to OF device structure
+ * @dev:	Pointer to OF device structure
  *
  * This function enables MDIO bus in the Emaclite device and registers a
  * mii_bus.
@@ -903,6 +908,9 @@ static void xemaclite_adjust_link(struct net_device *ndev)
  * This function sets the MAC address, requests an IRQ and enables interrupts
  * for the Emaclite device and starts the Tx queue.
  * It also connects to the phy device, if MDIO is included in Emaclite device.
+ *
+ * Return:	0 on success. -ENODEV, if PHY cannot be connected.
+ *		Non-zero error value on failure.
  */
 static int xemaclite_open(struct net_device *dev)
 {
@@ -973,6 +981,8 @@ static int xemaclite_open(struct net_device *dev)
  * This function stops the Tx queue, disables interrupts and frees the IRQ for
  * the Emaclite device.
  * It also disconnects the phy device associated with the Emaclite device.
+ *
+ * Return:	0, always.
  */
 static int xemaclite_close(struct net_device *dev)
 {
@@ -1064,7 +1074,6 @@ static const struct net_device_ops xemaclite_netdev_ops;
 /**
  * xemaclite_of_probe - Probe method for the Emaclite device.
  * @ofdev:	Pointer to OF device structure
- * @match:	Pointer to the structure used for matching a device
  *
  * This function probes for the Emaclite device in the device tree.
  * It initializes the driver data structure and the hardware, sets the MAC
-- 
2.7.4
