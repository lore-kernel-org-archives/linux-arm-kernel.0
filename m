Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16491C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC15F21928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YCqVLQCI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ae4mWUHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC15F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MZZgjuyoxBkGaEqDNYBcWXyoNydmVZ2xdJGXAynaZd0=; b=YCqVLQCIP8D1elw1Wb09iCgrjv
	gRBg+csfZT5yadTYNuaDLHQScnPKTLCQxogY87pHUMXhp2qgqhINlKxYwjdv10GOPCs7ANcr5+fEq
	CSIpF8IUuYSTL3XXXAFCCK/Hf0lztq9KadJCaLx8ImJMBfYs7ddy8+TvKQGt6jQp3hTlmtXYDTrPJ
	Umy07f9B/7VegimOM/98UBYG0Mun601noj+LQua/qz+35V13/uyYfCuw+UyHmXVx0RK0VlLIz9P2I
	izzoMHqUyP5JJhTr4+iPJdlVtf3CywvlKjHR4Jjl8m79SqqjHUK6bN6aw11lcx+Nsnvipw+Z0WwQO
	946UU/kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLHD-00008w-Ul; Thu, 14 Feb 2019 17:58:23 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGf-0007rz-T0
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:57:56 +0000
Received: by mail-it1-x144.google.com with SMTP id l66so6389898itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3i4gUCnYFw3ZLY5kdJTtqJXFky8h7lyhLbYuAvzEmCA=;
 b=Ae4mWUHEi05pSRpGU3fhcUgaAzfaEoKO/l+a8qLzGEV29nYTXTRa/ITSPcftX1+I/J
 AFlX939TcrrK4rJy0iwKREENtXry2cvirsWwGeBWwNncjjzp8EMe9AZkISXhkDfMLbik
 N+/DqDHYFcOi6R5sS3fUE2UzCGgq+v42jYZcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3i4gUCnYFw3ZLY5kdJTtqJXFky8h7lyhLbYuAvzEmCA=;
 b=LLe++LZ2cTqejncgkIYVfoOqKooBrqgMt2N7AhmAp2yja0KXFJ53dmXI7XAqfOgIMI
 B7p80xQlcvxDzvOvcp0DbknU4jBUeETmCZoSA9VWiqRbbHk3jMi60I4GY8ennAZs+CB+
 DvM1qyw0rV0TQskQDPgidGE5J/QyJ+QwUYWcP82ovY+JdK0OmGdkL49VmcQ7oOtdd4EZ
 rgIN0ZBL8PQOTQxGZVfsv+DUKI3/OeHZsR57gIJ8qsVBI5O7HfoVc1P3/pdtIPQTeUsx
 gaIjzZe/LQCP4T0kNH1HfnQXlv4SP3loV/rzsr8JhA7oxVx9z7mOzqZG6BpoJo6YeSdT
 0lpQ==
X-Gm-Message-State: AHQUAuY2TDgx8ZAHry0bB4G7oeC2mVo9cY1JzP3hAcNT3LGIpy8kzU8E
 bMcfsdM+5cAkGS/Y5e/C5KHRxQ==
X-Google-Smtp-Source: AHgI3IYRExub64yA+DM00e6FqFSUWZR1ROsKZyJFvmmv/PhmjygONmCCyKq5BFoTIAIn371BjFPFuQ==
X-Received: by 2002:a24:8788:: with SMTP id f130mr31557ite.90.1550167069005;
 Thu, 14 Feb 2019 09:57:49 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:57:48 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 2/8] i2c: iproc: Add slave mode support
