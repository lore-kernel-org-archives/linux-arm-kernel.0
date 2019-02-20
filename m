Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AEB2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UEBkrg7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AEB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=z7KFuMYCILZwHcUPm5nzmrO3aWfzRG769tnZabB5YRs=; b=UEBkrg7ocIUqqX
	ucaV5nxihxlNJQ/RorowNAX4jKNn+DdsHdahoyl9yRH1ty17vvCo0xJsrCGsUJ7URdjxtFerV+gAF
	jtEQDoYNkQ6TV9ElKhDsT6rZ++1yRlYXbLOYgjn2Z9PuH0Un7IVndRWv04l6qdxyAcCE6t/zDQyfD
	KxRqrQXWZy0emoIOhKMZ+GPuHUFkItrQihGtDrd18aJcEl/Itg9Gfzf27ywmrF1b/8NTfn1MplA8Q
	0IMlKxt4BwVF+MFXxApKvMshvvWYMvAeWbjmNuPkZE4uN4ReGlw3mzkh2R7pAOnwp7clY1sD1UdvP
	QuHvT+pUyL10zAGa8haA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwOUs-0005Sw-9D; Wed, 20 Feb 2019 09:48:58 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOUp-0005SA-DH
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:48:57 +0000
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 534AB200015;
 Wed, 20 Feb 2019 09:48:46 +0000 (UTC)
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge emul
 code
Date: Wed, 20 Feb 2019 10:48:39 +0100
Message-Id: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_014855_594252_AEE1E040 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Leigh Brown <leigh@solinno.co.uk>,
 =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This set of two patches aim at fixing some regression reported by two
users (Luis and Leigh), that were introduced by the conversion of the
pci-mvebu driver to the common PCI bridge emulation code shared
between pci-aardvark and pci-mvebu.

Due to this conversion, some registers of the PCI configuration that
used to be read-only are now read-write, making the Linux PCI core
believe that some features are implemented by the PCI bridge. Namely
in the case of pci-mvebu, the prefetchable memory base/limit registers
were read-only, while they are now read-write. Due to this, the Linux
PCI core now believes it can configure a prefetchable memory area, but
this is not supported by pci-mvebu, which does not have the logic to
create the appropriate MBUs windows.

This set of two commits allow PCI controller code to tell the PCI
bridge emulation logic about their capabilities. Because we envision
that other capabilities than prefetchable memory support might need to
be communicated from the PCI controller code to the PCI bridge
emulation code in the future, we introduce a "flags" argument, even if
for now only one flag is supported.

Lorenzo, let me know what you think about this approach. I am open to
suggestions if the proposed approach is not satisfying.

Both patches have been confirmed by Luis and Leigh to fix the
regression, but I'll let them give a formal Tested-by.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (2):
  PCI: pci-bridge-emul: Create per-bridge copy of register behavior
  PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags

 drivers/pci/controller/pci-aardvark.c |  2 +-
 drivers/pci/controller/pci-mvebu.c    |  2 +-
 drivers/pci/pci-bridge-emul.c         | 86 ++++++++++++++++++---------
 drivers/pci/pci-bridge-emul.h         | 13 +++-
 4 files changed, 73 insertions(+), 30 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
