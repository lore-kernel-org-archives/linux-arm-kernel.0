Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8624C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA3F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xk/b4NL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA3F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yur1lKmJ8vixa6wEaTxJSvF4acgXGpcLPGwBfiOzTf4=; b=Xk/b4NL7ilr2g7
	S2p/axASWaxq7Yl0AFAt3VUc9IeS4h9GkXONHEkoBk6tVL+6iX7jakkBpC/PCZarTavVY8cVoNslV
	TOrd3fb1vV2RMQjgm9WCHN4kYJ3vV4hl567gVahQ/WN/VlEgpASLO78kw58hMsDHSGQ29NIFsjvgG
	SGPrlSvytZPQBymmIkEFrIU6cNTj9vZWiHjxwiqh8wUfqJw8sUXjr2g3TI+Nq8M3sA2reNZf5jrLE
	oqhQgnEdNaThOZ/3p9wBEI331oGvBIMVpWQQFfblkfC0ddQDJgL2S9KUQcG9jG5EE8hc81Oo5AqDG
	RK//hsxOVzip0t6bJUiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguBO-0000d6-3O; Tue, 08 Jan 2019 16:24:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguBK-0000aX-Fw
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:24:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 68648209EF; Tue,  8 Jan 2019 17:24:45 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 08E24209C2;
 Tue,  8 Jan 2019 17:24:45 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 01/15] PCI: aardvark: Enlarge PIO timeout
Date: Tue,  8 Jan 2019 17:24:26 +0100
Message-Id: <20190108162441.5278-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082446_838459_E637C403 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This delay has been proven to work until now, however, there is a
reproducible way to fail the driver probe because of it.

Adding the support for the PCIe gated peripheral clock that feeds the
Aardvark IP defers the Aardvark driver probe at boot time. The probe
functions calls pci_host_probe() at its end. This is where the timeout
(sometimes) resides, leading to a kernel panic the next time a
register is accessed. Here is the function call sequence:

    advk_pcie_probe()
    pci_host_probe()
    pci_scan_root_bus_bridge()
    pci_scan_child_bus_extend()
    pci_scan_bridge_extend()
    pci_scan_child_bus_extend()
    pci_scan_slot()
    pcie_aspm_init_link_state()
    pcie_aspm_cap_init()

pcie_aspm_cap_init() is in charge of doing the initial ASPM state
setup (PCIe Active-State Power Management). The logic at the top of
the function is:

    1/ Read upstream and downstream components' register state.
    2/ Configure the common clock before checking latencies.
    3/ Read again upstream and downstream component's register state.
    4/ ...

Experimentation shows that while 1/ always work, 3/ sometimes timeouts
when reading the downstream components' register state. Each read
operation is handled by the following sequence:

    pcie_capability_read_dword()
    pci_bus_read_config_dword()
    advk_pcie_rd_conf()

advk_pcie_rd_conf() just configures a few registers and polls on the
ISR bit before reading the value that has been retrieved through the
interconnect. The polling timeout of the ISR bit is set to 1ms. While
this value seems to fit most of the situations, in our case it is
sometimes crossed when reading PCI_EXP_LNKCAP (PCI link capacities)
from the downstream component. It has been measured that most of the
time that the read lasts longer than 1ms, it rises ~24ms. In my tests,
using twice this delay always works. The root cause and the reason why
the timeout only appearing when the probe is delayed is unknown
though.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..18120e312ae1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -175,7 +175,7 @@
 	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
 	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
 
-#define PIO_TIMEOUT_MS			1
+#define PIO_TIMEOUT_MS			50
 
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