Date: Thu, 14 Feb 2019 09:57:19 -0800
Message-Id: <20190214175725.60462-3-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095750_350309_64E1530E 
X-CRM114-Status: GOOD (  22.67  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org,
 Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 Michael Cheng <ccheng@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>

Add slave mode support to the iProc I2C driver.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Michael Cheng <ccheng@broadcom.com>
Signed-off-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/Kconfig         |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c | 314 ++++++++++++++++++++++++++++-
 2 files changed, 309 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f2c681971201..e0798b82b3bc 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -424,6 +424,7 @@ config I2C_BCM_IPROC
 	tristate "Broadcom iProc I2C controller"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	default ARCH_BCM_IPROC
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  Broadcom iProc I2C controller.
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index eb7339a0280e..775b3d89a9c4 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -23,11 +23,30 @@
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
+#define CFG_SLAVE_ADDR_0_SHIFT       28
 #define CFG_M_RETRY_CNT_SHIFT        16
 #define CFG_M_RETRY_CNT_MASK         0x0f
 
 #define TIM_CFG_OFFSET               0x04
 #define TIM_CFG_MODE_400_SHIFT       31
+#define TIM_RAND_SLAVE_STRETCH_SHIFT      24
+#define TIM_RAND_SLAVE_STRETCH_MASK       0x7f
+#define TIM_PERIODIC_SLAVE_STRETCH_SHIFT  16
+#define TIM_PERIODIC_SLAVE_STRETCH_MASK   0x7f
+
+#define S_CFG_SMBUS_ADDR_OFFSET           0x08
+#define S_CFG_EN_NIC_SMB_ADDR3_SHIFT      31
+#define S_CFG_NIC_SMB_ADDR3_SHIFT         24
+#define S_CFG_NIC_SMB_ADDR3_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR2_SHIFT      23
+#define S_CFG_NIC_SMB_ADDR2_SHIFT         16
+#define S_CFG_NIC_SMB_ADDR2_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR1_SHIFT      15
+#define S_CFG_NIC_SMB_ADDR1_SHIFT         8
+#define S_CFG_NIC_SMB_ADDR1_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR0_SHIFT      7
+#define S_CFG_NIC_SMB_ADDR0_SHIFT         0
+#define S_CFG_NIC_SMB_ADDR0_MASK          0x7f
 
 #define M_FIFO_CTRL_OFFSET           0x0c
 #define M_FIFO_RX_FLUSH_SHIFT        31
@@ -37,6 +56,14 @@
 #define M_FIFO_RX_THLD_SHIFT         8
 #define M_FIFO_RX_THLD_MASK          0x3f
 
+#define S_FIFO_CTRL_OFFSET           0x10
+#define S_FIFO_RX_FLUSH_SHIFT        31
+#define S_FIFO_TX_FLUSH_SHIFT        30
+#define S_FIFO_RX_CNT_SHIFT          16
+#define S_FIFO_RX_CNT_MASK           0x7f
+#define S_FIFO_RX_THLD_SHIFT         8
+#define S_FIFO_RX_THLD_MASK          0x3f
+
 #define M_CMD_OFFSET                 0x30
 #define M_CMD_START_BUSY_SHIFT       31
 #define M_CMD_STATUS_SHIFT           25
@@ -46,6 +73,8 @@
 #define M_CMD_STATUS_NACK_ADDR       0x2
 #define M_CMD_STATUS_NACK_DATA       0x3
 #define M_CMD_STATUS_TIMEOUT         0x4
+#define M_CMD_STATUS_FIFO_UNDERRUN   0x5
+#define M_CMD_STATUS_RX_FIFO_FULL    0x6
 #define M_CMD_PROTOCOL_SHIFT         9
 #define M_CMD_PROTOCOL_MASK          0xf
 #define M_CMD_PROTOCOL_BLK_WR        0x7
@@ -54,17 +83,36 @@
 #define M_CMD_RD_CNT_SHIFT           0
 #define M_CMD_RD_CNT_MASK            0xff
 
+#define S_CMD_OFFSET                 0x34
+#define S_CMD_START_BUSY_SHIFT       31
+#define S_CMD_STATUS_SHIFT           23
+#define S_CMD_STATUS_MASK            0x07
+#define S_CMD_STATUS_SUCCESS         0x0
+#define S_CMD_STATUS_TIMEOUT         0x5
+
 #define IE_OFFSET                    0x38
 #define IE_M_RX_FIFO_FULL_SHIFT      31
 #define IE_M_RX_THLD_SHIFT           30
 #define IE_M_START_BUSY_SHIFT        28
 #define IE_M_TX_UNDERRUN_SHIFT       27
+#define IE_S_RX_FIFO_FULL_SHIFT      26
+#define IE_S_RX_THLD_SHIFT           25
+#define IE_S_RX_EVENT_SHIFT          24
+#define IE_S_START_BUSY_SHIFT        23
+#define IE_S_TX_UNDERRUN_SHIFT       22
+#define IE_S_RD_EVENT_SHIFT          21
 
 #define IS_OFFSET                    0x3c
 #define IS_M_RX_FIFO_FULL_SHIFT      31
 #define IS_M_RX_THLD_SHIFT           30
 #define IS_M_START_BUSY_SHIFT        28
 #define IS_M_TX_UNDERRUN_SHIFT       27
+#define IS_S_RX_FIFO_FULL_SHIFT      26
+#define IS_S_RX_THLD_SHIFT           25
+#define IS_S_RX_EVENT_SHIFT          24
+#define IS_S_START_BUSY_SHIFT        23
+#define IS_S_TX_UNDERRUN_SHIFT       22
+#define IS_S_RD_EVENT_SHIFT          21
 
 #define M_TX_OFFSET                  0x40
 #define M_TX_WR_STATUS_SHIFT         31
@@ -78,6 +126,18 @@
 #define M_RX_DATA_SHIFT              0
 #define M_RX_DATA_MASK               0xff
 
+#define S_TX_OFFSET                  0x48
+#define S_TX_WR_STATUS_SHIFT         31
+#define S_TX_DATA_SHIFT              0
+#define S_TX_DATA_MASK               0xff
+
+#define S_RX_OFFSET                  0x4c
+#define S_RX_STATUS_SHIFT            30
+#define S_RX_STATUS_MASK             0x03
+#define S_RX_PEC_ERR_SHIFT           29
+#define S_RX_DATA_SHIFT              0
+#define S_RX_DATA_MASK               0xff
+
 #define I2C_TIMEOUT_MSEC             50000
 #define M_TX_RX_FIFO_SIZE            64
 #define M_RX_FIFO_MAX_THLD_VALUE     (M_TX_RX_FIFO_SIZE - 1)
@@ -85,6 +145,30 @@
 #define M_RX_MAX_READ_LEN            255
 #define M_RX_FIFO_THLD_VALUE         50
 
+#define IE_M_ALL_INTERRUPT_SHIFT     27
+#define IE_M_ALL_INTERRUPT_MASK      0x1e
+
+#define SLAVE_READ_WRITE_BIT_MASK    0x1
+#define SLAVE_READ_WRITE_BIT_SHIFT   0x1
+#define SLAVE_MAX_SIZE_TRANSACTION   64
+#define SLAVE_CLOCK_STRETCH_TIME     25
+
+#define IE_S_ALL_INTERRUPT_SHIFT     21
+#define IE_S_ALL_INTERRUPT_MASK      0x3f
+
+enum i2c_slave_read_status {
+	I2C_SLAVE_RX_FIFO_EMPTY = 0,
+	I2C_SLAVE_RX_START,
+	I2C_SLAVE_RX_DATA,
+	I2C_SLAVE_RX_END,
+};
+
+enum i2c_slave_xfer_dir {
+	I2C_SLAVE_DIR_READ = 0,
+	I2C_SLAVE_DIR_WRITE,
+	I2C_SLAVE_DIR_NONE,
+};
+
 enum bus_speed_index {
 	I2C_SPD_100K = 0,
 	I2C_SPD_400K,
@@ -104,6 +188,9 @@ struct bcm_iproc_i2c_dev {
 
 	struct i2c_msg *msg;
 
+	struct i2c_client *slave;
+	enum i2c_slave_xfer_dir xfer_dir;
+
 	/* bytes that have been transferred */
 	unsigned int tx_bytes;
 	/* bytes that have been read */
@@ -117,6 +204,156 @@ struct bcm_iproc_i2c_dev {
 #define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
 		| BIT(IS_M_RX_THLD_SHIFT))
 
+#define ISR_MASK_SLAVE (BIT(IS_S_START_BUSY_SHIFT)\
+		| BIT(IS_S_RX_EVENT_SHIFT) | BIT(IS_S_RD_EVENT_SHIFT))
+
+static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave);
+static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave);
+static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
+					 bool enable);
+
+static void bcm_iproc_i2c_slave_init(
+	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
+{
+	u32 val;
+
+	if (need_reset) {
+		/* put controller in reset */
+		val = readl(iproc_i2c->base + CFG_OFFSET);
+		val |= BIT(CFG_RESET_SHIFT);
+		writel(val, iproc_i2c->base + CFG_OFFSET);
+
+		/* wait 100 usec per spec */
+		udelay(100);
+
+		/* bring controller out of reset */
+		val &= ~(BIT(CFG_RESET_SHIFT));
+		writel(val, iproc_i2c->base + CFG_OFFSET);
+	}
+
+	/* flush TX/RX FIFOs */
+	val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
+	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
+
+	/* RANDOM SLAVE STRETCH time - 20ms*/
+	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val &= ~(TIM_RAND_SLAVE_STRETCH_MASK << TIM_RAND_SLAVE_STRETCH_SHIFT);
+	val |= (SLAVE_CLOCK_STRETCH_TIME << TIM_RAND_SLAVE_STRETCH_SHIFT);
+	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+
+	/* Configure the slave address */
+	val = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	val |= BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
+	val &= ~(S_CFG_NIC_SMB_ADDR3_MASK << S_CFG_NIC_SMB_ADDR3_SHIFT);
+	val |= (iproc_i2c->slave->addr << S_CFG_NIC_SMB_ADDR3_SHIFT);
+	writel(val, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+
+	/* clear all pending slave interrupts */
+	writel(ISR_MASK_SLAVE, iproc_i2c->base + IS_OFFSET);
+
+	/* Enable interrupt register for any READ event */
+	val = BIT(IE_S_RD_EVENT_SHIFT);
+	/* Enable interrupt register to indicate a valid byte in receive fifo */
+	val |= BIT(IE_S_RX_EVENT_SHIFT);
+	/* Enable interrupt register for the Slave BUSY command */
+	val |= BIT(IE_S_START_BUSY_SHIFT);
+	writel(val, iproc_i2c->base + IE_OFFSET);
+
+	iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+}
+
+static void bcm_iproc_i2c_check_slave_status(
+	struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	u32 val;
+
+	val = readl(iproc_i2c->base + S_CMD_OFFSET);
+	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
+
+	if (val == S_CMD_STATUS_TIMEOUT) {
+		dev_err(iproc_i2c->device, "slave random stretch time timeout\n");
+
+		/* re-initialize i2c for recovery */
+		bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+		bcm_iproc_i2c_slave_init(iproc_i2c, true);
+		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+	}
+}
+
+static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
+				u32 status)
+{
+	u8 value;
+	u32 val;
+	u32 rd_status;
+	u32 tmp;
+
+	/* Start of transaction. check address and populate the direction */
+	if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_NONE) {
+		tmp = readl(iproc_i2c->base + S_RX_OFFSET);
+		rd_status = (tmp >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
+		/* This condition checks whether the request is a new request */
+		if (((rd_status == I2C_SLAVE_RX_START) &&
+			(status & BIT(IS_S_RX_EVENT_SHIFT))) ||
+			((rd_status == I2C_SLAVE_RX_END) &&
+			(status & BIT(IS_S_RD_EVENT_SHIFT)))) {
+
+			/* Last bit is W/R bit.
+			 * If 1 then its a read request(by master).
+			 */
+			iproc_i2c->xfer_dir = tmp & SLAVE_READ_WRITE_BIT_MASK;
+			if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)
+				i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			else
+				i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &value);
+		}
+	}
+
+	/* read request from master */
+	if ((status & BIT(IS_S_RD_EVENT_SHIFT)) &&
+		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)) {
+		i2c_slave_event(iproc_i2c->slave,
+			I2C_SLAVE_READ_PROCESSED, &value);
+		writel(value, iproc_i2c->base + S_TX_OFFSET);
+
+		val = BIT(S_CMD_START_BUSY_SHIFT);
+		writel(val, iproc_i2c->base + S_CMD_OFFSET);
+	}
+
+	/* write request from master */
+	if ((status & BIT(IS_S_RX_EVENT_SHIFT)) &&
+		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_READ)) {
+		val = readl(iproc_i2c->base + S_RX_OFFSET);
+		/* Its a write request by Master to Slave.
+		 * We read data present in receive FIFO
+		 */
+		value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
+		i2c_slave_event(iproc_i2c->slave,
+			I2C_SLAVE_WRITE_RECEIVED, &value);
+
+		/* check the status for the last byte of the transaction */
+		rd_status = (val >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
+		if (rd_status == I2C_SLAVE_RX_END)
+			iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+
+		dev_dbg(iproc_i2c->device, "\nread value = 0x%x\n", value);
+	}
+
+	/* Stop */
+	if (status & BIT(IS_S_START_BUSY_SHIFT)) {
+		i2c_slave_event(iproc_i2c->slave, I2C_SLAVE_STOP, &value);
+		iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+	}
+
+	/* clear interrupt status */
+	writel(status, iproc_i2c->base + IS_OFFSET);
+
+	bcm_iproc_i2c_check_slave_status(iproc_i2c);
+	return true;
+}
+
 static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	struct i2c_msg *msg = iproc_i2c->msg;
