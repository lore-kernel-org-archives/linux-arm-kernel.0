Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D62FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:10:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EDC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gv+JklpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EDC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yMZz6r9O5ojEIx0LXi+3NFv9yLQ+ou59MnjGCxL9yxI=; b=Gv+JklpNkFhQzK
	P2gW2HmtmGiL2uqs3RzAY2gWcO+yaFytaeYB8z/En35Plpw6WghfAVI0i2/XMQ0zOvzz/GQN3WthF
	BB0NQslCW54vOwA3ENtet8gk13Nyu5N6k+ZfyB3nsg89BVtdUXZ34sayELYvUdKTbaLLIoxiEA9mo
	VfRNB6W+PvVhMnHoVZ3TJI9qE0glMZKEqfKjeZU1+HpUN8LNZtiEs2N2PcEXGYc/OhBEMHQw2MnML
	IcWIRqSKHsn2e/sAFMLx/fY+5KD43vofrIzY66ZJfwBd0fQymncbdsZJB2eQFlws1C4k8dT9WXx1S
	SXqwNdZx8sxV12IkIb5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsfZ-0000Lr-3X; Mon, 03 Dec 2018 18:10:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsd4-0005gE-H6
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:08:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583751682;
 Mon,  3 Dec 2018 10:07:34 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8834F3F59C;
 Mon,  3 Dec 2018 10:07:31 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 16/25] ACPI / APEI: Let the notification helper specify the
 fixmap slot
Date: Mon,  3 Dec 2018 18:06:04 +0000
Message-Id: <20181203180613.228133-17-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100735_090893_044B6375 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ghes_copy_tofrom_phys() uses a different fixmap slot depending on in_nmi().
This doesn't work when there are multiple NMI-like notifications, that
could interrupt each other.

As with the locking, move the chosen fixmap_idx to the notification helper.
This only matters for NMI-like notifications, anything calling
ghes_proc() can use the IRQ fixmap slot as its already holding an irqsave
spinlock.

This lets us collapse the ghes_ioremap_pfn_*() helpers.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---

The fixmap-idx and vaddr are passed back to ghes_unmap()
to allow ioremap() to be used in process context in the
future. This will let us send tlbi-ipi for notifications
that don't mask irqs.
---
 drivers/acpi/apei/ghes.c | 79 +++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 30490eff7704..b5c31f65a1c0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/llist.h>
 #include <linux/genalloc.h>
 #include <linux/pci.h>
+#include <linux/pfn.h>
 #include <linux/aer.h>
 #include <linux/nmi.h>
 #include <linux/sched/clock.h>
@@ -127,38 +128,24 @@ static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
 
-static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
+static void __iomem *ghes_map(u64 pfn, int fixmap_idx)
 {
 	phys_addr_t paddr;
 	pgprot_t prot;
 
-	paddr = pfn << PAGE_SHIFT;
+	paddr = PFN_PHYS(pfn);
 	prot = arch_apei_get_mem_attribute(paddr);
-	__set_fixmap(FIX_APEI_GHES_NMI, paddr, prot);
+	__set_fixmap(fixmap_idx, paddr, prot);
 
-	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_NMI);
+	return (void __iomem *) __fix_to_virt(fixmap_idx);
 }
 
-static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
+static void ghes_unmap(int fixmap_idx, void __iomem *vaddr)
 {
-	phys_addr_t paddr;
-	pgprot_t prot;
-
-	paddr = pfn << PAGE_SHIFT;
-	prot = arch_apei_get_mem_attribute(paddr);
-	__set_fixmap(FIX_APEI_GHES_IRQ, paddr, prot);
+	int _idx = virt_to_fix((unsigned long)vaddr);
 
-	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_IRQ);
-}
-
-static void ghes_iounmap_nmi(void)
-{
-	clear_fixmap(FIX_APEI_GHES_NMI);
-}
-
-static void ghes_iounmap_irq(void)
-{
-	clear_fixmap(FIX_APEI_GHES_IRQ);
+	WARN_ON_ONCE(fixmap_idx != _idx);
+	clear_fixmap(fixmap_idx);
 }
 
 int ghes_estatus_pool_init(int num_ghes)
@@ -268,20 +255,15 @@ static inline int ghes_severity(int severity)
 }
 
 static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
