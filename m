Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA1F20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlSmv6zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA1F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LLAvmNuNNe+eHwup2/9SDxkBW6TtJ475i+RRs5N/8ak=; b=ZlSmv6zEXz5TgG
	a3BCYi00Ljz09cq3cf888eYHMMzhB0W+elyF0B+axLlU8la7DDAO1MwYHbC0BkdZqfgU0N5ysz4wi
	u9Qfat+/ZMJYy7aAiKPtRknuueuer/OOhNlXBiHBHZZLY4rfrWsCBYODEzE1KHUeJ8qsJDJw0RKnq
	oRiZaelS7fQf0B629gl/QTF/A3u8MoERHb8CRggS39Oj9hIwR2/CnrNHG3IAqWS9xQuVJ6ZJl/+vX
	XFxgjYDoHLlxwssA+EYwWno+LIEUX108APMnrCv3XdI+Xh8zazGDjFFtImrjmD3XwjcsxUEZDBTAT
	ekxA6ViId5uEfS4F983Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfDO-0001bC-7B; Tue, 26 Feb 2019 16:04:18 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfDJ-0001aj-71; Tue, 26 Feb 2019 16:04:16 +0000
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5F2C326053B;
 Tue, 26 Feb 2019 16:04:07 +0000 (GMT)
Date: Tue, 26 Feb 2019 17:04:04 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurationsND
Message-ID: <20190226170404.36707f87@collabora.com>
In-Reply-To: <20190226165923.535f63f7@xps13>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
 <20190222154431.66c6911f@kernel.org>
 <20190225170118.62739fc4@xps13>
 <20190225173414.1836f0a8@kernel.org>
 <20190225194803.58fb8efc@collabora.com>
 <20190226165923.535f63f7@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_080413_381728_547006AC 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: Brian Norris <computersforpeace@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 16:59:23 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 25 Feb
> 2019 19:48:03 +0100:
> 
> > > > Also, the parsing of the DT (in nand_ecc_read_user_conf()) gives me the
> > > > user ECC mode and algo, so I cannot let the raw NAND core (or a raw
> > > > NAND controller driver) or the SPI NAND core decide which mode is the
> > > > default if not provided by the user.      
> > > 
> > > Except this prop is optional in most cases, and the default value is
> > > not always the same, which is why I think this ECC engine retrieval step
> > > should be left to each sub-layer (and sometimes to the controller driver
> > > behind it). Maybe you can provide helpers to help with that, but I
> > > don't think taking this decision here, based on the bus type, is a good
> > > idea. And I also don't like the idea of adding a new SPINAND type.    
> > 
> > Hm, after thinking a bit more about it, maybe we could have something
> > in-between: let the controller driver or sub-layer specify what the
> > default values are (provider/mode and possibly algorithm if that makes
> > sense) so that this generic function can use these defaults when
> > nand->ecc.user_conf.{mode,algo} == UNKNOWN.  
> 
> Having a "default_provider" in struct nand_ecc could to the trick. It
> would be filled by the controller drivers/sublayers before
> nanddev_ecc_engine_init() is called.

You'll also need a default_algo, at least for SW ECC. Note that other
props, like strength, step-size or flags (like the maximize flag) can
be left undefined as well, so providing default vals for those ones (or
deriving them from ECC requirements) might make sense too.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
