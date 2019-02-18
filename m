Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22E3217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LACDpsFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22E3217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7hwO/EwmhvpOy8bmowQjPndnTIypqRV25fqOXxyFbhw=; b=LACDpsFnvL0lwYKC0sUqRITXOW
	zzKCz9TnACd9hNAe4OtLJODgzcIt6eT7FxsrEdDIHJDVdv+pdLD81aBEKpG5oCDl8ccyUOzDy7alK
	mz/AtuSBULI4n+3x4wzPjroeg5W+gYd0Vq6Hw9poEfyVlJFcbr6mdkOMcd9HPq8qLKpvaGJH1fOMF
	cAoOZlWRAlu7H+GNRq9O3ciRJYo8R68O4dQRyWEq+nkunLHgTFMijzgtoPtqAlnj0TAnCc99h5qhH
	N93QR31ECcypN3nuPK3c5qmTB5V6qlqSOeXKGP/Byr8crAPU5F1SLi5XT7LFbWkOuqO84o5n04qN3
	o7VeAEdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp3F-0001dE-Vq; Mon, 18 Feb 2019 19:58:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozg-0004bY-Vj
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57091A25;
 Mon, 18 Feb 2019 11:54:05 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74BC73FBD5;
 Mon, 18 Feb 2019 11:53:41 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 07/26] arm64/sve: Clarify role of the VQ map maintenance
 functions
Date: Mon, 18 Feb 2019 19:52:20 +0000
Message-Id: <1550519559-15915-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115425_444816_4A29074D 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The roles of sve_init_vq_map(), sve_update_vq_map() and
sve_verify_vq_map() are highly non-obvious to anyone who has not dug
through cpufeatures.c in detail.

Since the way these functions interact with each other is more
important here than a full understanding of the cpufeatures code, this
patch adds comments to make the functions' roles clearer.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 64729e2..92c2331 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -647,6 +647,10 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
 	}
 }
 
+/*
+ * Initialise the set of known supported VQs for the boot CPU.
+ * This is called during kernel boot, before secondary CPUs are brought up.
+ */
 void __init sve_init_vq_map(void)
 {
 	sve_probe_vqs(sve_vq_map);
@@ -656,6 +660,7 @@ void __init sve_init_vq_map(void)
 /*
  * If we haven't committed to the set of supported VQs yet, filter out
  * those not supported by the current CPU.
+ * This function is called during the bring-up of early secondary CPUs only.
  */
 void sve_update_vq_map(void)
 {
@@ -666,7 +671,10 @@ void sve_update_vq_map(void)
 	bitmap_or(sve_vq_partial_map, sve_vq_partial_map, tmp_map, SVE_VQ_MAX);
 }
 
-/* Check whether the current CPU supports all VQs in the committed set */
+/*
+ * Check whether the current CPU supports all VQs in the committed set.
+ * This function is called during the bring-up of late secondary CPUs only.
+ */
 int sve_verify_vq_map(void)
 {
 	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
