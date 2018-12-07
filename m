Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9453C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AB12064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ulYrQocX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AB12064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=C3NebI3+F3QCC1MmA72jlJmAv0bOrgRSOZYJmkVSgsI=; b=ulY
	rQocX13wrgLSzdvpH5p+arJsoU1lNY/LQIcjYfjAqhesT5yZmwn7Bco8SFfUxVUBnXKgB1J/CGK0X
	UJGy5rTqN1Yo6VIhDMVhSGRCB3WCFwaw1eS4kvqtYHgVKabBcaqeF7VEt0FDFPQlqNdyweiGo4phL
	55qceKUUIatKyjDWhLxbBcouQK1AqdhPSek5VWM/QxjrXbU6+4PTZEbdYk8fcPwLp4vDjDsbIn+D3
	x9ZAxtDfXDgNZuPIH1O11s6hmibJnAhsbKbJAO8jfp4fqRCnj5VnS8a+8IKn8vuuFMx8a87mN8SIR
	KcQPvMDCAtObWNkgL1HM6Cmnibaphlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL33-0004kD-Ea; Fri, 07 Dec 2018 18:40:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL2p-0003Gw-3j
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:40:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E01EBD;
 Fri,  7 Dec 2018 10:39:59 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CC3C3F5AF;
 Fri,  7 Dec 2018 10:39:55 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 00/13] ARMv8.3 pointer authentication userspace support
Date: Fri,  7 Dec 2018 18:39:18 +0000
Message-Id: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104011_167566_52DF6CAD 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This series adds support for the ARMv8.3 pointer authentication extension,
enabling userspace return address protection with GCC 7 and above.

(The previous version also had in-kernel pointer authentication patches
as RFC; these will be updated and sent at a later time.)

Changes since v5 [1]:
 - Exposed all 5 keys (not just APIAKey) [Will]
 - New prctl for reinitializing keys [Will]
 - New ptrace options for getting and setting keys [Will]
 - Keys now per-thread instead of per-mm [Catalin]
 - Fixed cpufeature detection for late CPUs [Suzuki]
 - Added comments for ESR_ELx_EC_* definitions [Will]
 - Rebased onto v4.20-rc5

This series is based on v4.20-rc5. The aarch64 bootwrapper [2] does the
necessary EL3 setup.

The patches are also available at:
  git://linux-arm.org/linux-km.git ptrauth-user


Extension Overview
==================

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
* Authenticate strip a PAC from a pointer

If authentication succeeds, the code is removed, yielding the original pointer.
If authentication fails, bits are set in the pointer such that it is guaranteed
to cause a fault if used.

These instructions can make use of four keys:

* APIAKey (A.K.A. Instruction A key)
* APIBKey (A.K.A. Instruction B key)
* APDAKey (A.K.A. Data A key)
* APDBKey (A.K.A. Data B Key)

A subset of these instruction encodings have been allocated from the HINT
space, and will operate as NOPs on any ARMv8-A parts which do not feature the
extension (or if purposefully disabled by the kernel). Software using only this
subset of the instructions should function correctly on all ARMv8-A parts.

Additionally, instructions are added to authenticate small blocks of memory in
similar fashion, using APGAKey (A.K.A. Generic key).


This series
===========

This series enables userspace to use any pointer authentication instructions,
using any of the 5 keys. The keys are initialised and maintained per-process
(shared by all threads).

For the time being, this series hides pointer authentication functionality from
KVM guests. Amit Kachhap is currently looking into supporting pointer
authentication in guests.

Setting uprobes on pointer authentication instructions is not yet supported, and
may cause the application to behave in unexpected ways.

Feedback and comments are welcome.

Thanks,
Kristina

[1] https://lore.kernel.org/lkml/20181005084754.20950-1-kristina.martsenko@arm.com/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git


Kristina Martsenko (3):
  arm64: add comments about EC exception levels
  arm64: add prctl control for resetting ptrauth keys
  arm64: add ptrace regsets for ptrauth key management

Mark Rutland (10):
  arm64: add pointer authentication register bits
  arm64/kvm: consistently handle host HCR_EL2 flags
  arm64/kvm: hide ptrauth from guests
  arm64: Don't trap host pointer auth use to EL2
  arm64/cpufeature: detect pointer authentication
  arm64: add basic pointer authentication support
  arm64: expose user PAC bit positions via ptrace
  arm64: perf: strip PAC when unwinding userspace
  arm64: enable pointer authentication
  arm64: docs: document pointer authentication

 Documentation/arm64/booting.txt                |   8 ++
 Documentation/arm64/cpu-feature-registers.txt  |   8 ++
 Documentation/arm64/elf_hwcaps.txt             |  12 +++
 Documentation/arm64/pointer-authentication.txt |  93 +++++++++++++++++++++
 arch/arm64/Kconfig                             |  23 ++++++
 arch/arm64/include/asm/cpucaps.h               |   8 +-
 arch/arm64/include/asm/cpufeature.h            |  12 +++
 arch/arm64/include/asm/esr.h                   |  17 ++--
 arch/arm64/include/asm/kvm_arm.h               |   3 +
 arch/arm64/include/asm/pointer_auth.h          |  93 +++++++++++++++++++++
 arch/arm64/include/asm/processor.h             |   4 +
 arch/arm64/include/asm/sysreg.h                |  30 +++++++
 arch/arm64/include/asm/thread_info.h           |   4 +
 arch/arm64/include/uapi/asm/hwcap.h            |   2 +
 arch/arm64/include/uapi/asm/ptrace.h           |  25 ++++++
 arch/arm64/kernel/Makefile                     |   1 +
 arch/arm64/kernel/cpufeature.c                 | 103 +++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c                    |   2 +
 arch/arm64/kernel/head.S                       |   5 +-
 arch/arm64/kernel/perf_callchain.c             |   6 +-
 arch/arm64/kernel/pointer_auth.c               |  47 +++++++++++
 arch/arm64/kernel/process.c                    |   4 +
 arch/arm64/kernel/ptrace.c                     | 110 +++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c                   |  18 ++++
 arch/arm64/kvm/hyp/switch.c                    |   2 +-
 arch/arm64/kvm/sys_regs.c                      |   8 ++
 include/uapi/linux/elf.h                       |   3 +
 include/uapi/linux/prctl.h                     |   8 ++
 kernel/sys.c                                   |   8 ++
 29 files changed, 653 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/arm64/pointer-authentication.txt
 create mode 100644 arch/arm64/include/asm/pointer_auth.h
 create mode 100644 arch/arm64/kernel/pointer_auth.c

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
