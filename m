Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD99C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE8820656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpRcxOkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE8820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fhJQUSNkEMvz/kNBt0XEb60OkZPInueC5lyoTZfDUfo=; b=mpRcxOkMXPNFiX
	G/lPZbVSoudE3msDMuezvdXcIcXNhfEErQq1snNmwZT15wRh2Dv99e57IJXns1Xk3O6Gg+aKK+BBG
	PJYg+PajquanFLDta6KdnpYDE9Kqh5HAxu+IoFvrZaALDojr1z7+dxACBXTYb1M3ZDbXQxwYnlhXj
	coU6wyfaFtocp3AikmGg+d055BaX6hOaecsPrX8tKjA8PL4v9aHk/xbLtwi0jHAbMH1+MQ/WIgANc
	BYG9B4tNTbyxo8toFJmausB7xZ3Cg9v/qT3ZZt5lPpA5vbi8PHEhO96SJplGmyRG2abg3L9BGEuNF
	cORlMKhJ37rXaehsWw1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyuL-000861-QP; Mon, 14 Jan 2019 09:51:49 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyuI-00085S-8e
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 09:51:48 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5591E36D9C69F6C8E802;
 Mon, 14 Jan 2019 17:51:38 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Mon, 14 Jan 2019 17:51:29 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
Date: Mon, 14 Jan 2019 09:50:19 +0000
Message-ID: <20190114095019.12336-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_015146_474869_BD7901FC 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: gkulkarni@marvell.com, suzuki.poulose@arm.com, john.garry@huawei.com,
 linuxarm@huawei.com, Robert.Richter@cavium.com, shankerd@codeaurora.org,
 guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

The NUMA node information is visible to ITS driver but not being used
other than handling hardware errata. ITS/GICR hardware accesses to the
local NUMA node is usually quicker than the remote NUMA node. How slow
the remote NUMA accesses are depends on the implementation details.

This patch allocates memory for ITS management tables and command
queue from the corresponding NUMA node using the appropriate NUMA
aware functions. This change improves the performance of the ITS
tables read latency on systems where it has more than one ITS block,
and with the slower inter node accesses.

Apache Web server benchmarking using ab tool on a HiSilicon D06
board with multiple numa mem nodes shows Time per request and
Transfer rate improvements of ~3.6% with this patch.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
---

This is to revive the patch originally sent by Shanker[1] and 
to back it up with a benchmark test. Any further testing of
this is most welcome.

v3-->v4
-Addressed comments on alloc_pages_node() and page_address() usage.
-Rebased on 5.0-rc1
-Added Ganapatrao's R-by.

v2-->v3
 -Addressed comments to use page_address().
 -Added Benchmark results to commit log.
 -Removed T-by from Ganapatrao for now.

v1-->v2
 -Edited commit text.
 -Added Ganapatrao's tested-by.

Benchmark test details:
--------------------------------
Test Setup:
-D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
-ITS belongs to numa node 0.
-Filesystem mounted on a PCIe NVMe based disk.
-Apache server installed on D06.
-Running ab benchmark test in concurrency mode from a remote m/c
 connected to D06 via  hns3(PCIe) n/w port.
 "ab -k -c 750 -n 2000000 http://10.202.225.188/"

Test results are avg. of 15 runs.

For 4.20-rc1  Kernel,
----------------------------
Time per request(mean, concurrent)  = 0.02753[ms]  
Transfer Rate = 416501[Kbytes/sec]

For 4.20-rc1 +  this patch,
----------------------------------
Time per request(mean, concurrent)  = 0.02653[ms]  
Transfer Rate = 431954[Kbytes/sec]

% improvement ~3.6%

vmstat shows around 170K-200K interrupts per second.

~# vmstat 1 -w
procs -----------------------memory-- -  -system--
 r  b         swpd         free            in             
 5  0            0     30166724          102794 
 9  0            0     30141828          171148 
 5  0            0     30150160          207185 
13  0            0     30145924          175691 
15  0            0     30140792          145250 
13  0            0     30135556          201879 
13  0            0     30134864          192391 
10  0            0     30133632          168880 
....

[1] https://patchwork.kernel.org/patch/9833339/

 drivers/irqchip/irq-gic-v3-its.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..5df59ad 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1737,6 +1737,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 type = GITS_BASER_TYPE(val);
 	u64 baser_phys, tmp;
 	u32 alloc_pages;
+	struct page *page;
 	void *base;
 
 retry_alloc_baser:
@@ -1749,10 +1750,11 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!base)
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
 		return -ENOMEM;
 
+	base = (void *)page_address(page);
 	baser_phys = virt_to_phys(base);
 
 	/* Check if the physical address of the memory is above 48bits */
@@ -2236,7 +2238,8 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
-static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
+static bool its_alloc_table_entry(struct its_node *its,
+				  struct its_baser *baser, u32 id)
 {
 	struct page *page;
 	u32 esz, idx;
@@ -2256,7 +2259,8 @@ static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
 
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(baser->psz));
+		page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+					get_order(baser->psz));
 		if (!page)
 			return false;
 
@@ -2287,7 +2291,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 	if (!baser)
 		return (ilog2(dev_id) < its->device_ids);
 
-	return its_alloc_table_entry(baser, dev_id);
+	return its_alloc_table_entry(its, baser, dev_id);
 }
 
 static bool its_alloc_vpe_table(u32 vpe_id)
@@ -2311,7 +2315,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 		if (!baser)
 			return false;
 
-		if (!its_alloc_table_entry(baser, vpe_id))
+		if (!its_alloc_table_entry(its, baser, vpe_id))
 			return false;
 	}
 
@@ -2345,7 +2349,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kzalloc(sz, GFP_KERNEL);
+	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
@@ -3486,6 +3490,7 @@ static int __init its_probe_one(struct resource *res,
 	void __iomem *its_base;
 	u32 val, ctlr;
 	u64 baser, tmp, typer;
+	struct page *page;
 	int err;
 
 	its_base = ioremap(res->start, resource_size(res));
@@ -3541,12 +3546,13 @@ static int __init its_probe_one(struct resource *res,
 
 	its->numa_node = numa_node;
 
-	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(ITS_CMD_QUEUE_SZ));
-	if (!its->cmd_base) {
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+				get_order(ITS_CMD_QUEUE_SZ));
+	if (!page) {
 		err = -ENOMEM;
 		goto out_free_its;
 	}
+	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
 	its->fwnode_handle = handle;
 	its->get_msi_base = its_irq_get_msi_base;
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
