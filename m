Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E0C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05C420833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RGeO3nRE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O8lh3s3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05C420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EcgJoN1dVkmww3xZgk3ePzFoAQEpVIMGrvvnJfPGo9g=; b=RGeO3nREFSHKN0
	3GDXXicTBBi7mHnycSZUkDtgJCpyaN/4fmRCXz5YMQCgp64Ak+9+CfdtnaGPiEoxAYfKzefifrGIt
	eQz5k3Shj2U5IB00sR6EGl3M/iCUZT6jRJylxCUvWq6uh6W6kVE8YHtPFC2tQLcy3U0CetJVpt6Yj
	5+FgbvHTLtrx2ILbCmUsVrOFUIGrDHqyP0u5deN178Nnc8dl1kBS3IZlNvGWRXSHOLRTP26fhaHIi
	n0qdqpsZFcAFEvEbsPipgw5d06lhJjcaapYN8vA3hqUD6Z6ABbNVKST+uHaH2zU7b0VxM7iwS84Hf
	QC5ogpNZ3AWuZw7yfGrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp25D-0006T2-50; Thu, 31 Jan 2019 02:28:03 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp259-0006SZ-Hf
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 02:28:00 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c525d120000>; Wed, 30 Jan 2019 18:27:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 30 Jan 2019 18:27:58 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 18:27:58 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 02:27:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Thu, 31 Jan 2019 02:27:58 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c525d2d0001>; Wed, 30 Jan 2019 18:27:58 -0800
From: Joseph Lo <josephl@nvidia.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Thu, 31 Jan 2019 10:27:49 +0800
Message-ID: <20190131022749.19046-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548901650; bh=K/Sn/R96/V9UvB/oooNtf+xhwMY4u/ll78TrSAWn144=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=O8lh3s3Kwn2uoeVfl2/HJLf7w3gH5/vpq4ZQN0xlxuvd5EznFp0O6akC+cHtwkUSE
 UYugE0aXFvugYeKdUdppD299Vr8uRmUGpanMKL9F1/u1JnDI/GW1q/dZvNWfefEHQR
 S/6utw5p/3fY2zreMZh5xiJcGVdNWR35D6LyNWibypZyd7dyv6v1323wbdSgRWp3KO
 rTZQZyRFtnWcDAH+7Y8J+7Ac2XSawEW2TMb83EL1mEs/0Iw3RmDxm0v59nyRdUuWQc
 XXL+mRhI4uIFUYzMKzxuvOF5y4KdhfJNiEsQ7se916fM3c6RUZ08mPmujNyLv8yxQr
 X2rShz40dqYwA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_182759_589181_91373E4F 
X-CRM114-Status: UNSURE (   8.16  )
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
Cc: linux-tegra@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the DT of the idle states will be parsed first whether it's
compatible or not. This could cause a warning message that comes from if
the CPU doesn't support identical idle states. E.g. Tegra186 can run
with 2 Cortex-A57 and 2 Denver cores with different idle states on
different types of these cores.

We fix it to check the compatible string before the parsing procedures.
So it can make sure it only goes through the idle states that the CPU
supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/cpuidle/dt_idle_states.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 53342b7f1010..4a528908abb3 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -180,6 +180,11 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
+		if (!of_device_is_compatible(state_node, matches->compatible)) {
+			err = -EINVAL;
+			break;
+		}
+
 		if (!of_device_is_available(state_node)) {
 			of_node_put(state_node);
 			continue;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
