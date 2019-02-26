Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE6420652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvWlfN7o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rvHSdklt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE6420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RnmpKst9lVZhgUGgSs7tryK/n19nqZNF8xokA/V5cBY=; b=gvWlfN7opLZExA
	4GAdgf6bdijLcbd/cLMV4pAUGL1F35oNH1AWyf5/DujDP41j2yxepXHovQfc838OtKASfmtczD12U
	2D1vX/jKPQ6CnYjCcHbEqylBfIfxqz0d8eHZoKtgDQG9Uh/swuVXfarF3oRhiDj5tJwNZRkKnA9r6
	Phpnhgd3tYlhxfIQIHXSANISQyP0/d0b3wwaDH3y0b3QO6Q30yKWsFK0PUbByfmySAMiOwoK1HM62
	Vw7fEaBVv9/flK8AllEt8+f9+zsWrLWfecr+i8CNQifoKHFUarAn+Hk/B8fJmo4DRlmZ6TI0wbGkA
	j6IM8X/jTg7u0TGu6tUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfH8-0003O5-8N; Tue, 26 Feb 2019 16:08:10 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfH4-0003NU-6C
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:08:08 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c75646c0001>; Tue, 26 Feb 2019 08:08:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 26 Feb 2019 08:08:03 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 26 Feb 2019 08:08:03 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Feb
 2019 16:08:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 16:08:03 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c7564620003>; Tue, 26 Feb 2019 08:08:03 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] arm64: tegra: Add supply for temperature sensor on P2888
Date: Tue, 26 Feb 2019 16:07:55 +0000
Message-ID: <1551197275-8977-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1551197292; bh=qqH8dLntyX8Y6PYkjVM335Wgs6r4H32K+/OW1W86il0=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=rvHSdkltY6ElyA9BZZX5rgwFyTnGbzeM9okrzbYT1195He2t4+p/pZt0V9gYanq56
 LXH2c3vQ1utm57OVRxjtrbfa9tFRTM10+ONLxIBerB0/fGc2ofbOZ69++3eLZ+0lCB
 KvGY1zgvB+4djSSo8uhWTM3dN+eFacpxc2tj5j4+PPmmOtCBDMC9JhJfHPthOECyxO
 DUttxs6VTNaEkBbmyj7kMAwQvszE5ec9YW+TqS+O4lROWBj/dw8BHJWmtAqKRt3FYB
 ftvJJvw0BoV0uJnwW3IyxcjmmARCbWtQP7N8Oo5y459mXqoDFWwz094tAuphx6GWs0
 fJBv4gc/56fsg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_080806_810677_8075F174 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The VCC supply property is not populated for the temperature sensor on
the P2888 board and so the following warning is observed on boot ...

 lm90 0-004c: 0-004c supply vcc not found, using dummy regulator

On the P2888 board, the VCC supply for the temperature sensor is
connected to the 'vdd_1v8ls' rail. Add the 'vcc-supply' property for
the temperature sensor to prevent this warning message from occurring.

Fixes: 8b457812f54b ('arm64: tegra: Add temperature sensor on P2888')

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 246c1ebbd055..0fd5bd29fbf9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -256,6 +256,7 @@
 				interrupt-parent = <&gpio>;
 				interrupts = <TEGRA194_MAIN_GPIO(H, 2)
 					      IRQ_TYPE_LEVEL_LOW>;
+				vcc-supply = <&vdd_1v8ls>;
 
 				#thermal-sensor-cells = <1>;
 			};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