@@ -142,6 +379,18 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 	u32 status = readl(iproc_i2c->base + IS_OFFSET);
 	u32 tmp;
 
+
+	bool ret;
+	u32 sl_status = status & ISR_MASK_SLAVE;
+
+	if (sl_status) {
+		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
+		if (ret)
+			return IRQ_HANDLED;
+		else
+			return IRQ_NONE;
+	}
+
 	status &= ISR_MASK;
 
 	if (!status)
@@ -224,22 +473,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
 
 	/* put controller in reset */
 	val = readl(iproc_i2c->base + CFG_OFFSET);
-	val |= 1 << CFG_RESET_SHIFT;
-	val &= ~(1 << CFG_EN_SHIFT);
+	val |= BIT(CFG_RESET_SHIFT);
+	val &= ~(BIT(CFG_EN_SHIFT));
 	writel(val, iproc_i2c->base + CFG_OFFSET);
 
 	/* wait 100 usec per spec */
 	udelay(100);
 
 	/* bring controller out of reset */
-	val &= ~(1 << CFG_RESET_SHIFT);
+	val &= ~(BIT(CFG_RESET_SHIFT));
 	writel(val, iproc_i2c->base + CFG_OFFSET);
 
 	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
-	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
+	val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
 	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
 	/* disable all interrupts */
