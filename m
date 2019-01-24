Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56F6218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtjO4eER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56F6218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSuIrBPNc8nFi/9TNby/MkkfmWVjCGLg10la7h3gRu8=; b=XtjO4eERH0AdXx
	y0sm88C6R8NsBfBQUYYUueKap8i7abKvV1Klc8pEu8sLwK8UQTXOnjAGIh+G1natEHF62SxPSeOO4
	cGKBAs7DkHCMg2s7dTFeEKBuX+daht0+ASpXWc0Rufh3qjBIifT+Hyc5wp1ZzIcFxsObkgp3GUqIn
	4QaphZAJSYptlyLkN2bJPvrxaQJa8WqZNY8EtKG3pa+/lbyonM6FXSCqKFfrnKv0i7Gk2d4YkL0SI
	64A4RwoQSTM8Obo3i5EOVJcrtwaBI1ypJA7TWZDTszwbskT857UH01CDaQ0rmnHOIieLF5GgHA+ya
	oUAjamou7Y9h7IaX03nA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmht1-0003R4-41; Thu, 24 Jan 2019 16:29:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhsx-0003KR-5h
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:29:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2894BEBD;
 Thu, 24 Jan 2019 08:29:45 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7AC3F237;
 Thu, 24 Jan 2019 08:29:43 -0800 (PST)
Date: Thu, 24 Jan 2019 16:27:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
Message-ID: <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
 <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_082947_222971_BC3D5E43 
X-CRM114-Status: GOOD (  23.02  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> 
> On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
> >>Originally, cns3xxx used it's own functions for mapping, reading and writing registers.
> >>
> >>Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> >>removed the internal PCI config write function in favor of the generic one:
> >>
> >>cns3xxx_pci_write_config() --> pci_generic_config_write()
> >>
> >>cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
> >>while the generic one pci_generic_config_write() actually expects the real address
> >>as both the function and hardware are capable of byte-aligned writes.
> >>
> >>This currently leads to pci_generic_config_write() writing
> >>to the wrong registers on some ocasions.
> >>
> >>First issue seen due to this:
> >>
> >>- driver ath9k gets loaded
> >>- The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
> >>- cns3xxx_pci_map_bus() aligns the address to 0x0C
> >>- pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)
> >>
> >>This seems to cause some slight instability when certain PCI devices are used.
> >>
> >>Another issue example caused by this this is the PCI bus numbering,
> >>where the primary bus is higher than the secondary, which is impossible.
> >>
> >>Before:
> >>
> >>00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
> >>     Flags: bus master, fast devsel, latency 0, IRQ 255
> >>     Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0
> >>
> >>After fix:
> >>
> >>00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
> >>     Flags: bus master, fast devsel, latency 0, IRQ 255
> >>     Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
> >>
> >>And very likely some more ..
> >>
> >>Fix all by omitting the alignment being done in the mapping function.
> >>
> >>Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> >>Acked-by: Krzysztof Halasa <khalasa@piap.pl>
> >>Acked-by: Tim Harvey <tharvey@gateworks.com>
> >>Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> >>CC: Arnd Bergmann <arnd@arndb.de>
> >>CC: Bjorn Helgaas <bhelgaas@google.com>
> >>CC: Olof Johansson <olof@lixom.net>
> >>CC: Robin Leblon <robin.leblon@ncentric.com>
> >>CC: Rob Herring <robh@kernel.org>
> >>CC: Russell King <linux@armlinux.org.uk>
> >>CC: stable@vger.kernel.org # v4.0+
> >>---
> >>  arch/arm/mach-cns3xxx/pcie.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >I have applied both patches to pci/arm-cns3xxx for v5.1, however I had
> >to reformat and rewrite both logs (commit line wrappings,
> >capitalization, etc.) so have a look.
> >
> >Thanks,
> >Lorenzo
> 
> Hi Lorenzo,
> 
> Thank you for taking care of the wrappings etc.?? it seems my auto-wrap was
> disabled in my git tooling ..
> Your adaptions look more than fine.
> 
> 
> Purely for my information:
> 
> Testing on a lot of devices here shows a huge improvement towards stability.
> Is it possible to get it merged sooner?
> Does "queued for 5.1" also mean that backporting to stables only will happen
> at 5.1_rc1 release?

Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
(so effectively you will get them in v5.0 and propagated to stable
earlier), I do not think it is that urgent either though, let me handle
that.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
