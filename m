Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12418C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:04:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1E9218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lYfm8ptW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1E9218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=024ouv3iZEVRUOBhE5eLcMVb/+hfCQ6KSTtq9TjPJ2c=; b=lYfm8ptWP+vrA0
	eg60zuev3hs71No6ZODJtht0P++VUr8T36grUOJI7uDIvwnV+OwwzXSzlxqhB8183Nv0XenBSgQog
	0WHoMmQMRmwrPhll2QK7ogIJwjiJpKe5MvVdVfyV7+WqGtRlTxLjWGGSsXkkZeBd9guh/UFUfMxOh
	9Q6og9JWTcBXmnvOHdjmJhsvJ84X8H566tHr0UVqnHstYHpktp92knQiUipLTzQuqr0uwT6PEvv6T
	h+dCuAjb+ssbu48j3syWOHQEbqjxX7l8q26CRAaNBy70v1LM+0+1JzDGrVP+KKIxk3yPtsED62HoS
	/jmNCOTbS39Wtb+GyLuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgDC-0006If-JL; Wed, 19 Dec 2018 18:04:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgCj-0005p5-4q
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:04:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DC1165C;
 Wed, 19 Dec 2018 10:04:20 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35C723F675;
 Wed, 19 Dec 2018 10:04:18 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 04/28] KVM: arm/arm64: Log PSTATE for unhandled sysregs
Date: Wed, 19 Dec 2018 18:03:25 +0000
Message-Id: <20181219180349.242681-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100421_312406_9EA630B1 
X-CRM114-Status: GOOD (  13.91  )
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

From: Mark Rutland <mark.rutland@arm.com>

When KVM traps an unhandled sysreg/coproc access from a guest, it logs
the guest PC. To aid debugging, it would be helpful to know which
exception level the trap came from, along with other PSTATE/CPSR bits,
so let's log the PSTATE/CPSR too.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c     | 4 ++--
 arch/arm64/kvm/sys_regs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index cb094e55dc5f..222c1635bc7a 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -602,8 +602,8 @@ static int emulate_cp15(struct kvm_vcpu *vcpu,
 		}
 	} else {
 		/* If access function fails, it should complain. */
-		kvm_err("Unsupported guest CP15 access at: %08lx\n",
-			*vcpu_pc(vcpu));
+		kvm_err("Unsupported guest CP15 access at: %08lx [%08lx]\n",
+			*vcpu_pc(vcpu), *vcpu_cpsr(vcpu));
 		print_cp_instr(params);
 		kvm_inject_undefined(vcpu);
 	}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22fbbdbece3c..ecbf67ccabf5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1912,8 +1912,8 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 		WARN_ON(1);
 	}
 
-	kvm_err("Unsupported guest CP%d access at: %08lx\n",
-		cp, *vcpu_pc(vcpu));
+	kvm_err("Unsupported guest CP%d access at: %08lx [%08lx]\n",
+		cp, *vcpu_pc(vcpu), *vcpu_cpsr(vcpu));
 	print_sys_reg_instr(params);
 	kvm_inject_undefined(vcpu);
 }
@@ -2063,8 +2063,8 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
 	} else {
-		kvm_err("Unsupported guest sys_reg access at: %lx\n",
-			*vcpu_pc(vcpu));
+		kvm_err("Unsupported guest sys_reg access at: %lx [%08lx]\n",
+			*vcpu_pc(vcpu), *vcpu_cpsr(vcpu));
 		print_sys_reg_instr(params);
 		kvm_inject_undefined(vcpu);
 	}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
