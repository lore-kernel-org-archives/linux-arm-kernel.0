Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1BC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898CC20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XykpOAZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898CC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=h5kT0ZCoIEDHNb9EIhKvjncc+9RkR2Flvq4t4yXqJ3o=; b=XykpOAZL5r8yZZsAG3kTZe77yt
	dALNbg7YVLi3EDN/4DIzmoDqQOYVbBwRZuGXBUiEz6WET5+bMMHLXAkp1p2R9Shlt5EUsGhIpsp7s
	DtfEiuz4XsAAJjyjDkgEKpAWt4q81AV/IaqVdh3wW0GDjBVrpiSF92j2bKwinMlKM9wKKD9QkOmTT
	or3MRPGxmLwx23GS2r5mXirVPOMNS6fhRbGIqXEQsHWDGy6pQFf+J5lcoI3FBv4a/L3yvgFgVl1yy
	BM/bMW2ExZQ1mDLUFJVGs9Dlp/HYv4psutyC+9fvSQdZIX7O1INpiju3NP9rtsoqABbwa8LDvkroT
	1Hz8o15A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX8M-0002XA-Ng; Mon, 21 Jan 2019 10:48:50 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX72-000185-9P
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:47:38 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FEBB1A0144;
 Mon, 21 Jan 2019 11:47:27 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EAA591A012F;
 Mon, 21 Jan 2019 11:47:22 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9519040313;
 Mon, 21 Jan 2019 18:47:14 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v3, 5/6] ptp: add debugfs support for ptp_qoriq
Date: Mon, 21 Jan 2019 18:41:42 +0800
Message-Id: <20190121104143.46782-6-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121104143.46782-1-yangbo.lu@nxp.com>
References: <20190121104143.46782-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024729_312178_F00695EA 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Yangbo Lu <yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch is to add debugfs support for ptp_qoriq. Current debugfs
supports to control fiper1/fiper2 loopback mode. If the loopback mode
is enabled, the fiper1/fiper2 pulse is looped back into trigger1/
trigger2 input. This is very useful for validating hardware and driver
without external hardware. Below is an example to enable fiper1 loopback.

echo 1 > /sys/kernel/debug/2d10e00.ptp_clock/fiper1-loopback

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- Converted to use debugfs.
---
 drivers/ptp/Kconfig             |    2 +-
 drivers/ptp/Makefile            |    4 +-
 drivers/ptp/ptp_qoriq.c         |    3 +
 drivers/ptp/ptp_qoriq_debugfs.c |  101 +++++++++++++++++++++++++++++++++++++++
 include/linux/fsl/ptp_qoriq.h   |   12 +++++
 5 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ptp/ptp_qoriq_debugfs.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index d137c48..aeb4a8b 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -53,7 +53,7 @@ config PTP_1588_CLOCK_QORIQ
 	  packets using the SO_TIMESTAMPING API.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_qoriq.
+	  will be called ptp-qoriq.
 
 config PTP_1588_CLOCK_IXP46X
 	tristate "Intel IXP46x as PTP clock"
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 19efa9c..677d1d1 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -9,4 +9,6 @@ obj-$(CONFIG_PTP_1588_CLOCK_DTE)	+= ptp_dte.o
 obj-$(CONFIG_PTP_1588_CLOCK_IXP46X)	+= ptp_ixp46x.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
 obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
-obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
+obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp-qoriq.o
+ptp-qoriq-y				+= ptp_qoriq.o
+ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index a2e7702..43416b2 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -471,6 +471,7 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 
 	err = -EINVAL;
 
+	qoriq_ptp->dev = &dev->dev;
 	qoriq_ptp->caps = ptp_qoriq_caps;
 
 	if (of_property_read_u32(node, "fsl,cksel", &qoriq_ptp->cksel))
@@ -572,6 +573,7 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 	}
 	qoriq_ptp->phc_index = ptp_clock_index(qoriq_ptp->clock);
 
+	ptp_qoriq_create_debugfs(qoriq_ptp);
 	platform_set_drvdata(dev, qoriq_ptp);
 
 	return 0;
@@ -597,6 +599,7 @@ static int qoriq_ptp_remove(struct platform_device *dev)
 	qoriq_write(&regs->ctrl_regs->tmr_temask, 0);
 	qoriq_write(&regs->ctrl_regs->tmr_ctrl,   0);
 
+	ptp_qoriq_remove_debugfs(qoriq_ptp);
 	ptp_clock_unregister(qoriq_ptp->clock);
 	iounmap(qoriq_ptp->base);
 	release_resource(qoriq_ptp->rsrc);
