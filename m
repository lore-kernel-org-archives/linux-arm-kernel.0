Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:44:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FF920883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QtVSxt1C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXS6zvSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FF920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mruYmF2vDquEE3ggEeXFNTjopKlJAENeOdsRXHWaqWI=; b=QtV
	Sxt1C+jNV4ZcKWpYiOOCEmVtb82l4yMPjhrous3bceokRpXMrd/WZ1gOVLu3B+8OZRz4gkYqZaf7B
	qnFsI/Wp01H0dS1As/jul1eDDckciv+nhdOJ10RLPPuDIenivUBitlikfSnS9PcDw5hi9QrBW5zG0
	ySAi7Tug582icIzWHINb2HXvdPOOP2fQyahFKeMUKXsZh45U8zBF1hgOrdxT2MAZzt0kB+BJF+1da
	gSBipGCtDxQ0Z0rdfOW57V1InqBzq+/v9LU06ZW9DwjSVrcUsOEg/viePmVE/+1HXmHxiEJp1nRQs
	yoA5/w1rJ+g3jDdugBg21/F0BrEen7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkMx6-0004ON-N1; Fri, 18 Jan 2019 05:44:24 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkMx3-0004Ng-Di
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 05:44:22 +0000
Received: by mail-pf1-x441.google.com with SMTP id r136so6018336pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
 b=SXS6zvSgz61eGAv+AUSQPQ6wGd+cifI1ReG8IIAjkcfzVHY/3CovtB/8eydebQ4gIt
 zSmEDiZIqGQpIePtIG19FbT36ChW54ES9DRZYdohs7GSnjD94HVMlmucXef3izKcnWI8
 wTzAocoVkZC88/FlTk2jgcE8vDUqnsZenLBoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
 b=ocKanfG801R19rMxMErHD3nKN1YZUWAuYfP02adUysl9VtkCU/XGaFDVIQ7H5ClCZY
 MBbvyZ9q7YFn1H992Oea499QePAELhLpXDAgmyIDbMQj+H3Ys77+izpPjEese+jBmUfT
 xSDKyPLiL70hWkqtG69/qHdDefxrm1FBDkzC95sh9/o4S/uHakUToNlGZ+ofe91GqzFp
 88cUjmiVMRcMIu4E0XQyk3aN/3eP8+UmaKTGcE1i2zuIHbo2bBiAQ+Yvcrcx2KgOpduI
 4I9GXwn7avFLIxbsXvhfgNVo+KPCBfLB9jLRIJXlOAYbvvzQMcMetTxsOHjv8CVmAHip
 lAEg==
X-Gm-Message-State: AJcUukeiZN0JuT2DoxtzzDD7dIYxfelxINqndUX0VK5RSqZTHYTnchYL
 eiTpnOKNNUg90xZYbP/8NAd25A==
X-Google-Smtp-Source: ALg8bN49T6bfJ1cB6jKb8O0W5gsSDGCPeYkKhTQ8bC3uZz/f6qYeJnrPPuAyBV86a9zR6czQAf8k5Q==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr16071423pgc.11.1547790257873; 
 Thu, 17 Jan 2019 21:44:17 -0800 (PST)
Received: from pramodku-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id 202sm4537444pfy.87.2019.01.17.21.44.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 21:44:17 -0800 (PST)
From: Pramod Kumar <pramod.kumar@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH INTERNAL RFC 1/1] arm64: Use PSCI calls for CPU stop when
 hotplug is supported
Date: Fri, 18 Jan 2019 11:15:00 +0530
Message-Id: <1547790300-6190-1-git-send-email-pramod.kumar@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_214421_466213_8AE1D970 
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
