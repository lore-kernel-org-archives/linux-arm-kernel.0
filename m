Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC9C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B84218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kPzxNuLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B84218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rveG6DztV5bs5Pb+BxVz8AQKir3+sh+ocYjN52CDZOM=; b=kPz
	xNuLjpV4w1pgKhM/3RzbyJ8BhEhrPmy9ggtzzxDzgj3eefVA+iUz7NF++NKDWY12K/03/sCfvTCRq
	8MrZJg9hogOTNGE5s1bhl6V+TLVGXD5JjBqokI+ViPIewObG7uw/JiVbRlryk8kd9Ddgt7KMi+4u3
	PvvFdy3IqIe8k+2LG2DMChF8fhnWBsQaWkeQwBit9LzzMqkA+13gtWQ8L14S1XL7QIVmsMstiPARj
	+9QKLwdccAoKiZxwbfM9S+vXj+qqjm22DEPi92jS7fOl/gJk6szVsri9FzfwktSw5RtgnDLqMRMvQ
	7Nex66m70YbGgnkZvc6ISsauqXVd/Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfZB-0003Lb-QE; Thu, 24 Jan 2019 14:01:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYa-0002mq-Vv
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:00:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0C2A78;
 Thu, 24 Jan 2019 06:00:36 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB013F5C1;
 Thu, 24 Jan 2019 06:00:35 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/14] KVM: arm/arm64: Various rework in preparation of nested
 virt support
Date: Thu, 24 Jan 2019 15:00:18 +0100
Message-Id: <20190124140032.8588-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060037_027462_B6A55A0E 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series contains a somewhat random set of reworks and improvements to the
KVM/Arm code in preparation for nested virtualization support.

We plan to merge these as early as v5.1.

The series relies on an additional patch which exposes the physical EL1 timer's
IRQ number to KVM:
  "clocksource/arm_arch_timer: Store physical timer IRQ number for KVM on VHE"
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1908965.html


Andre Przywara (1):
  KVM: arm/arm64: consolidate arch timer trap handlers

Christoffer Dall (6):
  KVM: arm/arm64: Factor out VMID into struct kvm_vmid
  KVM: arm/arm64: Simplify bg_timer programming
  KVM: arm/arm64: timer: Rework data structures for multiple timers
  KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems
  KVM: arm/arm64: Rework the timer code to use a timer_map
  KVM: arm/arm64: Move kvm_is_write_fault to header file

Marc Zyngier (7):
  arm/arm64: KVM: Introduce kvm_call_hyp_ret()
  arm64: KVM: Allow for direct call of HYP functions when using VHE
  arm64: KVM: Drop VHE-specific HYP call stub
  ARM: KVM: Teach some form of type-safety to kvm_call_hyp
  arm/arm64: KVM: Statically configure the host's view of MPIDR
  KVM: arm64: Fix ICH_ELRSR_EL2 sysreg naming
  KVM: arm64: Reuse sys_reg() macro when searching the trap table

 arch/arm/include/asm/arch_gicv3.h    |   4 +-
 arch/arm/include/asm/kvm_emulate.h   |   8 +
 arch/arm/include/asm/kvm_host.h      |  53 ++-
 arch/arm/include/asm/kvm_hyp.h       |   4 +
 arch/arm/include/asm/kvm_mmu.h       |  11 +
 arch/arm/kvm/coproc.c                |  23 +-
 arch/arm/kvm/hyp/cp15-sr.c           |   1 -
 arch/arm/kvm/hyp/hyp-entry.S         |   2 +-
 arch/arm/kvm/hyp/switch.c            |   2 +-
 arch/arm/kvm/hyp/tlb.c               |   4 +-
 arch/arm/kvm/interrupts.S            |   4 +-
 arch/arm64/include/asm/kvm_emulate.h |   8 +
 arch/arm64/include/asm/kvm_host.h    |  48 ++-
 arch/arm64/include/asm/kvm_hyp.h     |   3 +-
 arch/arm64/include/asm/kvm_mmu.h     |  11 +
 arch/arm64/include/asm/sysreg.h      |   6 +-
 arch/arm64/kvm/debug.c               |   2 +-
 arch/arm64/kvm/hyp.S                 |   3 -
 arch/arm64/kvm/hyp/hyp-entry.S       |  12 -
 arch/arm64/kvm/hyp/sysreg-sr.c       |   1 -
 arch/arm64/kvm/sys_regs.c            |  99 +++--
 include/kvm/arm_arch_timer.h         |  68 +++-
 virt/kvm/arm/arch_timer.c            | 583 +++++++++++++++++++--------
 virt/kvm/arm/arm.c                   |  62 +--
 virt/kvm/arm/hyp/vgic-v3-sr.c        |   2 +-
 virt/kvm/arm/mmu.c                   |  10 +-
 virt/kvm/arm/trace.h                 | 105 +++++
 virt/kvm/arm/vgic/vgic-v3.c          |   4 +-
 28 files changed, 799 insertions(+), 344 deletions(-)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
