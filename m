Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913372145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oa44rVym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913372145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YH1H2yo5aUrTTjB3iuur/nfNz2CtBYH6NmG69x4liVY=; b=Oa4
	4rVymjzo32r5H6N9JOp4v6H2hFoY6xjlFdYvzMunFQ+4Q1S0h2w80Ytkl1lfVVnnLlCw9ADiCvoPX
	MBFjymQ88Th49C1anu0hNtmxYJ5L55JWKajmKv+R+5jKivnnviQPrBCkcFmBG5b/EoureYKEMNbdw
	nyuOhRFmo4VLCaZGXzendVIQBrwojvO4GpMv9KBg5Y6c/FToO4a1LGSWt+16074STCKvVe2/mhlmX
	k42Jmc3wkf/h1CRo63rhBcLZWWEyPHWGm7RQ1dGLthjruk/YFt3FewfP9nwQDbaSbQNRHpFwGatnc
	Vq3AKPzdDfgog3cg2CUT65x/pyOmL1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmga-0008Hz-L6; Fri, 30 Nov 2018 17:34:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmgL-00087H-H3
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:34:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20F6EBD;
 Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A191E3F5A0;
 Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 774221AE0FA2; Fri, 30 Nov 2018 17:34:32 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Date: Fri, 30 Nov 2018 17:34:29 +0000
Message-Id: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_093425_573114_63AFF74A 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com,
 rml@tech9.net, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 schwidefsky@de.ibm.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

This is version two of the patches I originally posted here:

  http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com

The only change since v1 is that  __preempt_count_dec_and_test() now
reloads the need_resched flag if it initially saw that it was set. This
resolves the issue spotted by Peter, where an IRQ coming in during the
decrement can cause a reschedule to be missed.

Feedback welcome.

Will

--->8

Will Deacon (2):
  preempt: Move PREEMPT_NEED_RESCHED definition into arch code
  arm64: preempt: Provide our own implementation of asm/preempt.h

 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/preempt.h     | 88 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 13 +++++-
 arch/s390/include/asm/preempt.h      |  2 +
 arch/x86/include/asm/preempt.h       |  3 ++
 include/linux/preempt.h              |  3 --
 6 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/preempt.h

-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
