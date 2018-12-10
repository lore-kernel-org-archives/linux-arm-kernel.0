Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B75EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD822082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pnP9TU13";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y154kKpT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYP/0cOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD822082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9NOtOvOtmGnE3huAXZn+pAhXuAPKmwO4LQjqRvcoh9U=; b=pnP9TU13fm8Gj+6MQ1XlbSVYjF
	BA7SBf5rWzJs+s6Ax4bRnTsy9nUvo5wRJHeMYKHF0XQ/21YT3zRjAxhAPbyakKvS2Ueslfpa/0ERl
	v4YEyLcm/lBBV2FtXs6TwgrmHjy3jKFBdKnTCSgkiEVChJVx7AuMSN06MwrVQkvxxfr/Xrp/hp+dX
	lqurjJRKUBcjQNbrl0okwUbxhx/VHidANpYh3kOzAIqFaHP08Al/PFV6O5c6BUlye1tHgPNsUS3uz
	lcVsHq8HiFTbjg44CtiAXZErdyKyn62JIW2Zly76YgsqzbclMvy51NJxa5dYwX253YSzocGQRZlrO
	4tAQUQAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQL6-0006IL-9Z; Mon, 10 Dec 2018 18:31:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQL5-0006HR-2x
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 18:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ve2dYgrCZ5Tle2sJqAhn9PzIY+bLP3s6YNDsILvoiZc=; b=y154kKpTMQhpb/ga6qzWjJCC5
 ahK73MXSFSyD9egWmdxaHy5G8a6CIjiOa8PCE9X8LALA3Xb0egV3NBriMNipTJYvs1to+dP8YKGkg
 JcrIl768SQN0/IIwv0thFSydtIKW4iwrD4XcpF+Llys7FPrqy5l9uKPFbW5inygFk1uMsCdKmMe8M
 DzjwI+2Puh7YOyC7ebLnyyk7Ms9HrjBqk9LFMlDWef8SST4aZhKU6hGiE+/UaG1wxZnS7qV3BMjl6
 0/w7DHK49XzMC/KuR3Y8OdT42Rm3vXFR+6GXCuJDOcJhxM+tEZgymrVUa2x0F8TPBvnYZrGbeWBau
 R4YXcWTIg==;
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPUr-0005nw-D7
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:33 +0000
Received: by mail-pg1-x544.google.com with SMTP id w6so5277501pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ve2dYgrCZ5Tle2sJqAhn9PzIY+bLP3s6YNDsILvoiZc=;
 b=LYP/0cOgbYK2nuTZi3UJj5tE6bBV7bMqxBkzrvcG0JwpitEI8gurlVUXxCV1K5T6bH
 9dD74F1YiYMpWDoDRmL+v/ag9WgP8e7xEHLcPRbM4+QXtIBuQ2J6icUpPP0cCAfKBeFs
 SKG0VT9WQOO1cb2rhdQM9z5x0jznpwl6Xi4y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ve2dYgrCZ5Tle2sJqAhn9PzIY+bLP3s6YNDsILvoiZc=;
 b=hX6eiLhQEGxmawvSZRG0DPRF/n9PghioeGcqeXj6IODWTUS/k1m1e7fI1thhZhIoUP
 t/Ws9DujVF8nmTELk741kn2Q/hJ9ZKYxHpAyQV/OO23D/V1Qj1yAigCQcWAoxicTcNop
 XBkWbXAfU5v4WKEc76/8wIln/RkhwkRVRoWDc/K2aV17GzXSVLwXpPrAOUj0qayaL/RJ
 zbKI7VUJkrRSRHlT2Ra/gM0QrTOLmKBWQnogwVpux9Gv0O9T0wx4fRt/U2IO7wTBgKQd
 KU5ryYJAXfUn6lrzh524/hzUUKencv+UOlaTmluhePzu+cfl9CGgyNOy/fPTa5xvwzrB
 Rabw==
X-Gm-Message-State: AA+aEWbpVKraQgos4bPabA70NrHAyw3d0VR4QtHfVRupnnUNaHKIg6zV
 qttmCz3sCJrflLwdA6zimigy
X-Google-Smtp-Source: AFSGD/VCP41P+oi6oAUSJ5qVFaUMQwfwdDsobUxtD/1d6CKrDLV5is0oFowj+9K3e3Pk7BMNQt6akw==
X-Received: by 2002:a63:181c:: with SMTP id y28mr11299843pgl.75.1544463441170; 
 Mon, 10 Dec 2018 09:37:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:20 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date: Mon, 10 Dec 2018 23:05:44 +0530
Message-Id: <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_123733_463539_2A21C80E 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..4db542c9a0fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,20 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain two interrupts.
+- interrupt-names :  Should be "hwtimer", "ostimer".
+
+Example:
+
+		apb@20900000 {
+			compatible = "simple-bus";
+			...
+			timer@10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
