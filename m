Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F1C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AD62080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FO9OOyb9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qs789xBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AD62080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AN2R87Au39fb1WfMZCwuSC8hvgzC5mn+/kgk2NRbbwU=; b=FO9OOyb9Fze5Bv
	vO3ifd+PrEIU58kaSFgq92tai29nxjWrb6YLvWPxjewDss4fxy7LfLjtcFlb4GfuajgyH1eDwyNt4
	LydOtqmnUa2cTVfauFWKVzp7TSFeOAxMFGKelJAgjI0vzrC2D6wIOqKMR3KtDrPyZlqRljBbh5cZx
	C8scxgxq2FPPkwf95pAZG/LgcNFUx/itb1nDF0Kj19tyYAmcR58CeM93NIge0yOmTOgm2bnwKTRhV
	A02xhY9bUskAn6hbrOWIW0E/OK6LB03qXMAcYpYoYGDthAbhVwJE4BXqq9EG3fcxSicx+trFyDGVx
	LuC060X9WPA+R8NHBVzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNPl-0001Jr-5r; Thu, 13 Dec 2018 09:36:17 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNOb-0007HN-IP
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:35:11 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1227c00000>; Thu, 13 Dec 2018 01:34:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 01:34:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 01:34:59 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:34:59 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:34:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:34:59 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c1227c10006>; Thu, 13 Dec 2018 01:34:58 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 04/21] dt-bindings: cpufreq: tegra124: remove cpu_lp clock
 from required properties
Date: Thu, 13 Dec 2018 17:34:21 +0800
Message-ID: <20181213093438.29621-5-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213093438.29621-1-josephl@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544693696; bh=VCHfLBMx8Da+rXf9UJ2gOo/OyDqKfHHAnbMGMXXz5zg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Qs789xBR42uTWacv9XeSy2dHEAuoDiWvf6INDPUlzU4Lx8IfStATIZsHqorqRu/Wh
 Ulj/N7T1wCLLVrpLjeoU2dkNnBz+4PJIRjYu6rY2JZ6TDBNNuHoK3/mM/EXSrYNmLP
 geerU+PoSgC8EcjRuIXdN77qAmU9H0sI1GaZxeFw8RXNx+3d7c5QroZUfyQ4JltrrL
 2AVIjjAunxJjLuqQUkZR5Adfkaj7YyzjZpe9CY71UmXpkdgXG47ghcQLGcuYWDFpNN
 u3BN4ByFpyJaqTW5NxAHpUSeE7i1EOTZwEnRL70a7N4FMehGauuj/6rbD+W4sNwpDd
 xc5EI5A1xlgAQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013506_136364_2EB67E65 
X-CRM114-Status: UNSURE (   8.88  )
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
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The cpu_lp clock property is only needed when the CPUfreq driver
supports CPU cluster switching. But it was not a design for this driver
and it didn't handle that as well. So removing this property.

Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V2:
 - add ack tag
---
 .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt   | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
index 031545a29caf..03196d5ea515 100644
--- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
@@ -9,7 +9,6 @@ Required properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
   - cpu_g: Clock mux for the fast CPU cluster.
-  - cpu_lp: Clock mux for the low-power CPU cluster.
   - pll_x: Fast PLL clocksource.
   - pll_p: Auxiliary PLL used during fast PLL rate changes.
   - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
@@ -30,11 +29,10 @@ cpus {
 		reg = <0>;
 
 		clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
-			 <&tegra_car TEGRA124_CLK_CCLK_LP>,
 			 <&tegra_car TEGRA124_CLK_PLL_X>,
 			 <&tegra_car TEGRA124_CLK_PLL_P>,
 			 <&dfll>;
-		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+		clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 		clock-latency = <300000>;
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
