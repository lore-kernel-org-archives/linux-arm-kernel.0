Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D0C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90052080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p+82JDi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90052080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1dzORmFaqndZ0p++qDPWJDSbXvZYonxvNAc+sKC8YtY=; b=p+82JDi7H7ZiCSDeAnCqaI/L0N
	KkuMRvT866P/HeEUp14sTXeIcoFjhLULIG9a9iek14EBoHrWutxm3YSwvRZSbCoeW3+Hz3k8puAyL
	02HgND1w0pLIpvLnb5ipDwWv/gZXv2dGpWui+ZTNXDuBX4drVA5Tmut4CHDOPPLRTaOUdf+cDTDYy
	HM8D9gIU/gL7G/CVTohEP84P8H549l2fT/TCgBYqDIFIzVmEMysOBwyKnWT4nQmVf3Rc9vu+6+8B0
	UwBNxdclbr46R2s86DrP2yh6+l0sNVLARR45WvB8nsW80XFWFbdG9usB/h0GNviS67N7XaPBjO9gU
	dgvN/Wsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXlOt-0001EH-0o; Fri, 14 Dec 2018 11:12:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXlNL-0007qj-Mb; Fri, 14 Dec 2018 11:11:35 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5AFB8B10A;
 Fri, 14 Dec 2018 11:11:12 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-139.ams2.redhat.com [10.36.117.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5356017C6F;
 Fri, 14 Dec 2018 11:11:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 7/9] arm64: kdump: No need to mark crashkernel pages
 manually PG_reserved
Date: Fri, 14 Dec 2018 12:10:12 +0100
Message-Id: <20181214111014.15672-8-david@redhat.com>
In-Reply-To: <20181214111014.15672-1-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 14 Dec 2018 11:11:13 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_031124_136352_7CD35B68 
X-CRM114-Status: GOOD (  17.19  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 CHANDAN VN <chandan.vn@samsung.com>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Stefan Agner <stefan@agner.ch>, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Laura Abbott <labbott@redhat.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 Dave Kleikamp <dave.kleikamp@oracle.com>, James Morse <james.morse@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Hackmann <ghackmann@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The crashkernel is reserved via memblock_reserve(). memblock_free_all()
will call free_low_memory_core_early(), which will go over all reserved
memblocks, marking the pages as PG_reserved.

So manually marking pages as PG_reserved is not necessary, they are
already in the desired state (otherwise they would have been handed over
to the buddy as free pages and bad things would happen).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec.c |  2 +-
 arch/arm64/mm/init.c              | 27 ---------------------------
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 6f0587b5e941..66b5d697d943 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -321,7 +321,7 @@ void crash_post_resume(void)
  * but does not hold any data of loaded kernel image.
  *
  * Note that all the pages in crash dump kernel memory have been initially
- * marked as Reserved in kexec_reserve_crashkres_pages().
+ * marked as Reserved as memory was allocated via memblock_reserve().
  *
  * In hibernation, the pages which are Reserved and yet "nosave" are excluded
  * from the hibernation iamge. crash_is_nosave() does thich check for crash
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8f2e4792ef9..9dcfa809b7ab 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -118,35 +118,10 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-#ifdef CONFIG_HIBERNATION
-	phys_addr_t addr;
-	struct page *page;
-
-	if (!crashk_res.end)
-		return;
-
-	/*
-	 * To reduce the size of hibernation image, all the pages are
-	 * marked as Reserved initially.
-	 */
-	for (addr = crashk_res.start; addr < (crashk_res.end + 1);
-			addr += PAGE_SIZE) {
-		page = phys_to_page(addr);
-		SetPageReserved(page);
-	}
-#endif
-}
 #else
 static void __init reserve_crashkernel(void)
 {
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-}
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
@@ -586,8 +561,6 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
-	kexec_reserve_crashkres_pages();
-
 	mem_init_print_info(NULL);
 
 	/*
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
