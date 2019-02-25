Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD1C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:48:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3138D2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+x6ryAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3138D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uvhrEGvpDmB4pencISmkUQJY5pgW0SCymnlwbs2fXyI=; b=n+x6ryAp6Pk3EW
	IbwNCu10Py2iw4Ak2P+VNwN8Whjq9aipFT/3L1YvTuaVQIHmeu64IoD8ljAd8JN0Ue43m2RirlyYP
	QGqedfU/ra3VLTo6jcuitIwkr03Cn7AiMwqLCeffn4wlHppqYZRuWaclPsVm8gDaUyOC912Q3Ppmw
	T+VHTLroWvpaAXbC2fDXmSThdzHFvQ/D+j2UwEIyCCUMYeEbcLhkQudkHQQbvzlSTo9PDxbIXoMs8
	uCWJ/YQ3ZKIjUn4HDrnUY2UEpXV38dFSTwBRD3lHCXpSiwcbZyE84TJUhqLH5mLTld/n2wSq+WL2d
	eGmibyCfqWjagoWMNDUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLIT-0005X4-2p; Mon, 25 Feb 2019 18:48:13 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLIP-0005Vv-Lk; Mon, 25 Feb 2019 18:48:11 +0000
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2FB42260877;
 Mon, 25 Feb 2019 18:48:07 +0000 (GMT)
Date: Mon, 25 Feb 2019 19:48:03 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurations
Message-ID: <20190225194803.58fb8efc@collabora.com>
In-Reply-To: <20190225173414.1836f0a8@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
 <20190222154431.66c6911f@kernel.org>
 <20190225170118.62739fc4@xps13>
 <20190225173414.1836f0a8@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_104809_975304_09965928 
X-CRM114-Status: GOOD (  39.53  )
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

