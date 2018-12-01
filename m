Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB68C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBDA2081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IhyVqGlG";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="r7DoDvYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBDA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RRkg1KG5HszT26Q+BmqOh7RNogrim745gltdLxL+pes=; b=IhyVqGlGjBNTQq5cmBqSuFFRuH
	Okl8U6pb79igzsy5OmEbZaMHremy5ioFlo6/rcmiGIHSVbYHOEkzUUyEWwIdKyTp5YiMGd2QMy0xC
	npnJ7aRZSmcQQZTWGHgiz7OV1L7S39vK9LJ9megsF2IN7IMzASPaL1580YLJp63SNSiWgaVAjY/iL
	HrC+ML2uP0madGUjBPop53ycP3N4AIB4NZ+Luj6QaUzJLXMx3ULhpM/HTE6+DwpRmd0JRt3C+Ij0y
	9QqDy1goehGDUjhJx6c/3oiDYVPbH5zCJtiG+/4Oa5fIAe//ckb6imOcJ1f2gl7aDg4LorduX9zCQ
	Q4U3PpnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT2DC-0004Dl-HB; Sat, 01 Dec 2018 10:09:22 +0000
Received: from mail1.kuutio.org ([92.222.216.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT2D9-0004Bs-QW; Sat, 01 Dec 2018 10:09:21 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id 0D8F31F978;
 Sat,  1 Dec 2018 11:09:06 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=dkim; t=1543658945; x=
 1546250946; bh=MzMBlHLkwiO/Fjwv4OAmFkPbUn6e8VQqxVxiqId1keM=; b=r
 7DoDvYKXp1GnJysyhAmB34LtkVCKF2PK66Fubxq/fmSxV+EIQwsX2qZoZvJ7TE6r
 hvYuOothTRbr2qXUFXEQYHtv0mMWoivuqJoXtZOqzAaa5dnDLBfPa+dbLmKEI+XN
 TGLD+AwTtS7VqY2DH/Z02OCpB41DuBzmmvfOCEQnEFzRpb18PNeit8f3nwv+cJyQ
 oqnwA/wTQA2j1ugGzXUL43NVZHSIvwfcfBAXoNlOpyUb9vWJ14pkMEd9OcojkhNq
 aDAQf840O5zEGjXkOEIEBIP1WeyBWEiw+UbO4QVzrKpRDDEleerjjbkuy9pxqzVh
 1d0WkpkjEeHyjTYltNW0g4dB0DgGKVMKcV1x6PPdmQDjl3vybaL++yOHDQg7HYdN
 mojHaupm+NsYrewiNWtRYVyZ47oFy7MXGcXZDyy5KNpmZqq2TcieIePax7A/aQYg
 yBibI1tT/LzJKc5GNBle3K59LscJZ1+qZ3kCi3R+j7Bw6cJiBfsmet1mD2QXznaa
 UbkI6A2VQY4a4Yx9S+4FC24n4zgxkb5k8fZWVuGM95otNcmd0B1tfYxL2AXhzOGn
 gG3zy1UkZrhSuZXr1aqAg9db35m3uv5IMvqMvrt2H+9/4jfWvaJzEkzxPN8urdcV
 R1CyMjjfrp4Q8rU3KaMJEVV2wmT5fjx32TPS5Krw04=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 6Uhxi4Dz5h0S; Sat,  1 Dec 2018 11:09:05 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id 988B41F99C;
 Sat,  1 Dec 2018 11:09:04 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: rockpro64 fix video output chain
Date: Sat,  1 Dec 2018 12:08:17 +0200
Message-Id: <20181201100817.20688-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181201100817.20688-1-oskari@lemmela.net>
References: <20181201100817.20688-1-oskari@lemmela.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_020920_025687_A77E9DAD 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: devicetree@vger.kernel.org, Akash Gajjar <Akash_Gajjar@mentor.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Oskari Lemmela <oskari@lemmela.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rockpro64 is not able boot if kernel is compiled with
CONFIG_DRM_ROCKCHIP=m

Enable Rockpro64 board HDMI output to fix issue.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 5bd4d69914bd..be78172abc09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -205,6 +205,13 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
