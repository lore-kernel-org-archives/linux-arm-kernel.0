Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD7A2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1ys2pvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD7A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Bp8EQmI/QHhfJetSj1rhmIY7kSTb8vnTzPRKIsEZLhs=; b=P1y
	s2pvPgjYABnniWOVVAPnQMt03PNM7fXwMrguj51/mSgEkKqcM+GM1r0iB9JwNmtiIMyUB5M+orfUF
	J2LoSyhnruaWzh9iD5OdwoCA2W0fUu+eeTMs9nnTuYnKhyOlv4G0Rifnku7XgKH0MeaaKN3WaNKi1
	foCSzRVRj4w35RMwfUdj7o1eg8Da/Jiy5J5VzUqOyaRq1rxwVot8pLb6rRPP+KY29XyC6QLl9GCUb
	ksdQu2ORHmyBkSApoJ4Df0CZcmR2Ut36UI0b3rnvCRO16F7PuBZLv8P87Zzq6s0G67yl6rqjeVF4j
	EZsucOg6+cg+5+V3Xhr3j705FGBWwVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnLf-0003x7-TW; Thu, 21 Feb 2019 12:21:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnLc-0003w4-GK
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:21:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E36780D;
 Thu, 21 Feb 2019 04:21:04 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D756E3F575;
 Thu, 21 Feb 2019 04:21:02 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/6] Initial support for CVADP
Date: Thu, 21 Feb 2019 12:20:51 +0000
Message-Id: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042104_549206_4C76555A 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARMv8.5 introduces a DC CVADP instruction which cleans the data cache to
the point of deep persistence. This series makes the instruction
available to userspace and advertises the presence of this CPU feature.

At present when CONFIG_ARM64_PMEM is enabled and the CVAP feature is
present (ARMv8.2) the CVAP instruction is used (from memcpy_flushcache
and arch_wb_cache_pmem). No changes have been made to use CVADP in
these functions or similar.

As we have moved beyond 32 capabilities we now begin using AT_HWCAP2
for userspace.

Tested as follows:

# dmesg | grep "Deep"
[    0.166496] CPU features: detected: Data cache clean to Point of Deep Persistence

# LD_SHOW_AUXV=1 sleep 2>&1 | grep AT_HWCAP
AT_HWCAP:        ef91ff87
AT_HWCAP2:       0x1

Changes since v1:

 - Rebased onto v5.0-rc7

 - Introduced cpu_{have,set}_feature_name to eliminate use of
   KERNEL_HWCAP prefix

 - Hard coded MAX_CPU_FEATURES and added a WARN_ON

 - Minor comment and tab/spacing changes

 - Use elf_hwcap for all 64 caps in the kernel instead of
   a new elf_hwcap2

Andrew Murray (6):
  arm64: Handle trapped DC CVADP
  arm64: HWCAP: add support for AT_HWCAP2
  arm64: HWCAP: encapsulate elf_hwcap
  arm64: Expose DC CVADP to userspace
  arm64: add CVADP support to the cache maintenance helper
  arm64: Advertise ARM64_HAS_DCPODP cpu feature

 Documentation/arm64/elf_hwcaps.txt       |   4 ++
 arch/arm64/crypto/aes-ce-ccm-glue.c      |   2 +-
 arch/arm64/crypto/aes-neonbs-glue.c      |   2 +-
 arch/arm64/crypto/chacha-neon-glue.c     |   2 +-
 arch/arm64/crypto/crct10dif-ce-glue.c    |   2 +-
 arch/arm64/crypto/ghash-ce-glue.c        |   6 +-
 arch/arm64/crypto/nhpoly1305-neon-glue.c |   2 +-
 arch/arm64/crypto/sha256-glue.c          |   4 +-
 arch/arm64/include/asm/assembler.h       |   4 ++
 arch/arm64/include/asm/cpucaps.h         |   3 +-
 arch/arm64/include/asm/cpufeature.h      |  18 +++---
 arch/arm64/include/asm/esr.h             |   3 +-
 arch/arm64/include/asm/hwcap.h           |  42 ++++++++++++-
 arch/arm64/include/uapi/asm/hwcap.h      |   7 ++-
 arch/arm64/kernel/cpufeature.c           | 103 ++++++++++++++++++++-----------
 arch/arm64/kernel/cpuinfo.c              |   3 +-
 arch/arm64/kernel/fpsimd.c               |   4 +-
 arch/arm64/kernel/traps.c                |   3 +
 drivers/clocksource/arm_arch_timer.c     |   8 +++
 19 files changed, 161 insertions(+), 61 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
