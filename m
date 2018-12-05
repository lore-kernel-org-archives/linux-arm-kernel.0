Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A36C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:42:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A3420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BZB6JnTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A3420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HuwiWgRy/29Gz2gPKaf3bObPXjS+AHonuNYB/BVQUyc=; b=BZB6JnTJv+rL4Y
	uNMB8KU2iJxM9pNUiBiWi3YM/XKBE7NBSQ313sV8Uhz7Q/WWXRQRhKRw2LObJHmqPlBqTDzwtEPSx
	dDZYZTkW+sSNzqLAIgDYehQ1aXJFYct+YJ8MyFIxwWNz+WY/LDyTqe4O5UlBR0Zx9j26qvB5jocZC
	9coX9+IdC28xuf3QyyeqYZ7R6xSaDveyb3bpr2weoSm7gIcfZigC5A11a5Jj9ZnvyBoBRawiWxibq
	urmRENqZkwWIiICQ+H49wkz2UmDAf2fl5ozTKH+BJ5VXJz5lT6YlIFNkAwbrh2rEm+ONGyPI6+axR
	bNfM2HjJCZpwytl/NBiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaFy-0000sO-Vb; Wed, 05 Dec 2018 16:42:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaFU-0000Kb-AH
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:42:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607CA1650;
 Wed,  5 Dec 2018 08:42:02 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A8A13F5AF;
 Wed,  5 Dec 2018 08:42:00 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 2/6] arm64: mm: Introduce DEFAULT_MAP_WINDOW
Date: Wed,  5 Dec 2018 16:41:41 +0000
Message-Id: <20181205164145.24568-3-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205164145.24568-1-steve.capper@arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084208_412807_719F3619 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
 will.deacon@arm.com, jcm@redhat.com, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We wish to introduce a 52-bit virtual address space for userspace but
maintain compatibility with software that assumes the maximum VA space
size is 48 bit.

In order to achieve this, on 52-bit VA systems, we make mmap behave as
if it were running on a 48-bit VA system (unless userspace explicitly
requests a VA where addr[51:48] != 0).

On a system running a 52-bit userspace we need TASK_SIZE to represent
the 52-bit limit as it is used in various places to distinguish between
kernelspace and userspace addresses.

Thus we need a new limit for mmap, stack, ELF loader and EFI (which uses
TTBR0) to represent the non-extended VA space.

This patch introduces DEFAULT_MAP_WINDOW and DEFAULT_MAP_WINDOW_64 and
switches the appropriate logic to use that instead of TASK_SIZE.

Signed-off-by: Steve Capper <steve.capper@arm.com>

---

Changed in V3: corrections to allow COMPAT 32-bit EL0 mode to work
---
 arch/arm64/include/asm/elf.h            |  2 +-
 arch/arm64/include/asm/processor.h      | 10 ++++++++--
 arch/arm64/mm/init.c                    |  2 +-
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 433b9554c6a1..bc9bd9e77d9d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -117,7 +117,7 @@
  * 64-bit, this is above 4GB to leave the entire 32-bit address
  * space open for things that want to use the area for 32-bit pointers.
  */
-#define ELF_ET_DYN_BASE		(2 * TASK_SIZE_64 / 3)
+#define ELF_ET_DYN_BASE		(2 * DEFAULT_MAP_WINDOW_64 / 3)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3e2091708b8e..50586ca6bacb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -45,19 +45,25 @@
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
+
+#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
+
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
+#define DEFAULT_MAP_WINDOW	(test_thread_flag(TIF_32BIT) ? \
+				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
+#define DEFAULT_MAP_WINDOW	DEFAULT_MAP_WINDOW_64
 #endif /* CONFIG_COMPAT */
 
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
+#define STACK_TOP_MAX		DEFAULT_MAP_WINDOW_64
 
-#define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582cac6c4..7239c103be06 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -609,7 +609,7 @@ void __init mem_init(void)
 	 * detected at build time already.
 	 */
 #ifdef CONFIG_COMPAT
-	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
+	BUILD_BUG_ON(TASK_SIZE_32 > DEFAULT_MAP_WINDOW_64);
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..952cec5b611a 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,7 +38,7 @@ static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
 		{ 0,		"UEFI runtime start" },
-		{ TASK_SIZE_64,	"UEFI runtime end" }
+		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
 	},
 	.base_addr	= 0,
 };
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 30ac0c975f8a..d1ec7136e3e1 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -33,7 +33,7 @@
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
 
 #ifdef CONFIG_ARM64
-# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_64
+# define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
 #else
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
 #endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
