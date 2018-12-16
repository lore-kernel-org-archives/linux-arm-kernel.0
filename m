Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F75C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5329A217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGi1vmg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5329A217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMwR2oBOClKwecDjWix9Dsk1pNQivqk4w8623/Dhi8s=; b=dGi1vmg2e86P0I
	n18sn+ccPKkfTmUfXw0iWrKLp2l+sMx9/SAduXP5iT9kf8XtYoB/pO9iXbw49OqEgO24HBE0HY9y4
	zNBjYPvQmsQ2wPyFnzFOrqHkJdU8rj/j8IRt+5epH8D+5LfCycwKPnRc7aKGPo86IExl/kkr0s8+e
	NYi8iGqCJ/c7wGOeL1ypa1eo+gL8Jy3ciUI6KmbQs6veOoUSHAhu7cup4QvsBNs4r7OFsJe9bjc9T
	3nG+o250yroVaE5RQwXD9+cFqS9Nh0nIDNiEJxi7zws8md3zy+10Wh5iB5j61XuBX0rKBzBLgeY/r
	aFD/HalQ+K3MNcrWT7Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYdEJ-0007sG-Ag; Sun, 16 Dec 2018 20:41:39 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYdEG-0007rU-Q5
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 20:41:38 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 2CF7A14EF614A;
 Sun, 16 Dec 2018 12:41:21 -0800 (PST)
Date: Sun, 16 Dec 2018 12:41:20 -0800 (PST)
Message-Id: <20181216.124120.731491122771817496.davem@davemloft.net>
To: mw@semihalf.com
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
From: David Miller <davem@davemloft.net>
In-Reply-To: <1544533009-12425-1-git-send-email-mw@semihalf.com>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 16 Dec 2018 12:41:21 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_124136_840117_53948CD5 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: jaz@semihalf.com, antoine.tenart@bootlin.com, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, stefanc@marvell.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 11 Dec 2018 13:56:49 +0100

> Recent changes in the mvneta driver reworked allocation
> and handling of the ingress buffers to use entire pages.
> Apart from that in SW BM scenario the HW must be informed
> via PRXDQS about the biggest possible incoming buffer
> that can be propagated by RX descriptors.
> 
> The BufferSize field was filled according to the MTU-dependent
> pkt_size value. Later change to PAGE_SIZE broke RX operation
> when usin 64K pages, as the field is simply too small.
> 
> This patch conditionally limits the value passed to the BufferSize
> of the PRXDQS register, depending on the PAGE_SIZE used.
> On the occasion remove now unused frag_size field of the mvneta_port
> structure.
> 
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

The discussion died on this, but the bug should be fixed.

So in the short term I am applying this and queueing it up for v4.19
-stable.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
