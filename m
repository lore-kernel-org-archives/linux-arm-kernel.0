Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF174C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:10:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CB206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a1BZv3rZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Tli5CzlTjKrUAF8zjH82i7p1Qg1F3pmYrk4cNK70ALs=; b=a1BZv3rZ/RBPR/
	1OKopAnxT1bIaEhXqcYVgCtp682bt0CnL2mXn6QBfc8zB+BbuNj1JpwcOsKXd7suZIAKVoBdnQOdk
	EtAXKxUpZ+HcnPgfmw5YXRz8ADjtHdiHzOuqCpQOIwD7k2Atr3soVkJeTNto8AUNZWpK1eJmAxm+j
	1g8s5nDpLLDCy8YjN2jHxhsGZKPz8TGMQzxEPWzW/KqgeQvN/LFFU0f2zlqMb8fIFkeagL13dCuiL
	rwF9ci2ku8rJ0pWiK+Pgs5CSXxCQb+fcdLqUv7EFDhKxlkwUmSrcrT/efRCqggDXPPv/n6+pgXuCb
	bNDAtf975Eki7MBk6/Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxuPa-0007xl-9B; Sun, 24 Feb 2019 14:05:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxuP8-0007Ye-CR; Sun, 24 Feb 2019 14:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7859A78;
 Sun, 24 Feb 2019 06:05:08 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B762A3F690;
 Sun, 24 Feb 2019 06:05:05 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Kalle Valo <kvalo@codeaurora.org>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Sun, 24 Feb 2019 14:04:22 +0000
Message-Id: <20190224140426.3267-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_060518_427791_4C1ABA6F 
X-CRM114-Status: GOOD (  13.63  )
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

For quite some time, I wondered why the PCI mwifiex device built in my
Chromebook was unable to use the good old legacy interrupts. But as MSIs
were working fine, I never really bothered investigating. I finally had a
look, and the result isn't very pretty.

On this machine (rk3399-based kevin), the wake-up interrupt is described as
such:

&pci_rootport {
	mvl_wifi: wifi@0,0 {
		compatible = "pci1b4b,2b42";
		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
		interrupt-parent = <&gpio0>;
		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&wlan_host_wake_l>;
		wakeup-source;
	};
};

Note how the interrupt is part of the properties directly attached to the
PCI node. And yet, this interrupt has nothing to do with a PCI legacy
interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
altogether (Yay for the broken design!). This is in total violation of the
IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
specifiers describe the PCI device interrupts, and must obey the
INT-{A,B,C,D} mapping. Oops!

The net effect of the above is that Linux tries to do something vaguely
sensible, and uses the same interrupt for both the wake-up widget and the
PCI device. This doesn't work for two reasons: (1) the wake-up widget grabs
the interrupt in exclusive mode, and (2) the PCI interrupt is still routed
to the RC, leading to a screaming interrupt. This simply cannot work.

To sort out this mess, we need to lift the confusion between the two
interrupts. This is done by extending the DT binding to allow the wake-up
interrupt to be described in a 'wake-up' subnode, sidestepping the issue
completely. On my Chromebook, it now looks like this:

&pci_rootport {
	mvl_wifi: wifi@0,0 {
		compatible = "pci1b4b,2b42";
		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
		pinctrl-names = "default";
		pinctrl-0 = <&wlan_host_wake_l>;
		wake-up {
			interrupt-parent = <&gpio0>;
			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
			wakeup-source;
		};
	};
};

The driver is then updated to look for this subnode first, and fallback to
the original, broken behaviour (spitting out a warning in the offending
configuration).

For good measure, there are two additional patches:

- The wake-up interrupt requesting is horribly racy, and could lead to
  unpredictable behaviours. Let's fix that properly.

- A final patch implementing the above transformation for the whole
  RK3399-based Chromebook range, which all use the same broken
  configuration.

With all that, I finally have PCI legacy interrupts working with the mwifiex
driver on my Chromebook.

[1] http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

Marc Zyngier (4):
  dt-bindings/marvell-8xxx: Allow wake-up interrupt to be placed in a
    separate node
  mwifiex: Fetch wake-up interrupt from 'wake-up' subnode when it exists
  mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN rather than disabling
    it too late
  arm64: dts: rockchip: gru: Move wifi wake-up interrupt into its own
    subnode

 .../bindings/net/wireless/marvell-8xxx.txt    | 23 ++++++++++++++++++-
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  8 ++++---
 drivers/net/wireless/marvell/mwifiex/main.c   | 13 +++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
