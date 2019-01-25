Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CCC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:47:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19042082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LVMRqZbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19042082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VhaOgEG4RjkXqd4Q7U/qv5NijQ7yrVrGiBGl5RU6zyQ=; b=LVM
	RqZbjy6LD/szhTPAx9Iz9tWGdrFiKsAJ1rb8uYvTHh871ehcCFij5ekC3fvRxO3eUNBxk/gcNkk6L
	teMBF58KhJ2LzVY7UfLV6MoGv/QIIEXg8rbjDZ6+1Wqmwk0d5k/M4OQyVZc3weHgPicTmWA1RolZH
	vQ3zRap1H77vpFFwFy1+FadCV9kCE21YgaijZuT7q441Fv1fN6WJDVGV6CWipAOChDwxaHExWY5Et
	BftxMZd8sm0ZGSAKX5qlqLuCcceDk0FE525/m3iWBj8QXY7XILXfiaqBr3ASXSf6/uSgWeo4bgi3J
	xwmrCBS6cvNGHs5udBbTK3Qz7vrWsYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy4m-00038U-Ub; Fri, 25 Jan 2019 09:47:04 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy4i-0002sy-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:47:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47294EBD;
 Fri, 25 Jan 2019 01:47:00 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEA33F589;
 Fri, 25 Jan 2019 01:46:59 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] KVM: arm/arm64: Fix VCPU power management problems
Date: Fri, 25 Jan 2019 10:46:51 +0100
Message-Id: <20190125094656.5026-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014700_898518_19D00EEC 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series fixes a number of issues:

 - When powering on and resetting VCPUs, we can be preempted in the
   middle which can lead to guest system register corruption.

 - We were missing support for PSCI ON_PENDING when multiple VCPUs try
   to turn on a target VCPU at the same time.

 - Powering off a VCPU could race with powering on the same VCPU.

 - We unnecesarily panic'ed if we found a non-initialized guest system
   register.

The main approach to fixing all these problems is by using VCPU
requests.

See the individual patches for more details.

Christoffer Dall (3):
  KVM: arm/arm64: Reset the VCPU without preemption and vcpu state
    loaded
  KVM: arm/arm64: Require VCPU threads to turn them self off
  KVM: arm/arm64: Implement PSCI ON_PENDING when turning on VCPUs

Marc Zyngier (2):
  arm/arm64: KVM: Allow a VCPU to fully reset itself
  arm/arm64: KVM: Don't panic on failure to properly reset system
    registers

 arch/arm/include/asm/kvm_host.h   | 22 ++++++++++-
 arch/arm/kvm/coproc.c             |  4 +-
 arch/arm/kvm/reset.c              | 24 ++++++++++++
 arch/arm64/include/asm/kvm_host.h | 23 ++++++++++-
 arch/arm64/kvm/reset.c            | 50 +++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c         |  4 +-
 virt/kvm/arm/arm.c                | 40 ++++++++++++++-----
 virt/kvm/arm/psci.c               | 64 +++++++++++++++----------------
 8 files changed, 177 insertions(+), 54 deletions(-)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
