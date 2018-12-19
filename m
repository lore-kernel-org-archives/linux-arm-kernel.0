Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31554C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CD0218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gt58ySVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CD0218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TKSPsWcOQKVFYEPyXdQ8ZLBd57K1+0Bngvl5GR9g+5g=; b=gt58ySVWw0oe+y
	Ul9BVRVkhXjGA3mEs5sbE/a7fJSpwnQjXhzYbllisx/lONy50poxJP6DmulW9tAnQCEDJGHiBAcPG
	qMjDzCoHwd6M5v5/R3LdOXPPoUbJgMM+nbqLlH8ehmackJqbXCYq+zF0BICvVPLLEDzokFzX1cPLF
	drqV5protHfH9hWZXlDQei3IkfLZEblRRG8CZqRNFmuiE5pWblLH9GG/AHaOc01QaoLUHxOFspdk4
	vfaYOYZfVdJR3ss+k7mHQqjSCb9cIZGOGpguH9QVIvKwgcu0OQOYh+SC0a1kJ3zFApeSJHrYwxhO3
	//M2aLTcC/VHtP1FnF8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgGi-0002Ra-5Q; Wed, 19 Dec 2018 18:08:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDO-0006AY-KN
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B62915AB;
 Wed, 19 Dec 2018 10:05:02 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06C43F675;
 Wed, 19 Dec 2018 10:04:59 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 19/28] KVM: arm/arm64: Fixup the kvm_exit tracepoint
Date: Wed, 19 Dec 2018 18:03:40 +0000
Message-Id: <20181219180349.242681-20-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100504_323656_C7A8DEFF 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

The kvm_exit tracepoint strangely always reported exits as being IRQs.
This seems to be because either the __print_symbolic or the tracepoint
macros use a variable named idx.

Take this chance to update the fields in the tracepoint to reflect the
concepts in the arm64 architecture that we pass to the tracepoint and
move the exception type table to the same location and header files as
the exits code.

We also clear out the exception code to 0 for IRQ exits (which
translates to UNKNOWN in text) to make it slighyly less confusing to
parse the trace output.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  4 ----
 arch/arm64/include/asm/kvm_asm.h |  6 ++++++
 virt/kvm/arm/trace.h             | 18 +++++++++---------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6f602af5263c..9921bb7ab6d8 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -320,10 +320,6 @@
 #define PAR_TO_HPFAR(par)		\
 	(((par) & GENMASK_ULL(PHYS_MASK_SHIFT - 1, 12)) >> 8)
 
-#define kvm_arm_exception_type	\
-	{0, "IRQ" }, 		\
-	{1, "TRAP" }
-
 #define ECN(x) { ESR_ELx_EC_##x, #x }
 
 #define kvm_arm_exception_class \
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index aea01a09eb94..b2e12c99db7d 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -34,6 +34,12 @@
 /* The hyp-stub will return this for any kvm_call_hyp() call */
 #define ARM_EXCEPTION_HYP_GONE	  HVC_STUB_ERR
 
+#define kvm_arm_exception_type					\
+	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
+	{ARM_EXCEPTION_EL1_SERROR, 	"SERROR"	},	\
+	{ARM_EXCEPTION_TRAP, 		"TRAP"		},	\
+	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
+
 #ifndef __ASSEMBLY__
 
 #include <linux/mm.h>
diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 57b3edebbb40..f21f04f8036d 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -26,25 +26,25 @@ TRACE_EVENT(kvm_entry,
 );
 
 TRACE_EVENT(kvm_exit,
-	TP_PROTO(int idx, unsigned int exit_reason, unsigned long vcpu_pc),
-	TP_ARGS(idx, exit_reason, vcpu_pc),
+	TP_PROTO(int ret, unsigned int esr_ec, unsigned long vcpu_pc),
+	TP_ARGS(ret, esr_ec, vcpu_pc),
 
 	TP_STRUCT__entry(
-		__field(	int,		idx		)
-		__field(	unsigned int,	exit_reason	)
+		__field(	int,		ret		)
+		__field(	unsigned int,	esr_ec		)
 		__field(	unsigned long,	vcpu_pc		)
 	),
 
 	TP_fast_assign(
-		__entry->idx			= idx;
-		__entry->exit_reason		= exit_reason;
+		__entry->ret			= ARM_EXCEPTION_CODE(ret);
+		__entry->esr_ec = (ARM_EXCEPTION_CODE(ret) == ARM_EXCEPTION_TRAP) ? esr_ec : 0;
 		__entry->vcpu_pc		= vcpu_pc;
 	),
 
 	TP_printk("%s: HSR_EC: 0x%04x (%s), PC: 0x%08lx",
-		  __print_symbolic(__entry->idx, kvm_arm_exception_type),
-		  __entry->exit_reason,
-		  __print_symbolic(__entry->exit_reason, kvm_arm_exception_class),
+		  __print_symbolic(__entry->ret, kvm_arm_exception_type),
+		  __entry->esr_ec,
+		  __print_symbolic(__entry->esr_ec, kvm_arm_exception_class),
 		  __entry->vcpu_pc)
 );
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
