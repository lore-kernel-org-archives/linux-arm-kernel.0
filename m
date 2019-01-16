Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6188820651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBrz/lyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6188820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dEcyzj9hhxYJt/RbkAn/gux7KL7cF6lnwZHpA7M4oSI=; b=pBrz/lyuwXKVzC
	hhEik99cITmI/+ju4gg6oUd5bGc3TBFlFeCkGUwPe5qEjXaQuMla5YnR/4YAe1IlBu0C3RnYoUC/5
	6rjnVX1QmuLAF5zTwiZA7Dwsd89QBl9UhF0AVLT2nwNUcZAXQjmzsowIVLn9X8dttwI8HXAouO+ef
	ZfVOp2XS/4UL1GCd3dOXa051iudBiWvwPDDz6RV90VfKu9w7fikFqspuNkEIwrBMnuwKe7rAWc6XW
	aOqE91O/z92VlkbHg0Yq/vXqrQEmzmydSkX4VSb0e/5pTeTBmNMmPdWL1mhtrtwam5UnCnd/tFhA1
	1dPKESiTL2mA1hFK6P9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjaBJ-0007m9-Pz; Wed, 16 Jan 2019 01:39:49 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjaB8-0007dP-AV; Wed, 16 Jan 2019 01:39:40 +0000
X-UUID: 75ceac8bc93b4781b02952a39e9d59d3-20190115
X-UUID: 75ceac8bc93b4781b02952a39e9d59d3-20190115
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 467075706; Tue, 15 Jan 2019 17:39:32 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 17:39:30 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 09:39:28 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 09:39:28 +0800
From: CK Hu <ck.hu@mediatek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?q?Noralf=20Tr=F8nnes?= <noralf@tronnes.org>, Frank Wunderlich
 <frank-w@public-files.de>
Subject: [PATCH 1/2] drm/mediatek: Implement gem prime vmap/vunmap function
Date: Wed, 16 Jan 2019 09:39:23 +0800
Message-ID: <20190116013924.11345-1-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_173938_371124_3FCA17A7 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For some application which need kernel virtual address, such as fbcon,
implement these function to map/unmap kernel virtual address of prime
buffer.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 46 ++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_gem.h |  3 ++
 3 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6422e99952fe..6ec4ca070382 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -341,6 +341,8 @@ static struct drm_driver mtk_drm_driver = {
 	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
 	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
+	.gem_prime_vmap = mtk_drm_gem_prime_vmap,
+	.gem_prime_vunmap = mtk_drm_gem_prime_vunmap,
 	.fops = &mtk_drm_fops,
 
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 259b7b0de1d2..38483e9ee071 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -241,3 +241,49 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 	kfree(mtk_gem);
 	return ERR_PTR(ret);
 }
+
+void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
+	struct sg_table *sgt;
+	struct sg_page_iter iter;
+	unsigned int npages;
+	unsigned int i = 0;
+
+	if (mtk_gem->kvaddr)
+		return mtk_gem->kvaddr;
+
+	sgt = mtk_gem_prime_get_sg_table(obj);
+	if (IS_ERR(sgt))
+		return NULL;
+
+	npages = obj->size >> PAGE_SHIFT;
+	mtk_gem->pages = kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
+	if (!mtk_gem->pages)
+		goto out;
+
+	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
+		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
+		if (i > npages)
+			break;
+	}
+	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
+			       pgprot_writecombine(PAGE_KERNEL));
+
+out:
+	kfree((void *)sgt);
+
+	return mtk_gem->kvaddr;
+}
+
+void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
+
+	if (!mtk_gem->pages)
+		return;
+
+	vunmap(vaddr);
+	mtk_gem->kvaddr = 0;
+	kfree((void *)mtk_gem->pages);
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
index 534639b43a1c..c047a7ef294f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
@@ -37,6 +37,7 @@ struct mtk_drm_gem_obj {
 	dma_addr_t		dma_addr;
 	unsigned long		dma_attrs;
 	struct sg_table		*sg;
+	struct page		**pages;
 };
 
 #define to_mtk_gem_obj(x)	container_of(x, struct mtk_drm_gem_obj, base)
@@ -52,5 +53,7 @@ int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj,
 struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 			struct dma_buf_attachment *attach, struct sg_table *sg);
+void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj);
+void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
 #endif
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
