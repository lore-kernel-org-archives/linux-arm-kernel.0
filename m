Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C1FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1238120818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UzZnEv7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1238120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kWN3wXpZ6/sWBipAoj+Ja3Xw8eEzp4TNQeqtn7kYAWA=; b=UzZnEv7EkUdNe5
	8WMPLxGZmouHLinwde7pZD4QFZ42MkfiSAFNPwpLaHr4wJM1Sx5n3wZa/ebhfqQDssUKE5o4QfCL/
	LSi9Q3HLUBMd+KOdiP0nY+3yt5UZEESDGTMSV6hActQ6o/yoJywiRRuaWiQktVuXNquplZ0emOZE7
	GsjJV+QaCdxznf2/L6eVI94Lp2tTucOPkruU8o7+mCasV+s4DVRZgu1skYmnejyYSShD/pPA+POIY
	qcCzCsFGaPwBix517S0bQS86A0WOaGPuY72Z6TTDzEzFOsFX33HCqM/F14mg34Y6mSWLfc7co2wwc
	aOvYvDV+eSqbKCu+SvfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx75u-0005XH-Bu; Fri, 22 Feb 2019 09:26:10 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx75f-0005Gz-K4
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:25:57 +0000
X-IronPort-AV: E=Sophos;i="5.58,399,1544511600"; d="scan'208";a="27113264"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Feb 2019 02:25:53 -0700
Received: from M43218.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Fri, 22 Feb 2019 02:25:53 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/3] i2c: at91: added slave mode support
Date: Fri, 22 Feb 2019 10:25:22 +0100
Message-ID: <20190222092522.4913-4-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222092522.4913-1-ludovic.desroches@microchip.com>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_012555_769063_2454D72A 
X-CRM114-Status: GOOD (  19.54  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: alexandre.belloni@bootlin.com, wsa@the-dreams.de, me@jue.yt,
 linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Juergen Fitschen <jfi@ssv-embedded.de>

Slave mode driver is based on the concept of i2c-designware driver.

Signed-off-by: Juergen Fitschen <me@jue.yt>
[ludovic.desroches@microchip.com: rework Kconfig and replace IS_ENABLED
by defined]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/Kconfig          |  13 +++
 drivers/i2c/busses/Makefile         |   3 +
 drivers/i2c/busses/i2c-at91-core.c  |  13 ++-
 drivers/i2c/busses/i2c-at91-slave.c | 143 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h       |  30 +++++-
 5 files changed, 198 insertions(+), 4 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f2c681971201..6b1f6dcdf533 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -387,6 +387,19 @@ config I2C_AT91
 	  the latency to fill the transmission register is too long. If you
 	  are facing this situation, use the i2c-gpio driver.
 
+config I2C_AT91_SLAVE_EXPERIMENTAL
+	tristate "Microchip AT91 I2C experimental slave mode"
+	depends on I2C_AT91
+	select I2C_SLAVE
+	help
+	  If you say yes to this option, support for the slave mode will be
+	  added. Caution: do not use it for production. This feature has not
+	  been tested in a heavy way, help wanted.
+	  There are known bugs:
+	    - It can hang, on a SAMA5D4, after several transfers.
+	    - There are some mismtaches with a SAMA5D4 as slave and a SAMA5D2 as
+	    master.
+
 config I2C_AU1550
 	tristate "Au1550/Au1200/Au1300 SMBus interface"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ea75a777940e..59b22fbef90a 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -36,6 +36,9 @@ obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
 obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
 i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
+ifeq ($(CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL),y)
+	i2c-at91-objs		+= i2c-at91-slave.o
+endif
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index 6cb22341fa81..8d55cdd69ff4 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -56,8 +56,10 @@ void at91_init_twi_bus(struct at91_twi_dev *dev)
 {
 	at91_disable_twi_interrupts(dev);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
-
-	at91_init_twi_bus_master(dev);
+	if (dev->slave_detected)
+		at91_init_twi_bus_slave(dev);
+	else
+		at91_init_twi_bus_master(dev);
 }
 
 static struct at91_twi_pdata at91rm9200_config = {
@@ -239,7 +241,12 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
-	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	dev->slave_detected = i2c_detect_slave_mode(&pdev->dev);
+
+	if (dev->slave_detected)
+		rc = at91_twi_probe_slave(pdev, phy_addr, dev);
+	else
+		rc = at91_twi_probe_master(pdev, phy_addr, dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
new file mode 100644
index 000000000000..d6eeea5166c0
--- /dev/null
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
+ *
+ *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+
+#include "i2c-at91.h"
+
+static irqreturn_t atmel_twi_interrupt_slave(int irq, void *dev_id)
+{
+	struct at91_twi_dev *dev = dev_id;
+	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
+	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
+	u8 value;
+
+	if (!irqstatus)
+		return IRQ_NONE;
+
+	/* slave address has been detected on I2C bus */
+	if (irqstatus & AT91_TWI_SVACC) {
+		if (status & AT91_TWI_SVREAD) {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			writeb_relaxed(value, dev->base + AT91_TWI_THR);
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_TXRDY | AT91_TWI_EOSACC);
+		} else {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &value);
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+		}
+		at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_SVACC);
+	}
+
+	/* byte transmitted to remote master */
+	if (irqstatus & AT91_TWI_TXRDY) {
+		i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &value);
+		writeb_relaxed(value, dev->base + AT91_TWI_THR);
+	}
+
+	/* byte received from remote master */
+	if (irqstatus & AT91_TWI_RXRDY) {
+		value = readb_relaxed(dev->base + AT91_TWI_RHR);
+		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
+	}
+
+	/* master sent stop */
+	if (irqstatus & AT91_TWI_EOSACC) {
+		at91_twi_write(dev, AT91_TWI_IDR,
+			       AT91_TWI_TXRDY | AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_SVACC);
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &value);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int at91_reg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	if (dev->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	/* Make sure twi_clk doesn't get turned off! */
+	pm_runtime_get_sync(dev->dev);
+
+	dev->slave = slave;
+	dev->smr = AT91_TWI_SMR_SADR(slave->addr);
+
+	at91_init_twi_bus(dev);
+	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_SVACC);
+
+	dev_info(dev->dev, "entered slave mode (ADR=%d)\n", slave->addr);
+
+	return 0;
+}
+
+static int at91_unreg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!dev->slave);
+
+	dev_info(dev->dev, "leaving slave mode\n");
+
+	dev->slave = NULL;
+	dev->smr = 0;
+
+	at91_init_twi_bus(dev);
+
+	pm_runtime_put(dev->dev);
+
+	return 0;
+}
+
+static u32 at91_twi_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm at91_twi_algorithm_slave = {
+	.reg_slave	= at91_reg_slave,
+	.unreg_slave	= at91_unreg_slave,
+	.functionality	= at91_twi_func,
+};
+
+int at91_twi_probe_slave(struct platform_device *pdev,
+			 u32 phy_addr, struct at91_twi_dev *dev)
+{
+	int rc;
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt_slave,
+			      0, dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
+	}
+
+	dev->adapter.algo = &at91_twi_algorithm_slave;
+
+	return 0;
+}
+
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev)
+{
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSDIS);
+	if (dev->slave_detected && dev->smr) {
+		at91_twi_write(dev, AT91_TWI_SMR, dev->smr);
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVEN);
+	}
+}
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 636447498b41..be0e7afda529 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -49,6 +49,10 @@
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
 #define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
 
