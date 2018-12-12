Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E254CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:03:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20B520873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n4kr58Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20B520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NTGKxY3cJExoFK5+D9izRJO+2vIwy+qoClEO21mz8+k=; b=n4kr58Gy21cBhv
	OyNi3X+30SWJG7UF2/sC1JrHbzq9TQsU4AAsfDgaWToa1PuV1ByUICASm36WgYxD6bCs7S/uk1ZQ9
	BG2Z68X0eW825guFjcG/jdv8YfxspMseN7+bh7M5QimfzBqAUlEwNmm41gTYdQ01gWCIYImxiygvn
	brQWVNYpmqGMj4V0L3hr2fUA5aX8wkfRTrf0JIb0tDLsJ0/oNIVA42F5Kmr29X6Gkwml/PPaizl/A
	CEj8RZOWqXlY3DJL8rvZkhz5Bu8pn6TtQtv1qJXrh3bZwDQ2zkgY1ZluWuGnIO9cLxtT8WmLIIGiG
	3e5K3mfo8xRE2GKXBBmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX62b-0006S5-C4; Wed, 12 Dec 2018 15:03:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62U-0006BQ-M0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976C4EBD;
 Wed, 12 Dec 2018 07:02:53 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE173F59C;
 Wed, 12 Dec 2018 07:02:51 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 00/12] arm64: Paravirtualized time support
Date: Wed, 12 Dec 2018 15:02:14 +0000
Message-Id: <20181212150226.38051-1-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070306_747725_77439BAC 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series add support for paravirtualized time for Arm64 guests and
KVM hosts following the specification in Arm's document DEN 0057A:

https://developer.arm.com/docs/den0057/a

It implements support for Live Physical Time (LPT) which provides the
guest with a method to derive a stable counter of time during which the
guest is executing even when the guest is being migrated between hosts
with different physical counter frequencies.

It also implements support for stolen time, allowing the guest to
identify time when it is forcibly not executing.

Patch 1 provides some documentation
Patches 2-4 and 8 provide some refactoring of existing code
Patches 5-7 and 9 implement cmmon code and support for stolen time
Patches 10-12 implement Live Physical Time

Changes since v1:
 * Live physical time changes split up and moved to the last three patches
   of the series.
 * Renamed arm_smccc_1_1 to arm_smccc_1_1_call to match Mark Rutland's series
   tidying SMCCC up. Potentially these changes can be dropped in favour of
   Mark's series.
 * Renamed things to avoid use of "page" as the shared structures are not
   necessarily an entire/single page.
 * Moved the contents of include/kvm/arm_pv.h to include/linux/arm-smccc.h
 * Fix definition of GPA_INVALID to be sign-extension safe

Christoffer Dall (1):
  KVM: arm/arm64: Factor out hypercall handling from PSCI code

Steven Price (11):
  KVM: arm64: Document PV-time interface
  arm/arm64: Provide a wrapper for SMCCC 1.1 calls
  arm/arm64: Make use of the SMCCC 1.1 wrapper
  KVM: arm64: Implement PV_FEATURES call
  KVM: arm64: Support stolen time reporting via shared structure
  arm64: Retrieve stolen time as paravirtualized guest
  KVM: Allow kvm_device_ops to be const
  KVM: arm64: Provide a PV_TIME device to user space
  KVM: arm64: Support Live Physical Time reporting
  clocksource: arm_arch_timer: Use paravirtualized LPT
  KVM: arm64: Export LPT using PV_TIME device

 Documentation/virtual/kvm/arm/pvtime.txt | 169 ++++++++++++++
 arch/arm/kvm/Makefile                    |   2 +-
 arch/arm/kvm/handle_exit.c               |   2 +-
 arch/arm/mm/proc-v7-bugs.c               |  46 ++--
 arch/arm64/include/asm/arch_timer.h      |  32 ++-
 arch/arm64/include/asm/kvm_host.h        |  16 ++
 arch/arm64/include/asm/kvm_mmu.h         |   2 +
 arch/arm64/include/asm/pvclock-abi.h     |  32 +++
 arch/arm64/include/uapi/asm/kvm.h        |   8 +
 arch/arm64/kernel/Makefile               |   1 +
 arch/arm64/kernel/cpu_errata.c           |  47 +---
 arch/arm64/kernel/cpuinfo.c              |   2 +-
 arch/arm64/kernel/kvm.c                  | 156 +++++++++++++
 arch/arm64/kvm/Kconfig                   |   1 +
 arch/arm64/kvm/Makefile                  |   2 +
 arch/arm64/kvm/handle_exit.c             |   4 +-
 drivers/clocksource/arm_arch_timer.c     | 177 ++++++++++++++-
 include/kvm/arm_arch_timer.h             |   2 +
 include/kvm/arm_hypercalls.h             |  44 ++++
 include/kvm/arm_psci.h                   |   2 +-
 include/linux/arm-smccc.h                |  64 ++++++
 include/linux/cpuhotplug.h               |   1 +
 include/linux/kvm_host.h                 |   4 +-
 include/linux/kvm_types.h                |   2 +
 include/uapi/linux/kvm.h                 |   2 +
 virt/kvm/arm/arm.c                       |  25 ++-
 virt/kvm/arm/hypercalls.c                | 271 +++++++++++++++++++++++
 virt/kvm/arm/mmu.c                       |  44 ++++
 virt/kvm/arm/psci.c                      |  76 +------
 virt/kvm/arm/pvtime.c                    | 244 ++++++++++++++++++++
 virt/kvm/kvm_main.c                      |   6 +-
 31 files changed, 1333 insertions(+), 153 deletions(-)
 create mode 100644 Documentation/virtual/kvm/arm/pvtime.txt
 create mode 100644 arch/arm64/include/asm/pvclock-abi.h
 create mode 100644 arch/arm64/kernel/kvm.c
 create mode 100644 include/kvm/arm_hypercalls.h
 create mode 100644 virt/kvm/arm/hypercalls.c
 create mode 100644 virt/kvm/arm/pvtime.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
