Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB70C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D42C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W12vUdPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D42C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bVZMBs7SgLeJlIGXk64pD8K7vSPV6fyxgZBXA/WCvAU=; b=W12vUdPLrqdVF6UZ57y4rs+QoR
	I7oVBgBITyJDGIUTpkWvu5uvchNrsMMsbVaHpItimfdhMLYOzBgTGOPi4pgEMMPnPrIQ6FvxrBxCT
	ZYz94gEND8IC4VX6SY1couliG4i1wMRAkMUb8qbtxG9O9ig998OI1kmc4lGb+mHRoUpqvf72LkwxU
	q2y/gAttfRBL94a/y0IK3K6SDSThTFqUa9/TIKdGcdweY4Xnrg6enUQSv9LcUPwMMt9DE9+HoYogv
	XTREmRTGcJeY4lEpEc77K5kD0GmFEO1mLV4SOUKHGOX+KqjDKIrxGXBkez95Wr5Mj3UwU6RJXzIrD
	vPugf6ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXIw-0000MH-K7; Fri, 18 Jan 2019 16:47:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXI2-00085Y-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:46:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B78BA165C;
 Fri, 18 Jan 2019 08:46:42 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C51773F7BE;
 Fri, 18 Jan 2019 08:46:40 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/8] arm64/fpsimdmacros: Allow the macro "for" to be used
 in more cases
Date: Fri, 18 Jan 2019 16:46:05 +0000
Message-Id: <20190118164610.8123-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084643_010720_4B8C1A70 
X-CRM114-Status: GOOD (  12.63  )
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
 alex.bennee@linaro.org, Dave Martin <dave.martin@arm.com>, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current version of the macro "for" is only able to works when the
counter is used to generate registers using mnemonics. This is because
gas is not able to evaluate the expression generated if used to generate
registers name (i.e x\n).

Gas offers a way to evaluate macro arguments by using % in front of
them under the alternate macro mode [1].

The implementation of "for" is updated to use the alternate macro mode
and %, so we can use the macro in more cases. As the alternate macro mode
may have side-effect, this is disabled when generating the body.

While it is enough to prefix the argument of the macro "__for_body" with
%, the arguments of "__for" are also prefixed to get a more bearable
value in case of compilation error.

[1] https://sourceware.org/binutils/docs/as/Altmacro.html

Suggested-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/fpsimdmacros.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 46843515d77b..e2ab77dd9b4f 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -177,19 +177,23 @@
 
 .macro __for from:req, to:req
 	.if (\from) == (\to)
-		_for__body \from
+		_for__body %\from
 	.else
-		__for \from, (\from) + ((\to) - (\from)) / 2
-		__for (\from) + ((\to) - (\from)) / 2 + 1, \to
+		__for %\from, %((\from) + ((\to) - (\from)) / 2)
+		__for %((\from) + ((\to) - (\from)) / 2 + 1), %\to
 	.endif
 .endm
 
 .macro _for var:req, from:req, to:req, insn:vararg
 	.macro _for__body \var:req
+		.noaltmacro
 		\insn
+		.altmacro
 	.endm
 
+	.altmacro
 	__for \from, \to
+	.noaltmacro
 
 	.purgem _for__body
 .endm
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
