Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E835C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZpRVW+gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E835C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ciTXs0x80fnktNa6pzcqCZb2zJ+pLD9lMp+1yIDfcnc=; b=ZpRVW+gDcpHlgI
	ubGuUiUJDxoi0EW4chBoiHC7ymPuzmRlR+2wR2hm3uGLRXkRlVsOi248TCb8r45Z3FE1ssP8Wp15s
	YhHFTBq75Msof0roe1m+OVBe2eobihmyETx9AnDg1ND5bBEoyqnZ8whAb4vOnuXV/X7llZgoq0R4U
	Wd3EFQ5XKaG1eYzykfL3mO9XzwY+XPfqXOaWafIjg+NmTuXR0mej6IEPQbEWHlnsSyh6TKWZlxmZm
	cQCV5VhW2LN0LKmqxb96fbX+ZqycfCphMsIoWtk4GBrd+fSFcM/mdduWil3j84/n4+bbEGQzSHUw9
	qW9U4cd/cQfvWs1aUvrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEJu-0003a4-FH; Wed, 09 Jan 2019 13:54:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEJq-0003Yo-S2
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:54:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E8B280D;
 Wed,  9 Jan 2019 05:54:52 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC9C3F6CF;
 Wed,  9 Jan 2019 05:54:51 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: KVM: Allow direct function calls on VHE
Date: Wed,  9 Jan 2019 13:54:32 +0000
Message-Id: <20190109135435.178664-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_055454_907302_E72A3D0D 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It recently appeared that the nasty hack we use to call a HYP function
on a non-VHE system has an interesting side effect on VHE: We wrap any
such call into a hypercall, losing any form of type checking between
the caller and the callee.

This isn't a big deal if you can guarantee to write code that is
always 100% correct, but it appears that I'm not you.

In order to restore some sanity, let's use the following property: On
a VHE system, it is always possible to call any function directly as
they live in the same address space. We can thus always emit a direct
call, and use a static key to flip from one to the other. As a bonus,
this also sanitizes !VHE systems as we always generate code for noth
revisions of the architecture.

Marc Zyngier (3):
  arm/arm64: KVM: Introduce kvm_call_hyp_ret()
  arm64: KVM: Allow for direct call of HYP functions when using VHE
  arm64: KVM: Drop VHE-specific HYP call stub

 arch/arm/include/asm/kvm_host.h   |  3 +++
 arch/arm64/include/asm/kvm_host.h | 31 ++++++++++++++++++++++++++++++-
 arch/arm64/kvm/debug.c            |  2 +-
 arch/arm64/kvm/hyp.S              |  3 ---
 arch/arm64/kvm/hyp/hyp-entry.S    | 12 ------------
 virt/kvm/arm/arm.c                |  2 +-
 virt/kvm/arm/vgic/vgic-v3.c       |  4 ++--
 7 files changed, 37 insertions(+), 20 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
