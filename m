Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E9C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3045B2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwG7GIvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3045B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KsMaGk5JadMJ544b42+L5LIuU0WchXx9ffOe3dUH9cw=; b=gwG7GIvju80klF
	ayoPnJLI6XwS5lQPhiwDI5q3J1sg9GAdp3+FYcH8WNXV+Hg+7aiQxtr61Y3VJtR3Uoa9aVu8NE4UG
	T+a2bPAiYnHtQwnRNvTntQPXmGbvrxOZ245piBjzvTxpaRK0zOThJBb7shVhieq6YFptCphn76VMt
	lkyJYk1LmoQLAQvdBVjN0dacbWidzYLBR74qe7D+agR8OnVmAh9rAw3aZ/hC0gwk8x5UXR8gF6evP
	EXTl2DnKIfQHM9Y8JNN5vTLBtjrGjTV8Bt9klZ50swPcGa6VV4pJiX/zopwkHxM3fjqSYEeXGJmxS
	x+DvTDvcIM11N10RoSlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gld0k-0004hZ-D3; Mon, 21 Jan 2019 17:05:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glczm-0002mX-1l
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:04:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E0815AB;
 Mon, 21 Jan 2019 09:04:21 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3011B3F614;
 Mon, 21 Jan 2019 09:04:20 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] arm64: hyp-stub: Forbid kprobing of the hyp-stub
Date: Mon, 21 Jan 2019 17:04:03 +0000
Message-Id: <20190121170404.142966-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121170404.142966-1-james.morse@arm.com>
References: <20190121170404.142966-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_090422_789993_EA389A1A 
X-CRM114-Status: GOOD (  13.11  )
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

The hyp-stub is loaded by the kernel's early startup code at EL2
during boot, before KVM takes ownership later. The hyp-stub's
text is part of the regular kernel text, meaning it can be kprobed.

A breakpoint in the hyp-stub causes the CPU to spin in el2_sync_invalid.

Add it to the __hyp_text.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: stable@vger.kernel.org
---

This has been a problem since kprobes was merged, it should
probably have been covered in 888b3c8720e0.

I'm not sure __hyp_text is the right place. Its not idmaped,
and as it contains a set of vectors, adding it to the host/hyp
idmap sections could grow them beyond a page... but it does
run with the MMU off, so does need to be cleaned to PoC when
anything wacky, like hibernate happens. With this patch,
hibernate should clean the __hyp_text to PoC too.
---
 arch/arm64/kernel/hyp-stub.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index e1261fbaa374..17f325ba831e 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -28,6 +28,8 @@
 #include <asm/virt.h>
 
 	.text
+	.pushsection	.hyp.text, "ax"
+
 	.align 11
 
 ENTRY(__hyp_stub_vectors)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
