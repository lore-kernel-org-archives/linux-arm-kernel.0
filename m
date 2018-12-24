Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73974C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:21:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A2520675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8fO7Agb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LusW/WV5XOAvSmuQ63vbZNmuFc0qhEl6E9DLQyT1tfk=; b=m8f
	O7AgbCJKbjAEnMzs+wpPAbgOUFFUo53Bi0h4rL0e8IneENg1roudu69m5YDDei7yMgpgMRGbp+V6D
	5oXxRN20EBeZgHYRmhvR8ZDq5NtMp6cAw1xvvNVv+v73FQIb7wl47+XTxYnISHpE094nL4aGAxXvE
	BHzyGze1EISoFW+Xjm7UfyqTG5HjlyOPouWedJPEJgZrTlZC7nMMzkGJV41huszfPAqebUDUXxyIn
	9aTZnDPvwyMVxuYZ+bgqmNvbXdjq1UPQuTIihuqDxvCRBJZBLRytYByAoLIKqNu34d5o2cXUm2lp3
	PpDfntYksDw38sgNNaYyAr+B+QVItfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbNMs-0006A3-CM; Mon, 24 Dec 2018 10:21:50 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbNMo-000693-Az
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 10:21:48 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 5E72FF91688E4AA56276;
 Mon, 24 Dec 2018 18:21:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBOALJP7067919;
 Mon, 24 Dec 2018 18:21:19 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018122418212639-18450520 ;
 Mon, 24 Dec 2018 18:21:26 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: christoffer.dall@arm.com, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH]  kvm/arm64 : reduce the size of kvm_vcpu
Date: Mon, 24 Dec 2018 18:42:24 +0800
Message-Id: <1545648144-64778-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-24 18:21:26,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-24 18:21:18, Serialize complete at 2018-12-24 18:21:18
X-MAIL: mse01.zte.com.cn wBOALJP7067919
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_022146_933036_8E23740D 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: Peng Hao <peng.hao2@zte.com.cn>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to adjust the position of variables in kvm_vcpu_arch,
the size of kvm_vcpu can reduce 16 bytes.
before:
cat /proc/slabinfo | grep kvm
kvm_vcpu  252    252   9120   28  ...

after:
cat /proc/slabinfo | grep kvm
kvm_vcpu   28     28   9104   28  ...

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm64/include/asm/kvm_host.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc82..e805b7e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -287,16 +287,17 @@ struct kvm_vcpu_arch {
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
+	u64 vsesr_el2;
+
+	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
+
 	/* Target CPU and feature flags */
 	int target;
-	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
 
 	/* Detect first run of a vcpu */
 	bool has_run_once;
 
-	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
-	u64 vsesr_el2;
-
 	/* True when deferrable sysregs are loaded on the physical CPU,
 	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
 	bool sysregs_loaded_on_cpu;
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
