Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD47DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AEB20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+nLqxI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AEB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=022kTbbh73GXy3CyPO+0A3NtgEkFHIQX2hMs+acnZkc=; b=l+nLqxI0pZpWxhczvjr2c7KJOY
	PqbM+HmdcQMe3TU/Gj1xnK+IE9CozO48cVUnZIJ6gGAWbyAvMzBsMt08Z2OTQI73gEGzX7djcNFfc
	+92gJ+qZpQYJOSFP8uxNJf3pR+5+S8P/Nu0d191wD30XIoJ7SGE5XD8sYxyaMlM5LF86xI95v8GAl
	Svfk5pT1BYQ8Cis7kD3NtlSOJ9NVkDYXUytjib7AfLfL45iyJOxc7TNt1aj7bz1J4JODW9qYl4Sqp
	XjMpWu6Dk7K4aE1VpfYNfoyw7wpezhtbaHJphFaHZxklUWCNgBUpKU/3W8XmkxVqV6EyOgF7oRMnH
	OCX9FuHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0au-0000CZ-Oo; Sun, 09 Dec 2018 15:02:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0Zv-0007XI-PS
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 15:01:16 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB9ExIhm108961
 for <linux-arm-kernel@lists.infradead.org>; Sun, 9 Dec 2018 10:00:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8v24f1a9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Sun, 09 Dec 2018 10:00:57 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Sun, 9 Dec 2018 15:00:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 9 Dec 2018 15:00:47 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB9F0kxZ29098018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 15:00:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BC0D11C04C;
 Sun,  9 Dec 2018 15:00:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE5EF11C050;
 Sun,  9 Dec 2018 15:00:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.213])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun,  9 Dec 2018 15:00:43 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Sun, 09 Dec 2018 17:00:43 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 5/6] arch: simplify several early memory allocations
Date: Sun,  9 Dec 2018 17:00:23 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544367624-15376-1-git-send-email-rppt@linux.ibm.com>
References: <1544367624-15376-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120915-0016-0000-0000-000002341C81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120915-0017-0000-0000-0000328C4066
Message-Id: <1544367624-15376-6-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_070108_151053_E4C92B72 
X-CRM114-Status: GOOD (  28.16  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are several early memory allocations in arch/ code that use
memblock_phys_alloc() to allocate memory, convert the returned physical
address to the virtual address and then set the allocated memory to zero.

Exactly the same behaviour can be achieved simply by calling
memblock_alloc(): it allocates the memory in the same way as
memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
clears the allocated memory.

Replace the longer sequence with a simpler call to memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c                     |  4 +---
 arch/c6x/mm/dma-coherent.c            |  9 ++-------
 arch/nds32/mm/init.c                  | 12 ++++--------
 arch/powerpc/kernel/setup-common.c    |  4 ++--
 arch/powerpc/mm/pgtable_32.c          |  4 +---
 arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
 arch/powerpc/platforms/powernv/opal.c |  3 +--
 arch/sparc/kernel/prom_64.c           |  7 ++-----
 arch/sparc/mm/init_64.c               |  9 +++------
 arch/unicore32/mm/mmu.c               |  4 +---
 10 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f5cc1cc..0a04c9a5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -721,9 +721,7 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
 {
-	void *ptr = __va(memblock_phys_alloc(sz, align));
-	memset(ptr, 0, sz);
-	return ptr;
+	return memblock_alloc(sz, align);
 }
 
 static void __init *early_alloc(unsigned long sz)
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index 01305c7..ffc49e2 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -118,8 +118,6 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
  */
 void __init coherent_mem_init(phys_addr_t start, u32 size)
 {
-	phys_addr_t bitmap_phys;
-
 	if (!size)
 		return;
 
@@ -135,11 +133,8 @@ void __init coherent_mem_init(phys_addr_t start, u32 size)
 	if (dma_size & (PAGE_SIZE - 1))
 		++dma_pages;
 
-	bitmap_phys = memblock_phys_alloc(BITS_TO_LONGS(dma_pages) * sizeof(long),
-					  sizeof(long));
-
-	dma_bitmap = phys_to_virt(bitmap_phys);
-	memset(dma_bitmap, 0, dma_pages * PAGE_SIZE);
+	dma_bitmap = memblock_alloc(BITS_TO_LONGS(dma_pages) * sizeof(long),
+				    sizeof(long));
 }
 
 static void c6x_dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 131104b..9f19be8 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -80,8 +80,7 @@ static void __init map_ram(void)
 		}
 
 		/* Alloc one page for holding PTE's... */
