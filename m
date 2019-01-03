Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9624C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD5F2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVA2hr4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD5F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LentrXVRiatyXXYVPG1J+34nTlOQ0Uwos7e58z43av4=; b=bVA
	2hr4tmbxZ88O8Pw7qrOu13z9+YCFwFgFkopd3Dv4zJIeynpenTDFGUwSNk4AR5NL2MsrHkcM0VRqz
	PagUUkbz9A5u/H/cGdyup+TUxpzOl5Vb40GhPH0icwmHZR17vEwBPsiesUAVel5BHZw2+TvRk4i8V
	tlwAaVpIFuTUKWLK30EYZFpluTEV+zGh8TfezBv1HhNJ6Wq2tV9myNRbxj11LRY/FRY/EN/fXWtMd
	ypj6zXv5ANqJgxIQD6nozVZU9YLQHqeY94+NrV0V744DgcDx9iZEcLQQbLTdMOLRfujKrZrSUWENI
	ll0msOqkxSSvvkuQ1WnRcgx63GayeWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7VY-0004JT-AR; Thu, 03 Jan 2019 18:14:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7VL-00048b-13
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:14:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77DD615AD;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45E423F5D4;
 Thu,  3 Jan 2019 10:14:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 756941AE0BD1; Thu,  3 Jan 2019 18:14:02 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Fix private compat syscall emulation
Date: Thu,  3 Jan 2019 18:13:57 +0000
Message-Id: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_101403_080475_C432FF5C 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, pihsun@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

These three fixes should address the issues reported in [1] relating to
our emulation of the ARM private syscall region.

Cheers,

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623132.html

--->8

Will Deacon (3):
  arm64: compat: Avoid sending SIGILL for unallocated syscall numbers
  arm64: compat: Don't pull syscall number from regs in
    arm_compat_syscall
  arm64: compat: Hook up io_pgetevents() for 32-bit tasks

 arch/arm64/include/asm/unistd.h   |  7 ++++---
 arch/arm64/include/asm/unistd32.h |  2 ++
 arch/arm64/kernel/sys_compat.c    | 11 +++++------
 arch/arm64/kernel/syscall.c       |  9 ++++-----
 4 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
