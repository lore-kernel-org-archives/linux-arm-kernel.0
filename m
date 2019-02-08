Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEDAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F1620844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1l47HN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F1620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RWbfNmxC/6uRsvEISasmT5yXORhC6oleZ47A5a6BIo0=; b=H1l47HN2YRWyEt
	copSteloiV1MrnYZdDI6n8VnRiGXRp2YNDGQdhSC9MQu3jgFuUP4mn9jCVjHAIbEDtxFIgZUkaVn3
	Txd5emZgprsy77dybw1FXDTfV7V5lrEdBGSj6AUIM1P14f/5xMutpL5NmO/Xa4L5HEH4+P/rstcou
	eIiBSURyNUJYUKvGfxd19oVAhR/YRtd+K7ERiPZpBQbeDH5l41kcuHQR8oAwPKmQsz5OSHSzhvU5+
	mmt1LWS8qkxNCRBvBgtBPl0DcOUa91C/EfDrmYzBEb/RaQohqrTpkP+l+uRFKSYNcBST1vQZYBshA
	oZKk6sSw3HtTOIPglKAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8px-0007E1-GS; Fri, 08 Feb 2019 16:17:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8pv-0007DJ-2Y
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:17:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591BEA78;
 Fri,  8 Feb 2019 08:17:04 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 001FE3F719; Fri,  8 Feb 2019 08:17:01 -0800 (PST)
Date: Fri, 8 Feb 2019 16:16:59 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208161658.GB232749@arrakis.emea.arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
 <20190208043543.GA5040@archlinux-ryzen>
 <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_081707_126909_4E7A4E69 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 Nick Desaulniers <ndesaulniers@google.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 09:36:48AM +0000, Julien Thierry wrote:
> From e839dec632bbf440efe8314751138ba46324078c Mon Sep 17 00:00:00 2001
> From: Julien Thierry <julien.thierry@arm.com>
> Date: Fri, 8 Feb 2019 09:21:58 +0000
> Subject: [PATCH] arm64: irqflags: Fix clang build warnings
> 
> Clang complains when passing asm operands that are smaller than the
> registers they are mapped to:
> 
> arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not
> 	match register size specified by the constraint and modifier
> 	[-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQON)
> 
> Fix it by casting the affected input operands to a type of the correct
> size.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Applied. Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
