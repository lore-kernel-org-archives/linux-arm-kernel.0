Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB97FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A161F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tajDKBWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A161F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lmk8yXjNYsvSYh6Cri+U9C+qyTd9FTztd5j8I24ooS8=; b=tajDKBWNn2adSu
	bqignsM4lISNMu/GorG8RGyAnxjh7W+ms8WrgWzRNxadBFyZbTjCgbSECg7Ag8RupDD7dRtuR+0Oq
	qR/oDnnEIUjFUyocgnGYjMr+1jS8dTJCSmyCZrKUNraMJQXrUJqnqS4R7Etr3kkd4JRVCqgegXPN8
	eCZu63xRK9ZRE0POQ3ROEkyJujq9Iv+PxnSJpuadCaiLvbPh5UhJ3Xyp/c6VoTOtPZO2olWWQZN+a
	mvbqYXWz7q2kxvB+wdHJ4pfXB5Dq4YSefd2vCAUVvpbd7N/T3+w6XP5Zb01DPu+TUvnRKIIvNb+GX
	Y+KAi7OY35CQwy/uFQiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxVm-0000rm-Gu; Thu, 06 Dec 2018 17:32:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxV4-00007i-05
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:31:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6F680D;
 Thu,  6 Dec 2018 09:31:35 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55383F5AF;
 Thu,  6 Dec 2018 09:31:33 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 0/8] Workaround for Cortex-A76 erratum 1165522
Date: Thu,  6 Dec 2018 17:31:18 +0000
Message-Id: <20181206173126.139877-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093146_136013_6847B4D6 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Early Cortex-A76 suffer from an erratum that can result in invalid
TLBs when the CPU speculatively executes an AT instruction in the
middle of a guest world switch, while the guest virtual memory
configuration is in an inconsistent state.

We handle this issue by mandating the use of VHE and making sure that
the guest context is fully installed before switching HCR_EL2.TGE to
zero. This ensures that a speculated AT instruction is either executed
on the host context (TGE set) or the guest context (TGE clear), and
that there is no intermediate state.

There is some additional complexity in the TLB invalidation code,
where we most make sure that a speculated AT instruction cannot mess
the stage-1 TLBs.

* From v2:
  - Dropped a bunch of spurious ISBs after James review
  - Added James RBs.

* From v1:
  - VHE TLB invalidation now atomic
  - Avoid speculated AT during TLB invalidation
  - Addressed most comments from Christoffer
  - Resplit to ease reviewing

Marc Zyngier (8):
  arm64: KVM: Make VHE Stage-2 TLB invalidation operations
    non-interruptible
  KVM: arm64: Rework detection of SVE, !VHE systems
  arm64: KVM: Install stage-2 translation before enabling traps
  arm64: Add TCR_EPD{0,1} definitions
  arm64: KVM: Force VHE for systems affected by erratum 1165522
  arm64: KVM: Add synchronization on translation regime change for
    erratum 1165522
  arm64: KVM: Handle ARM erratum 1165522 in TLB invalidation
  arm64: Add configuration/documentation for Cortex-A76 erratum 1165522

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm/include/asm/kvm_host.h        |  2 +-
 arch/arm64/Kconfig                     | 12 +++++
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/include/asm/kvm_host.h      | 10 ++--
 arch/arm64/include/asm/kvm_hyp.h       |  8 +++
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++
 arch/arm64/kernel/cpu_errata.c         |  8 +++
 arch/arm64/kvm/hyp/switch.c            | 23 ++++++++-
 arch/arm64/kvm/hyp/tlb.c               | 71 ++++++++++++++++++++++----
 virt/kvm/arm/arm.c                     |  8 +--
 11 files changed, 129 insertions(+), 21 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