diff --git a/drivers/ptp/ptp_qoriq_debugfs.c b/drivers/ptp/ptp_qoriq_debugfs.c
new file mode 100644
index 0000000..d904332
--- /dev/null
+++ b/drivers/ptp/ptp_qoriq_debugfs.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2019 NXP
+ */
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/fsl/ptp_qoriq.h>
+
+static int ptp_qoriq_fiper1_lpbk_get(void *data, u64 *val)
+{
+	struct qoriq_ptp *qoriq_ptp = data;
+	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
+	u32 ctrl;
+
+	ctrl = qoriq_read(&regs->ctrl_regs->tmr_ctrl);
+	*val = ctrl & PP1L ? 1 : 0;
+
+	return 0;
+}
+
+static int ptp_qoriq_fiper1_lpbk_set(void *data, u64 val)
+{
+	struct qoriq_ptp *qoriq_ptp = data;
+	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
+	u32 ctrl;
+
+	ctrl = qoriq_read(&regs->ctrl_regs->tmr_ctrl);
+	if (val == 0)
+		ctrl &= ~PP1L;
+	else
+		ctrl |= PP1L;
+
+	qoriq_write(&regs->ctrl_regs->tmr_ctrl, ctrl);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ptp_qoriq_fiper1_fops, ptp_qoriq_fiper1_lpbk_get,
+			ptp_qoriq_fiper1_lpbk_set, "%llu\n");
+
+static int ptp_qoriq_fiper2_lpbk_get(void *data, u64 *val)
+{
+	struct qoriq_ptp *qoriq_ptp = data;
+	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
+	u32 ctrl;
+
+	ctrl = qoriq_read(&regs->ctrl_regs->tmr_ctrl);
+	*val = ctrl & PP2L ? 1 : 0;
+
+	return 0;
+}
+
+static int ptp_qoriq_fiper2_lpbk_set(void *data, u64 val)
+{
+	struct qoriq_ptp *qoriq_ptp = data;
+	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
+	u32 ctrl;
+
+	ctrl = qoriq_read(&regs->ctrl_regs->tmr_ctrl);
+	if (val == 0)
+		ctrl &= ~PP2L;
+	else
+		ctrl |= PP2L;
+
+	qoriq_write(&regs->ctrl_regs->tmr_ctrl, ctrl);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ptp_qoriq_fiper2_fops, ptp_qoriq_fiper2_lpbk_get,
+			ptp_qoriq_fiper2_lpbk_set, "%llu\n");
+
+void ptp_qoriq_create_debugfs(struct qoriq_ptp *qoriq_ptp)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(dev_name(qoriq_ptp->dev), NULL);
+	if (IS_ERR(root))
+		return;
+	if (!root)
+		goto err_root;
+
+	qoriq_ptp->debugfs_root = root;
+
+	if (!debugfs_create_file("fiper1-loopback", 0600, root, qoriq_ptp,
+				 &ptp_qoriq_fiper1_fops))
+		goto err_node;
+	if (!debugfs_create_file("fiper2-loopback", 0600, root, qoriq_ptp,
+				 &ptp_qoriq_fiper2_fops))
+		goto err_node;
+	return;
+
+err_node:
+	debugfs_remove_recursive(root);
+	qoriq_ptp->debugfs_root = NULL;
+err_root:
+	dev_err(qoriq_ptp->dev, "failed to initialize debugfs\n");
+}
+
+void ptp_qoriq_remove_debugfs(struct qoriq_ptp *qoriq_ptp)
+{
+	debugfs_remove_recursive(qoriq_ptp->debugfs_root);
+	qoriq_ptp->debugfs_root = NULL;
+}
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index 43b4b44..94e9797 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -143,6 +143,8 @@ struct qoriq_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	struct resource *rsrc;
+	struct dentry *debugfs_root;
+	struct device *dev;
 	bool extts_fifo_support;
 	int irq;
 	int phc_index;
@@ -169,4 +171,14 @@ static inline void qoriq_write(unsigned __iomem *addr, u32 val)
 	iowrite32be(val, addr);
 }
 
+#ifdef CONFIG_DEBUG_FS
+void ptp_qoriq_create_debugfs(struct qoriq_ptp *qoriq_ptp);
+void ptp_qoriq_remove_debugfs(struct qoriq_ptp *qoriq_ptp);
+#else
+static inline void ptp_qoriq_create_debugfs(struct qoriq_ptp *qoriq_ptp)
+{ }
+static inline void ptp_qoriq_remove_debugfs(struct qoriq_ptp *qoriq_ptp)
+{ }
+#endif
+
 #endif
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
