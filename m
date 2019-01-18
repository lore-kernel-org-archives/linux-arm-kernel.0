Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF6B20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5izB999"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF6B20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6g+IJWjtqlAFkR881kNClOLKqg9vF2a+iUtMFYDAirQ=; b=H5izB999/p9TGIpAuHDYzmdpec
	xpgiTxTkM86o43OhJYUMTbfWgL1dC2oJAt1Mf1AkgqmqIJ8iPrgQ10SqGuV2PqYU//Bxc0YJMKigW
	gfsfrl44hlFoxfpL2p6pxbh0scsAQAyISBsDeBi5hgtaWKPdbwFKEKYc/3G0tfntMyLGyJTx6I657
	m1BHYQHgXhTp24n0Ds171reHlVZt/WWZ/BbagB8wOrpQTUYZ1ft7S97GCiRoj9dGXr2pFjbsIMw/d
	6NK9cVya8fK70RjMRhFRhGxXLdLVB5O4xzH2vGNviHecIXH/NdMkZeOk05IPXRq7xD5x3XRG+4yAf
	bAyDs7yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWpX-0006r2-Hy; Fri, 18 Jan 2019 16:17:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWns-0005Tx-JX
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BC30EBD;
 Fri, 18 Jan 2019 08:15:32 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BD263F557;
 Fri, 18 Jan 2019 08:15:30 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 08/12] arm64: [HACK] Basic SVE support
Date: Fri, 18 Jan 2019 16:14:17 +0000
Message-Id: <1547828061-20462-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081533_499784_741E7FEE 
X-CRM114-Status: GOOD (  13.48  )
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
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For compatibility reasons, new vcpus created by KVM always have SVE
disabled by default.

To enable SVE to be turned on, this patch adds an option --sve.

Currently, no independent control is added per-vcpu.  This means
that it is not currently possible to create a VM containing a mix
of SVE-enabled and non-SVE-enabled vcpus.  This functionality could
be added later if desired.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch64/include/kvm/kvm-config-arch.h | 2 ++
 arm/aarch64/include/kvm/kvm-cpu-arch.h    | 3 ++-
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index cb3f8bc..7710f14 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -6,6 +6,8 @@
 			"Run AArch32 guest"),				\
 	OPT_BOOLEAN('\0', "pmu", &(cfg)->has_pmuv3,			\
 			"Create PMUv3 device"),				\
+	OPT_BOOLEAN('\0', "sve", &(cfg)->has_sve,			\
+		    "Enable SVE for the guest"),			\
 	OPT_BOOLEAN('\0', "show-reg-list", &(cfg)->show_reg_list,	\
 		    "Show the list of KVM register IDs on startup"),	\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
index a9d8563..6aeddde 100644
--- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
@@ -8,7 +8,8 @@
 #define ARM_VCPU_FEATURE_FLAGS(kvm, cpuid)	{				\
 	[0] = ((!!(cpuid) << KVM_ARM_VCPU_POWER_OFF) |				\
 	       (!!(kvm)->cfg.arch.aarch32_guest << KVM_ARM_VCPU_EL1_32BIT) |	\
-	       (!!(kvm)->cfg.arch.has_pmuv3 << KVM_ARM_VCPU_PMU_V3))		\
+	       (!!(kvm)->cfg.arch.has_pmuv3 << KVM_ARM_VCPU_PMU_V3) |		\
+	       (!!(kvm)->cfg.arch.has_sve << KVM_ARM_VCPU_SVE))			\
 }
 
 #define ARM_MPIDR_HWID_BITMASK	0xFF00FFFFFFUL
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index f18bfd4..6abb170 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -9,6 +9,7 @@ struct kvm_config_arch {
 	bool		virtio_trans_pci;
 	bool		aarch32_guest;
 	bool		has_pmuv3;
+	bool		has_sve;
 	bool		show_reg_list;
 	u64		kaslr_seed;
 	enum irqchip_type irqchip;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
