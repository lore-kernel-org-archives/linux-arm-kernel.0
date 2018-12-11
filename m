Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69711C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3799920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VgaC+BYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3799920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uNYnKx687wx6438rWH1Vd++Jy3YiZfmokAbi1TJbopY=; b=VgaC+BYO7cRT/Xm/vSscrVUpZ5
	/1roVYjDVAFfgWWGyhgSG8W+VaiQ9qKmzR3ADdfQXtqgFLkA8oKeYVqoWmeco0HMgz1nSzv+Y/Bst
	SYaJL+9K2eue19cCDaBc05IZcZQS2ZU4ccp0zK3rVoZVPx9Zf2uNw6U5xgpscE1R5+Hpb8/Hk7OWR
	kje/yId0H7rK1hWoilVVk3jU7YaogmM6hai6921jFPksvSzAgNLE5dKFTg60nbfwKhub7WqQ4rIF9
	WPVFAck9ojq9br+Rap1b72gUev+eqfPwpT4BzZD/AGGevSX7Jo8lzwO1pTGVn6+ZfZ6kNtAq1x6YC
	93kCISmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrWW-0007ia-JV; Tue, 11 Dec 2018 23:33:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTh-00045R-R1
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A13D21684;
 Tue, 11 Dec 2018 15:30:01 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA6563F614;
 Tue, 11 Dec 2018 15:29:59 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 06/24] arm64/sve: Clarify role of the VQ map
 maintenance functions
Date: Tue, 11 Dec 2018 23:28:43 +0000
Message-Id: <1544570941-7377-7-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153014_593129_BDDE8193 
X-CRM114-Status: GOOD (  12.93  )
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
 Will Deacon <will.deacon@arm.com>,
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

Changes since RFC v2:

 * New patch.
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
