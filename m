Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9224C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F22920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ioUZSV3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F22920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0pgUj+SoBO11aGY4x/NeFmlSwqZdEZQXpy15v4HpYGw=; b=ioUZSV3JNCHdZV
	cbtZ3ZRj0fumebv9N8lfFlb0RzvakXawCLxRqDutJKr83G4WevFqDn5jC35G/V20vbROo0zYsLKoT
	29GXcpYao1OZOpz3lIEMrX+mNDDbsotgn7C+YmHVnoYZHhv9v/ddp+gQ0FcXidvURh+Zdipe3Ebas
	h1KIsDE7Pl/uX/XnhjGl65XMvbx6B0dnlKNnHY0vjnY9Kw8DVxuLOhShrMiIjXX9XjggS6OFfCaAD
	O8fJTGnkc6HqtjmddjNEWhjyKmsMeUFh9WaNw8JqEyHdasWLG+YVWa6qkYCX2bZvuBq75xhwQ4eBC
	In9pVpTaxkmxX7G6gqhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSP9F-0005hO-PO; Thu, 29 Nov 2018 16:26:41 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSP9D-0005gw-AS
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:26:40 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D39E968B03; Thu, 29 Nov 2018 17:26:27 +0100 (CET)
Date: Thu, 29 Nov 2018 17:26:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
Message-ID: <20181129162627.GB27068@lst.de>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
 <7b054176-aaef-cbdd-b2df-82eda94180e8@arm.com>
 <20181129102259.GR30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129102259.GR30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_082639_506324_81ADA2EF 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Nathan Jones <nathanj439@gmail.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 10:22:59AM +0000, Russell King - ARM Linux wrote:
> I don't think so - if we were to remove the call to
> dma_mmap_from_dev_coherent(), it reintroduces the bug.
> 
> Quite why we have dma_mmap_from_dev_coherent() returning a 0/1 and
> error code via pointer I'm really not sure.
> 
> 	ret = dma_mmap_from_dev_coherent(...);
> 	if (ret)
> 		return ret > 0 ? 0 : ret;
> 
> and have dma_mmap_from_dev_coherent() return -ve for errnos, 1 if
> mapped via the coherent pool mechanism, or 0 otherwise.
> 
> The down-side is that 'ret' would be zero for the follow-on code,
> which would need explicit initialisation - but at least it's then
> obvious what is going on.

The above would be better than the current calling conventions, which
are horrible.  But the magic positive error code also tends to lead
to subtle errors sometimes.  My preference for this pattern is something
like:

	bool mapped;

	ret = dma_mmap_from_dev_coherent(..., &mapped);
	if (ret || mapped)
		return ret;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
