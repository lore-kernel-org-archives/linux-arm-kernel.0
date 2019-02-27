Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C7EC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0FA21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bqcm1k7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0FA21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6iiFOq0M3gi+bisOXMZWw3uts5508H7gW5cJWskAyWA=; b=bqcm1k7lvAs2Pp
	/LAev2qUWedNLVpuDVg2sJshRM3pH2YiuzFGB2UkfycO6eNKS7UoOvcqznlBSliB0BlvZdBJt43gQ
	5EfWiifhsXFFR7ygRpFyNPaL3CizlKNcp4MWODiOeKWhxkbtpe92BGe8ac8yY4IDO17rVfkgEZYJd
	OL3u8fn1aDmgZl7O7k7g16VH94iW5QoHg7RaSCV075awzDdACYbZtTZTAwSn5KYOeC+GFJ0dYRqgc
	FYeKXQXCgHodLMDOYcylwM4oMaZwvFsBYVFgRAhlthHiodhaLAGwaWs77GepJJAw3vfdzukJMTmZ6
	pW7DXJ7VC6Et38x3gNeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0IU-0000eM-2s; Wed, 27 Feb 2019 14:34:58 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0Hm-0008Co-UN; Wed, 27 Feb 2019 14:34:17 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2AD614000D;
 Wed, 27 Feb 2019 14:34:09 +0000 (UTC)
Date: Wed, 27 Feb 2019 15:34:09 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190227153409.0e138bc8@xps13>
In-Reply-To: <20190227152823.73249976@collabora.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
 <20190225195543.27799e77@kernel.org>
 <20190227145607.24e49014@xps13>
 <20190227150633.7d8f5c5c@collabora.com>
 <20190227151957.4de6ff32@xps13>
 <20190227152823.73249976@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063415_140209_32C8E6B1 
X-CRM114-Status: GOOD (  20.38  )
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


> > > > Furthermore if this is just a hook to do reference counting.      
> > > 
> > > Well, what this put() does depends on the class of engine. For SW and
> > > on-die ECC it can be a NOOP (that's true only if you keep the approach
> > > where you have a single instance shared by everyone for SW-based ECC
> > > engines).
> > > For HW-controller-side ECC engines, you'll have to call device_get() on
> > > the parent device in your nand_get_hw_ecc_engine() function while you
> > > hold the lock protecting the ECC engine list. And device_put() will be
> > > called in nand_put_hw_ecc_engine().    
> > 
> > 
> > I see.
> > 
> > Then I prefer keeping the logic in the core, not in the engine driver
> > and propose a
> > 
> >         void nand_ecc_put_engine(struct nand_ecc_engine *engine)
> > 
> > which will do nothing for on-die/sw engines and drop the reference for
> > hw engines. I will also rename the "find_ecc_engine" to "get_engine" so
> > that the call to the "put" helper has more meaning.  
> 
> Ack for most of it. One thing I'd like to clarify: it's probably better
> to have a separate function called nand_ecc_put_hw_engine() which you'll
> call from nand_ecc_put_engine() when you're dealing with an
> HW ECC engine rather than calling put_device() directly from
> nand_ecc_put_engine(). This way you keep the code for HW ECC engine
> well isolated.
> 
> Same goes for the nand_ecc_get_engine() path, just delegate to
> nand_ecc_get_hw_engine() when ->provider == HW_ECC.

Ack.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