-	writel(0, iproc_i2c->base + IE_OFFSET);
+	val = readl(iproc_i2c->base + IE_OFFSET);
+	val &= ~(IE_M_ALL_INTERRUPT_MASK <<
+			IE_M_ALL_INTERRUPT_SHIFT);
+	writel(val, iproc_i2c->base + IE_OFFSET);
 
 	/* clear all pending interrupts */
 	writel(0xffffffff, iproc_i2c->base + IS_OFFSET);
@@ -288,6 +540,14 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 		dev_dbg(iproc_i2c->device, "bus timeout\n");
 		return -ETIMEDOUT;
 
+	case M_CMD_STATUS_FIFO_UNDERRUN:
+		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
+		return -ENXIO;
+
+	case M_CMD_STATUS_RX_FIFO_FULL:
+		dev_dbg(iproc_i2c->device, "Master Rx FIFO full > 10ms\n");
+		return -ETIMEDOUT;
+
 	default:
 		dev_dbg(iproc_i2c->device, "unknown error code=%d\n", val);
 
@@ -442,12 +702,14 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
 }
 
 static const struct i2c_algorithm bcm_iproc_algo = {
 	.master_xfer = bcm_iproc_i2c_xfer,
 	.functionality = bcm_iproc_i2c_functionality,
+	.reg_slave = bcm_iproc_i2c_reg_slave,
+	.unreg_slave = bcm_iproc_i2c_unreg_slave,
 };
 
 static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
@@ -612,6 +874,46 @@ static const struct dev_pm_ops bcm_iproc_i2c_pm_ops = {
 #define BCM_IPROC_I2C_PM_OPS NULL
 #endif /* CONFIG_PM_SLEEP */
 
+
+static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(slave->adapter);
+
+	if (iproc_i2c->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	iproc_i2c->slave = slave;
+	bcm_iproc_i2c_slave_init(iproc_i2c, false);
+	return 0;
+}
+
+static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
+{
+	u32 tmp;
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(slave->adapter);
+
+	if (!iproc_i2c->slave)
+		return -EINVAL;
+
+	iproc_i2c->slave = NULL;
+
+	/* disable all slave interrupts */
+	tmp = readl(iproc_i2c->base + IE_OFFSET);
+	tmp &= ~(IE_S_ALL_INTERRUPT_MASK <<
+			IE_S_ALL_INTERRUPT_SHIFT);
+	writel(tmp, iproc_i2c->base + IE_OFFSET);
+
+	/* Erase the slave address programmed */
+	tmp = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	tmp &= ~BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
+	writel(tmp, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+
+	return 0;
+}
+
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
 	{ .compatible = "brcm,iproc-i2c" },
 	{ /* sentinel */ }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
