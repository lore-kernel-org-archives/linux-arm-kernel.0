Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB80721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="US4BM7gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9+uvPVPjgIHhRGGQSvhJjZPEHroaT0mvoco27JQWPfY=; b=US4BM7ggzuVPDP
	+ucAk0Qp/HaXP6ECk66h2joUI0yo2mC1l1EQitzVsbHsod+Y44zxof0yiF1A26G+pufDYT3rtW6K0
	PobUtrLYC6M3daVjC/X0RmNbJJCkg6REadcPZ4geihkEc5tIE4cjafGcmSnvYHkGTKZ/2MO9aPGDA
	1NUpNqVYBH980o25W8OR5OP+5M81/ZW5xtyCbM2lTCTvU5cCAcFN+Quofo+V6/te5Gid25JnvSq/g
	a6Vknpa2RNLF7ULNuEIiMAuDc+Hl8WjGfqLJ8BNBz4ghssExOnnWbEg0CajgwpT0x+elffwwNV/xp
	GYvJQZc8RzbY2Jrf3MVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6H4-0008GV-3r; Tue, 19 Feb 2019 14:21:30 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6H0-0008Fg-Fs
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:21:28 +0000
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.76) (envelope-from <colin.king@canonical.com>)
 id 1gw6Gu-0004nc-IN; Tue, 19 Feb 2019 14:21:20 +0000
From: Colin King <colin.king@canonical.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 "David S . Miller" <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH][next] ptp_qoriq: don't pass a large struct by value but
 instead pass it by reference
Date: Tue, 19 Feb 2019 14:21:20 +0000
Message-Id: <20190219142120.11347-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_062126_668071_70C3805B 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Passing the struct ptp_clock_info caps by parameter is passing over 130 bytes
of data by value on the stack. Optimize this by passing it by reference instead.
Also shinks the object code size:

Before:
   text	   data	    bss	    dec	    hex	filename
  12596	   2160	     64	  14820	   39e4	drivers/ptp/ptp_qoriq.o

After:
   text	   data	    bss	    dec	    hex	filename
  12567	   2160	     64	  14791	   39c7	drivers/ptp/ptp_qoriq.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 2 +-
 drivers/ptp/ptp_qoriq.c                          | 6 +++---
 include/linux/fsl/ptp_qoriq.h                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index dc2f58a7c9e5..8c1497e7d9c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -92,7 +92,7 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 
 	ptp_qoriq->dev = &pdev->dev;
 
-	err = ptp_qoriq_init(ptp_qoriq, base, enetc_ptp_caps);
+	err = ptp_qoriq_init(ptp_qoriq, base, &enetc_ptp_caps);
 	if (err)
 		goto err_no_clock;
 
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 42d3654f77f0..53775362aac6 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -459,7 +459,7 @@ static int ptp_qoriq_auto_config(struct ptp_qoriq *ptp_qoriq,
 }
 
 int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
-		   const struct ptp_clock_info caps)
+		   const struct ptp_clock_info *caps)
 {
 	struct device_node *node = ptp_qoriq->dev->of_node;
 	struct ptp_qoriq_registers *regs;
@@ -468,7 +468,7 @@ int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
 	u32 tmr_ctrl;
 
 	ptp_qoriq->base = base;
-	ptp_qoriq->caps = caps;
+	ptp_qoriq->caps = *caps;
 
 	if (of_property_read_u32(node, "fsl,cksel", &ptp_qoriq->cksel))
 		ptp_qoriq->cksel = DEFAULT_CKSEL;
@@ -605,7 +605,7 @@ static int ptp_qoriq_probe(struct platform_device *dev)
 		goto no_ioremap;
 	}
 
-	err = ptp_qoriq_init(ptp_qoriq, base, ptp_qoriq_caps);
+	err = ptp_qoriq_init(ptp_qoriq, base, &ptp_qoriq_caps);
 	if (err)
 		goto no_clock;
 
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index f127adb71041..992bf9fa1729 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -183,7 +183,7 @@ static inline void qoriq_write_le(unsigned __iomem *addr, u32 val)
 
 irqreturn_t ptp_qoriq_isr(int irq, void *priv);
 int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
-		   const struct ptp_clock_info caps);
+		   const struct ptp_clock_info *caps);
 void ptp_qoriq_free(struct ptp_qoriq *ptp_qoriq);
 int ptp_qoriq_adjfine(struct ptp_clock_info *ptp, long scaled_ppm);
 int ptp_qoriq_adjtime(struct ptp_clock_info *ptp, s64 delta);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
