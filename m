Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B696C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384E02173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EkseoXRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384E02173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=0wzyzNI2kdzTvlNtZ40a7sJJM2kMU/B810kCCcd73Fw=; b=Eks
	eoXRwD9Lk47NJ/hLd1rOKggIn6BrNJzLYknLPdUxMob80Ekg1/FeA3uiE38vPlXFSXprD2ihB5B9A
	w3Hz5GFoyhZwW2nWM6V+dfkCySNoMFIjtDw+6f+rMvrt7crisM00IeNhkBLsm2GGtaKh7Oa/plfOm
	7Y6cH0F/8AswmbsNuCL5eGaWaErqDnpxXu0IKKZEwXE5MnkJnnZLzR7j6EWhUyhNY+UwW3GMLVK7x
	x3hyD1tpmy7b7k/zrP79bB5lB3vQQ2NFQM/FocKH3zMhFpCVdNhsv50LiTVmR8lS996eIo8h8U5VN
	mBHtg8d4gIjSfsr/9FQGC+f3AQBz0IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggW6N-0004Tx-9Q; Mon, 07 Jan 2019 14:42:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggW69-0004LB-Ck
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 14:41:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B540E80D;
 Mon,  7 Jan 2019 06:41:45 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5DB3F5AF;
 Mon,  7 Jan 2019 06:41:43 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v9 0/5] arm64: Support perf event modifiers :G and :H
Date: Mon,  7 Jan 2019 14:41:24 +0000
Message-Id: <1546872089-56278-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_064149_436873_660043FF 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset provides support for perf event modifiers :G and :H which
allows for filtering of PMU events between host and guests when used
with KVM.

As the underlying hardware cannot distinguish between guest and host
context, the performance counters must be stopped and started upon
entry/exit to the guest. This is performed at EL2 in a way that
minimizes overhead and improves accuracy of recording events that only
occur in the requested context.

This has been tested with VHE and non-VHE kernels with a KVM guest.

Changes from v8:

 - Added additional comments
 - Fixed bisect build failure
 - Renamed cpu_ctxt variable to cpu_data

Changes from v7:

 - Added additional patch to encapsulate kvm_cpu_context in kvm_host_data

Changes from v6:

 - Move events_host/events_guest out of kvm_cpu_context

Changes from v5:

 - Tweak logic in use of kvm_set_pmu_events

Changes from v4:

 - Prevent unnecessary write_sysreg calls by improving
   __pmu_switch_to_xxx logic.

Changes from v3:

 - Remove confusing _only suffix from bitfields in kvm_cpu_context
 - Remove unnecessary condition when clearing event bits in disable
 - Simplify API of KVM accessors
 - Prevent unnecessary setting of pmcnten when guest/host events are
   the same.

Changes from v2:

 - Ensured that exclude_kernel works for guest
 - Removed unnecessary exclusion of EL2 with exclude_host on !VHE
 - Renamed kvm_clr_set_host_pmu_events to reflect args order
 - Added additional information to isb patch

Changes from v1:

 - Removed unnecessary exclusion of EL1 with exclude_guest on VHE
 - Removed unnecessary isb from existing perf_event.c driver
 - Folded perf_event.c patches together
 - Added additional information to last patch commit message


Andrew Murray (5):
  arm64: arm_pmu: remove unnecessary isb instruction
  arm64: KVM: encapsulate kvm_cpu_context in kvm_host_data
  arm64: KVM: add accessors to track guest/host only counters
  arm64: arm_pmu: Add support for exclude_host/exclude_guest attributes
  arm64: KVM: Enable support for :G/:H perf event modifiers

 arch/arm/include/asm/kvm_host.h   |  8 ++++--
 arch/arm64/include/asm/kvm_asm.h  |  4 +--
 arch/arm64/include/asm/kvm_host.h | 42 +++++++++++++++++++++++----
 arch/arm64/kernel/asm-offsets.c   |  2 +-
 arch/arm64/kernel/perf_event.c    | 54 +++++++++++++++++++++++++++++------
 arch/arm64/kvm/hyp/switch.c       | 60 +++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/arm.c                | 12 ++++----
 7 files changed, 159 insertions(+), 23 deletions(-)

-- 
2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
