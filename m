Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050E9217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqwDJRkZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e4UHor/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050E9217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IaUUXrll6X6P68gQ0f+/dpJIOyIONKnh3Gv7/0YqTyc=; b=fqwDJRkZvtqKNM
	BHxSddIIEnP7p4jNNKomfB7paXL/rbFjm7h+r83K0UCuvNk+lInGi1ch2itmcoS4G9VeJG+5q2Mpv
	5xSaNtUsfIi+C11PHx41uwxbFErz33uO0071MU79PTl2KTYqhuyrYQYyBUfGKP+uF3mEoQRtRib9+
	uyWKzA3I63e+sLtKsaqaiQJG8IeUfocHGEk1j8QD+pUUmI03KiMgzypmlgWi0thCxTm3uanicFi2G
	FfjoK8kSvxxoN9z/YG9o6WR+iZaZlSqsY8ElhhSR5+3vt52QYwirhvfWMw8Aa2uQJ10jWuxPf0ZYr
	c2VNbqbSPFAqQhfvsdTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBVa-0001hc-5Y; Tue, 18 Dec 2018 09:17:46 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBRX-00058j-KW
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:13:40 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18ba2f0000>; Tue, 18 Dec 2018 01:13:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:13:24 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 01:13:24 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:24 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 18 Dec 2018 09:13:24 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c18ba320003>; Tue, 18 Dec 2018 01:13:23 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 17/20] arm64: dts: tegra210-p2371-2180: enable DFLL clock
Date: Tue, 18 Dec 2018 17:12:29 +0800
Message-ID: <20181218091232.23532-18-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545124399; bh=TRrB/5yDjmFkodAr3jKXV8G6KUGVr/8Xkgu7egYULn8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=e4UHor/XALzLPaPQ+45JJ+Xjt0Q58lLKmL2m9kI2YjRoGvmC+5XpPRGU1k5DpLgyk
 ispo3vkCVFVJXKtjwxBsp8P62VfYxPqskftXZT889CctGN3bUMHdLVHCqVxuCxP5sF
 iQdnYXI5D7LwEAiR09fwmBXVgnZo+0WLff/VhPfx3clLpOx2itspN/PTVBVmra3NbK
 xL/3f7saVjCSqMOfkW/IDIPvfVWV7iveU99p4PsmmAMq/hmB8fxgA4puPV/zsnbPHH
 jSjn+vodCMJVqIlRc+Woyv+r3g5yaUD4F9RzDDBxk+9Umm6WqpGN1ZCAhNjQSPJGYc
 dOs51/8voEuZQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011335_988987_B39B4926 
X-CRM114-Status: UNSURE (   7.51  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable DFLL clock for Jetson TX1 platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V3:
 - add ack tag
*V2:
 - remove non exist DT bindings
 - update the PWM DT bindings accordingly
---
 .../boot/dts/nvidia/tegra210-p2371-2180.dts   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 37e3c46e753f..99c016bfc601 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -78,4 +78,25 @@
 			};
 		};
 	};
+
+	clock@70110000 {
+		status = "okay";
+
+		nvidia,cf = <6>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,sample-rate = <25000>;
+
+		nvidia,pwm-min-microvolts = <708000>;
+		nvidia,pwm-period = <2500>; /* 2.5us */
+		nvidia,pwm-to-pmic;
+		nvidia,pwm-tristate-microvolts = <1000000>;
+		nvidia,pwm-voltage-step-microvolts = <19200>;
+
+		pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
+		pinctrl-0 = <&dvfs_pwm_active_state>;
+		pinctrl-1 = <&dvfs_pwm_inactive_state>;
+	};
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
