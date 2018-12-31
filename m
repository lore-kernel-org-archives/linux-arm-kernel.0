Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A668C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A89421019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g5HmHsYo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="VrdEK9Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dd/4cT8yTiKGjLpJChunDIybIbBFwMt1ItAu2IyTwGM=; b=g5HmHsYoSxgrLj
	O5i2QS6iDbasvj1SbYUQ4H7Ttjx93a5mKfxBxh41j0+/xMRWvo86nFR8+m6xCViUeFUZr82/Fb5nE
	PMTpfm2UJgvp/3gET8LMLzIHPIBaCT4v7ycR4IP12jFvUi2qbqV6vUdJUDK7foGEV9pYe9QAEWEBs
	bW1DzsMaUf+8zSooox5plrdSBytBgRNMolDxoGManoRsvxksLnq/Wq+Djl/R0QUkTBIYSQ/i09f3U
	qsSQPQ55+siXETALgKmlWBW0qTdRZrl9s2QfvkQ/BXBYlSU9XHXgeWC8P16UbnFLWXyq12DYYd77R
	XGwWRPVAH4wxZZW+93SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gduap-0007DS-Sg; Mon, 31 Dec 2018 10:14:43 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gduam-0007Cw-U1
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 10:14:42 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id B393C441E7B;
 Mon, 31 Dec 2018 11:14:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl B393C441E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1546251269; bh=oaSulQfLn7M4vvjRGvwagR4ybyDPMiU/KyQKj4HcQKo=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=VrdEK9ZnuOALJGGa52nPww9jPoxujWFz76m9Ezp9lTyTx4A1Tc35mecROioCYAKWK
 yybSHrY21v1rJ34EJE1rGKC1gPUamEj1vdyq90PvowObLkmlQBGU0HBsNmScK0TIJf
 6K2gnsJfI9v9vCK/AW4GBYo4mIpqjqIxO7IdHd/w=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com>
Date: Mon, 31 Dec 2018 11:14:28 +0100
In-Reply-To: <20181230010625.GC159477@google.com> (Bjorn Helgaas's message of
 "Sat, 29 Dec 2018 19:06:26 -0600")
Message-ID: <m336qegfzv.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 133560 [Dec 31 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 232 232
 27ac0ce265d8cfe64c397d431e1d2387c92c9415, {Tracking_DKIM, one},
 {Tracking_marketers, sender}, {Tracking_ sender_matches_from},
 {Tracking_subj_double_letters}, {Tracking_weird_subj_double_letters},
 {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/29 09:49:57
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2018/12/31 06:10:00 #9277396
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_021441_295776_9EFFB2D8 
X-CRM114-Status: GOOD (  13.98  )
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
 Robin Leblon <robin.leblon@ncentric.com>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:

> 802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
> __raw_writel() so it only did 32-bit accesses, with
> pci_generic_config_write(), which uses writeb/writew/writel()
> depending on the size.
>
> 802b7c06adc7 also converted cns3xxx_pci_read_config() from always
> using __raw_readl() (a 32-bit access) to using
> pci_generic_config_read32(), which also always does a 32-bit access.
>
> This makes me think the cnx3xxx hardware is only capable of 32-bit
> accesses, and this patch should change the driver to use
> pci_generic_config_write32() instead of pci_generic_config_write() in
> addition to the mapping fix above.

Hasn't it already been verified that the CNS3xxx can do 8-bit accesses
(and probably 16-bit ones as well), and that the docs don't mention any
such limitation?

> I don't think hardware that only supports 32-bit PCI writes can be
> quite spec-compliant (see the comments in
> pci_generic_config_write32()).  So (1) you may see an additional
> dmesg warning when you convert to use it, and (2) it's possible that
> there may still be instability related to the corruption caused by
> using a 32-bit write when an 8-bit write was intended.

Right. I think IDE/SATA controllers are affected, for example.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
