Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70607C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB2C20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dmEM9abR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lqot3MN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB2C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mruYmF2vDquEE3ggEeXFNTjopKlJAENeOdsRXHWaqWI=; b=dmE
	M9abRnJuxx7MHKEcXlvM21fHJGzoNgMRqouSC8IWXtSUN2f+AlIJ3zkvNODA//D6xjLe8Wo6aU8wJ
	dK3oviSdsLTT6kbgMt58pYV63kCr6hrPgkfZip6umDlbeJwIDSRf0zH4M5u4VF+u6+FsAX9SbtgkK
	CfVpH20egZ/gyhuANu7pPRNEzzt+CjuMIC2QQvfIRJR7oztwv0ITyfIaIrY/mfn4TK6hwXAhlFuu4
	zVlVoeMO0SFx+jXW+mmwwKxyeDhsc/YGuKCxelmIWATUZVS0D1sFlIIe0YpRDvS6ZcN/QvU6gECra
	kOMfYnVRrmps2Vt+3Xy3LglVSlapJqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkMyH-00061K-Vn; Fri, 18 Jan 2019 05:45:37 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkMyE-00060w-N8
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 05:45:36 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so5830807ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 21:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
 b=Lqot3MN3q/rP4POvMC+G9EZaYGDfxuBoX+U8QsEsosKnYg7V2G5vgPMewV1LuxoaWM
 5I+GuZidL0D3+YAYzdtfP7zZWCRfRprwQRk9mtmuhiXW9WpEF7rlrpCg1puvAxHjbPDz
 pLlMMlKTjZzaMPRCLvBiCERwMhZ2H6hFWarxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
 b=M2HQL6GCgVCUVvrZUZSAfHPS3dGMH5/vDnG09SGHEB9xezB2jti/Jci8M20Nk07fhl
 iQRI8uP8FBAzq82fSwjQDdvScwgMONA+p+OmEHFHddkXunXNhhBI2WjXzPiprmcy9RdL
 oXMsTGT7J7xo4fVb3xMqR6eCCcJjLLoAlWUM0A1yVBRYbq9ftVTPH+wB5U+Y/DJDfAKa
 pFZ/PjreCVHHQbMm4yOqEL5aNEqyHiDdsr4AisEmSbrCo5t2gBpYVxlWo1NlBEoo8aHe
 krhM71NGiJ3Q5eum+c67NwmEIb+La9g9Sgf3h8UAEbr91acPWH1QaPHOBiI96oPslhEK
 vzwQ==
X-Gm-Message-State: AJcUukd8AuGIn1Y2RMdpKiOLk1OE+0cDFBdVLf1q4U8iiTmYiglWC72Q
 2Mg2fiX9sPH2I7dOOeXr4VcIIQ==
X-Google-Smtp-Source: ALg8bN44GgQV1V9GC6wrvd8U+o3O/82fe/Z1pfqaauYKt/Y4QTetQjEjHU7/dFD+dHBxlqs69iOZyg==
X-Received: by 2002:a17:902:8a91:: with SMTP id
 p17mr18011684plo.316.1547790333630; 
 Thu, 17 Jan 2019 21:45:33 -0800 (PST)
Received: from pramodku-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id l5sm476264pfi.56.2019.01.17.21.45.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 21:45:33 -0800 (PST)
From: Pramod Kumar <pramod.kumar@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug is
 supported
Date: Fri, 18 Jan 2019 11:16:20 +0530
Message-Id: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_214534_759057_EB924B49 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steve Capper <steve.capper@arm.com>,
 linux-kernel@vger.kernel.org, Pramod Kumar <pramod.kumar@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
call to stop the CPU. This call ensures L1/L2 cache flush,
CPUs cache-cohenrecy setting w.r.to interconnect.

Apart from this, this gives control to f/w to reduce power consumption
by take appropriate decesion on power rails for plugging-out core.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..360e52b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -822,8 +822,13 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_daif_mask();
 	sdei_mask_local_cpu();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+#else
 	while (1)
 		cpu_relax();
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
