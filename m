From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue,  9 Jan 2018 14:31:23 -0800
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed PECI
 and generic PECI headers
In-Reply-To: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds driver implementation for Aspeed PECI. Also adds
generic peci.h and peci_ioctl.h files to provide compatibility
to peci drivers that can be implemented later e.g. Nuvoton's BMC
SoC family.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/misc/Kconfig            |    9 +
 drivers/misc/Makefile           |    1 +
 drivers/misc/aspeed-peci.c      | 1130 +++++++++++++++++++++++++++++++++++++++
 include/misc/peci.h             |   11 +
 include/uapi/linux/Kbuild       |    1 +
 include/uapi/linux/peci_ioctl.h |  270 ++++++++++
 6 files changed, 1422 insertions(+)
 create mode 100644 drivers/misc/aspeed-peci.c
 create mode 100644 include/misc/peci.h
 create mode 100644 include/uapi/linux/peci_ioctl.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 02ffdd1..96e1e04 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -782,6 +782,15 @@ config ASPEED_LPC_SNOOP
 	  allows the BMC to listen on and save the data written by
 	  the host to an arbitrary LPC I/O port.
 
+config ASPEED_PECI
+	tristate "Aspeed AST2400/AST2500 PECI support"
+	select CRC8
+	select REGMAP_MMIO
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  Provides a driver for Platform Environment Control Interface (PECI)
+	  controller on Aspeed AST2400/AST2500 SoC.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ab8af76..8a22455 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
+obj-$(CONFIG_ASPEED_PECI)       += aspeed-peci.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/aspeed-peci.c b/drivers/misc/aspeed-peci.c
new file mode 100644
index 0000000..04fb794
--- /dev/null
+++ b/drivers/misc/aspeed-peci.c
@@ -0,0 +1,1130 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012-2020 ASPEED Technology Inc.
+// Copyright (c) 2017 Intel Corporation
+
+#include <linux/clk.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/peci_ioctl.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/semaphore.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define SOC_NAME "aspeed"
+#define DEVICE_NAME "peci"
+
+#define DUMP_DEBUG 0
+
+/* Aspeed PECI Registers */
+#define AST_PECI_CTRL     0x00
+#define AST_PECI_TIMING   0x04
+#define AST_PECI_CMD      0x08
+#define AST_PECI_CMD_CTRL 0x0c
+#define AST_PECI_EXP_FCS  0x10
+#define AST_PECI_CAP_FCS  0x14
+#define AST_PECI_INT_CTRL 0x18
+#define AST_PECI_INT_STS  0x1c
+#define AST_PECI_W_DATA0  0x20
+#define AST_PECI_W_DATA1  0x24
+#define AST_PECI_W_DATA2  0x28
+#define AST_PECI_W_DATA3  0x2c
+#define AST_PECI_R_DATA0  0x30
+#define AST_PECI_R_DATA1  0x34
+#define AST_PECI_R_DATA2  0x38
+#define AST_PECI_R_DATA3  0x3c
+#define AST_PECI_W_DATA4  0x40
+#define AST_PECI_W_DATA5  0x44
+#define AST_PECI_W_DATA6  0x48
+#define AST_PECI_W_DATA7  0x4c
+#define AST_PECI_R_DATA4  0x50
+#define AST_PECI_R_DATA5  0x54
+#define AST_PECI_R_DATA6  0x58
+#define AST_PECI_R_DATA7  0x5c
+
+/* AST_PECI_CTRL - 0x00 : Control Register */
+#define PECI_CTRL_SAMPLING_MASK     GENMASK(19, 16)
+#define PECI_CTRL_SAMPLING(x)       ((x << 16) & PECI_CTRL_SAMPLING_MASK)
+#define PECI_CTRL_SAMPLING_GET(x)   ((x & PECI_CTRL_SAMPLING_MASK) >> 16)
+#define PECI_CTRL_READ_MODE_MASK    GENMASK(13, 12)
+#define PECI_CTRL_READ_MODE(x)      ((x << 12) & PECI_CTRL_READ_MODE_MASK)
+#define PECI_CTRL_READ_MODE_GET(x)  ((x & PECI_CTRL_READ_MODE_MASK) >> 12)
+#define PECI_CTRL_READ_MODE_COUNT   BIT(12)
+#define PECI_CTRL_READ_MODE_DBG     BIT(13)
+#define PECI_CTRL_CLK_SOURCE_MASK   BIT(11)
+#define PECI_CTRL_CLK_SOURCE(x)     ((x << 11) & PECI_CTRL_CLK_SOURCE_MASK)
+#define PECI_CTRL_CLK_SOURCE_GET(x) ((x & PECI_CTRL_CLK_SOURCE_MASK) >> 11)
+#define PECI_CTRL_CLK_DIV_MASK      GENMASK(10, 8)
+#define PECI_CTRL_CLK_DIV(x)        ((x << 8) & PECI_CTRL_CLK_DIV_MASK)
+#define PECI_CTRL_CLK_DIV_GET(x)    ((x & PECI_CTRL_CLK_DIV_MASK) >> 8)
+#define PECI_CTRL_INVERT_OUT        BIT(7)
+#define PECI_CTRL_INVERT_IN         BIT(6)
+#define PECI_CTRL_BUS_CONTENT_EN    BIT(5)
+#define PECI_CTRL_PECI_EN           BIT(4)
+#define PECI_CTRL_PECI_CLK_EN       BIT(0)
+
+/* AST_PECI_TIMING - 0x04 : Timing Negotiation Register */
+#define PECI_TIMING_MESSAGE_MASK   GENMASK(15, 8)
+#define PECI_TIMING_MESSAGE(x)     ((x << 8) & PECI_TIMING_MESSAGE_MASK)
+#define PECI_TIMING_MESSAGE_GET(x) ((x & PECI_TIMING_MESSAGE_MASK) >> 8)
+#define PECI_TIMING_ADDRESS_MASK   GENMASK(7, 0)
+#define PECI_TIMING_ADDRESS(x)     (x & PECI_TIMING_ADDRESS_MASK)
+#define PECI_TIMING_ADDRESS_GET(x) (x & PECI_TIMING_ADDRESS_MASK)
+
+/* AST_PECI_CMD - 0x08 : Command Register */
+#define PECI_CMD_PIN_MON    BIT(31)
+#define PECI_CMD_STS_MASK   GENMASK(27, 24)
+#define PECI_CMD_STS_GET(x) ((x & PECI_CMD_STS_MASK) >> 24)
+#define PECI_CMD_FIRE       BIT(0)
+
+/* AST_PECI_LEN - 0x0C : Read/Write Length Register */
+#define PECI_AW_FCS_EN       BIT(31)
+#define PECI_READ_LEN_MASK   GENMASK(23, 16)
+#define PECI_READ_LEN(x)     ((x << 16) & PECI_READ_LEN_MASK)
+#define PECI_WRITE_LEN_MASK  GENMASK(15, 8)
+#define PECI_WRITE_LEN(x)    ((x << 8) & PECI_WRITE_LEN_MASK)
+#define PECI_TAGET_ADDR_MASK GENMASK(7, 0)
+#define PECI_TAGET_ADDR(x)   ((x) & PECI_TAGET_ADDR_MASK)
+
+/* AST_PECI_EXP_FCS - 0x10 : Expected FCS Data Register  */
+#define PECI_EXPECT_READ_FCS_MASK      GENMASK(23, 16)
+#define PECI_EXPECT_READ_FCS_GET(x)    ((x & PECI_EXPECT_READ_FCS_MASK) >> 16)
+#define PECI_EXPECT_AW_FCS_AUTO_MASK   GENMASK(15, 8)
+#define PECI_EXPECT_AW_FCS_AUTO_GET(x) ((x & PECI_EXPECT_AW_FCS_AUTO_MASK) >> 8)
+#define PECI_EXPECT_WRITE_FCS_MASK     GENMASK(7, 0)
+#define PECI_EXPECT_WRITE_FCS_GET(x)   (x & PECI_EXPECT_WRITE_FCS_MASK)
+
+/* AST_PECI_CAP_FCS - 0x14 : Captured FCS Data Register */
+#define PECI_CAPTURE_READ_FCS_MASK    GENMASK(23, 16)
+#define PECI_CAPTURE_READ_FCS_GET(x)  ((x & PECI_CAPTURE_READ_FCS_MASK) >> 16)
+#define PECI_CAPTURE_WRITE_FCS_MASK   GENMASK(7, 0)
+#define PECI_CAPTURE_WRITE_FCS_GET(x) (x & PECI_CAPTURE_WRITE_FCS_MASK)
+
+/* AST_PECI_INT_CTRL/STS - 0x18/0x1c : Interrupt Register */
+#define PECI_INT_TIMING_RESULT_MASK GENMASK(31, 30)
+#define PECI_INT_TIMEOUT            BIT(4)
+#define PECI_INT_CONNECT            BIT(3)
+#define PECI_INT_W_FCS_BAD          BIT(2)
+#define PECI_INT_W_FCS_ABORT        BIT(1)
+#define PECI_INT_CMD_DONE           BIT(0)
+
+struct aspeed_peci {
+	struct miscdevice miscdev;
+	struct device *dev;
+	struct regmap *regmap;
+	atomic_t ref_count;
+	int irq;
+	struct completion xfer_complete;
+	u32 sts;
+	u32 cmd_timeout_ms;
+	bool initialized;
+	bool cmd_support[PECI_CMD_MAX];
+	struct mutex mutex;
+};
+
+#define PECI_INT_MASK  (PECI_INT_TIMEOUT | PECI_INT_CONNECT | \
+			PECI_INT_W_FCS_BAD | PECI_INT_W_FCS_ABORT | \
+			PECI_INT_CMD_DONE)
+
+#define PECI_IDLE_CHECK_TIMEOUT         5
+
+#define PECI_RD_SAMPLING_POINT_DEFAULT  8
+#define PECI_RD_SAMPLING_POINT_MAX      15
+#define PECI_CLK_DIV_DEFAULT            0
+#define PECI_CLK_DIV_MAX                7
+#define PECI_MSG_TIMING_NEGO_DEFAULT    1
+#define PECI_MSG_TIMING_NEGO_MAX        255
+#define PECI_ADDR_TIMING_NEGO_DEFAULT   1
+#define PECI_ADDR_TIMING_NEGO_MAX       255
+#define PECI_CMD_TIMEOUT_MS_DEFAULT     1000
+#define PECI_CMD_TIMEOUT_MS_MAX         60000
+
+#define PECI_CRC8_POLYNOMIAL            0x07
+
+DECLARE_CRC8_TABLE(aspeed_peci_crc8_table);
+
+static struct aspeed_peci *aspeed_peci_priv;
+
+
+static u8 compute_aw_fcs(u8 *data, int len)
+{
+	return crc8(aspeed_peci_crc8_table, data, (size_t)len, 0);
+}
+
+static int ioctl_xfer_msg(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_xfer_msg *pumsg = pmsg;
+	u32 peci_head;
+	u32 peci_state;
+	u32 rx_data;
+	uint reg;
+	long timeout;
+	int i;
+	int rc = 0;
+
+	reinit_completion(&priv->xfer_complete);
+
+	peci_head = PECI_TAGET_ADDR(pumsg->client_addr) |
+				    PECI_WRITE_LEN(pumsg->tx_len) |
+				    PECI_READ_LEN(pumsg->rx_len);
+
+	rc = regmap_write(priv->regmap, AST_PECI_CMD_CTRL, peci_head);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < pumsg->tx_len; i += 4) {
+		reg = i < 16 ? AST_PECI_W_DATA0 + i % 16 :
+			       AST_PECI_W_DATA4 + i % 16;
+		rc = regmap_write(priv->regmap, reg,
+				  (pumsg->tx_buf[i + 3] << 24) |
+				  (pumsg->tx_buf[i + 2] << 16) |
+				  (pumsg->tx_buf[i + 1] << 8) |
+				  pumsg->tx_buf[i + 0]);
+		if (rc)
+			return rc;
+	}
+
+	dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
+#if DUMP_DEBUG
+	print_hex_dump(KERN_DEBUG, "TX : ", DUMP_PREFIX_NONE, 16, 1,
+		       pumsg->tx_buf, pumsg->tx_len, true);
+#endif
+
+	rc = regmap_write(priv->regmap, AST_PECI_CMD, PECI_CMD_FIRE);
+	if (rc)
+		return rc;
+
+	timeout = wait_for_completion_interruptible_timeout(
+					&priv->xfer_complete,
+					msecs_to_jiffies(priv->cmd_timeout_ms));
+
+	dev_dbg(priv->dev, "INT_STS : 0x%08x\n", priv->sts);
+	if (!regmap_read(priv->regmap, AST_PECI_CMD, &peci_state))
+		dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
+			PECI_CMD_STS_GET(peci_state));
+	else
+		dev_dbg(priv->dev, "PECI_STATE : read error\n");
+
+	if (timeout <= 0 || !(priv->sts & PECI_INT_CMD_DONE)) {
+		if (timeout <= 0) {
+			dev_dbg(priv->dev, "Timeout waiting for a response!\n");
+			rc = -ETIME;
+		} else {
+			dev_dbg(priv->dev, "No valid response!\n");
+			rc = -EFAULT;
+		}
+		return rc;
+	}
+
+	for (i = 0; i < pumsg->rx_len; i++) {
+		u8 byte_offset = i % 4;
+
+		if (byte_offset == 0) {
+			reg = i < 16 ? AST_PECI_R_DATA0 + i % 16 :
+				       AST_PECI_R_DATA4 + i % 16;
+			rc = regmap_read(priv->regmap, reg, &rx_data);
+			if (rc)
+				return rc;
+		}
+
+		pumsg->rx_buf[i] = (u8)(rx_data >> (byte_offset << 3));
+	}
+
+#if DUMP_DEBUG
+	print_hex_dump(KERN_DEBUG, "RX : ", DUMP_PREFIX_NONE, 16, 1,
+		       pumsg->rx_buf, pumsg->rx_len, true);
+#endif
+	if (!regmap_read(priv->regmap, AST_PECI_CMD, &peci_state))
+		dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
+			PECI_CMD_STS_GET(peci_state));
+	else
+		dev_dbg(priv->dev, "PECI_STATE : read error\n");
+	dev_dbg(priv->dev, "------------------------\n");
+
+	return rc;
+}
+
+static int
+xfer_msg_with_retries(struct aspeed_peci *priv, void *pmsg, bool has_aw_fcs)
+{
+	struct peci_xfer_msg *pumsg = pmsg;
+	uint retries = DEV_PECI_RETRY_ATTEMPTS;
+	int rc = 0;
+
+	/* Per the PECI spec, need to retry any commands that return 0x8x */
+	do {
+		rc = ioctl_xfer_msg(priv, pumsg);
+		if (!(!rc && ((pumsg->rx_buf[0] & DEV_PECI_CC_RETRY_ERR_MASK) ==
+			      DEV_PECI_CC_TIMEOUT)))
+			break;
+
+		/* Set the retry bit to indicate a retry attempt */
+		pumsg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
+
+		/* Recalculate the AW FCS if it has one */
+		if (has_aw_fcs)
+			pumsg->tx_buf[pumsg->tx_len - 1] = 0x80 ^
+					compute_aw_fcs((u8 *)pumsg,
+					2 + pumsg->tx_len);
+
+		/*
+		 * Retry for at least 250ms before returning an error.
+		 * Retry interval guideline:
+		 *   No minimum < Retry Interval < No maximum
+		 *                (recommend 10ms)
+		 */
+		usleep_range(DEV_PECI_RETRY_DELAY_MS * 1000,
+			     (DEV_PECI_RETRY_DELAY_MS * 1000) + 1000);
+	} while (retries--);
+
+	return rc;
+}
+
+static int initialize(struct aspeed_peci *priv)
+{
+	struct peci_xfer_msg msg;
+	u32 dib;
+	int rc = 0;
+
+	/* Initialize it just once. */
+	if (priv->initialized)
+		return 0;
+
+	/* Update command table just once. */
+	if (priv->cmd_support[PECI_CMD_PING])
+		return 0;
+
+	msg.client_addr = PECI_BASE_ADDR;
+	msg.tx_len      = GET_DIB_WR_LEN;
+	msg.rx_len      = GET_DIB_RD_LEN;
+	msg.tx_buf[0]   = GET_DIB_PECI_CMD;
+
+	rc = ioctl_xfer_msg(priv, &msg);
+	if (rc < 0) {
+		dev_dbg(priv->dev, "PECI xfer error, rc : %d\n", rc);
+		return rc;
+	}
+
+	dib = msg.rx_buf[0] | (msg.rx_buf[1] << 8) |
+	      (msg.rx_buf[2] << 16) | (msg.rx_buf[3] << 24);
+
+	/* Check special case for Get DIB command */
+	if (dib == 0x00) {
+		dev_dbg(priv->dev, "DIB read as 0x00\n");
+		return -1;
+	}
+
+	if (!rc) {
+		/*
+		 * setting up the supporting commands based on minor rev#
+		 * see PECI Spec Table 3-1
+		 */
+		priv->cmd_support[PECI_CMD_PING] = true;
+		priv->cmd_support[PECI_CMD_GET_TEMP] = true;
+		priv->cmd_support[PECI_CMD_GET_DIB] = true;
+
+		/* get minor rev# */
+		dib = (dib >> 8) & 0xF;
+
+		if (dib >= 0x1) {
+			priv->cmd_support[PECI_CMD_RD_PKG_CFG] = true;
+			priv->cmd_support[PECI_CMD_WR_PKG_CFG] = true;
+		}
+
+		if (dib >= 0x2)
+			priv->cmd_support[PECI_CMD_RD_IA_MSR] = true;
+
+		if (dib >= 0x3) {
+			priv->cmd_support[PECI_CMD_RD_PCI_CFG_LOCAL] = true;
+			priv->cmd_support[PECI_CMD_WR_PCI_CFG_LOCAL] = true;
+		}
+
+		if (dib >= 0x4)
+			priv->cmd_support[PECI_CMD_RD_PCI_CFG] = true;
+
+		if (dib >= 0x5)
+			priv->cmd_support[PECI_CMD_WR_PCI_CFG] = true;
+
+		if (dib >= 0x6)
+			priv->cmd_support[PECI_CMD_WR_IA_MSR] = true;
+
+		priv->initialized = true;
+	} else {
+		dev_dbg(priv->dev, "Error reading DIB, rc : %d\n", rc);
+	}
+
+	return rc;
+}
+
+static int ioctl_ping(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_ping_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc;
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_PING]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len      = 0;
+	msg.rx_len      = 0;
+
+	rc = ioctl_xfer_msg(priv, &msg);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static int ioctl_get_dib(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_get_dib_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc;
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_GET_DIB]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len      = GET_DIB_WR_LEN;
+	msg.rx_len      = GET_DIB_RD_LEN;
+	msg.tx_buf[0]   = GET_DIB_PECI_CMD;
+
+	rc = ioctl_xfer_msg(priv, &msg);
+	if (rc < 0)
+		return rc;
+
+	pumsg->dib = msg.rx_buf[0] | (msg.rx_buf[1] << 8) |
+		     (msg.rx_buf[2] << 16) | (msg.rx_buf[3] << 24);
+
+	return 0;
+}
+
+static int ioctl_get_temp(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_get_temp_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc;
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_GET_TEMP]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len      = GET_TEMP_WR_LEN;
+	msg.rx_len      = GET_TEMP_RD_LEN;
+	msg.tx_buf[0]   = GET_TEMP_PECI_CMD;
+
+	rc = ioctl_xfer_msg(priv, &msg);
+	if (rc < 0)
+		return rc;
+
+	pumsg->temp_raw = (signed short)(msg.rx_buf[0] | (msg.rx_buf[1] << 8));
+
+	return 0;
+}
+
+static int ioctl_rd_pkg_cfg(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_rd_pkg_cfg_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc = 0;
+
+	/* Per the PECI spec, the read length must be a byte, word, or dword */
+	if (pumsg->rx_len != 1 && pumsg->rx_len != 2 && pumsg->rx_len != 4) {
+		dev_dbg(priv->dev, "Invalid read length, rx_len: %d\n",
+			pumsg->rx_len);
+		return -EINVAL;
+	}
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_RD_PKG_CFG]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len = RDPKGCFG_WRITE_LEN;
+	/* read lengths of 1 and 2 result in an error, so only use 4 for now */
+	msg.rx_len = RDPKGCFG_READ_LEN_BASE + pumsg->rx_len;
+	msg.tx_buf[0] = RDPKGCFG_PECI_CMD;
+	msg.tx_buf[1] = 0x00;         /* request byte for Host ID / Retry bit */
+				      /* Host ID is 0 for PECI 3.0 */
+	msg.tx_buf[2] = pumsg->index;            /* RdPkgConfig index */
+	msg.tx_buf[3] = (u8)pumsg->param;        /* LSB - Config parameter */
+	msg.tx_buf[4] = (u8)(pumsg->param >> 8); /* MSB - Config parameter */
+
+	rc = xfer_msg_with_retries(priv, &msg, false);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	memcpy(pumsg->pkg_config, &msg.rx_buf[1], pumsg->rx_len);
+
+	return rc;
+}
+
+static int ioctl_wr_pkg_cfg(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_wr_pkg_cfg_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc = 0, i;
+
+	/* Per the PECI spec, the write length must be a dword */
+	if (pumsg->tx_len != 4) {
+		dev_dbg(priv->dev, "Invalid write length, tx_len: %d\n",
+			pumsg->tx_len);
+		return -EINVAL;
+	}
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_WR_PKG_CFG]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len = WRPKGCFG_WRITE_LEN_BASE + pumsg->tx_len;
+	/* read lengths of 1 and 2 result in an error, so only use 4 for now */
+	msg.rx_len = WRPKGCFG_READ_LEN;
+	msg.tx_buf[0] = WRPKGCFG_PECI_CMD;
+	msg.tx_buf[1] = 0x00;         /* request byte for Host ID / Retry bit */
+				      /* Host ID is 0 for PECI 3.0 */
+	msg.tx_buf[2] = pumsg->index;            /* RdPkgConfig index */
+	msg.tx_buf[3] = (u8)pumsg->param;        /* LSB - Config parameter */
+	msg.tx_buf[4] = (u8)(pumsg->param >> 8); /* MSB - Config parameter */
+	for (i = 0; i < pumsg->tx_len; i++)
+		msg.tx_buf[5 + i] = ((u8 *)&pumsg->value)[i];
+
+	/* Add an Assure Write Frame Check Sequence byte */
+	msg.tx_buf[5 + i] = 0x80 ^
+			    compute_aw_fcs((u8 *)&msg, 8 + pumsg->tx_len);
+
+	rc = xfer_msg_with_retries(priv, &msg, true);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	return rc;
+}
+
+static int ioctl_rd_ia_msr(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_rd_ia_msr_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	int rc = 0;
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_RD_IA_MSR]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len = RDIAMSR_WRITE_LEN;
+	msg.rx_len = RDIAMSR_READ_LEN;
+	msg.tx_buf[0] = RDIAMSR_PECI_CMD;
+	msg.tx_buf[1] = 0x00;
+	msg.tx_buf[2] = pumsg->thread_id;
+	msg.tx_buf[3] = (u8)pumsg->address;
+	msg.tx_buf[4] = (u8)(pumsg->address >> 8);
+
+	rc = xfer_msg_with_retries(priv, &msg, false);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	memcpy(&pumsg->value, &msg.rx_buf[1], sizeof(uint64_t));
+
+	return rc;
+}
+
+static int ioctl_rd_pci_cfg(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_rd_pci_cfg_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	u32 address;
+	int rc = 0;
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_RD_PCI_CFG]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	address = pumsg->reg;                  /* [11:0]  - Register */
+	address |= (u32)pumsg->function << 12; /* [14:12] - Function */
+	address |= (u32)pumsg->device << 15;   /* [19:15] - Device   */
+	address |= (u32)pumsg->bus << 20;      /* [27:20] - Bus      */
+					       /* [31:28] - Reserved */
+	msg.client_addr = pumsg->target;
+	msg.tx_len = RDPCICFG_WRITE_LEN;
+	msg.rx_len = RDPCICFG_READ_LEN;
+	msg.tx_buf[0] = RDPCICFG_PECI_CMD;
+	msg.tx_buf[1] = 0x00;         /* request byte for Host ID / Retry bit */
+				      /* Host ID is 0 for PECI 3.0 */
+	msg.tx_buf[2] = (u8)address;         /* LSB - PCI Config Address */
+	msg.tx_buf[3] = (u8)(address >> 8);  /* PCI Config Address */
+	msg.tx_buf[4] = (u8)(address >> 16); /* PCI Config Address */
+	msg.tx_buf[5] = (u8)(address >> 24); /* MSB - PCI Config Address */
+
+	rc = xfer_msg_with_retries(priv, &msg, false);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	memcpy(pumsg->pci_config, &msg.rx_buf[1], 4);
+
+	return rc;
+}
+
+static int ioctl_rd_pci_cfg_local(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_rd_pci_cfg_local_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	u32 address;
+	int rc = 0;
+
+	/* Per the PECI spec, the read length must be a byte, word, or dword */
+	if (pumsg->rx_len != 1 && pumsg->rx_len != 2 && pumsg->rx_len != 4) {
+		dev_dbg(priv->dev, "Invalid read length, rx_len: %d\n",
+			pumsg->rx_len);
+		return -EINVAL;
+	}
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_RD_PCI_CFG_LOCAL]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	address = pumsg->reg;                  /* [11:0]  - Register */
+	address |= (u32)pumsg->function << 12; /* [14:12] - Function */
+	address |= (u32)pumsg->device << 15;   /* [19:15] - Device   */
+	address |= (u32)pumsg->bus << 20;      /* [23:20] - Bus      */
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len = RDPCICFGLOCAL_WRITE_LEN;
+	msg.rx_len = RDPCICFGLOCAL_READ_LEN_BASE + pumsg->rx_len;
+	msg.tx_buf[0] = RDPCICFGLOCAL_PECI_CMD;
+	msg.tx_buf[1] = 0x00;         /* request byte for Host ID / Retry bit */
+				      /* Host ID is 0 for PECI 3.0 */
+	msg.tx_buf[2] = (u8)address;       /* LSB - PCI Configuration Address */
+	msg.tx_buf[3] = (u8)(address >> 8);  /* PCI Configuration Address */
+	msg.tx_buf[4] = (u8)(address >> 16); /* PCI Configuration Address */
+
+	rc = xfer_msg_with_retries(priv, &msg, false);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	memcpy(pumsg->pci_config, &msg.rx_buf[1], pumsg->rx_len);
+
+	return rc;
+}
+
+static int ioctl_wr_pci_cfg_local(struct aspeed_peci *priv, void *pmsg)
+{
+	struct peci_wr_pci_cfg_local_msg *pumsg = pmsg;
+	struct peci_xfer_msg msg;
+	u32 address;
+	int rc = 0, i;
+
+	/* Per the PECI spec, the write length must be a byte, word, or dword */
+	if (pumsg->tx_len != 1 && pumsg->tx_len != 2 && pumsg->tx_len != 4) {
+		dev_dbg(priv->dev, "Invalid write length, tx_len: %d\n",
+			pumsg->tx_len);
+		return -EINVAL;
+	}
+
+	if (!priv->initialized && initialize(priv) < 0) {
+		dev_dbg(priv->dev, "Failed to initialize peci\n");
+		return -EIO;
+	}
+
+	if (!priv->cmd_support[PECI_CMD_RD_PCI_CFG_LOCAL]) {
+		dev_dbg(priv->dev, "Command is not supported\n");
+		return -EBADRQC;
+	}
+
+	address = pumsg->reg;                  /* [11:0]  - Register */
+	address |= (u32)pumsg->function << 12; /* [14:12] - Function */
+	address |= (u32)pumsg->device << 15;   /* [19:15] - Device   */
+	address |= (u32)pumsg->bus << 20;      /* [23:20] - Bus      */
+
+	msg.client_addr = pumsg->target;
+	msg.tx_len = WRPCICFGLOCAL_WRITE_LEN_BASE + pumsg->tx_len;
+	msg.rx_len = WRPCICFGLOCAL_READ_LEN;
+	msg.tx_buf[0] = WRPCICFGLOCAL_PECI_CMD;
+	msg.tx_buf[1] = 0x00;         /* request byte for Host ID / Retry bit */
+				      /* Host ID is 0 for PECI 3.0 */
+	msg.tx_buf[2] = (u8)address;       /* LSB - PCI Configuration Address */
+	msg.tx_buf[3] = (u8)(address >> 8);  /* PCI Configuration Address */
+	msg.tx_buf[4] = (u8)(address >> 16); /* PCI Configuration Address */
+	for (i = 0; i < pumsg->tx_len; i++)
+		msg.tx_buf[5 + i] = ((u8 *)&pumsg->value)[i];
+
+	/* Add an Assure Write Frame Check Sequence byte */
+	msg.tx_buf[5 + i] = 0x80 ^
+			    compute_aw_fcs((u8 *)&msg, 8 + pumsg->tx_len);
+
+	rc = xfer_msg_with_retries(priv, &msg, true);
+	if (rc || msg.rx_buf[0] != DEV_PECI_CC_SUCCESS) {
+		dev_dbg(priv->dev, "ioctl error, rc : %d\n", rc);
+		return -EIO;
+	}
+
+	return rc;
+}
+
+
+typedef int (*ioctl_fn)(struct aspeed_peci *, void *);
+
+static ioctl_fn peci_ioctl_fn[PECI_CMD_MAX] = {
+	ioctl_xfer_msg,
+	ioctl_ping,
+	ioctl_get_dib,
+	ioctl_get_temp,
+	ioctl_rd_pkg_cfg,
+	ioctl_wr_pkg_cfg,
+	ioctl_rd_ia_msr,
+	NULL, /* Reserved */
+	ioctl_rd_pci_cfg,
+	NULL, /* Reserved */
+	ioctl_rd_pci_cfg_local,
+	ioctl_wr_pci_cfg_local,
+};
+
+
+long peci_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct aspeed_peci *priv;
+	long ret = 0;
+	void __user *argp = (void __user *)arg;
+	int timeout = PECI_IDLE_CHECK_TIMEOUT;
+	u8 msg[sizeof(struct peci_xfer_msg)];
+	unsigned int peci_cmd, msg_size;
+	u32 cmd_sts;
+
+	/*
+	 * Treat it as an inter module call when filp is null but only in case
+	 * the private data is initialized.
+	 */
+	if (filp)
+		priv = container_of(filp->private_data,
+				    struct aspeed_peci, miscdev);
+	else
+		priv = aspeed_peci_priv;
+
+	if (!priv)
+		return -ENXIO;
+
+	switch (cmd) {
+	case PECI_IOC_XFER:
+	case PECI_IOC_PING:
+	case PECI_IOC_GET_DIB:
+	case PECI_IOC_GET_TEMP:
+	case PECI_IOC_RD_PKG_CFG:
+	case PECI_IOC_WR_PKG_CFG:
+	case PECI_IOC_RD_IA_MSR:
+	case PECI_IOC_RD_PCI_CFG:
+	case PECI_IOC_RD_PCI_CFG_LOCAL:
+	case PECI_IOC_WR_PCI_CFG_LOCAL:
+		peci_cmd = _IOC_TYPE(cmd) - PECI_IOC_BASE;
+		msg_size = _IOC_SIZE(cmd);
+		break;
+
+	default:
+		dev_dbg(priv->dev, "Invalid ioctl cmd : 0x%08x\n", cmd);
+		return -EINVAL;
+	}
+
+	if (!peci_ioctl_fn[peci_cmd])
+		return -EPERM;
+
+	mutex_lock(&priv->mutex);
+
+	dev_dbg(priv->dev, "CMD : 0x%08x, peci_cmd : %d, msg_size : %d\n",
+		cmd, peci_cmd, msg_size);
+
+	/* Check command sts and bus idle state */
+	while (!regmap_read(priv->regmap, AST_PECI_CMD, &cmd_sts)
+	       && (cmd_sts & (PECI_CMD_STS_MASK | PECI_CMD_PIN_MON))) {
+		if (timeout-- < 0) {
+			dev_dbg(priv->dev, "Timeout waiting for idle state!\n");
+			ret = -ETIME;
+			goto out;
+		}
+		usleep_range(10000, 11000);
+	};
+
+	if (msg_size &&
+	    (filp ? copy_from_user(&msg, argp, msg_size) :
+		    memcpy(&msg, (const void *)arg, msg_size) != &msg)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = peci_ioctl_fn[peci_cmd](priv, &msg);
+
+	if (ret == 0 && msg_size &&
+	    (filp ? copy_to_user(argp, &msg, msg_size) :
+		    memcpy((void *)arg, &msg, msg_size) != (void *)arg))
+		ret = -EFAULT;
+
+out:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(peci_ioctl);
+
+static int aspeed_peci_open(struct inode *inode, struct file *filp)
+{
+	struct aspeed_peci *priv =
+		container_of(filp->private_data, struct aspeed_peci, miscdev);
+
+	atomic_inc(&priv->ref_count);
+
+	dev_dbg(priv->dev, "ref_count : %d\n", atomic_read(&priv->ref_count));
+
+	return 0;
+}
+
+static int aspeed_peci_release(struct inode *inode, struct file *filp)
+{
+	struct aspeed_peci *priv =
+		container_of(filp->private_data, struct aspeed_peci, miscdev);
+
+	atomic_dec(&priv->ref_count);
+
+	dev_dbg(priv->dev, "ref_count : %d\n", atomic_read(&priv->ref_count));
+
+	return 0;
+}
+
+static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
+{
+	struct aspeed_peci *priv = arg;
+	bool valid_irq = true;
+
+	if (regmap_read(priv->regmap, AST_PECI_INT_STS, &priv->sts))
+		return IRQ_NONE;
+
+	switch (priv->sts & PECI_INT_MASK) {
+	case PECI_INT_TIMEOUT:
+		dev_dbg(priv->dev, "PECI_INT_TIMEOUT\n");
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS,
+				 PECI_INT_TIMEOUT))
+			return IRQ_NONE;
+		break;
+	case PECI_INT_CONNECT:
+		dev_dbg(priv->dev, "PECI_INT_CONNECT\n");
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS,
+			     PECI_INT_CONNECT))
+			return IRQ_NONE;
+		break;
+	case PECI_INT_W_FCS_BAD:
+		dev_dbg(priv->dev, "PECI_INT_W_FCS_BAD\n");
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS,
+			     PECI_INT_W_FCS_BAD))
+			return IRQ_NONE;
+		break;
+	case PECI_INT_W_FCS_ABORT:
+		dev_dbg(priv->dev, "PECI_INT_W_FCS_ABORT\n");
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS,
+			     PECI_INT_W_FCS_ABORT))
+			return IRQ_NONE;
+		break;
+	case PECI_INT_CMD_DONE:
+		dev_dbg(priv->dev, "PECI_INT_CMD_DONE\n");
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS,
+			     PECI_INT_CMD_DONE) ||
+		    regmap_write(priv->regmap, AST_PECI_CMD, 0))
+			return IRQ_NONE;
+		break;
+	default:
+		dev_dbg(priv->dev, "Unknown PECI interrupt : 0x%08x\n",
+			priv->sts);
+		if (regmap_write(priv->regmap, AST_PECI_INT_STS, priv->sts))
+			return IRQ_NONE;
+		valid_irq = false;
+		break;
+	}
+
+	if (valid_irq)
+		complete(&priv->xfer_complete);
+
+	return IRQ_HANDLED;
+}
+
+static int aspeed_peci_init_ctrl(struct aspeed_peci *priv)
+{
+	struct clk *clkin;
+	u32 clk_freq, clk_divisor, clk_div_val = 0;
+	u32 msg_timing_nego, addr_timing_nego, rd_sampling_point;
+	int ret;
+
+	clkin = devm_clk_get(priv->dev, NULL);
+	if (IS_ERR(clkin)) {
+		dev_err(priv->dev, "Failed to get clk source.\n");
+		return PTR_ERR(clkin);
+	}
+
+	ret = of_property_read_u32(priv->dev->of_node, "clock-frequency",
+				   &clk_freq);
+	if (ret < 0) {
+		dev_err(priv->dev,
+			"Could not read clock-frequency property.\n");
+		return ret;
+	}
+
+	clk_divisor = clk_get_rate(clkin) / clk_freq;
+	devm_clk_put(priv->dev, clkin);
+
+	while ((clk_divisor >> 1) && (clk_div_val < PECI_CLK_DIV_MAX))
+		clk_div_val++;
+
+	ret = of_property_read_u32(priv->dev->of_node, "msg-timing-nego",
+				   &msg_timing_nego);
+	if (ret || msg_timing_nego > PECI_MSG_TIMING_NEGO_MAX) {
+		dev_warn(priv->dev,
+			 "Invalid msg-timing-nego : %u, Use default : %u\n",
+			 msg_timing_nego, PECI_MSG_TIMING_NEGO_DEFAULT);
+		msg_timing_nego = PECI_MSG_TIMING_NEGO_DEFAULT;
+	}
+
+	ret = of_property_read_u32(priv->dev->of_node, "addr-timing-nego",
+				   &addr_timing_nego);
+	if (ret || addr_timing_nego > PECI_ADDR_TIMING_NEGO_MAX) {
+		dev_warn(priv->dev,
+			 "Invalid addr-timing-nego : %u, Use default : %u\n",
+			 addr_timing_nego, PECI_ADDR_TIMING_NEGO_DEFAULT);
+		addr_timing_nego = PECI_ADDR_TIMING_NEGO_DEFAULT;
+	}
+
+	ret = of_property_read_u32(priv->dev->of_node, "rd-sampling-point",
+				   &rd_sampling_point);
+	if (ret || rd_sampling_point > PECI_RD_SAMPLING_POINT_MAX) {
+		dev_warn(priv->dev,
+			 "Invalid rd-sampling-point : %u. Use default : %u\n",
+			 rd_sampling_point,
+			 PECI_RD_SAMPLING_POINT_DEFAULT);
+		rd_sampling_point = PECI_RD_SAMPLING_POINT_DEFAULT;
+	}
+
+	ret = of_property_read_u32(priv->dev->of_node, "cmd-timeout-ms",
+				   &priv->cmd_timeout_ms);
+	if (ret || priv->cmd_timeout_ms > PECI_CMD_TIMEOUT_MS_MAX ||
+		priv->cmd_timeout_ms == 0) {
+		dev_warn(priv->dev,
+			 "Invalid cmd-timeout-ms : %u. Use default : %u\n",
+			 priv->cmd_timeout_ms,
+			 PECI_CMD_TIMEOUT_MS_DEFAULT);
+		priv->cmd_timeout_ms = PECI_CMD_TIMEOUT_MS_DEFAULT;
+	}
+
+	ret = regmap_write(priv->regmap, AST_PECI_CTRL,
+			   PECI_CTRL_CLK_DIV(PECI_CLK_DIV_DEFAULT) |
+			   PECI_CTRL_PECI_CLK_EN);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 5000);
+
+	/*
+	 * Timing negotiation period setting.
+	 * The unit of the programmed value is 4 times of PECI clock period.
+	 */
+	ret = regmap_write(priv->regmap, AST_PECI_TIMING,
+			   PECI_TIMING_MESSAGE(msg_timing_nego) |
+			   PECI_TIMING_ADDRESS(addr_timing_nego));
+	if (ret)
+		return ret;
+
+	/* Clear interrupts. */
+	ret = regmap_write(priv->regmap, AST_PECI_INT_STS, PECI_INT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable interrupts. */
+	ret = regmap_write(priv->regmap, AST_PECI_INT_CTRL, PECI_INT_MASK);
+	if (ret)
+		return ret;
+
+	/* Read sampling point and clock speed setting. */
+	ret = regmap_write(priv->regmap, AST_PECI_CTRL,
+			   PECI_CTRL_SAMPLING(rd_sampling_point) |
+			   PECI_CTRL_CLK_DIV(clk_div_val) |
+			   PECI_CTRL_PECI_EN | PECI_CTRL_PECI_CLK_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct regmap_config aspeed_peci_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = AST_PECI_R_DATA7,
+	.fast_io = true,
+};
+
+static const struct file_operations aspeed_peci_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.unlocked_ioctl = peci_ioctl,
+	.open = aspeed_peci_open,
+	.release = aspeed_peci_release,
+};
+
+static int __init aspeed_peci_probe(struct platform_device *pdev)
+{
+	struct aspeed_peci *priv;
+	struct device *dev;
+	struct resource *res;
+	void __iomem *base;
+	int ret = 0;
+
+	dev = &pdev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &aspeed_peci_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (!priv->irq)
+		return -ENODEV;
+
+	ret = devm_request_irq(dev, priv->irq, aspeed_peci_irq_handler,
+			       IRQF_SHARED,
+			       SOC_NAME "-" DEVICE_NAME "-irq",
+			       priv);
+	if (ret < 0)
+		return ret;
+
+	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+	priv->miscdev.name = DEVICE_NAME;
+	priv->miscdev.parent = dev;
+	priv->miscdev.fops = &aspeed_peci_fops;
+
+	ret = misc_register(&priv->miscdev);
+	if (ret) {
+		dev_err(dev, "Failed to request interrupt.\n");
+		return ret;
+	}
+
+	mutex_init(&priv->mutex);
+	init_completion(&priv->xfer_complete);
+
+	crc8_populate_msb(aspeed_peci_crc8_table, PECI_CRC8_POLYNOMIAL);
+
+	ret = aspeed_peci_init_ctrl(priv);
+	if (ret < 0)
+		return ret;
+
+	aspeed_peci_priv = priv;
+
+	dev_info(dev, "peci registered, IRQ %d\n", priv->irq);
+
+	return 0;
+}
+
+static int aspeed_peci_remove(struct platform_device *pdev)
+{
+	struct aspeed_peci *priv = dev_get_drvdata(&pdev->dev);
+
+	aspeed_peci_priv = NULL;
+	dev_set_drvdata(&pdev->dev, NULL);
+	misc_deregister(&priv->miscdev);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_peci_of_table[] = {
+	{ .compatible = "aspeed,ast2400-peci", },
+	{ .compatible = "aspeed,ast2500-peci", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_peci_of_table);
+
+static struct platform_driver aspeed_peci_driver = {
+	.probe  = aspeed_peci_probe,
+	.remove = aspeed_peci_remove,
+	.driver = {
+		.name           = SOC_NAME "-" DEVICE_NAME,
+		.of_match_table = aspeed_peci_of_table,
+	},
+};
+module_platform_driver(aspeed_peci_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("Aspeed PECI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/misc/peci.h b/include/misc/peci.h
new file mode 100644
index 0000000..66322c6
--- /dev/null
+++ b/include/misc/peci.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Intel Corporation
+
+#ifndef __PECI_H
+#define __PECI_H
+
+#include <linux/peci_ioctl.h>
+
+long peci_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+
+#endif /* __PECI_H */
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index f330ba4..b34960b 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -327,6 +327,7 @@ header-y += packet_diag.h
 header-y += param.h
 header-y += parport.h
 header-y += patchkey.h
+header-y += peci_ioctl.h
 header-y += pci.h
 header-y += pci_regs.h
 header-y += perf_event.h
diff --git a/include/uapi/linux/peci_ioctl.h b/include/uapi/linux/peci_ioctl.h
new file mode 100644
index 0000000..8386848
--- /dev/null
+++ b/include/uapi/linux/peci_ioctl.h
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Intel Corporation
+
+#ifndef __PECI_IOCTL_H
+#define __PECI_IOCTL_H
+
+#include <linux/ioctl.h>
+
+/* Base Address of 48d */
+#define PECI_BASE_ADDR  0x30  /* The PECI client's default address of 0x30 */
+#define PECI_OFFSET_MAX 8     /* Max numver of CPU clients */
+
+/* PCI Access */
+#define MAX_PCI_READ_LEN 24  /* Number of bytes of the PCI Space read */
+
+#define PCI_BUS0_CPU0      0x00
+#define PCI_BUS0_CPU1      0x80
+#define PCI_CPUBUSNO_BUS   0x00
+#define PCI_CPUBUSNO_DEV   0x08
+#define PCI_CPUBUSNO_FUNC  0x02
+#define PCI_CPUBUSNO       0xcc
+#define PCI_CPUBUSNO_1     0xd0
+#define PCI_CPUBUSNO_VALID 0xd4
+
+/* Package Identifier Read Parameter Value */
+#define PKG_ID_CPU_ID               0x0000  /* 0 - CPUID Info */
+#define PKG_ID_PLATFORM_ID          0x0001  /* 1 - Platform ID */
+#define PKG_ID_UNCORE_ID            0x0002  /* 2 - Uncore Device ID */
+#define PKG_ID_MAX_THREAD_ID        0x0003  /* 3 - Max Thread ID */
+#define PKG_ID_MICROCODE_REV        0x0004  /* 4 - CPU Microcode Update Revision */
+#define PKG_ID_MACHINE_CHECK_STATUS 0x0005  /* 5 - Machine Check Status */
+
+/* RdPkgConfig Index */
+#define MBX_INDEX_CPU_ID            0   /* Package Identifier Read */
+#define MBX_INDEX_VR_DEBUG          1   /* VR Debug */
+#define MBX_INDEX_PKG_TEMP_READ     2   /* Package Temperature Read */
+#define MBX_INDEX_ENERGY_COUNTER    3   /* Energy counter */
+#define MBX_INDEX_ENERGY_STATUS     4   /* DDR Energy Status */
+#define MBX_INDEX_WAKE_MODE_BIT     5   /* "Wake on PECI" Mode bit */
+#define MBX_INDEX_EPI               6   /* Efficient Performance Indication */
+#define MBX_INDEX_PKG_RAPL_PERF     8   /* Package RAPL Performance Status Read */
+#define MBX_INDEX_PER_CORE_DTS_TEMP 9   /* Per Core DTS Temperature Read */
+#define MBX_INDEX_DTS_MARGIN        10  /* DTS thermal margin */
+#define MBX_INDEX_SKT_PWR_THRTL_DUR 11  /* Socket Power Throttled Duration */
+#define MBX_INDEX_CFG_TDP_CONTROL   12  /* TDP Config Control */
+#define MBX_INDEX_CFG_TDP_LEVELS    13  /* TDP Config Levels */
+#define MBX_INDEX_DDR_DIMM_TEMP     14  /* DDR DIMM Temperature */
+#define MBX_INDEX_CFG_ICCMAX        15  /* Configurable ICCMAX */
+#define MBX_INDEX_TEMP_TARGET       16  /* Temperature Target Read */
+#define MBX_INDEX_CURR_CFG_LIMIT    17  /* Current Config Limit */
+#define MBX_INDEX_DIMM_TEMP_READ    20  /* Package Thermal Status Read */
+#define MBX_INDEX_DRAM_IMC_TMP_READ 22  /* DRAM IMC Temperature Read */
+#define MBX_INDEX_DDR_CH_THERM_STAT 23  /* DDR Channel Thermal Status */
+#define MBX_INDEX_PKG_POWER_LIMIT1  26  /* Package Power Limit1 */
+#define MBX_INDEX_PKG_POWER_LIMIT2  27  /* Package Power Limit2 */
+#define MBX_INDEX_TDP               28  /* Thermal design power minimum */
+#define MBX_INDEX_TDP_HIGH          29  /* Thermal design power maximum */
+#define MBX_INDEX_TDP_UNITS         30  /* Units for power and energy registers */
+#define MBX_INDEX_RUN_TIME          31  /* Accumulated Run Time */
+#define MBX_INDEX_CONSTRAINED_TIME  32  /* Thermally Constrained Time Read */
+#define MBX_INDEX_TURBO_RATIO       33  /* Turbo Activation Ratio */
+#define MBX_INDEX_DDR_RAPL_PL1      34  /* DDR RAPL PL1 */
+#define MBX_INDEX_DDR_PWR_INFO_HIGH 35  /* DRAM Power Info Read (high) */
+#define MBX_INDEX_DDR_PWR_INFO_LOW  36  /* DRAM Power Info Read (low) */
+#define MBX_INDEX_DDR_RAPL_PL2      37  /* DDR RAPL PL2 */
+#define MBX_INDEX_DDR_RAPL_STATUS   38  /* DDR RAPL Performance Status */
+#define MBX_INDEX_DDR_HOT_ABSOLUTE  43  /* DDR Hottest Dimm Absolute Temperature */
+#define MBX_INDEX_DDR_HOT_RELATIVE  44  /* DDR Hottest Dimm Relative Temperature */
+#define MBX_INDEX_DDR_THROTTLE_TIME 45  /* DDR Throttle Time */
+#define MBX_INDEX_DDR_THERM_STATUS  46  /* DDR Thermal Status */
+#define MBX_INDEX_TIME_AVG_TEMP     47  /* Package time-averaged temperature */
+#define MBX_INDEX_TURBO_RATIO_LIMIT 49  /* Turbo Ratio Limit Read */
+#define MBX_INDEX_HWP_AUTO_OOB      53  /* HWP Autonomous Out-of-band */
+#define MBX_INDEX_DDR_WARM_BUDGET   55  /* DDR Warm Power Budget */
+#define MBX_INDEX_DDR_HOT_BUDGET    56  /* DDR Hot Power Budget */
+#define MBX_INDEX_PKG_PSYS_PWR_LIM3 57  /* Package/Psys Power Limit3 */
+#define MBX_INDEX_PKG_PSYS_PWR_LIM1 58  /* Package/Psys Power Limit1 */
+#define MBX_INDEX_PKG_PSYS_PWR_LIM2 59  /* Package/Psys Power Limit2 */
+#define MBX_INDEX_PKG_PSYS_PWR_LIM4 60  /* Package/Psys Power Limit4 */
+#define MBX_INDEX_PERF_LIMIT_REASON 65  /* Performance Limit Reasons */
+
+/* WrPkgConfig Index */
+#define MBX_INDEX_DIMM_ABIENT 19
+#define MBX_INDEX_DIMM_TEMP   24
+
+/* Device Specific Completion Code (CC) Definition */
+#define DEV_PECI_CC_RETRY_ERR_MASK  0xf0
+#define DEV_PECI_CC_SUCCESS         0x40
+#define DEV_PECI_CC_TIMEOUT         0x80
+#define DEV_PECI_CC_OUT_OF_RESOURCE 0x81
+#define DEV_PECI_CC_INVALID_REQ     0x90
+
+/* Skylake EDS says to retry for 250ms */
+#define DEV_PECI_RETRY_ATTEMPTS 25
+#define DEV_PECI_RETRY_DELAY_MS 10
+#define DEV_PECI_RETRY_BIT      0x01
+
+#define GET_TEMP_WR_LEN   1
+#define GET_TEMP_RD_LEN   2
+#define GET_TEMP_PECI_CMD 0x01
+
+#define GET_DIB_WR_LEN   1
+#define GET_DIB_RD_LEN   8
+#define GET_DIB_PECI_CMD 0xf7
+
+#define RDPKGCFG_WRITE_LEN     5
+#define RDPKGCFG_READ_LEN_BASE 1
+#define RDPKGCFG_PECI_CMD      0xa1
+
+#define WRPKGCFG_WRITE_LEN_BASE 6
+#define WRPKGCFG_READ_LEN       1
+#define WRPKGCFG_PECI_CMD       0xa5
+
+#define RDIAMSR_WRITE_LEN 5
+#define RDIAMSR_READ_LEN  9
+#define RDIAMSR_PECI_CMD  0xb1
+
+#define WRIAMSR_PECI_CMD  0xb5
+
+#define RDPCICFG_WRITE_LEN 6
+#define RDPCICFG_READ_LEN  5
+#define RDPCICFG_PECI_CMD  0x61
+
+#define WRPCICFG_PECI_CMD  0x65
+
+#define RDPCICFGLOCAL_WRITE_LEN     5
+#define RDPCICFGLOCAL_READ_LEN_BASE 1
+#define RDPCICFGLOCAL_PECI_CMD      0xe1
+
+#define WRPCICFGLOCAL_WRITE_LEN_BASE 6
+#define WRPCICFGLOCAL_READ_LEN       1
+#define WRPCICFGLOCAL_PECI_CMD       0xe5
+
+enum PECI_CMD {
+	PECI_CMD_XFER = 0,
+	PECI_CMD_PING,
+	PECI_CMD_GET_DIB,
+	PECI_CMD_GET_TEMP,
+	PECI_CMD_RD_PKG_CFG,
+	PECI_CMD_WR_PKG_CFG,
+	PECI_CMD_RD_IA_MSR,
+	PECI_CMD_WR_IA_MSR,
+	PECI_CMD_RD_PCI_CFG,
+	PECI_CMD_WR_PCI_CFG,
+	PECI_CMD_RD_PCI_CFG_LOCAL,
+	PECI_CMD_WR_PCI_CFG_LOCAL,
+	PECI_CMD_MAX,
+};
+
+#define MAX_BUFFER_SIZE  32
+
+#pragma pack(push, 1)
+struct peci_xfer_msg {
+	unsigned char client_addr;
+	unsigned char tx_len;
+	unsigned char rx_len;
+	unsigned char tx_buf[MAX_BUFFER_SIZE];
+	unsigned char rx_buf[MAX_BUFFER_SIZE];
+};
+#pragma pack(pop)
+
+struct peci_ping_msg {
+	unsigned char target;
+};
+
+struct peci_get_dib_msg {
+	unsigned char target;
+	unsigned int  dib;
+};
+
+struct peci_get_temp_msg {
+	unsigned char target;
+	signed short  temp_raw;
+};
+
+struct peci_rd_pkg_cfg_msg {
+	unsigned char target;
+	unsigned char index;
+	unsigned short param;
+	unsigned char rx_len;
+	unsigned char pkg_config[4];
+};
+
+struct peci_wr_pkg_cfg_msg {
+	unsigned char target;
+	unsigned char index;
+	unsigned short param;
+	unsigned char tx_len;
+	unsigned int value;
+};
+
+struct peci_rd_ia_msr_msg {
+	unsigned char target;
+	unsigned char thread_id;
+	unsigned short address;
+	unsigned long value;
+};
+
+struct peci_rd_pci_cfg_msg {
+	unsigned char target;
+	unsigned char bus;
+	unsigned char device;
+	unsigned char function;
+	unsigned short reg;
+	unsigned char pci_config[4];
+};
+
+struct peci_rd_pci_cfg_local_msg {
+	unsigned char target;
+	unsigned char bus;
+	unsigned char device;
+	unsigned char function;
+	unsigned short reg;
+	unsigned char rx_len;
+	unsigned char pci_config[4];
+};
+
+struct peci_wr_pci_cfg_local_msg {
+	unsigned char target;
+	unsigned char bus;
+	unsigned char device;
+	unsigned char function;
+	unsigned short reg;
+	unsigned char tx_len;
+	unsigned int value;
+};
+
+#define PECI_IOC_BASE  'P'
+
+#define PECI_IOC_XFER \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_XFER, 0, \
+		struct peci_xfer_msg)
+
+#define PECI_IOC_PING \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_PING, 0, \
+		struct peci_ping_msg)
+
+#define PECI_IOC_GET_DIB \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_GET_DIB, 0, \
+		struct peci_get_dib_msg)
+
+#define PECI_IOC_GET_TEMP \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_GET_TEMP, 0, \
+		struct peci_get_temp_msg)
+
+#define PECI_IOC_RD_PKG_CFG \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_RD_PKG_CFG, 0, \
+		struct peci_rd_pkg_cfg_msg)
+
+#define PECI_IOC_WR_PKG_CFG \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_WR_PKG_CFG, 0, \
+		struct peci_wr_pkg_cfg_msg)
+
+#define PECI_IOC_RD_IA_MSR \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_RD_IA_MSR, 0, \
+		struct peci_rd_ia_msr_msg)
+
+#define PECI_IOC_RD_PCI_CFG \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_RD_PCI_CFG, 0, \
+		struct peci_rd_pci_cfg_msg)
+
+#define PECI_IOC_RD_PCI_CFG_LOCAL \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_RD_PCI_CFG_LOCAL, 0, \
+		struct peci_rd_pci_cfg_local_msg)
+
+#define PECI_IOC_WR_PCI_CFG_LOCAL \
+	_IOWR(PECI_IOC_BASE + PECI_CMD_WR_PCI_CFG_LOCAL, 0, \
+		struct peci_wr_pci_cfg_local_msg)
+
+#endif /* __PECI_IOCTL_H */
-- 
2.7.4
