Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4493C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:06:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A472E20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ua/ky3Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A472E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8IfDt4PYhzGdGKXesKvROa4C0UA06WzgrfECHOAZ9A4=; b=Ua/ky3McSS9vHJ
	aUULmhMt7CO0+2icjwitHbcywbtjB3OEo8NtdX5HrkBkardONyUZTdU5DMr3Z37tus1p+1btg7NTw
	Q/i4MYp4s8QtKluScxm8X39BzLuqr86IsXlyH+KJnVxInBIhiXnfl0jja3BBkJRLf9wCwJc/jJiD9
	og+R0Z2RZpsIEgvSSd6n+zZYZEGJo7xgy/zdUfM7zrzGyknjpJ6eJPhEY7yamvZ27b/hRpaSdKiht
	QgVxp/kAk5nwrV6v5m/lPY8gSedmolTbms8kRc750vTqa9c1D7cGyZf1hJshkw9QU0SDbTY7iT9Ul
	7a1PmFXYLiFmI8pUulfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzr9-0004vc-1A; Wed, 27 Feb 2019 14:06:43 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzr5-0004v3-L5; Wed, 27 Feb 2019 14:06:41 +0000
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ECD8127FE76;
 Wed, 27 Feb 2019 14:06:36 +0000 (GMT)
Date: Wed, 27 Feb 2019 15:06:33 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190227150633.7d8f5c5c@collabora.com>
In-Reply-To: <20190227145607.24e49014@xps13>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
 <20190225195543.27799e77@kernel.org>
 <20190227145607.24e49014@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_060639_823222_1CEBF340 
X-CRM114-Status: GOOD (  20.89  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>, Boris Brezillon <bbrezillon@kernel.org>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 27 Feb 2019 14:56:07 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <bbrezillon@kernel.org> wrote on Mon, 25 Feb 2019
> 19:55:43 +0100:
> 
> > On Thu, 21 Feb 2019 11:01:52 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > +
> > > +/**
> > > + * struct nand_ecc_engine_ops - Generic ECC engine operations
> > > + *
> > > + * @init_ctx: given a desired user configuration for the pointed NAND device,
> > > + *            requests the ECC engine driver to setup a configuration with
> > > + *            values it supports.
> > > + * @cleanup_ctx: clean the context initialized by @init_ctx.
> > > + * @prepare_io_req: is called before reading/writing a page to prepare the I/O
> > > + *                  request to be performed with ECC correction.
> > > + * @finish_io_req: is called after reading/writing a page to terminate the I/O
> > > + *                 request and ensure proper ECC correction.
> > > + */
> > > +struct nand_ecc_engine_ops {    
> > 
> > We might want to add a
> > 
> > 	void (*put_engine)(struct nand_ecc_engine *engine);
> > 
> > here if we want the nanddev cleanup path to be generic.
> > This hook would be implemented by drivers where the ECC engine object is
> > refcounted (typically the case for HW ECC engines shared by the raw NAND
> > controller and the SPI controller).
> > 
> > Alternatively, you can just add one nand_put_xxx_ecc_engine() func per
> > engine class (SW, ondie and HW).  
> 
> Can't this be handled in the init/cleanup_ctx() path directly?

You really have to get the reference before init_ctx() otherwise the
engine might disappear between your get() and init() call, and, to keep
things symmetric, I think it's best to handle the put() outside the
cleanup_ctx() path.

> 
> Furthermore if this is just a hook to do reference counting.

Well, what this put() does depends on the class of engine. For SW and
on-die ECC it can be a NOOP (that's true only if you keep the approach
where you have a single instance shared by everyone for SW-based ECC
engines).
For HW-controller-side ECC engines, you'll have to call device_get() on
the parent device in your nand_get_hw_ecc_engine() function while you
hold the lock protecting the ECC engine list. And device_put() will be
called in nand_put_hw_ecc_engine().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
