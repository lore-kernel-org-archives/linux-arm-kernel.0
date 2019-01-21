Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378BBC31690
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:35:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E828720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kZJ/53UB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E828720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H8ydnD03zzgMP7wpjoANd5q6t78oV8M/cjRDxD2mE5I=; b=kZJ/53UB5QI1Lk
	F4uh0kshJjdANX2edqotbMayvkI3ae5dYID2Jyz9SrVxYaTrC3AIa+KY+p57LBhEhkh5u5asiOdvj
	udqEGwfMVh1cpY0GkGiiNqL7qBmPscGDZ5XSXwLCo0E1N4c73mVdZEtrd/TVC+ah8JTQPUuebVMLc
	fieVllTdD95ravBrcHRQnqEodSc5MhgPcu4R8bQ0kR58pqjzGmKiGm1HhekXW5jM6qCKCAagywawx
	NXSPVJ6uIhV0VQ5qpJDHJpNlbuSgMUyFRJd3UT12tKXVBq3aIJiM12aZcCyLEtKR97ITDzCfjrcRX
	n9kx0XBoilguzLgWqx1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldTT-0002t1-P6; Mon, 21 Jan 2019 17:35:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldTQ-0002h2-El
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:35:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A998F15AB;
 Mon, 21 Jan 2019 09:34:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 761273F614; Mon, 21 Jan 2019 09:34:58 -0800 (PST)
Date: Mon, 21 Jan 2019 17:34:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
Message-ID: <20190121173455.GI29504@arrakis.emea.arm.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
 <20190110141503.GA31328@fuggles.cambridge.arm.com>
 <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_093500_549792_D4735183 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 09:51:52AM -0700, Logan Gunthorpe wrote:
> On 2019-01-10 7:15 a.m., Will Deacon wrote:
> > On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
> >> Cleanup the arm64_memory_present() function seeing it's very
> >> similar to other arches.
> >>
> >> memblocks_present() is a direct replacement of arm64_memory_present()
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/mm/init.c | 20 +-------------------
> >>  1 file changed, 1 insertion(+), 19 deletions(-)
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Did you want us to take this via the arm64 tree?
> 
> Yes please.

Patch 2/2 queued for 5.1. Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
