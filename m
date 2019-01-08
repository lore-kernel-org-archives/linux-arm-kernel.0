Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5030C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FD3206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VFDYeF9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FD3206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Muy0NGU/6UMS1+fl2qChqaTnNY/80lGK+7gKIO+JP34=; b=VFD
	YeF9zgCOQ4iv4VI+wRCF6HYDC0yhd2TaSg4yfSeIhFFSOLTeWYCK/I0eZfqYW9vMx/tcm7/FQ3KIo
	fIJLtsnEs21Cw1ovTTPAizcjqYpAkMLxOca6Pjocvn7aq3Jh6R6V+4OtGYu46r72FAnK6t22d2iPQ
	b5+CmXObCE85E8FrELnkspUfZZYtPBFkUy/DURkYbQF5hL7e8gebs+ZDkB2TZmMHwK/w4cZLM6rtI
	JjKfxtU5v675lOH6wcbPLMpc8xGkHmMOjOOYnPdgltkIGlOQulfHuRp0XYteMDqbzTCYEdN1KX1N1
	zFmxrvGSJqtKekPJidZN03mrLOI7kgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs37-00073Q-4Y; Tue, 08 Jan 2019 14:08:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs2w-0006ru-Md
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89E380D;
 Tue,  8 Jan 2019 06:07:57 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8F773F70D;
 Tue,  8 Jan 2019 06:07:55 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 00/26] arm64: provide pseudo NMI with GICv3
Date: Tue,  8 Jan 2019 14:07:18 +0000
Message-Id: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060758_984390_CCDF6455 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This series is a continuation of the work started by Daniel [1]. The goal
is to use GICv3 interrupt priorities to simulate an NMI.

The patches depend on the core API for NMIs patches [2]. Both series can
be found on this branch:
git clone http://linux-arm.org/linux-jt.git -b v4.20-pseudo-nmi


To achieve this, set two priorities, one for standard interrupts and
another, higher priority, for NMIs. Whenever we want to disable interrupts,
we mask the standard priority instead so NMIs can still be raised. Some
corner cases though still require to actually mask all interrupts
effectively disabling the NMI.

Daniel Thompson ran some benchmarks [3] on a previous version showing a
small (<1%) performance drop when using interrupt priorities on Cortex-A53
and GIC-500.

Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now. LPIs being controlled by the ITS cannot be delivered as NMI.
When an NMI is active on a CPU, no other NMI can be triggered on the CPU.

Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs or have single security state
- Select Kernel Feature -> Support for NMI-like interrupts
- Provide "enable_pseudo_nmi" on the kernel command line


* Patch 1 fixes an existing issue with current NMI contexts in arm64
* Patches 2 and 3 are just a bit of cleanup
* Patch 4 introduces a CPU feature to check if priority masking should be
  used
* Patches 5 and 6 add the support for priority masking in GICv3 driver
* Patches 7 to 13 add the support for priority masking the arch/arm64
  code
* Patches 14 and 15 allow us to apply alternatives earlier in the boot
  process
* Patches 16 to 18 starts the PMR masking on cpu startup and provides
  primitives for arm64 GICv3 driver to perform priority masking
* Patches 19 to 22 Add support for pseudo-NMIs in GICv3 driver
* Patches 23 to 25 Add support for receiving NMIs in arch/arm64
* Patch 26 adds the build config and command line option to enable
  pseudo-NMIs


Changes since v7[4]:
* Rebase on v5.0-rc1
* Move default arch_nmi_enter/exit definition to fix build issues
* Override flags to preserve accross EFI services calls


[1] http://www.spinics.net/lists/arm-kernel/msg525077.html
[2] https://lkml.org/lkml/2018/11/12/2113
[3] https://lkml.org/lkml/2018/7/20/803
[4] https://www.spinics.net/lists/arm-kernel/msg695086.html

Cheers,

Julien

-->

Daniel Thompson (1):
  arm64: alternative: Apply alternatives early in boot process

Julien Thierry (25):
  arm64: Fix HCR.TGE status for NMI contexts
  arm64: Remove unused daif related functions/macros
  arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
  arm64: cpufeature: Add cpufeature for IRQ priority masking
  arm/arm64: gic-v3: Add PMR and RPR accessors
  irqchip/gic-v3: Switch to PMR masking before calling IRQ handler
  arm64: ptrace: Provide definitions for PMR values
  arm64: Make PMR part of task context
  arm64: Unmask PMR before going idle
  arm64: kvm: Unmask PMR before entering guest
  efi: Let architectures decide the flags that should be saved/restored
  arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
  arm64: daifflags: Include PMR in daifflags restore operations
  arm64: alternative: Allow alternative status checking per cpufeature
  irqchip/gic-v3: Factor group0 detection into functions
  arm64: Switch to PMR masking when starting CPUs
  arm64: gic-v3: Implement arch support for priority masking
  irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
  irqchip/gic-v3: Handle pseudo-NMIs
  irqchip/gic: Add functions to access irq priorities
  irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
  arm64: Handle serror in NMI context
  arm64: Skip preemption when exiting an NMI
  arm64: Skip irqflags tracing for NMI in IRQs disabled context
  arm64: Enable the support of pseudo-NMIs

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/arm64/booting.txt                 |   5 +
 arch/arm/include/asm/arch_gicv3.h               |  33 ++++
 arch/arm64/Kconfig                              |  14 ++
 arch/arm64/include/asm/alternative.h            |   4 +-
 arch/arm64/include/asm/arch_gicv3.h             |  32 +++
 arch/arm64/include/asm/assembler.h              |  10 +-
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  10 +
 arch/arm64/include/asm/daifflags.h              |  41 ++--
 arch/arm64/include/asm/efi.h                    |  11 ++
 arch/arm64/include/asm/hardirq.h                |  28 +++
 arch/arm64/include/asm/irqflags.h               | 123 +++++++++---
 arch/arm64/include/asm/kvm_host.h               |  12 ++
 arch/arm64/include/asm/processor.h              |   3 +
 arch/arm64/include/asm/ptrace.h                 |  26 ++-
 arch/arm64/kernel/alternative.c                 |  60 +++++-
 arch/arm64/kernel/asm-offsets.c                 |   1 +
 arch/arm64/kernel/cpufeature.c                  |  42 +++-
 arch/arm64/kernel/entry.S                       |  43 ++++
 arch/arm64/kernel/irq.c                         |   3 +
 arch/arm64/kernel/process.c                     |  51 +++++
 arch/arm64/kernel/smp.c                         |  33 ++++
 arch/arm64/kernel/traps.c                       |   8 +-
 arch/arm64/kvm/hyp/switch.c                     |  16 ++
 arch/arm64/mm/proc.S                            |  11 --
 drivers/firmware/efi/runtime-wrappers.c         |  17 +-
 drivers/irqchip/irq-gic-common.c                |  10 +
 drivers/irqchip/irq-gic-common.h                |   2 +
 drivers/irqchip/irq-gic-v3.c                    | 252 +++++++++++++++++++++---
 include/linux/efi.h                             |   5 +-
 include/linux/hardirq.h                         |   7 +
 32 files changed, 807 insertions(+), 115 deletions(-)

--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