+#define	AT91_TWI_SMR		0x0008	/* Slave Mode Register */
+#define	AT91_TWI_SMR_SADR_MAX	0x007f
+#define	AT91_TWI_SMR_SADR(x)	(((x) & AT91_TWI_SMR_SADR_MAX) << 16)
+
 #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
 
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
@@ -59,13 +63,17 @@
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
 #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
 #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
+#define	AT91_TWI_SVACC		BIT(4)	/* Slave Access */
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
+#define	AT91_TWI_EOSACC		BIT(11)	/* End Of Slave Access */
 #define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
 
 #define	AT91_TWI_INT_MASK \
-	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
+	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
+	| AT91_TWI_SVACC | AT91_TWI_EOSACC)
 
 #define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
 #define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
@@ -133,6 +141,11 @@ struct at91_twi_dev {
 	bool recv_len_abort;
 	u32 fifo_size;
 	struct at91_twi_dma dma;
+	bool slave_detected;
+#ifdef CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL
+	unsigned smr;
+	struct i2c_client *slave;
+#endif
 };
 
 unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
@@ -145,3 +158,18 @@ void at91_init_twi_bus(struct at91_twi_dev *dev);
 void at91_init_twi_bus_master(struct at91_twi_dev *dev);
 int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
 			  struct at91_twi_dev *dev);
+
+#ifdef CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev);
+int at91_twi_probe_slave(struct platform_device *pdev, u32 phy_addr,
+			 struct at91_twi_dev *dev);
+
+#else
+static inline void at91_init_twi_bus_slave(struct at91_twi_dev *dev) {}
+static inline int at91_twi_probe_slave(struct platform_device *pdev,
+				       u32 phy_addr, struct at91_twi_dev *dev)
+{
+	return -EINVAL;
+}
+
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