On Mon, 25 Feb 2019 17:34:22 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 25 Feb 2019 17:01:18 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Boris,
> > 
> > Boris Brezillon <bbrezillon@kernel.org> wrote on Fri, 22 Feb 2019
> > 15:44:31 +0100:
> >   
> > > On Thu, 21 Feb 2019 13:58:04 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >     
> > > > Add the logic in the NAND core to find the right ECC engine depending
> > > > on the NAND chip requirements and the user desires. Right now, the
> > > > choice may be made between (more will come):
> > > > * software Hamming
> > > > * software BCH
> > > > * on-die (SPI-NAND devices only)
> > > > 
> > > > Once the ECC engine has been found, the ECC engine must be
> > > > configured.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/mtd/nand/core.c  | 107 +++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/mtd/nand.h |   4 ++
> > > >  2 files changed, 111 insertions(+)
> > > > 
> > > > diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> > > > index 872d46b5fc0f..9feb118c9f68 100644
> > > > --- a/drivers/mtd/nand/core.c
> > > > +++ b/drivers/mtd/nand/core.c
> > > > @@ -207,6 +207,113 @@ int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nanddev_mtd_max_bad_blocks);
> > > >  
> > > > +/**
> > > > + * nanddev_find_ecc_engine() - Find a suitable ECC engine
> > > > + * @nand: NAND device
> > > > + */
> > > > +static int nanddev_find_ecc_engine(struct nand_device *nand)      
> > > 
> > > Can we pass the conf in argument instead of reading it from
> > > nand->ecc.user_conf?
> > >     
> > > > +{
> > > > +	bool is_spinand = mtd_type_is_spinand(&nand->mtd);      
> > > 
> > > And here is the reason for the SPINAND type.
> > >     
> > > > +
> > > > +	/* Read the user desires in terms of ECC engine/configuration */
> > > > +	nand_ecc_read_user_conf(nand);
> > > > +
> > > > +	/* No ECC engine requestedn, let's return without error */
> > > > +	if (nand->ecc.user_conf.mode == NAND_ECC_NONE)
> > > > +		return 0;
> > > > +
> > > > +	/* Raw NAND default mode is hardware */
> > > > +	if (!is_spinand && nand->ecc.user_conf.mode < 0)
> > > > +		nand->ecc.user_conf.mode = NAND_ECC_HW;      
> > > 
> > > We should let the raw NAND layer take this decision (actually, it's
> > > even a raw NAND controller driver decision). Please complain if
> > > user_conf.mode is invalid.
> > > This way you won't need the SPINAND type you added in one of your
> > > previous patch.
> > >     
> > > > +
> > > > +	/* SPI-NAND default mode is on-die */
> > > > +	if (is_spinand && nand->ecc.user_conf.mode < 0)
> > > > +		nand->ecc.user_conf.mode = NAND_ECC_ON_DIE;
> > > > +
> > > > +	switch (nand->ecc.user_conf.mode) {
> > > > +	case NAND_ECC_SOFT:
> > > > +		nand->ecc.engine = nand_ecc_sw_get_engine(nand);
> > > > +		break;
> > > > +	case NAND_ECC_ON_DIE:
> > > > +		if (is_spinand)
> > > > +			nand->ecc.engine = spinand_ondie_ecc_get_engine();      
> > > 
> > > So, maybe it's worth having the ondie ECC engine instance directly
> > > embedded in nand_device instead of spinand, or maybe just a pointer, so
> > > that you don't reserve extra space when the NAND device does not have
> > > on-die ECC.
> > >     
> > > > +		else
> > > > +			pr_err("On-die ECC engines for non SPI devices not supported yet\n");
> > > > +		break;
> > > > +	case NAND_ECC_HW:
> > > > +		pr_err("Hardware ECC engines not supported yet\n");
> > > > +		break;
> > > > +	default:
> > > > +		pr_err("Missing ECC engine property\n");
> > > > +	}
> > > > +
> > > > +	if (!nand->ecc.engine)
> > > > +		return  -EINVAL;
> > > > +
> > > > +	return 0;
> > > > +}      
> > >     
> > 
> > I think this is the root patch were our ideas diverge. For me, each
> > 'ECC engine' has a _get() helper and the NAND core decides which one to
> > call to retrieve the right engine. Can you please explain what was your
> > idea if this one does not fit?  
> 
> Each class of ECC engine has its own way of getting a pointer to an ECC
> engine instance:
> 
> - ondie: the engine is directly attached to the device and can be
>   retrieved by accessing a nand_device field (nanddev->ondie_ecc?).
> - sw ECC: you can create a new instance for each device and possibly
>   pass the OOB layout you want to use (assuming you don't want to use
>   the default one)
> - HW-controller-side engine: refers to the controller device (parent
>   node) or the device pointed by the ecc-engine DT prop (we'll probably
>   need a way to pass this info when for non-DT platforms). For this one
>   we'll add a nanddev_get_hw_ecc_engine() which will search for all
>   registered HW ECC engines and try to match with some search keys (in
>   case of DT, it's the ->of_node pointer address)
> 
> Clearly, for SW-based ECC, you'll need more than just the nanddev
> object, as layouts can differ depending on the controller driver. So,
> what I'm suggesting is to have a
> 
> 	nand_create_sw_ecc_engine(algo, layout) 
> 
> funtion that returns this ECC engine instance which the driver will
> then attach to the NAND device.

I'm reconsidering what I said here. I guess having the layout set by
the driver before nand_ecc_sw_get_engine() is called could do the
trick. We just need to make sure the layout provided has enough space
to store ECC bytes at context creation time.

> 
> > 
> > Also, the parsing of the DT (in nand_ecc_read_user_conf()) gives me the
> > user ECC mode and algo, so I cannot let the raw NAND core (or a raw
> > NAND controller driver) or the SPI NAND core decide which mode is the
> > default if not provided by the user.  
> 
> Except this prop is optional in most cases, and the default value is
> not always the same, which is why I think this ECC engine retrieval step
> should be left to each sub-layer (and sometimes to the controller driver
> behind it). Maybe you can provide helpers to help with that, but I
> don't think taking this decision here, based on the bus type, is a good
> idea. And I also don't like the idea of adding a new SPINAND type.

Hm, after thinking a bit more about it, maybe we could have something
in-between: let the controller driver or sub-layer specify what the
default values are (provider/mode and possibly algorithm if that makes
sense) so that this generic function can use these defaults when
nand->ecc.user_conf.{mode,algo} == UNKNOWN.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
