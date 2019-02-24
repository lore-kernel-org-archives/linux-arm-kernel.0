Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693D6C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B94B206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PKyfeMCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B94B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PO44sIrdyx1RDzeJQF+7GUpFdJtbb0lA+BEf5YyAgDQ=; b=PKyfeMCKylNy0y
	TJjeKW5fPhOIwzgV8EAkYFTzAcFwrnAPXxdPWnz39ClpSyY/ylg8X9s7oIVNse8skj3vLwDLl88jA
	mQfXIriR9fiF5gbdJ0LrN0pb7AVIQU1XPsLWb8EIk0KYMTWRruHn5d17ZVPjdISoF12vD/0WTJa/w
	joeHgcWIlVigR3TZb4qKd/6ZARDfteNbuJv0Fo6hRO5jvbPXgsdJK3apPhf6Ty8fVWtO1CJCAJf+/
	nnB8wLytyQG9jXzmzYEySvXSVex0kNQZlR2/4KELtXAoDLW++vI2etRfrDySOzZQ2KmxlIhp4NhEP
	4wPMwoHv6yAZeqtzPAZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxuPL-0007di-Ie; Sun, 24 Feb 2019 14:05:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxuP8-0007Yd-FR; Sun, 24 Feb 2019 14:05:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2D91596;
 Sun, 24 Feb 2019 06:05:12 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3166C3F690;
 Sun, 24 Feb 2019 06:05:09 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Kalle Valo <kvalo@codeaurora.org>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH 1/4] dt-bindings/marvell-8xxx: Allow wake-up interrupt to be
 placed in a separate node
Date: Sun, 24 Feb 2019 14:04:23 +0000
Message-Id: <20190224140426.3267-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_060518_521184_74369415 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The DT binding for the PCI version of the Marvell 8xxx wifi devices
is pretty broken (the fact that a PCI device requires a DT binding
is quite telling on its own).

The binding allows the description of a wake-up interrupt as a sideband
signal, allowing the wifi device to wake-up the system. So far, so good.
Until you realise that placing an interrupt in the PCI device DT node
has a specific meaning, and applies to the actual PCI function, and
not some random sideband stuff. This is of course in total violation
of the OF specification (IEEE Std 1275-1994), but hey, who cares.

Let's thus change the binding to be somewhat compatible with the spec,
by placing the wake-up interrupt in a subnode called "wake-up". This
still is an optional property, but a recommended one for PCI devices.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../bindings/net/wireless/marvell-8xxx.txt    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
index 9bf9bbac16e2..f9340ca37047 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
@@ -33,10 +33,16 @@ Optional properties:
 		 this interrupt number. during system suspend, the irq will be enabled
 		 so that the wifi chip can wakeup host platform under certain condition.
 		 during system resume, the irq will be disabled to make sure
-		 unnecessary interrupt is not received.
+		 unnecessary interrupt is not received. For PCI devices, it
+		 is recommended that this property is placed in a "wake-up"
+		 sub-node in order to limit the ambiguity with PCI legacy
+		 interrupts.
   - vmmc-supply: a phandle of a regulator, supplying VCC to the card
   - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
 		 for documentation of MMC power sequence bindings.
+  - wake-up:	 a subnode containing the interrupt specifier for a wake-up
+		 interrupt. This is the recommended configuration for PCI
+		 devices.
 
 Example:
 
@@ -66,3 +72,18 @@ so that firmware can wakeup host using this device side pin.
 		marvell,wakeup-pin = <3>;
 	};
 };
+
+&pci_rootport {
+	mvl_wifi: wifi@0,0 {
+		compatible = "pci1b4b,2b42";
+		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
+		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_host_wake_l>;
+		wake-up {
+			interrupt-parent = <&gpio0>;
+			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+			wakeup-source;
+		};
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
