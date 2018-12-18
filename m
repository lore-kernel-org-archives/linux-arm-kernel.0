Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49154C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E3F21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nkX4dODi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E3F21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/cgAQ/HUAnTbgLPgNOJugK4dpIGGpfnNiXoDj1YbqNk=; b=nkX4dODiviheeT
	usJBh20ddryAgkl6f5eKZrro9lf469VFyb5+IaSL9bT8r51VUzR0hGl5S5nLW6Ed0DXotJm2i3iBI
	JIdQC+SC9JyA/BazRY8bO4sBePi/mtaZ4t9bMXcVP9heVbzIabrCwEIr1QE8nAj+nIciBgqm4w350
	5xIh2JuxQOQhTJDSsqgfJzAluLvMbRccP7MCsi8YTPN8FAXztOliY1g0/U2qKaS6YETvVugMGajG6
	PWxyyAlD1SLw6JL6pkLB2N/kfMFS745IklA9fRWg3gLZAHFI4TfQ3KVt3s1LJ2sO6EInXU/SAWZxa
	FW9gHuvWjlrYl6kEi4Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGg5-0001n0-En; Tue, 18 Dec 2018 14:48:57 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGg0-0001lV-UG
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:48:55 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBIEkYJA015616; Tue, 18 Dec 2018 15:48:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xr9fe-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 18 Dec 2018 15:48:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A22734;
 Tue, 18 Dec 2018 14:48:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D75F54E6E;
 Tue, 18 Dec 2018 14:48:27 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Tue, 18 Dec 2018 15:48:27 +0100
From: <patrice.chotard@st.com>
To: Russell King <linux@armlinux.org.uk>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Date: Tue, 18 Dec 2018 15:48:13 +0100
Message-ID: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-18_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_064853_269218_86B0CB2E 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: patrice.chotard@st.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Due to pen_release and boot_lock removal, secondary CPU's bringup
was broken. Restore CPU's bringup by reworking properly
.smp_prepare_cpus and .smp_boot_secondary STi callbacks.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-sti/platsmp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 2166850..9bfc93a 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -28,8 +28,21 @@
 
 #include "smp.h"
 
+static u32 __iomem *cpu_strt_ptr;
+
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
+
+	__raw_writel(entry_pa, cpu_strt_ptr);
+
+	/*
+	 * wmb so that data is actually written
+	 * before cache flush is done
+	 */
+	smp_wmb();
+	sync_cache_w(cpu_strt_ptr);
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * it to jump to the secondary entrypoint.
@@ -43,10 +56,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
 	void __iomem *scu_base;
-	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = __pa_symbol(secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
@@ -74,8 +85,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		/*
-		 * holding pen is usually configured in SBC DMEM but can also be
-		 * in RAM.
+		 * cpu-release-addr is usually configured in SBC DMEM but can
+		 * also be in RAM.
 		 */
 
 		if (!memblock_is_memory(release_phys))
@@ -85,17 +96,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 			cpu_strt_ptr =
 				(u32 __iomem *)phys_to_virt(release_phys);
 
-		__raw_writel(entry_pa, cpu_strt_ptr);
-
-		/*
-		 * wmb so that data is actually written
-		 * before cache flush is done
-		 */
-		smp_wmb();
-		sync_cache_w(cpu_strt_ptr);
-
-		if (!memblock_is_memory(release_phys))
-			iounmap(cpu_strt_ptr);
+		set_cpu_possible(cpu, true);
 	}
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
