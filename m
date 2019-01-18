Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36309C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:07:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0928A20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YmSQHLDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0928A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=W88Z3yBm3Y0vGNfzWo4ZQY6ptXM4+9hrZrGJuB+6cTc=; b=YmS
	QHLDYaVRYjUJOAVQcsfFR8BEH5HfY5f+xGJlftdJ06v42tZr/wJKymIez4dLWr/Yut6664AMtcFIH
	np7bxspKP+1Z/OXV0uD3CTvQLDG6qwcIv1zAv211+98e813Rf+9X4IC7McvZBMmIH+9OQZwiIpaEA
	P/WpXGuWwjmtzuCIew3B8ecFvqXorhtijywh+v6nIF5BXuE0E4UuFaT241ize8HwdYYG9yNAZqK0h
	+DlPWX9hdbBr4jGbLX7/E22fLGvEoSuBpe8AJDuo7OBbtGeopZyUhncyt9PgORgaf+qZhP941NN5r
	Vo/SNM21YQaJ+rpe2PT5YZTJnhKIZtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkR3L-0006aT-2W; Fri, 18 Jan 2019 10:07:07 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkR3G-0006Ze-At
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:07:04 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E263A1A0289;
 Fri, 18 Jan 2019 11:06:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D32561A0286;
 Fri, 18 Jan 2019 11:06:58 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EF26205DB;
 Fri, 18 Jan 2019 11:06:58 +0100 (CET)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH] dmaengine: fsl-edma: dma map slave device address
Date: Fri, 18 Jan 2019 12:06:23 +0200
Message-Id: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_020702_704207_F24AA036 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This mapping needs to be created in order for slave dma transfers
to work on systems with SMMU. The implementation mostly mimics the
one in pl330 dma driver, authored by Robin Murphy.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
---
Original approach was to add the missing mappings in the i2c client driver,
see here for discussion: https://patchwork.ozlabs.org/patch/1026013/

 drivers/dma/fsl-edma-common.c | 66 ++++++++++++++++++++++++++++++++---
 drivers/dma/fsl-edma-common.h |  4 +++
 drivers/dma/fsl-edma.c        |  1 +
 drivers/dma/mcf-edma.c        |  1 +
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 8876c4c1bb2c..0e95ee24b6d4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -6,6 +6,7 @@
 #include <linux/dmapool.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include "fsl-edma-common.h"
 
@@ -173,12 +174,62 @@ int fsl_edma_resume(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(fsl_edma_resume);
 
+static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
+{
+	if (fsl_chan->dma_dir != DMA_NONE)
+		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
+				   fsl_chan->dma_dev_addr,
+				   fsl_chan->dma_dev_size,
+				   fsl_chan->dma_dir, 0);
+	fsl_chan->dma_dir = DMA_NONE;
+}
+
+static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
+				    enum dma_transfer_direction dir)
+{
+	struct device *dev = fsl_chan->vchan.chan.device->dev;
+	enum dma_data_direction dma_dir;
+	phys_addr_t addr = 0;
+	u32 size = 0;
+
+	switch (dir) {
+	case DMA_MEM_TO_DEV:
+		dma_dir = DMA_FROM_DEVICE;
+		addr = fsl_chan->cfg.dst_addr;
+		size = fsl_chan->cfg.dst_maxburst;
+		break;
+	case DMA_DEV_TO_MEM:
+		dma_dir = DMA_TO_DEVICE;
+		addr = fsl_chan->cfg.src_addr;
+		size = fsl_chan->cfg.src_maxburst;
+		break;
+	default:
+		dma_dir = DMA_NONE;
+		break;
+	}
+
+	/* Already mapped for this config? */
+	if (fsl_chan->dma_dir == dma_dir)
+		return true;
+
+	fsl_edma_unprep_slave_dma(fsl_chan);
+
+	fsl_chan->dma_dev_addr = dma_map_resource(dev, addr, size, dma_dir, 0);
+	if (dma_mapping_error(dev, fsl_chan->dma_dev_addr))
+		return false;
+	fsl_chan->dma_dev_size = size;
+	fsl_chan->dma_dir = dma_dir;
+
+	return true;
+}
+
 int fsl_edma_slave_config(struct dma_chan *chan,
 				 struct dma_slave_config *cfg)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
 	memcpy(&fsl_chan->cfg, cfg, sizeof(*cfg));
+	fsl_edma_unprep_slave_dma(fsl_chan);
 
 	return 0;
 }
@@ -378,6 +429,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	if (!is_slave_direction(direction))
 		return NULL;
 
+	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
+		return NULL;
+
 	sg_len = buf_len / period_len;
 	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
 	if (!fsl_desc)
@@ -409,11 +463,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = dma_buf_next;
-			dst_addr = fsl_chan->cfg.dst_addr;
+			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = 0;
 		} else {
-			src_addr = fsl_chan->cfg.src_addr;
+			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
 			soff = 0;
 			doff = fsl_chan->cfg.src_addr_width;
@@ -444,6 +498,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	if (!is_slave_direction(direction))
 		return NULL;
 
+	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
+		return NULL;
+
 	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
 	if (!fsl_desc)
 		return NULL;
@@ -468,11 +525,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = sg_dma_address(sg);
-			dst_addr = fsl_chan->cfg.dst_addr;
+			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = 0;
 		} else {
-			src_addr = fsl_chan->cfg.src_addr;
+			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = sg_dma_address(sg);
 			soff = 0;
 			doff = fsl_chan->cfg.src_addr_width;
@@ -555,6 +612,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_edma_chan_mux(fsl_chan, 0, false);
 	fsl_chan->edesc = NULL;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
+	fsl_edma_unprep_slave_dma(fsl_chan);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 8917e8865959..b435d8e1e3a1 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -6,6 +6,7 @@
 #ifndef _FSL_EDMA_COMMON_H_
 #define _FSL_EDMA_COMMON_H_
 
+#include <linux/dma-direction.h>
 #include "virt-dma.h"
 
 #define EDMA_CR_EDBG		BIT(1)
@@ -120,6 +121,9 @@ struct fsl_edma_chan {
 	struct dma_slave_config		cfg;
 	u32				attr;
 	struct dma_pool			*tcd_pool;
+	dma_addr_t			dma_dev_addr;
+	u32				dma_dev_size;
+	enum dma_data_direction		dma_dir;
 };
 
 struct fsl_edma_desc {
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 34d70112fcc9..75e8a7ba3a22 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -254,6 +254,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->slave_id = 0;
 		fsl_chan->idle = true;
+		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index 5de1b07eddff..7de54b2fafdb 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -214,6 +214,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		mcf_chan->edma = mcf_edma;
 		mcf_chan->slave_id = i;
 		mcf_chan->idle = true;
+		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
 		iowrite32(0x0, &regs->tcd[i].csr);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
