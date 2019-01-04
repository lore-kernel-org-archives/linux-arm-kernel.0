Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E3DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C522070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiNpDppi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C522070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wQV9lo94sYWDmNVJ5rrLQHHWrpNPm6+NSkA1lEy3n7Q=; b=FiN
	pDppiUpknFP8qyhaQg2fP0uJ8HwhmAc+A8Qqamk3jPNAiSQsm6dgIB+oQNoKoZNR0+IZcPHKjNQfh
	B2PkQy1xv0vjRR6IgK256C8BzOKI0luJA3Cl+TCV4Y66JY8XzTni81frBJpQt2swu6Koe6uRla6oY
	/adZGD1H9+CMDhbl3DHOh3WEJ+LUDR9LBhXpXtTF6A5T6cLYnEm+jSz1DpjGSRal+6P/XLKnei+hI
	gEC/CsySW2r1tPeZwtKlJbuTSQtI5G1ve3G2z7fYC9grpHPjIsNbuPWE+/WobJ8KYvhYOjDtSp4hM
	KYC0X/eG9AD88C/FNaFLy4v4ivMEhYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPEh-0006Bs-DU; Fri, 04 Jan 2019 13:10:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPEd-00068u-EH
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:10:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28F1AEBD;
 Fri,  4 Jan 2019 05:09:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15DEF3F5D4;
 Fri,  4 Jan 2019 05:09:55 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arm64/sve: UAPI: Disentangle ptrace.h from sigcontext.h
Date: Fri,  4 Jan 2019 13:09:49 +0000
Message-Id: <1546607391-3850-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_050959_485890_96746732 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch refactors the UAPI header definitions for the Arm SVE
extension to avoid multiple-definition problems when userspace mixes its
own sigcontext.h definitions with the kernel's ptrace.h (which is
apparently routine).

A common backend header is created to hold common definitions, suitably
namespaced.

The extra header guard in sve_context.h was considered redundant and is
now gone, so patch 1 (kbuild: install_headers.sh: Strip _UAPI from
#if-defined() guards) from the previous version of the series has been
dropeed.

Dave Martin (2):
  arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
  arm64/sve: Disentangle <uapi/asm/ptrace.h> from
    <uapi/asm/sigcontext.h>

 arch/arm64/include/uapi/asm/ptrace.h      | 39 ++++++++++-----------
 arch/arm64/include/uapi/asm/sigcontext.h  | 56 +++++++++++++++----------------
 arch/arm64/include/uapi/asm/sve_context.h | 53 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/sve_context.h

-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
