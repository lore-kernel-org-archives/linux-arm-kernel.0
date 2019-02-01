Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:16:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6520A20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="McDlbHcu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XGKIJBbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6520A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RouHeJ9BMlrBrHeV2MVF2AmVua6ouPAtzEFyK4F7RFk=; b=McDlbHcuFayDfV
	xQDo4L30ovOpA+Kmfs5qlqATB6VsCC2iPEnbw0PX4KDMbbEDozGfAfBFaZze+QY+u1af5PCIll9QP
	RPoACjf5BohjsqyKwYQvq2e1V6Gn51rcV6HB9F+gwe3Zyj8cD6fZ523Zr5FDZR0UcAaVCbfcZa/BY
	My/eAXKLOLTWh3MUp4Vj6DDqwoVIO4NOmAnNEi7QagUIiAm6zw1dMjg8wjKTm4XyTDZhXKF024NTC
	KpaS5PSrvKcQsaKHrjL2+AOpdFIEnSSy0UrhIjnit1g0KzXO/aZIN8+hhshONjxhZA2P0wSXU7aqo
	khHZLaaHm0/3PkaVbIaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpONr-0007zm-Ka; Fri, 01 Feb 2019 02:16:47 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpONo-0007zO-Pu
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 02:16:46 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53ac0e0000>; Thu, 31 Jan 2019 18:16:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 18:16:44 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 18:16:44 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 02:16:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 02:16:43 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c53ac0a0003>; Thu, 31 Jan 2019 18:16:43 -0800
From: Joseph Lo <josephl@nvidia.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Subject: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Fri, 1 Feb 2019 10:16:39 +0800
Message-ID: <20190201021639.27245-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548987406; bh=xHFinBIHHiPCrjKdjMcLZrTppMXBCiOOzTv5MfwdUB0=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=XGKIJBbHGD1Its0Jy/VYxmLF9WegAHGjrtsElqBgiVeMeeyD9qqSSUuB7xEhd9UiG
 ZKgCYFOea94bc32lJhvN8tLgfDfC5o9EKzIApYT6vlbMz/GC1DNOLvCMfuPage1xec
 EW5ddgU9he/0JctBKvmHi+fVd2ru5y7JwomR68snhWR68d0nWcWT8tya3NoUbJgYuP
 fql/RxPumYkG/T3HDED27wPA62ImzmChs9A7Eq419lWWtyJGBgsNWTTpAzswAJ4cCX
 uSDegg4Kw4JHPnBMumqWao3/0amZpwODf/yIgWaCSB9otgq+Di2EFWjRtPcp53Q/C0
 YYbHeyYMJf/4Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_181644_852768_A8D48FA0 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: linux-tegra@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Joseph Lo <josephl@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the DT of the idle states will be parsed first whether it's
compatible or not. This could cause a warning message that comes from if
the CPU doesn't support identical idle states. E.g. Tegra186 can run
with 2 Cortex-A57 and 2 Denver cores with different idle states on
different types of these cores.

So fix it by checking the match node earlier, then it can make sure it
only goes through the idle states that the CPU supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v2:
 * fix it by moving of_match_node earlier, so we don't need to match the
   node twice like the v1 did.
---
 drivers/cpuidle/dt_idle_states.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 53342b7f1010..add9569636b5 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -22,16 +22,12 @@
 #include "dt_idle_states.h"
 
 static int init_state_node(struct cpuidle_state *idle_state,
-			   const struct of_device_id *matches,
+			   const struct of_device_id *match_id,
 			   struct device_node *state_node)
 {
 	int err;
-	const struct of_device_id *match_id;
 	const char *desc;
 
-	match_id = of_match_node(matches, state_node);
-	if (!match_id)
-		return -ENODEV;
 	/*
 	 * CPUidle drivers are expected to initialize the const void *data
 	 * pointer of the passed in struct of_device_id array to the idle
@@ -160,6 +156,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 {
 	struct cpuidle_state *idle_state;
 	struct device_node *state_node, *cpu_node;
+	const struct of_device_id *match_id;
 	int i, err = 0;
 	const cpumask_t *cpumask;
 	unsigned int state_idx = start_idx;
@@ -180,6 +177,12 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
+		match_id = of_match_node(matches, state_node);
+		if (!match_id) {
+			err = -ENODEV;
+			break;
+		}
+
 		if (!of_device_is_available(state_node)) {
 			of_node_put(state_node);
 			continue;
@@ -198,7 +201,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		}
 
 		idle_state = &drv->states[state_idx++];
-		err = init_state_node(idle_state, matches, state_node);
+		err = init_state_node(idle_state, match_id, state_node);
 		if (err) {
 			pr_err("Parsing idle state node %pOF failed with err %d\n",
 			       state_node, err);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
