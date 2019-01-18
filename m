Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD6420896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B9jTG31I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD6420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iYGEqiFOBdsaFtVIAgjw1csZZVgmZuwzvHoiX6DzI3g=; b=B9j
	TG31IMktvAIsyyLUJJcM5eFbw23uerC8AE+p0F1WfVddEcCCLt+KccnZZyV4LuzrOnNxdHDUXfuXz
	G079GaKVcUY1NmYILM44U8bUV6YDeGB5CKTOUspKPL88nULKJSiVC/SvSWwswamziUwIJFT+TGKa7
	Du65JuLptxoOSVY8TqSBgFDqmJCEK2BZid9Hv0z6e0R1Y952lhbYCNTDL410o4kCjWBEHkjpoem/X
	ZKhlPVjSksL62FNRwX7B5mh9kdLELcQU4gNSPy698aFkBHkuiDAFzvKTmAWoXa4tW6d/B9gqDtfhh
	4CcGs1ju1CYedabZl81FaQhj7ZRcLMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWn0-0003fN-FW; Fri, 18 Jan 2019 16:14:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWmx-0003ey-Ah
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:14:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0879FEBD;
 Fri, 18 Jan 2019 08:14:34 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 170853F557;
 Fri, 18 Jan 2019 08:14:31 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 00/12] arm64: SVE guest support test hacks
Date: Fri, 18 Jan 2019 16:14:09 +0000
Message-Id: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081435_373141_D7FD62B9 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
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

This series, based on kvmtool master [1], contains development hacks
to accompany the recently posted v4 SVE guest support series for the
Linux kernel [2].

This is not proposed for upstreaming in its current form, but some
things are probably close to being appropriate for upstream.

Comments and review welcome (but don't sweat the details too much).

[1] 
git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git master
https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/log/

Specifically, commit fdd26ecb4bc5 ("kvm-cpu: Pause vCPU in signal handler").

[2] [PATCH v4 00/25] KVM: arm64: SVE guest support
https://lists.cs.columbia.edu/pipermail/kvmarm/2019-January/034134.html
git://linux-arm.org/linux-dm.git sve-kvm/v4/head
http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/sve-kvm/v4/head


Dave Martin (12):
  guest: Add generated file guest/guest_init.c to .gitignore
  update_headers: Sync kvm UAPI headers with linux v5.0-rc2
  Makefile: [HACK] Work around GCC 8 warnings :(
  Makefile: [HACK] Pass relevant flags when checking for libfdt
  arm64: Correct ARM64_CORE_REG() size encodings for all core registers
  arm64: [HACK] Pull in kvm UAPI header updates from SVE development
    branch
  arm64: [HACK] Add option to show the kernel's KVM register ID list
  arm64: [HACK] Basic SVE support
  arm64: [HACK] Show extra info about SVE with --show-reg-list
  arm64: [HACK] Allow configuration of the guest's set of SVE vector
    lengths
  arm64: [HACK] FPSIMD/SVE register dumping for lkvm debug
  arm64: [HACK] Check that out-of-range SVE register IDs can't be dumped

 Makefile                                  |  11 +-
 arm/aarch32/include/asm/kvm.h             |  55 ++++++-
 arm/aarch64/include/asm/kvm.h             |  54 ++++++-
 arm/aarch64/include/kvm/kvm-config-arch.h |   9 ++
 arm/aarch64/include/kvm/kvm-cpu-arch.h    |   3 +-
 arm/aarch64/kvm-cpu.c                     | 209 ++++++++++++++++++++++++-
 arm/include/arm-common/kvm-config-arch.h  |   2 +
 arm/kvm-cpu.c                             | 239 ++++++++++++++++++++++++++++
 guest/.gitignore                          |   1 +
 include/linux/kvm.h                       | 250 +++++++++++++++++++++++++++++-
 mips/include/asm/kvm.h                    |  23 ++-
 powerpc/include/asm/kvm.h                 |  39 +++++
 x86/include/asm/kvm.h                     |  69 ++++++++-
 13 files changed, 944 insertions(+), 20 deletions(-)
 create mode 100644 guest/.gitignore

-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
