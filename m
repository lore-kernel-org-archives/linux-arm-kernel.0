Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:38:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891992184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DGiv3nVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891992184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d8r8AreCCcVLXL4AlUjCpp+X/AOyQq9KCBGd6/j4N5A=; b=DGiv3nVjAGtWhw
	NnvDmCTtnOaRs4V+ihkNUdG7oB6qSnI6NfbxFSJnfFNS7iaSelYrxokwS5wbVHcNHvWr2aAMKjp1r
	He5vhlkJO8gapEriczAQv6eFTUgeP6tjKeBMs6VwF/U9AaC5h9cjMOpvVt7M6Sw+Smd649YRESSMI
	VmNywdl8QJPT7KUF0cL4TTyFpuHwwu10Ma+TtlD86WxvR6im0Mc4sCa6OqGUeaRY9LOpiFHlEnjBW
	3pvbKRQBsqRAjrclmfIlfX1+QolEDHTrLqnHtAmiz5PO3xrT99pWredk+z5QYBdWDIUPWtnVyQm5A
	Lzc0yv6ApJKc4YnfjN+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvW0x-0006Qt-O6; Sun, 17 Feb 2019 23:38:27 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvW0u-0006QM-Pn
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 23:38:25 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 1813612339A63;
 Sun, 17 Feb 2019 15:38:24 -0800 (PST)
Date: Sun, 17 Feb 2019 15:38:23 -0800 (PST)
Message-Id: <20190217.153823.1902309066603119738.davem@davemloft.net>
To: alexandre.torgue@st.com
Subject: Re: [net, PATCH v2] net: stmmac: handle endianness in
 dwmac4_get_timestamp
From: David Miller <davem@davemloft.net>
In-Reply-To: <1550224149-30380-1-git-send-email-alexandre.torgue@st.com>
References: <1550224149-30380-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 17 Feb 2019 15:38:24 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_153824_839205_228E6840 
X-CRM114-Status: UNSURE (   6.82  )
X-CRM114-Notice: Please train this message.
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
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 joabreu@synopsys.com, peppe.cavallaro@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Alexandre Torgue <alexandre.torgue@st.com>
Date: Fri, 15 Feb 2019 10:49:09 +0100

> GMAC IP is little-endian and used on several kind of CPU (big or little
> endian). Main callbacks functions of the stmmac drivers take care about
> it. It was not the case for dwmac4_get_timestamp function.
> 
> Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Please do not put an empty line between Fixes: and other tags.  All
tags are equal and should be placed together as a cohesive group.

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
