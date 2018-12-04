Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CBC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE2D2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHC580rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE2D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sKeBU0f2Jh2bwqzCIV6hQqUfXqHYI50tiMDmks6jXLA=; b=JHC580rqLaPvJ2
	mhdzSSEWiqfVqUj9xrju6kc9PG4PfWxxcr0FC+l4d4nLjRI1DyEdBf81DJQTbMhQNxZv8fzu2U4ff
	pXemYiCGZ7jEG1v0+T9wOT1H1sWVNBSAQcWskgnhhbohKBTioXWxofwnCZ0IA3+5NGpa1QHjZJYhX
	kNHscXFDLjR9Wn5oGnJDWNHQNOXYmKzTL3HdN+pf/kfPZGfc1QGDXLb3tZoSueMFz8PnpDXuEUP3g
	n+TQ4P5Eild+iPAm5FVT6ypwl1CI5KH/GUl8A7UAhC+Od8ChqPImYtRPdU12vaqY9Xt9+yn8eBRWZ
	kpF2my38qbmm3Kh1YsKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCbm-00084c-Lv; Tue, 04 Dec 2018 15:27:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUCbi-00083z-Uv; Tue, 04 Dec 2018 15:27:30 +0000
Date: Tue, 4 Dec 2018 07:27:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Message-ID: <20181204152730.GA30896@infradead.org>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
 <20181204150124.GA23762@infradead.org>
 <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: linux-block@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 liuyun01 <liuyun01@kylinos.cn>, Will Deacon <will.deacon@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 04:02:36PM +0100, Ard Biesheuvel wrote:
> On Tue, 4 Dec 2018 at 16:01, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Why does this go to linux-block?
> 
> Because xor_blocks() is part of the RAID driver?

The only caller of xor_blocks() seems btrfs.  And the RAID code has its
own list anyway..

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