-				  int from_phys)
+				  int from_phys, int fixmap_idx)
 {
 	void __iomem *vaddr;
-	int in_nmi = in_nmi();
 	u64 offset;
 	u32 trunk;
 
 	while (len > 0) {
 		offset = paddr - (paddr & PAGE_MASK);
-		if (in_nmi) {
-			vaddr = ghes_ioremap_pfn_nmi(paddr >> PAGE_SHIFT);
-		} else {
-			vaddr = ghes_ioremap_pfn_irq(paddr >> PAGE_SHIFT);
-		}
+		vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
 		trunk = PAGE_SIZE - offset;
 		trunk = min(trunk, len);
 		if (from_phys)
@@ -291,15 +273,12 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 		len -= trunk;
 		paddr += trunk;
 		buffer += trunk;
-		if (in_nmi) {
-			ghes_iounmap_nmi();
-		} else {
-			ghes_iounmap_irq();
-		}
+		ghes_unmap(fixmap_idx, vaddr);
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
+static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr, int fixmap_idx)
+
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	u32 len;
@@ -317,7 +296,7 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 		return -ENOENT;
 
 	ghes_copy_tofrom_phys(ghes->estatus, *buf_paddr,
-			      sizeof(*ghes->estatus), 1);
+			      sizeof(*ghes->estatus), 1, fixmap_idx);
 	if (!ghes->estatus->block_status) {
 		*buf_paddr = 0;
 		return -ENOENT;
@@ -333,7 +312,7 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 		goto err_read_block;
 	ghes_copy_tofrom_phys(ghes->estatus + 1,
 			      *buf_paddr + sizeof(*ghes->estatus),
-			      len - sizeof(*ghes->estatus), 1);
+			      len - sizeof(*ghes->estatus), 1, fixmap_idx);
 	if (cper_estatus_check(ghes->estatus))
 		goto err_read_block;
 	rc = 0;
@@ -346,12 +325,13 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 	return rc;
 }
 
-static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr)
+static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr, int fixmap_idx)
 {
 	ghes->estatus->block_status = 0;
 	if (buf_paddr)
 		ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
-				      sizeof(ghes->estatus->block_status), 0);
+				      sizeof(ghes->estatus->block_status), 0,
+				      fixmap_idx);
 }
 
 static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
@@ -673,7 +653,7 @@ static int ghes_proc(struct ghes *ghes)
 	u64 buf_paddr;
 	int rc;
 
-	rc = ghes_read_estatus(ghes, &buf_paddr);
+	rc = ghes_read_estatus(ghes, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
@@ -688,7 +668,7 @@ static int ghes_proc(struct ghes *ghes)
 	ghes_do_proc(ghes, ghes->estatus);
 
 out:
-	ghes_clear_estatus(ghes, buf_paddr);
+	ghes_clear_estatus(ghes, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (rc == -ENOENT)
 		return rc;
@@ -864,13 +844,13 @@ static void __process_error(struct ghes *ghes)
 #endif
 }
 
-static int _in_nmi_notify_one(struct ghes *ghes)
+static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 {
 	u64 buf_paddr;
 	int sev;
 
-	if (ghes_read_estatus(ghes, &buf_paddr)) {
-		ghes_clear_estatus(ghes, buf_paddr);
+	if (ghes_read_estatus(ghes, &buf_paddr, fixmap_idx)) {
+		ghes_clear_estatus(ghes, buf_paddr, fixmap_idx);
 		return -ENOENT;
 	}
 
@@ -881,7 +861,7 @@ static int _in_nmi_notify_one(struct ghes *ghes)
 	}
 
 	__process_error(ghes);
-	ghes_clear_estatus(ghes, buf_paddr);
+	ghes_clear_estatus(ghes, buf_paddr, fixmap_idx);
 
 	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
 		pr_warn_ratelimited(FW_WARN GHES_PFX
@@ -890,14 +870,15 @@ static int _in_nmi_notify_one(struct ghes *ghes)
 	return 0;
 }
 
-static int ghes_estatus_queue_notified(struct list_head *rcu_list)
+static int ghes_estatus_queue_notified(struct list_head *rcu_list,
+				       int fixmap_idx)
 {
 	int ret = -ENOENT;
 	struct ghes *ghes;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, rcu_list, list) {
-		if (!_in_nmi_notify_one(ghes))
+		if (!_in_nmi_notify_one(ghes, fixmap_idx))
 			ret = 0;
 	}
 	rcu_read_unlock();
@@ -921,7 +902,7 @@ int ghes_notify_sea(void)
 	int rv;
 
 	raw_spin_lock(&ghes_notify_lock_sea);
-	rv = ghes_estatus_queue_notified(&ghes_sea);
+	rv = ghes_estatus_queue_notified(&ghes_sea, FIX_APEI_GHES_NMI);
 	raw_spin_unlock(&ghes_notify_lock_sea);
 
 	return rv;
@@ -964,7 +945,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		return ret;
 
 	raw_spin_lock(&ghes_notify_lock_nmi);
-	if (!ghes_estatus_queue_notified(&ghes_nmi))
+	if (!ghes_estatus_queue_notified(&ghes_nmi, FIX_APEI_GHES_NMI))
 		ret = NMI_HANDLED;
 	raw_spin_unlock(&ghes_notify_lock_nmi);
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
