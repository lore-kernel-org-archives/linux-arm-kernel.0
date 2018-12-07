Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D3B2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hZg+k4af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D3B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jJiO84J3ro7mlLiXa0+NmiDkwbQLLcuMK0G4OCEOS0Q=; b=hZg+k4af0UURJjNvs55O0T7UoE
	12dVBPdLjWDxKifoMxK/8RrVhJonPo3RknkodLBFm0y+uyY/Mdm+VhXFoC16hCpl1IBaQh+QT376t
	+E0K9fM+LyxvSfaOjWvOYPW3Jpa2k5+NHSRdw+cO48c/EBHfmIli3Nh5ZSwKLiBam2nwTS14LeQmE
	80YVudQGTblqGV++rThMuC6dV4FvxfBnotS1ihBnmhhtzkTPRF+VEfIBZCqayDbMrEkYBQeIkL6ge
	8ItWEkCFXL5+q6WhsQJ0KJOPOdAU0c0nDgcXwrofEEShr/RBdynMtRZGwXcqlErbPEBzIwaL5eeop
	qQ6HiLSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKZp-0001er-64; Fri, 07 Dec 2018 18:10:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYZ-0008OA-VY
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:09:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A3B1B4B;
 Fri,  7 Dec 2018 10:08:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3B9B3F5AF;
 Fri,  7 Dec 2018 10:08:44 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 09/10] arm64: frace: use asm EXPORT_SYMBOL()
Date: Fri,  7 Dec 2018 18:08:22 +0000
Message-Id: <20181207180823.36612-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100856_570522_EB612C4D 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the ftrace exports
to the assembly files the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c   | 5 -----
 arch/arm64/kernel/entry-ftrace.S | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index c142103bc0fe..4ca8d2b245d2 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -28,8 +28,3 @@
 
 #include <asm/checksum.h>
 
-#ifdef CONFIG_FUNCTION_TRACER
-EXPORT_SYMBOL(_mcount);
-NOKPROBE_SYMBOL(_mcount);
-#endif
-
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 032e24d2d554..81b8eb5c4633 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -120,6 +120,8 @@ skip_ftrace_call:			// }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 	mcount_exit
 ENDPROC(_mcount)
+EXPORT_SYMBOL(_mcount)
+NOKPROBE(_mcount)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
 /*
@@ -131,6 +133,8 @@ ENDPROC(_mcount)
 ENTRY(_mcount)
 	ret
 ENDPROC(_mcount)
+EXPORT_SYMBOL(_mcount)
+NOKPROBE(_mcount)
 
 /*
  * void ftrace_caller(unsigned long return_address)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
