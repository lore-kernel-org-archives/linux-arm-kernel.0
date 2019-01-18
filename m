Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E243CC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:46:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A6C20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qp3psxjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A6C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fNjDgzmkMRvzNcNP6RiwEWprNRpYa8MEfiPdHX3oqgw=; b=qp3
	psxjF3UF8UsWPYQydBVe7YTu1PRf+uJarbJzBEy5RyAyafS0aQHrDRSIzjtNt1aroPiabYHr7sVbr
	F9+7lyvgkt+maAIzyE1coMZP8AoGcl/rBORd5VjwowrELv9lflt2X1oZJt/FdzvDmnY4UxWM0ZBwr
	RJeF++aqchU8K4U9nmE+g27KsQxDOzm8o4DS6Q+JgR7SjMCdZ3+EXCsGIl013GiCb9Z1/q3nL4dGt
	EBPmi0n39L90zb9eF1O8i0FHDKwu3n+BUEBKNgAH+DrrYFfiEY2y/2k8Zk5d8PkGYuDTWeTaReqsf
	QqgaaRuybyP1ocvtJNoYOMC2tZJxmnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXI7-00086Q-JT; Fri, 18 Jan 2019 16:46:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXHy-00083T-AA
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:46:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7104980D;
 Fri, 18 Jan 2019 08:46:36 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A526A3F7BE;
 Fri, 18 Jan 2019 08:46:34 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/8] arm64/sve: First steps towards optimizing syscalls
Date: Fri, 18 Jan 2019 16:46:02 +0000
Message-Id: <20190118164610.8123-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084638_354438_F3783D69 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, Julien Grall <julien.grall@arm.com>,
 alex.bennee@linaro.org, Dave.Martin@arm.com, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

This is a first attempt to optimize the syscall path when the user
application uses SVE. The patch series is based on v5.0-rc2.

Per the syscall ABI, SVE registers will be unknown after a syscall. In
practice, the kernel will disable SVE and the registers will be zeroed
(except the first 128-bits of each vector) on the next SVE instruction.
In a workload mixing SVE and syscalls, this will result to 2 entry/exit
to the kernel per syscall.

This series aims to avoid the second entry/exit by zeroing the SVE
registers on syscall return with a twist when the task will get
rescheduled.

This implementation will have an impact on application using SVE
only once. SVE will now be turned on until the application terminates
(unless disabling it via ptrace). Cleverer strategies for choosing
between SVE and FPSIMD context switching are possible (see [1]), but
it is difficult to assess the benefit right now. We could improve the
behaviour in the future as a selection of mature hardware platform
emerges that we can benchmark.

It is also possible to optimize the case when the SVE vector-length
is 128-bit (i.e the same size as the FPSIMD vectors). This could be
explored in the future respin of the series.

While developing the series, I have added a series of tracepoint in
the SVE code. They may not be suitable for upstreaming and hence not
included in the series. I can provide them if anyone is interested.

Comments are welcomed.

Best regards,

[1] https://git.sphere.ly/dtc/kernel_moto_falcon/commit/acc207616a91a413a50fdd8847a747c4a7324167

Julien Grall (8):
  arm64/fpsimd: Update documentation of do_sve_acc
  arm64/signal: Update the comment in preserve_sve_context
  arm64/fpsimdmacros: Allow the macro "for" to be used in more cases
  arm64/fpsimdmacros: Introduce a macro to update ZCR_EL1.LEN
  arm64/sve: Implement helper to flush SVE registers
  arm64/sve: Implement helper to load SVE registers from FPSIMD state
  arm64/sve: Don't disable SVE on syscalls return
  arm64/sve: Rework SVE trap access to use TIF_SVE_NEEDS_FLUSH

 arch/arm64/include/asm/fpsimd.h       |  8 +++++
 arch/arm64/include/asm/fpsimdmacros.h | 48 ++++++++++++++++++++------
 arch/arm64/include/asm/thread_info.h  |  5 ++-
 arch/arm64/kernel/entry-fpsimd.S      | 29 ++++++++++++++++
 arch/arm64/kernel/fpsimd.c            | 64 ++++++++++++++++++++++++++++-------
 arch/arm64/kernel/process.c           |  1 +
 arch/arm64/kernel/ptrace.c            |  7 ++++
 arch/arm64/kernel/signal.c            | 17 ++++++++--
 arch/arm64/kernel/syscall.c           | 13 +++----
 9 files changed, 158 insertions(+), 34 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
