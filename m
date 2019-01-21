Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F09FC619C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:04:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E83D2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ppec1Tme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E83D2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rXLuNkQjEl3PhtnFqdWP8XIlfHxHrn8/ypuG3mw/by0=; b=Ppec1TmeliakQ2
	QZWWUXE2roisYHfErvSsDkEi0J6SgcgvJA7DXI8mDKFHAmkaKhK0JLXs5xECxn4bAxRJciciFTHoz
	xFpvOUOuT3DfEYxj+yRiNPTy9d76fmG4mmI3gXqodDHKESGHNSd/o2uuJM689ULNtl+v24pAg7ET6
	jNwJyHEG2WKAkbVClCYjNsS3vDMnq3MXFs7sR2iw5JQ57uCYqqoDSRwcGocATRN2QR7UgMEZUQ3pZ
	v2+qkPDR+339vxydvPNTWCrELlaMSrVkwTIt5VR/7ZAq1RGOwXyE4DeWt8ZXrDrCuwfDJlI6Aohwr
	C9/Y0egFwlqgE105AtLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glczu-0002v3-LU; Mon, 21 Jan 2019 17:04:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glczf-0002iW-Jm
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:04:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE4915BE;
 Mon, 21 Jan 2019 09:04:14 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31C0E3F7BE;
 Mon, 21 Jan 2019 09:04:13 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Fix some KVM/HYP interactions with kprobes
Date: Mon, 21 Jan 2019 17:04:00 +0000
Message-Id: <20190121170404.142966-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_090415_650311_56AE59F4 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, james.morse@arm.com,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

When looking at Masami Hiramatsu's kprobe cleanup series, it occurred
to me the 'no KVM' isn't just about the EL1/EL2  split on non-VHE systems,
but whether KVM is prepared to handle stepping on a breakpoint. It's not.

This moves all the VHE-only KVM functions that run during world switch
into the __kprobes section, and always blacklists __hyp_text for kprobes
to cover the common guest entry/exit code.

I anticipate patch 1 going via the KVM tree to avoid conflicts.
Patch 2 will conflict with [0].


I'm not sure what the best thing to do with the hyp-stub is.
Patch 3 moves it to __hyp_text, and patch 4 covers the hibernate fallout
from doing that. We don't have any other mmu-off but not idmap'd text.
Probing the hyp-stub has to be done by address as the symbol names
alias those in the __entry_text, which is blacklisted. (although this
might depend on link order). I think anyone doing this is trying to
shoot themselves in the foot.


Know issues:
* Other regions we should blacklist are the kexec and hibernate 'copy
  everything' code, as the vectors may have been overwritten by the time
  we step on the probe. cpu-suspend needs investigating...


Thanks,

James

[0] lore.kernel.org/r/154753341900.31541.8135985235882849464.stgit@devbox

James Morse (4):
  KVM: arm64: Forbid kprobing of the VHE world-switch code
  arm64: kprobe: Always blacklist the KVM world-switch code
  arm64: hyp-stub: Forbid kprobing of the hyp-stub
  arm64: hibernate: Clean the __hyp_text to PoC after resume

 arch/arm64/kernel/hibernate.c      |  4 +++-
 arch/arm64/kernel/hyp-stub.S       |  2 ++
 arch/arm64/kernel/probes/kprobes.c |  6 +++---
 arch/arm64/kvm/hyp/switch.c        | 11 ++++++-----
 arch/arm64/kvm/hyp/sysreg-sr.c     |  9 +++++----
 5 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
