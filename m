Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CE1207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pHFcim+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CE1207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.panasonic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:From:Subject:To:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wwNU6ndszv+Yr5br8OELgs4M9O9VjBYExs7iZqL3R8E=; b=pHF
	cim+BB1ur8Xb0GA82kpQECd/Lh4cGke97dm3If74/ORL+iFqmTCIHYhByvM2UEQodxLyjwJnFbr/Q
	b3bqgzmeWHZgbq4zl9ZsauejQbr838NW6c5WzkCAQJf+5guY4YYRcXT9xThpQEseBAdzDt+4Yq3TU
	woCiRICsbLcUMDF7Fv12a00YwHiyTJb/wzZ2iv5DOZPYHSD2KgkQVNYCp7Fc/mMFrBlYQw92Xvr1Z
	ZuTlq227dEeEdttgY/sAucevIyseKB/P1rL/PgW8P7V5RXSToA+pnslpFtUVgJwTZuk/TeBDPVS0V
	n0waBpKuhCSuDLucxN4G6dBMHyP1jvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6XB-0007VP-CS; Fri, 22 Feb 2019 08:50:17 +0000
Received: from smtp.mei.co.jp ([133.183.100.20])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6Wu-0006PD-3j
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:50:08 +0000
Received: from mail-gw.jp.panasonic.com ([157.8.1.157])
 by smtp.mei.co.jp (8.14.4/8.14.4/lvzy12) with ESMTP id x1M8nuTL025577;
 Fri, 22 Feb 2019 17:49:56 +0900
Received: from epochmail.jp.panasonic.com ([157.8.1.130])
 by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili14) with ESMTP id x1M8ntg16773;
 Fri, 22 Feb 2019 17:49:55 +0900
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/pml-send1) id
 x1M8ntSQ012690; Fri, 22 Feb 2019 17:49:55 +0900
Received: from jpa000secmn21.palet.jp.panasonic.com [10.74.216.56] 
 by JPA000SGWMN05.palet.jp.panasonic.com with ESMTP id TAA07812;
 Fri, 22 Feb 2019 17:49:55 +0900
Received: from localhost (10.74.216.120) by
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Fri, 22 Feb 2019 17:49:55 +0900
Date: Fri, 22 Feb 2019 17:49:53 +0900
Message-ID: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: imx6q: cpuidle: fix bug that CPU may not wake up
From: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Organization: Panasonic Corporation
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="--Next_Part(Fri_Feb_22_17_49_53_2019_321)--"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.216.120]
X-ClientProxiedBy: JPA000SECMN32.palet.jp.panasonic.com (10.74.216.73) To
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_005000_864885_D923A762 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, okuno.kohji@jp.panasonic.com,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

----Next_Part(Fri_Feb_22_17_49_53_2019_321)--
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
I found the bug in cpuidle-imx6q.c. Could you check my patch?

 In the current cpuidle implementation for i.MX6q, the CPU that sets
"WAIT_UNCLOCKED" and the CPU that returns to "WAIT_CLOCKED" are always
the same. While the CPU that sets "WAIT_UNCLOCKED" is in IDLE state of
"WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
istead of "WAIT", this CPU can not wake up at expired time.
 Because, in the case of "WFI", the CPU must be waked up by the local
timer interrupt. But, while "WAIT_UNCLOCKED" is set, the local timer
is stopped, when all CPUs execute "wfi" instruction. As a result, the
local timer interrupt is not fired.
 In this situation, this CPU will wake up by IRQ different from local
timer. (e.g. broacast tiemr)

So, this fix changes CPU to return to "WAIT_CLOCKED".

Best regards,
 Kohji Okuno

----Next_Part(Fri_Feb_22_17_49_53_2019_321)--
Content-Type: text/x-patch; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-ARM-imx6q-cpuidle-fix-bug-that-CPU-may-not-wake-up-a.patch"

From 2cfeb5f68c2dd0de4854dbac091bf330e25f00d1 Mon Sep 17 00:00:00 2001
From: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Date: Fri, 22 Feb 2019 17:45:26 +0900
Subject: [PATCH] ARM: imx6q: cpuidle: fix bug that CPU may not wake up at
 expected time

 In the current cpuidle implementation for i.MX6q, the CPU that sets
"WAIT_UNCLOCKED" and the CPU that returns to "WAIT_CLOCKED" are always
the same. While the CPU that sets "WAIT_UNCLOCKED" is in IDLE state of
"WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
istead of "WAIT", this CPU can not wake up at expired time.
 Because, in the case of "WFI", the CPU must be waked up by the local
timer interrupt. But, while "WAIT_UNCLOCKED" is set, the local timer
is stopped, when all CPUs execute "wfi" instruction. As a result, the
local timer interrupt is not fired.
 In this situation, this CPU will wake up by IRQ different from local
timer. (e.g. broacast tiemr)

So, this fix changes CPU to return to "WAIT_CLOCKED".
---
 arch/arm/mach-imx/cpuidle-imx6q.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index bfeb25aaf9a2..22d982d451d1 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -16,30 +16,25 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
-static atomic_t master = ATOMIC_INIT(0);
+static int master = 0;
 static DEFINE_SPINLOCK(master_lock);
 
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
+	spin_lock(&master_lock);
+	if (++master == num_online_cpus()) {
 		imx6_set_lpm(WAIT_UNCLOCKED);
-		cpu_do_idle();
-		imx6_set_lpm(WAIT_CLOCKED);
-		spin_unlock(&master_lock);
-		goto done;
 	}
+	spin_unlock(&master_lock);
 
-idle:
 	cpu_do_idle();
-done:
-	atomic_dec(&master);
+
+	spin_lock(&master_lock);
+	if (master-- == num_online_cpus()) {
+		imx6_set_lpm(WAIT_CLOCKED);
+	}
+	spin_unlock(&master_lock);
 
 	return index;
 }
-- 
2.17.1


----Next_Part(Fri_Feb_22_17_49_53_2019_321)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

----Next_Part(Fri_Feb_22_17_49_53_2019_321)----

