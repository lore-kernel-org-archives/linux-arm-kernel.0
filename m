Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD83C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:29:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1477720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G1s50vc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1477720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m33thXcCHb9JySHXHrFhLq246P04ExblObCiWJGFldw=; b=G1s50vc7Z5xZFw
	km7XamzWexw72cCmDOFgmw1vuqpY8Qie+RyAYXSS/G0neC0U2pM1EUXZV1X3NObm+LEv+0ylBwKwH
	IDLeqZ/A5LgfTKSfnLgm8554kAmjyypM1fB62SVrYcSP1M6LfOhBsIB3IFEKjjFEMlBcOQ71HsFq4
	pemRN+8t6l2+urrTN+p/48TeXpYksFwD5WKADML+I8VnRGfQo116IEZVFOzDImmV3NPLMfAb9x5ZR
	0Skhqd0Ys87Ywv4u/k9L2+9i7NxLfr5exM5Wcxk0xd8A1V57NT1D54HsGY4biVKwNFlJ48vM/LSKH
	Xr5/fvPmtwocBO9Bk38A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrSt-0003XK-RH; Tue, 11 Dec 2018 23:29:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrSq-0003Wr-6X
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:29:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8416E80D;
 Tue, 11 Dec 2018 15:29:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6EC53F614;
 Tue, 11 Dec 2018 15:29:07 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 00/24] KVM: arm64: SVE guest support
