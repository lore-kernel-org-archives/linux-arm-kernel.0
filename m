Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D88C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C89F206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FnkngCHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C89F206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SqQv96I5ZI8Xt61pokeGCT1BhEOgsHkeW0e4d47Mwqg=; b=FnkngCHq5JaDp6Q39Tbc6niYUl
	3DihSK1GhmHEGPkGdxDOT7xn0UjqLtqWwZccIUH9mEoVn1XFEGuPY7DJykf2H43p+xbXxXakSjpSa
	IDuWunswS5HqPQg7hM0rEP4yOIS7igGq66tCnT6VQhcMIwQVocJ5jL9hBg/Zi5zI0L8Np6FBFJGh0
	WD0nPerIK1+ocd4IsM27frxtWhZywugzgH8TPkWP0ZIXbCgAA97hnvRXaQUqXOqNP5y1StvkgT3hl
	V0mKyxVqGfqiu25yO8LejhUw31YiBHFzkCUhOntZcAfQR+PzzrpKRlP9UTvlXOj+cYRcozGQwvx+o
	ZxP59cbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlWw-0003Z8-Dp; Wed, 16 Jan 2019 13:46:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlVN-0001Yo-TB
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:45:37 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDeYNM036351
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q240wd0be-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:16 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:45:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:45:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDj1t650724892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:45:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56C7652059;
 Wed, 16 Jan 2019 13:45:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3403052054;
 Wed, 16 Jan 2019 13:44:57 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:44:56 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 07/21] memblock: memblock_phys_alloc(): don't panic
Date: Wed, 16 Jan 2019 15:44:07 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-4275-0000-0000-000002FFFEE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-4276-0000-0000-0000380E203C
Message-Id: <1547646261-32535-8-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_054518_426802_59A4974A 
X-CRM114-Status: GOOD (  23.72  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make the memblock_phys_alloc() function an inline wrapper for
memblock_phys_alloc_range() and update the memblock_phys_alloc() callers to
check the returned value and panic in case of error.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c                   | 4 ++++
 arch/arm64/mm/mmu.c                  | 2 ++
 arch/powerpc/sysdev/dart_iommu.c     | 3 +++
 arch/s390/kernel/crash_dump.c        | 3 +++
 arch/s390/kernel/setup.c             | 3 +++
 arch/sh/boards/mach-ap325rxa/setup.c | 3 +++
 arch/sh/boards/mach-ecovec24/setup.c | 6 ++++++
 arch/sh/boards/mach-kfr2r09/setup.c  | 3 +++
 arch/sh/boards/mach-migor/setup.c    | 3 +++
 arch/sh/boards/mach-se/7724/setup.c  | 6 ++++++
 arch/xtensa/mm/kasan_init.c          | 3 +++
 include/linux/memblock.h             | 7 ++++++-
 mm/memblock.c                        | 5 -----
 13 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b76b90e..15dddfe 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -206,6 +206,10 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	BUG_ON(!arm_memblock_steal_permitted);
 
 	phys = memblock_phys_alloc(size, align);
+	if (!phys)
+		panic("Failed to steal %pa bytes at %pS\n",
+		      &size, (void *)_RET_IP_);
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa5..a74e4be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -104,6 +104,8 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	void *ptr;
 
 	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate page table page\n");
 
 	/*
 	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 25bc25f..b82c9ff 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -265,6 +265,9 @@ static void allocate_dart(void)
 	 * prefetching into invalid pages and corrupting data
 	 */
 	tmp = memblock_phys_alloc(DART_PAGE_SIZE, DART_PAGE_SIZE);
+	if (!tmp)
+		panic("DART: table allocation failed\n");
+
 	dart_emptyval = DARTMAP_VALID | ((tmp >> DART_PAGE_SHIFT) &
 					 DARTMAP_RPNMASK);
 
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 97eae38..f96a585 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -61,6 +61,9 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
 	struct save_area *sa;
 
 	sa = (void *) memblock_phys_alloc(sizeof(*sa), 8);
+	if (!sa)
+		panic("Failed to allocate save area\n");
+
 	if (is_boot_cpu)
 		list_add(&sa->list, &dump_save_areas);
 	else
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72dd23e..da48397 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -968,6 +968,9 @@ static void __init setup_randomness(void)
 
 	vmms = (struct sysinfo_3_2_2 *) memblock_phys_alloc(PAGE_SIZE,
 							    PAGE_SIZE);
+	if (!vmms)
+		panic("Failed to allocate memory for sysinfo structure\n");
+
 	if (stsi(vmms, 3, 2, 2) == 0 && vmms->count)
 		add_device_randomness(&vmms->vm, sizeof(vmms->vm[0]) * vmms->count);
 	memblock_free((unsigned long) vmms, PAGE_SIZE);
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index d7ceab6..08a0cc9 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -558,6 +558,9 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a3901806..fd264a6 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1481,11 +1481,17 @@ static void __init ecovec_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU0 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU1 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 55bdf4a..ebe90d06 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -632,6 +632,9 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index ba7eee6..1adff09 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -631,6 +631,9 @@ static void __init migor_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 4696e10..201631a 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -966,11 +966,17 @@ static void __init ms7724se_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU0 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU1 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 48dbb03..4852848 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -54,6 +54,9 @@ static void __init populate(void *start, void *end)
 			phys_addr_t phys =
 				memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
+			if (!phys)
+				panic("Failed to allocate page table page\n");
+
 			set_pte(pte + j, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 		}
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 66dfdb3..7883c74 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -374,7 +374,12 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 phys_addr_t memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
-phys_addr_t memblock_phys_alloc(phys_addr_t size, phys_addr_t align);
+static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
+					      phys_addr_t align)
+{
+	return memblock_phys_alloc_range(size, align, 0,
+					 MEMBLOCK_ALLOC_ACCESSIBLE);
+}
 
 void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
 				 phys_addr_t min_addr, phys_addr_t max_addr,
diff --git a/mm/memblock.c b/mm/memblock.c
index 8aabb1b..461e40a3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1382,11 +1382,6 @@ phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys
 	return alloc;
 }
 
-phys_addr_t __init memblock_phys_alloc(phys_addr_t size, phys_addr_t align)
-{
-	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
-}
-
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	phys_addr_t res = memblock_phys_alloc_nid(size, align, nid);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