-		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-		memset(pte, 0, PAGE_SIZE);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		set_pmd(pme, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
 
 		/* Fill the newly allocated page with PTE'S */
@@ -113,8 +112,7 @@ static void __init fixedrange_init(void)
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pud = pud_offset(pgd, vaddr);
 	pmd = pmd_offset(pud, vaddr);
-	fixmap_pmd_p = (pmd_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(fixmap_pmd_p, 0, PAGE_SIZE);
+	fixmap_pmd_p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	set_pmd(pmd, __pmd(__pa(fixmap_pmd_p) + _PAGE_KERNEL_TABLE));
 
 #ifdef CONFIG_HIGHMEM
@@ -126,8 +124,7 @@ static void __init fixedrange_init(void)
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pud = pud_offset(pgd, vaddr);
 	pmd = pmd_offset(pud, vaddr);
-	pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(pte, 0, PAGE_SIZE);
+	pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	set_pmd(pmd, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
 	pkmap_page_table = pte;
 #endif /* CONFIG_HIGHMEM */
@@ -152,8 +149,7 @@ void __init paging_init(void)
 	fixedrange_init();
 
 	/* allocate space for empty_zero_page */
-	zero_page = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(zero_page, 0, PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	zone_sizes_init();
 
 	empty_zero_page = virt_to_page(zero_page);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93ee370..8f6c763 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -459,8 +459,8 @@ void __init smp_setup_cpu_maps(void)
 
 	DBG("smp_setup_cpu_maps()\n");
 
-	cpu_to_phys_id = __va(memblock_phys_alloc(nr_cpu_ids * sizeof(u32), __alignof__(u32)));
-	memset(cpu_to_phys_id, 0, nr_cpu_ids * sizeof(u32));
+	cpu_to_phys_id = memblock_alloc(nr_cpu_ids * sizeof(u32),
+					__alignof__(u32));
 
 	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bda3c6f..9931e68 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -50,9 +50,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 	if (slab_is_available()) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
 	} else {
-		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-		if (pte)
-			clear_page(pte);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	}
 	return pte;
 }
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f6f575b..fddf823 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -224,8 +224,7 @@ void __init MMU_init_hw(void)
 	 * Find some memory for the hash table.
 	 */
 	if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
-	Hash = __va(memblock_phys_alloc(Hash_size, Hash_size));
-	memset(Hash, 0, Hash_size);
+	Hash = memblock_alloc(Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
 	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index beed86f..29ee2ea 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -171,8 +171,7 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 	/*
 	 * Allocate a buffer to hold the MC recoverable ranges.
 	 */
-	mc_recoverable_range =__va(memblock_phys_alloc(size, __alignof__(u64)));
-	memset(mc_recoverable_range, 0, size);
+	mc_recoverable_range = memblock_alloc(size, __alignof__(u64));
 
 	for (i = 0; i < mc_recoverable_range_len; i++) {
 		mc_recoverable_range[i].start_addr =
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index c37955d..2a17665 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -34,16 +34,13 @@
 
 void * __init prom_early_alloc(unsigned long size)
 {
-	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
-	void *ret;
+	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
 
-	if (!paddr) {
+	if (!ret) {
 		prom_printf("prom_early_alloc(%lu) failed\n", size);
 		prom_halt();
 	}
 
-	ret = __va(paddr);
-	memset(ret, 0, size);
 	prom_early_allocated += size;
 
 	return ret;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3c8aac2..52884f4 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1089,16 +1089,13 @@ static void __init allocate_node_data(int nid)
 	struct pglist_data *p;
 	unsigned long start_pfn, end_pfn;
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-	unsigned long paddr;
 
-	paddr = memblock_phys_alloc_try_nid(sizeof(struct pglist_data),
-					    SMP_CACHE_BYTES, nid);
-	if (!paddr) {
+	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
+					     SMP_CACHE_BYTES, nid);
+	if (!NODE_DATA(nid)) {
 		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
 		prom_halt();
 	}
-	NODE_DATA(nid) = __va(paddr);
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
 	NODE_DATA(nid)->node_id = nid;
 #endif
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 040a8c2..50d8c1a 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -143,9 +143,7 @@ static void __init build_mem_type_table(void)
 
 static void __init *early_alloc(unsigned long sz)
 {
-	void *ptr = __va(memblock_phys_alloc(sz, sz));
-	memset(ptr, 0, sz);
-	return ptr;
+	return memblock_alloc(sz, sz);
 }
 
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