Date: Tue, 11 Dec 2018 23:28:37 +0000
Message-Id: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_152920_249952_A0171EF5 
X-CRM114-Status: GOOD (  19.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series implements support for allowing KVM guests to use the Arm
Scalable Vector Extension (SVE).

The patches are also available on a branch for reviewer convenience. [1]

The patches are based on v4.20-rc5, with [3] applied (which includes
some needed refactoring).

This is an interim posting of rework of the previous preliminary
series [2], addressing mostly minor comments, plus one significant
change outlined below which is likely to require discussion -- I'm
posting this series now so that people can comment while I try to work
out how best to improve it.

In the interest of getting this series out for review, this series
remains untested.

For description of minor updates, see the individual patches.


Major changes:

 * Due to sequencing problems between KVM_ARM_VCPU_INIT /
   KVM_ARM_SVE_CONFIG / KVM_ARM_GET_REG_LIST, I have attempted to add
   some enforcement to the order in which ioctls are issued.

   This enforcement is applied on a opt-in basis, enabled by userspace
   specifying the KVM_VM_TYPE_ARM_SVE flag in KVM_CREATE_VM.

   This makes is possible to enforce SVE configuration to happen before
   (and only before) KVM_VCPU_INIT is called.

   **Discussion required**

I'm now doubtful about the resulting model, because:

 * Calling kvm_vcpu_set_target() (via KVM_VCPU_INIT) _after_ setting
   the vcpu's vector lengths "feels wrong".  Surely selecting the
   target CPU would determine the set of vector lengths (or at least
   establish a default set which might subsequently be customised by
   the caller)?

 * The main issue with KVM_VCPU_INIT seems to be that it selects the
   target vcpu and resets it in a single call, providing no
   opportunity to configure the vcpu further before it gets reset and
   is marked ready to run.

   This oddity is also highlighted by the fact that further
   KVM_VCPU_INIT calls are not allowed to reconfigure the vcpu, but
   reset it instead; so KVM_VCPU_INIT is actually welding together two
   different actions.

   Perhaps it would be better to select a modified KVM_VCPU_INIT
   behaviour via a feature flag in kvm_vcpu_init.features, that makes
   KVM_VCPU_INIT return something like -EINPROGRESS after
   kvm_vcpu_set_target().  Then, supplementary config could be done
   via KVM_ARM_SVE_CONFIG etc.

   We could add a dedicated KVM_VCPU_RESET call to finalise the vcpu
   configuration (if unfinalised) and reset it.

   I haven't tried this model out yet, but I'd be interested in
   people's views on it.

   Alternatively, there may be other better ways to crowbar the SVE
   setup into the vcpu creation/initialisation sequence.

   We want something that can be reused without needing to be
   reinvented yet again to support another feature...

   

Known issues:

 * kvmtool/qemu updates are needed to enable creation of SVE-enabled
   guests (to be discussed separately).

 * Build-tested only.


[1]
http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/sve-kvm/rfcv3
git://linux-arm.org/linux-dm.git sve-kvm/rfcv3

[2] [RFC PATCH v2 00/23] KVM: arm64: Initial support for SVE guests
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/604550.html

[3] [PATCH 0/3] Fix KVM_GET_REG_LIST invalid register ID regression
https://lists.cs.columbia.edu/pipermail/kvmarm/2018-December/033710.html


Dave Martin (24):
  arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on task state flush
  KVM: arm64: Delete orphaned declaration for __fpsimd_enabled()
  KVM: arm64: Refactor kvm_arm_num_regs() for easier maintenance
  KVM: arm64: Add missing #include of <linux/bitmap.h> to kvm_host.h
  arm64/sve: Check SVE virtualisability
  arm64/sve: Clarify role of the VQ map maintenance functions
  arm64/sve: Enable SVE state tracking for non-task contexts
  KVM: arm64: Add a vcpu flag to control SVE visibility for the guest
  KVM: arm64: Propagate vcpu into read_id_reg()
  KVM: arm64: Extend reset_unknown() to handle mixed RES0/UNKNOWN
    registers
  KVM: arm64: Support runtime sysreg filtering for KVM_GET_REG_LIST
  KVM: arm64/sve: System register context switch and access support
  KVM: arm64/sve: Context switch the SVE registers
  KVM: Allow 2048-bit register access via ioctl interface
  KVM: arm64: Reject ioctl access to FPSIMD V-regs on SVE vcpus
  KVM: arm64/sve: Add SVE support to register access ioctl interface
  KVM: arm64: Enumerate SVE register indices for KVM_GET_REG_LIST
  arm64/sve: In-kernel vector length availability query interface
  KVM: arm: Move detection of invalid VM type bits to generic code
  KVM: arm: Add support for early vcpu configuration ioctls
  KVM: arm64/sve: Report and enable SVE API extensions for userspace
  KVM: arm64/sve: allow KVM_ARM_SVE_CONFIG_QUERY on vm fd
  KVM: Documentation: Document arm64 core registers in detail
  KVM: arm64/sve: Document KVM API extensions for SVE

 Documentation/virtual/kvm/api.txt | 194 +++++++++++++++++++
 arch/arm/include/asm/kvm_host.h   |  21 +-
 arch/arm/include/uapi/asm/kvm.h   |   3 +
 arch/arm64/include/asm/fpsimd.h   |  33 +++-
 arch/arm64/include/asm/kvm_host.h |  40 +++-
 arch/arm64/include/asm/kvm_hyp.h  |   1 -
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/uapi/asm/kvm.h |  24 +++
 arch/arm64/kernel/cpufeature.c    |   2 +-
 arch/arm64/kernel/fpsimd.c        | 172 ++++++++++++-----
 arch/arm64/kernel/signal.c        |   5 -
 arch/arm64/kvm/fpsimd.c           |  15 +-
 arch/arm64/kvm/guest.c            | 396 +++++++++++++++++++++++++++++++++++---
 arch/arm64/kvm/hyp/switch.c       |  70 +++++--
 arch/arm64/kvm/reset.c            |  69 ++++++-
 arch/arm64/kvm/sys_regs.c         | 144 ++++++++++++--
 arch/arm64/kvm/sys_regs.h         |  15 +-
 include/uapi/linux/kvm.h          |  14 ++
 virt/kvm/arm/arm.c                |  16 +-
 19 files changed, 1107 insertions(+), 130 deletions(-)

-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
