Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9626C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D3E2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7Lq5V3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D3E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=n8227zZdjS67s81FbN2D3tLAf0+PcnyBMhlQfK7Vy84=; b=L7L
	q5V3W2Kk6Q0jdpJn7o7RZwtE0ldTzDRPaq890OKvNmlWVmpGRTtTQKgDLTpcLGTLtwyAsZTPugY+k
	O+4du0yeqNDUny4k1zNt3hX6hopGTTwpPCLQvm4YeSGt3O/vNFqWxXOk/DhSRwmfQnDJlJdiEZqyy
	GDL/W5vdy7aB4vR3E9lEYsQZdrirylskvKR3uGSR6V/sK4R/GYPPGtjeJe7bKrUrnxgmx3lNxKtRZ
	1ak8IU73r40PgwK38oR5pPlvEIAvrJ3AHl+Bw1PfY24+jz5DllxKahpNhhpMY7k1jfW1RZPt41+d8
	Z8VZxeplCUPpM4uwUpELPHYDNZr/JgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggWUB-0006Uh-Qs; Mon, 07 Jan 2019 15:06:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggWU9-0006T5-2v
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:06:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF30180D;
 Mon,  7 Jan 2019 07:06:32 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 016303F5B7;
 Mon,  7 Jan 2019 07:06:30 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 0/3] KVM: arm/arm64: vgic: Use raw_spinlock for locks taken
 in IRQ context
Date: Mon,  7 Jan 2019 15:06:14 +0000
Message-Id: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_070637_139093_5EC1465A 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: linux-rt-users@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 marc.zyngier@arm.com, bigeasy@linutronix.de, Christoffer.Dall@arm.com,
 rostedt@goodmis.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

While testing KVM running on PREEMPT_RT, starting guest could simply
freeze the machine. This is because we are using spinlocks for VGIC
locks, which is invalid in the VGIC case since the locks must be take
with interrupts disabled.

The solution is to use raw_spinlock instead of spinlocks.

Changes since v2[1]:
- Rebase on v5.0-rc1
- Remove first patch from series as it has been applied

Changes since v1[2]:
- Rebase on v4.20-rc4
- Add Christoffer's Acked-by
- Fix potential lock up when waiting for vcpus to halt

[1] https://lkml.org/lkml/2018/11/27/20
[2] https://lkml.org/lkml/2018/11/19/776

Cheers,

Julien

-->

Julien Thierry (3):
  KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

 include/kvm/arm_vgic.h           |   6 +-
 virt/kvm/arm/vgic/vgic-debug.c   |   4 +-
 virt/kvm/arm/vgic/vgic-init.c    |   8 +--
 virt/kvm/arm/vgic/vgic-its.c     |  22 ++++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  14 ++---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  12 ++--
 virt/kvm/arm/vgic/vgic-mmio.c    |  34 +++++------
 virt/kvm/arm/vgic/vgic-v2.c      |   4 +-
 virt/kvm/arm/vgic/vgic-v3.c      |   8 +--
 virt/kvm/arm/vgic/vgic.c         | 118 +++++++++++++++++++--------------------
 10 files changed, 115 insertions(+), 115 deletions(-)

--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
