Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:08:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C1820449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S0BPIlia";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NRWI2kpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C1820449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8vztsyQ6c4BeQHrpgIzXizXVWKYYrqfVb419wqp0XU0=; b=S0BPIliaEX8gtV
	3pMVcr2wz7/TyI+KFGEBpOywDVEfIwhzGd1c4m2L95g7TuEo+2wf9kfmfhb8UIuUWIxUndgiJ9Rde
	xOzi7VZlHIHF0pVFUzngktfkA+s+EUyjEIYm1zBSjS+7SeVjUvKm9T7yxsuoGONYuL9iDPVZAqqf9
	+WUU2FIq2S4jvihyWkie1xg9nfafHsHw9RLA9r9zQXMsfGqBXTW1tL0XANQmLkW16Pc7n2UeFJ0eK
	gEtjlWYaIAp4MY3OGqsgsrVLcBrhVK6xIiI2pb5uwYQ/UkDL8h2A3LDrfNz/3AQWcdBnp7eAyokyb
	nk2Hu5zBTrpKZCs2xprw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFqc-0006fI-Ot; Fri, 04 Jan 2019 03:08:34 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpL-0005ce-0W
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:16 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecdd70000>; Thu, 03 Jan 2019 19:07:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:14 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 03 Jan 2019 19:07:14 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:14 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:14 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecde00002>; Thu, 03 Jan 2019 19:07:13 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 02/20] dt-bindings: clock: tegra124-dfll: add Tegra210
 support
Date: Fri, 4 Jan 2019 11:06:44 +0800
Message-ID: <20190104030702.8684-3-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571224; bh=8Jb9Untg09JdDqjd7osL/LQeyGu/BFeOheQ1GZTHluY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=NRWI2kpde+18j8wr9X7yyhNzKmURE+XZOeU3m9ZIsqB9eWdOGBR4P9KN7gqO2wTsI
 8K8hp4AgwZu0GuTl/BukurKFes3tRJKA5BLS6PWczWmvtvO51aqgnb+Z2hL8Cb0ii6
 MuH85pr1jkAwVlPn6+t7YkM4KK+5unGAGUdSXfUuhAy1A/3YQ2gMtz2dguMLOTT8S1
 J9+lVwFfVJpAjhHkbBjrZsLXoSo+BEuzObCaMtoLUZZ4y1+pYwC3Tsz2F+BxoyFp+r
 FaLt1f2G+5MJTnKA8iBLwww6jh2vjlkMNkktIvkePvPmJbr+kHAt3vyQgg39N3S7In
 Jl71lF9V2fJag==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190715_216252_D0C4DB56 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add Tegra210 support for DFLL clock.

Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
*V4:
 - add more ack and RB tags
*V3:
 - no change
*V2:
 - add ack tag
---
 .../devicetree/bindings/clock/nvidia,tegra124-dfll.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index 5558bb5fcf2c..958e0ad78c52 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -10,7 +10,9 @@ control module that will automatically adjust the VDD_CPU voltage by
 communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
 
 Required properties:
-- compatible : should be "nvidia,tegra124-dfll"
+- compatible : should be one of:
+  - "nvidia,tegra124-dfll": for Tegra124
+  - "nvidia,tegra210-dfll": for Tegra210
 - reg : Defines the following set of registers, in the order listed:
         - registers for the DFLL control logic.
         - registers for the I2C output logic.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
