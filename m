Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:34:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A8A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oj6mZBli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A8A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.panasonic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Oe7JT6AG6ij7pFlmvKQPPXhbmwrGh9kba0aH7tzbis=; b=Oj6mZBligBjtGO
	5okO1mir4FzIiJmK59zfwwu1fqHlMJu2qKofQI22NTddMKxPTEsYXJkL3BDDoPpT5LDzOlsq/UnT2
	JuzcxhY5ltA1yDmPU31qHikaqlLa2QSt4Ofe+WBaCP7AMIG4gFxOQHVT3j6ystULAkaKCD2STL+zS
	qMwiDCClh1TKa2BUSK2qyjMH4cTXwTBbf87ur18Jl4CNcdJTwuys+LmF1O7JILbjIe5wRWtLg6OqE
	ioek06T1tKSFj1bdH0E9KPRTOgyTUyyYUWY/AUv1gD4iYMk8FT5jDASAYgn+2OnPRcACrb7Vz4v7z
	2gXgnf4gFf/zvddGBlCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gySZo-0007dA-PP; Tue, 26 Feb 2019 02:34:36 +0000
Received: from smtp.mei.co.jp ([133.183.100.20])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gySZl-0007cf-27
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 02:34:34 +0000
Received: from mail-gw.jp.panasonic.com ([157.8.1.157])
 by smtp.mei.co.jp (8.14.4/8.14.4/lvzy11) with ESMTP id x1Q2YU1l022883;
 Tue, 26 Feb 2019 11:34:30 +0900
Received: from epochmail.jp.panasonic.com ([157.8.1.130])
 by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili17) with ESMTP id x1Q2YTR21973;
 Tue, 26 Feb 2019 11:34:29 +0900
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/pml-send1) id
 x1Q2YT33023435; Tue, 26 Feb 2019 11:34:29 +0900
Received: from jpa000secmn21.palet.jp.panasonic.com [10.74.216.56] 
 by JPA000SGWMN04.palet.jp.panasonic.com with ESMTP id MAA26627;
 Tue, 26 Feb 2019 11:34:29 +0900
Received: from localhost.localdomain (10.74.216.181) by
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Tue, 26 Feb 2019 11:34:29 +0900
From: Kohji Okuno <okuno.kohji@jp.panasonic.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] ARM: imx6q: cpuidle: fix bug that CPU might not wake up at
 expected time
Date: Tue, 26 Feb 2019 11:34:13 +0900
Message-ID: <20190226023413.19531-1-okuno.kohji@jp.panasonic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
MIME-Version: 1.0
X-Originating-IP: [10.74.216.181]
X-ClientProxiedBy: JPA000SECMN26.palet.jp.panasonic.com (10.74.216.63) To
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_183433_356475_09CAF158 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Kohji Okuno <okuno.kohji@jp.panasonic.com>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

 In the current cpuidle implementation for i.MX6q, the CPU that sets
'WAIT_UNCLOCKED' and the CPU that returns to 'WAIT_CLOCKED' are always
the same. While the CPU that sets 'WAIT_UNCLOCKED' is in IDLE state of
"WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
istead of "WAIT", this CPU can not wake up at expired time.
 Because, in the case of "WFI", the CPU must be waked up by the local
timer interrupt. But, while 'WAIT_UNCLOCKED' is set, the local timer
is stopped, when all CPUs execute "wfi" instruction. As a result, the
local timer interrupt is not fired.
 In this situation, this CPU will wake up by IRQ different from local
timer. (e.g. broacast tiemr)

So, this fix changes CPU to return to 'WAIT_CLOCKED'.

Signed-off-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
---

Changes for v3:
 - remove the braces for a single statement inside the if block.

Changes for v2:
 - change "master" variable name.

 arch/arm/mach-imx/cpuidle-imx6q.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index bfeb25aaf9a2..326e870d7123 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -16,30 +16,23 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
-static atomic_t master = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(master_lock);
+static int num_idle_cpus = 0;
+static DEFINE_SPINLOCK(cpuidle_lock);
 
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	if (atomic_inc_return(&master) == num_online_cpus()) {
-		/*
-		 * With this lock, we prevent other cpu to exit and enter
-		 * this function again and become the master.
-		 */
-		if (!spin_trylock(&master_lock))
-			goto idle;
+	spin_lock(&cpuidle_lock);
+	if (++num_idle_cpus == num_online_cpus())
 		imx6_set_lpm(WAIT_UNCLOCKED);
-		cpu_do_idle();
-		imx6_set_lpm(WAIT_CLOCKED);
-		spin_unlock(&master_lock);
-		goto done;
-	}
+	spin_unlock(&cpuidle_lock);
 
-idle:
 	cpu_do_idle();
-done:
-	atomic_dec(&master);
+
+	spin_lock(&cpuidle_lock);
+	if (num_idle_cpus-- == num_online_cpus())
+		imx6_set_lpm(WAIT_CLOCKED);
+	spin_unlock(&cpuidle_lock);
 
 	return index;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
