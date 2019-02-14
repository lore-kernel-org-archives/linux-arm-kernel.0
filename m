Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB27C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FF02080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMXOCe3e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QudLWP+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FF02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6uHsZ0LWP/NuQic3w+wGom4W/TyGuZeRK/dAZmw2i0Y=; b=BMXOCe3evJKjGvI82xpYqD2cS8
	cEnUHmyuhDXzdx3ti/uR2Kd1SbUCYh745FBnln3j2n9pdNHPNOA26yL46fH/jzAOqdPUs/PM4HWIG
	9KiFDkeUxeebYF37FSnTX/mvBZsPUoDZN8PaSYHrcRnQHuRCyjawAyFb1UjsVeEP7aL+LVzd6apCy
	OYkEVZAxAyfghw5CXVdPcRfpBvFGugf/yzXYjoUJUfF5u1cf1EpMm5EpNLUlJuh+CHlJgXs4vnJ54
	j1P2z1rh7vRb1QMS66BxS7gbXXZA8lhm+vXGcG7GfHnDgq4EyVskFf8wi/sR9zMWc9DwXMAOBo8Kk
	pCfeoTBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLI6-0001C5-Pq; Thu, 14 Feb 2019 17:59:18 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGz-0008JO-A4
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:58:28 +0000
Received: by mail-it1-x142.google.com with SMTP id l15so3677249iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
 b=QudLWP+sniBzsE8uYjGXuJXcEydbgmJhe/GvRfu9kTa9EIp4Z2eDYZ8REpNLIpE1Zm
 fyaW5eIjNG4/Fzzq+CL+z8f2UIIQqAc0EXYUO/coSwHV5l5bgbqTBH1lZAA+PV32UUS5
 rKgOyUjPR/1hen90tuQTJdD8IJTesj2YRH23g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
 b=bfZLGRrAbfigHbGd45AIKDrQATABTh41Zyy1VxinxjwBlb1ixuZCPApdkK0N3TRoAs
 4nHuoLHrshhnX8dDjEtMo0WquYjGY6jFNdrI+t5JFpiLVAJKULouKE3Wnxzkn3bFrS8c
 x5UcoOInHMcC0d6Viv6dGF+KAhXqdIrkZQQaeXVcg9bigAb3PJQxTC/US0nlBIEg+wUV
 eTWd0iZVDY09APbO7xj/3DqxYO+YW5IAUOLtNx5jlwZQ3rqOQVA9iYk7mgC+B/pXUXRO
 OgqjGr+PRxOHD9iXkw09Y2EAOkEVQSqXnHllGZJqktEQTpBhlU49mRMJ9ocW1zj447hy
 GUww==
X-Gm-Message-State: AHQUAuY9+AWrO37uGx5Ptbspzbah7pV3NQGusyNGtA0CIAiDvZFQpY3T
 RNIQ4z9AL91aSuw2D6y2mlT8CQ==
X-Google-Smtp-Source: AHgI3IbI06wiWDqUs7HRa1Q+9hP8xygHiei3IcNiwtWZlToH3VapRCyZPICy+iKeXQfRl1apGw4DCA==
X-Received: by 2002:a5d:9287:: with SMTP id s7mr2799518iom.295.1550167088620; 
 Thu, 14 Feb 2019 09:58:08 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:58:07 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 8/8] arm64: dts: Stingray: Add NIC i2c device node
Date: Thu, 14 Feb 2019 09:57:25 -0800
Message-Id: <20190214175725.60462-9-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095809_520237_04C5877B 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC i2c device node.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa855bd05..67e53768a84a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,22 @@
 			status = "disabled";
 		};
 	};
+
+	nic-hsls {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0  0x0 0x7fffffff>;
+
+		nic_i2c0: i2c@60826100 {
+			compatible = "brcm,iproc-nic-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x60826100 0x100>,
+			      <0x60e00408 0x1000>;
+			brcm,ape-hsls-addr-mask = <0x03400000>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
