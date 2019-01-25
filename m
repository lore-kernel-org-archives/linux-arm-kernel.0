Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05579C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:55:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C952E218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5BJ/7U1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="Hnb7QpLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C952E218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGCAxzCu6g9FILF2vz9klUozjHk19r9SX+RmxyToNvU=; b=b5BJ/7U189kUKN
	r/4Gf3CwWzrC1toR0faRBLdPIbN3j7tc8G35reKMp/l7k3njxHifYjOiGNDxgDRxV4pBd+rVgLOI9
	l7+PRD7wfGoI/QueddIXATx1QSQZDsQ6yLMpxY7iEsEtBkfwmCNAR33vQgla8F0PdEoYgaTHZi71B
	cwsGTCCrgiEmzeG/RLU4AI0For3JqFR2AUgWFAbS+MwVFuC9g4sYJ8QPq6R3mOXQq/XFdz58wOUYX
	g/D10kn3O174JlrmAO0mugUV8+BjLzQyDHADEDeiHFgkordl/SVKGa1Klbw5I9F4jtOaQljUwiQQR
	hDLWZaaID32IShED2/1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz91-0006Zj-Mj; Fri, 25 Jan 2019 10:55:31 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz8s-0006KW-B1
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:55:28 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id D47C2441EB6;
 Fri, 25 Jan 2019 11:55:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D47C2441EB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1548413714; bh=LNFHF1IWURpNCE4p7qITgCo3PLlEV+uVnnvEcGwFr3E=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=Hnb7QpLkMg8fxLFnSKGSBGuoOREpmzSxlMi7s3yr8Gfj0GDLY1QHCSfj4dXrbYVuZ
 ieNs7NG3S16VPoMj7H9dRkSj1ffQ9V8rO9pWwfeqKWZ2+IgCK18LTuSmhQDUoTJ3cs
 5nGaMZc9OqgXR313tMV4C+Yhha5IqgfTRWVrw3Nk=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: [PATCH v2 2/2] arm: cns3xxx: use actual size reads for PCIe
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190107134510.32494-2-koen.vandeputte@ncentric.com>
Date: Fri, 25 Jan 2019 11:55:12 +0100
In-Reply-To: <20190107134510.32494-2-koen.vandeputte@ncentric.com> (Koen
 Vandeputte's message of "Mon, 7 Jan 2019 14:45:10 +0100")
Message-ID: <m3d0oldn1r.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 134602 [Jan 25 2019]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 233 233
 0b4366ad0ca9e4c51768729fd07517e895618de5, {Tracking_DKIM, one},
 {Tracking_marketers, sender}, {Tracking_ sender_matches_from},
 {Tracking_subj_double_letters}, {Tracking_weird_subj_double_letters},
 {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2019/01/24 14:01:15
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/01/25 01:31:00 #9423158
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_025523_376498_F82A29ED 
X-CRM114-Status: GOOD (  12.04  )
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
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Koen Vandeputte <koen.vandeputte@ncentric.com> writes:

> commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> reimplemented cns3xxx_pci_read_config() using pci_generic_config_read32(),
> which preserved the property of only doing 32-bit reads.
>
> It also replaced cns3xxx_pci_write_config() with pci_generic_config_write(),
> so it changed writes from always being 32 bits to being the actual size,
> which works just fine.
>
> Due to:
> - The documentation does not mention that only 32 bit access is allowed.
> - Writes are already executed using the actual size
> - Extensive testing shows that 8b, 16b and 32b reads work as intended
>
> It makes perfectly sense to also swap 32 bit reading in favor of actual size.
>
> Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -93,7 +93,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>  	u32 mask = (0x1ull << (size * 8)) - 1;
>  	int shift = (where % 4) * 8;
>  
> -	ret = pci_generic_config_read32(bus, devfn, where, size, val);
> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
>  
>  	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
>  	    (where & 0xffc) == PCI_CLASS_REVISION)

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
