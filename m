Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A742133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wiu37uDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A742133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zuJe7Os1tH39aRr0QvvBhH6/mAd1+lfsQ3gSaaGIjaU=; b=Wiu
	37uDfzDCb5QFAliJNmLMGLznB/slbeaNippgZ5GARC7anDLi4a/v3GVwevooyIwSQaTbYVMnPMC/V
	/kqMtaMA0cgDCBeXKo4rqqLXuoLVrdLWuX9pPueNtD4ADbQngIcO8gZIRCr5sXwQmDfdJ+XmF5qpf
	BWqEtAAPNf7XEDTzzJS1oEUEQCzvD681CRqYh9khioEQFo81/40zfGY6IoWqNWqD5MutXfiZAFXn2
	qEng5vJgw+5EWlvABEFuWwXDHW/8M8vkqHY6syN0SeGTg/Sf5dmlDfnOGLjBqOxDEiTZatx5JyaUz
	kLKO7mdcraQkpuq5puSUMUZh8f0oPQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAGC-0001ml-DQ; Tue, 18 Dec 2018 07:57:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAFp-0001HB-D5
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 07:57:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 367D480D;
 Mon, 17 Dec 2018 23:57:09 -0800 (PST)
Received: from a75553-lin.blr.arm.com (a75553-lin.blr.arm.com [10.162.0.175])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9E47D3F575; Mon, 17 Dec 2018 23:57:05 -0800 (PST)
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] Add ARMv8.3 pointer authentication for kvm guest
Date: Tue, 18 Dec 2018 13:26:44 +0530
Message-Id: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_235725_718053_A778553C 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: Andrew Jones <drjones@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This patch series adds pointer authentication support for KVM guest and
is based on top of Linux 4.20-rc5 and generic pointer authentication patch
series[1]. The first two patch in this series was originally posted by
Mark Rutland earlier[2,3] and contains some history of this work.

Extension Overview:
=============================================

The ARMv8.3 pointer authentication extension adds functionality to detect
modification of pointer values, mitigating certain classes of attack such as
stack smashing, and making return oriented programming attacks harder.

The extension introduces the concept of a pointer authentication code (PAC),
which is stored in some upper bits of pointers. Each PAC is derived from the
original pointer, another 64-bit value (e.g. the stack pointer), and a secret
128-bit key.

New instructions are added which can be used to:

* Insert a PAC into a pointer
* Strip a PAC from a pointer
* Authenticate and strip a PAC from a pointer

The detailed description of ARMv8.3 pointer authentication support in
userspace/kernel can be found in Kristina's generic pointer authentication
patch series[1].

KVM guest work:
==============================================

If pointer authentication is enabled for KVM guests then the new PAC intructions
will not trap to EL2. If not then they may be ignored if in HINT region or trapped
in EL2 as illegal instruction. Since KVM guest vcpu runs as a thread so they have
a key initialised which will be used by PAC. When world switch happens between
host and guest then this key is exchanged.

There were some review comments by Christoffer Dall in the original series[2,3,4]
and this patch series tries to implement them. The original series enabled pointer
authentication for both userspace and kvm userspace. However it is now
bifurcated and this series contains only KVM guest support.

Changes since v3 [4]:
* Use pointer authentication only when VHE is present as ARM8.3 implies ARM8.1
  features to be present.
* Added lazy context handling of ptrauth instructions from V2 version again. 
* Added more details in Documentation.
* Rebased to new version of generic ptrauth patches [1].

Changes since v2 [2,3]:
* Allow host and guest to have different HCR_EL2 settings and not just constant
  value HCR_HOST_VHE_FLAGS or HCR_HOST_NVHE_FLAGS.
* Optimise the reading of HCR_EL2 in host/guest switch by fetching it once
  during KVM initialisation state and using it later.
* Context switch pointer authentication keys when switching between guest
  and host. Pointer authentication was enabled in a lazy context earlier[2] and
  is removed now to make it simple. However it can be revisited later if there
  is significant performance issue.
* Added a userspace option to choose pointer authentication.
* Based on the userspace option, ptrauth cpufeature will be visible.
* Based on the userspace option, ptrauth key registers will be accessible.
* A small document is added on how to enable pointer authentication from
  userspace KVM API.

Looking for feedback and comments.

Thanks,
Amit

[1]: https://lkml.org/lkml/2018/12/7/666
[2]: https://lore.kernel.org/lkml/20171127163806.31435-11-mark.rutland@arm.com/
[3]: https://lore.kernel.org/lkml/20171127163806.31435-10-mark.rutland@arm.com/
[4]: https://lkml.org/lkml/2018/10/17/594


Linux (4.20-rc5 based):


Amit Daniel Kachhap (5):
  arm64/kvm: preserve host HCR_EL2 value
  arm64/kvm: context-switch ptrauth registers
  arm64/kvm: add a userspace option to enable pointer authentication
  arm64/kvm: enable pointer authentication cpufeature conditionally
  arm64/kvm: control accessibility of ptrauth key registers

 Documentation/arm64/pointer-authentication.txt | 13 ++--
 Documentation/virtual/kvm/api.txt              |  4 ++
 arch/arm/include/asm/kvm_host.h                |  7 ++
 arch/arm64/include/asm/cpufeature.h            |  6 ++
 arch/arm64/include/asm/kvm_asm.h               |  2 +
 arch/arm64/include/asm/kvm_host.h              | 41 +++++++++++-
 arch/arm64/include/asm/kvm_hyp.h               |  7 ++
 arch/arm64/include/uapi/asm/kvm.h              |  1 +
 arch/arm64/kernel/traps.c                      |  1 +
 arch/arm64/kvm/handle_exit.c                   | 24 ++++---
 arch/arm64/kvm/hyp/Makefile                    |  1 +
 arch/arm64/kvm/hyp/ptrauth-sr.c                | 89 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c                    | 19 ++++--
 arch/arm64/kvm/hyp/sysreg-sr.c                 | 11 ++++
 arch/arm64/kvm/hyp/tlb.c                       |  6 +-
 arch/arm64/kvm/reset.c                         |  3 +
 arch/arm64/kvm/sys_regs.c                      | 91 ++++++++++++++++++++------
 include/uapi/linux/kvm.h                       |  1 +
 virt/kvm/arm/arm.c                             |  4 ++
 19 files changed, 289 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/ptrauth-sr.c

kvmtool:

Repo: git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
Amit Daniel Kachhap (1):
  arm/kvm: arm64: Add a vcpu feature for pointer authentication

 arm/aarch32/include/kvm/kvm-cpu-arch.h    | 2 ++
 arm/aarch64/include/asm/kvm.h             | 3 +++
 arm/aarch64/include/kvm/kvm-arch.h        | 1 +
 arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h    | 2 ++
 arm/aarch64/kvm-cpu.c                     | 5 +++++
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 arm/kvm-cpu.c                             | 7 +++++++
 include/linux/kvm.h                       | 1 +
 9 files changed, 25 insertions(+), 1 deletion(-)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
