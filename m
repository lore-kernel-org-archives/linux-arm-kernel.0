Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BA0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:37:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E0720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFFU2IsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E0720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D3S4vlsp8esuNHRVKur2VFObdMGffwMhAy/M/sOfXI4=; b=rFFU2IsXW+givf
	ju/mUuUNKbPIv9aQCcQr6EHG5KBMOMne3FLAm64wLrZrkZcJbXiFpFecuztNRzskock4XZ625l2lH
	Qvtko79DdI8EvF//bD2vHecW/ZMLwjcxOKAQz345vY46xVtKPKUfW8pBF+sTOxfUkCItVCuS5leX9
	nrqNooQgookPLBNGc/9cu8cbDn/5M8OGcPhqDNNtC/X1IVVAzY3qcy12ZXLYB7ZW3EfNVUL640ook
	t1IPQ+iVd0H28VMzwoxPRMKilgM8eO8LL50rf+I6e2teXMyO7uwD0mLZC4TGfLOEmW/eyoxRR5w32
	a2Dax5qR45OVKM/n7oHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYnTN-0005ie-Vv; Mon, 17 Dec 2018 07:37:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYnTJ-0005h9-NU
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 07:37:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 595272072F; Mon, 17 Dec 2018 08:37:35 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 09A532039F;
 Mon, 17 Dec 2018 08:37:35 +0100 (CET)
Date: Mon, 17 Dec 2018 08:37:35 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Message-ID: <20181217083735.4c6599b3@windsurf>
In-Reply-To: <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181216.124120.731491122771817496.davem@davemloft.net>
 <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_233749_903919_091928E2 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev <netdev@vger.kernel.org>,
 =?UTF-8?B?R3LDqWdvcnk=?= Clement <gregory.clement@bootlin.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 Grzegorz Jaszczyk <jaz@semihalf.com>, Stefan Chulski <stefanc@marvell.com>,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Marcin,

On Mon, 17 Dec 2018 00:25:58 +0100, Marcin Wojtas wrote:

> Thanks. Indeed, the patch is valid as a fix for current version of SW
> BM. However, because this concept is broken, I will rework it and
> submit patch/patches some time early 2019.

I know some people are working on XDP support in mvneta, and this work
also needs to change parts of the memory allocation strategy in this
driver. I'd suggest to get in touch with those folks. Antoine can give
you the contact details, I don't have them off-hand. Or perhaps they
will see this e-mail :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
