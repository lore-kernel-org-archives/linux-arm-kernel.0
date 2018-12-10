Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CB8C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E0720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZtqaGcLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E0720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qi7kP/IQZWK8MkJvgwc+2jFNJ3z4t/NuqXmddEkDCBI=; b=ZtqaGcLv+yL8Ak
	l3Hvw28sYbKLmdtbCp3awGbLKpPbyO7rdbNPOTR7AMc6VZFzNrGOMLrDTDbEk0s30G1ixI9hlDUEH
	9m6qYv7jt8+BECJaqTCmZ+VqA3LRa5vI9BPYWvXmVEl9lwlelRlLUNcuOEHsj0/OxhP8mq0AcWw9P
	EQLBL7oV5U7ZUG3ifBo0Gao+dTcR5ETzzSD/iliquYhxJaaeBz21jYY7z4L2Us0sDb77y0K+Ak7P0
	AGJBeTp+mO1tnNq2odJK+xTL/TVGNATBEQn/Q9CkNB1TSbj2ysm9ZLYE2ZhIc3+q9Orjs1McObLUd
	jiH2f4uAs/soA8oARhDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWNUt-0001Vv-0D; Mon, 10 Dec 2018 15:29:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWNUj-0001J0-5J
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 15:29:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32F91596;
 Mon, 10 Dec 2018 07:29:05 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28AD93F6A8;
 Mon, 10 Dec 2018 07:29:04 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	catalin.marinas@arm.com
Subject: [PATCH] arm64: Add memory hotplug support
Date: Mon, 10 Dec 2018 15:29:01 +0000
Message-Id: <0a0c7d3b8fbe1b2b399eeb6889027031335d2af1.1544453739.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_072917_858975_7BA851BC 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: anshuman.khandual@arm.com, cyrilc@xilinx.com, linux-kernel@vger.kernel.org,
 james.morse@arm.com, jonathan.cameron@huawei.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Wire up the basic support for hot-adding memory. Since memory hotplug
is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
cross-check the presence of a section in the manner of the generic
implementation, before falling back to memblock to check for no-map
regions within a present section as before. By having arch_add_memory(()
create the linear mapping first, this then makes everything work in the
way that __add_section() expects.

We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
should be safe from races by virtue of the global device hotplug lock.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Looks like I'm not going to have the whole pte_devmap story figured out
in time to land any ZONE_DEVICE support this cycle, but since this patch
also stands alone as a complete feature (and has ended up remarkably
simple and self-contained), I hope we might consider getting it merged
on its own merit.

Robin.

 arch/arm64/Kconfig   |  3 +++
 arch/arm64/mm/init.c |  8 ++++++++
 arch/arm64/mm/mmu.c  | 12 ++++++++++++
 arch/arm64/mm/numa.c | 10 ++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d2b25f51bb3..7b855ae45747 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -261,6 +261,9 @@ config ZONE_DMA32
 config HAVE_GENERIC_GUP
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 2983e0fc1786..82e0b08f2e31 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
 
 	if ((addr >> PAGE_SHIFT) != pfn)
 		return 0;
+
+#ifdef CONFIG_SPARSEMEM
+	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+		return 0;
+
+	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
+		return 0;
+#endif
 	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e1b2d58a311a..22379a74d289 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1044,3 +1044,15 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pmd_free(NULL, table);
 	return 1;
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
+		    bool want_memblock)
+{
+	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
+			     size, PAGE_KERNEL, pgd_pgtable_alloc, 0);
+
+	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
+			   altmap, want_memblock);
+}
+#endif
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 27a31efd9e8e..ae34e3a1cef1 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -466,3 +466,13 @@ void __init arm64_numa_init(void)
 
 	numa_init(dummy_numa_init);
 }
+
+/*
+ * We hope that we will be hotplugging memory on nodes we already know about,
+ * such that acpi_get_node() succeeds and we never fall back to this...
+ */
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
+	return 0;
+}
-- 
2.19.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
