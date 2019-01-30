Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:33:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1641D218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dM+Q+oXG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz1sufCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1641D218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+cdkzTF7IGH5fqCIbqzq1wwVrKcIMWEGA7wqTQNl22k=; b=dM+Q+oXGgucQcZ
	53FvCTf41hIMimUh71RvUU5/5Ydlat/30iHxm2q2fA4nb63m0Eo/emyLnWARuQGEWsYR2Z80C3KBU
	jbNXD+7lUt19YDZCMD4fwwDB3C4Vojyw0XOficcFpuT4CCWJ5J0cohTeSTtkTc9Ojn8cuFBk41ZAA
	sHWjU7ctXZlO2XYEdIoLZ68gnUOUD/X6uUTvRogRaGppGRZn+GuXMhIyMEbuPt25Hg/fruuvrpHhZ
	VfgJFDjsU+wR7CfR/UOn+ERvPLcuEfulnpvHxsuEbcAh6h4X4RU6JV5oPteexwYqAqaqlxnocCbbe
	FqBfOMoGx8tkfrdP/eBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govcR-0000gj-Js; Wed, 30 Jan 2019 19:33:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govcN-0000gN-GS
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:33:53 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6E69218A4;
 Wed, 30 Jan 2019 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548876831;
 bh=BPlEQH+U/bnY6PnlU3AcTWtT2I3p4HH7404MougbRnw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cz1sufCOo0cnVukVf7WWGKhlH3dH+4drmdLKXF/bBrh59twqGNpwVmAZEGf4UNcnG
 x69OuPi708GaUqq/40s5MneEtmPeok2Ta2UBmVxx2ITQDqIY5EVU7zxFcIMfTUXfKJ
 yAoIY0sI6RgbHkEY2kCQNyokz9iNaGE+gX7qEc50=
Date: Wed, 30 Jan 2019 20:33:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/4] arm64: dump: no need to check return value of
 debugfs_create functions
Message-ID: <20190130193348.GC20667@kroah.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-2-gregkh@linuxfoundation.org>
 <20190130182102.GK18558@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130182102.GK18558@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_113351_565688_8F2A9A6B 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, Peng Donglin <dolinux.peng@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 06:21:02PM +0000, Will Deacon wrote:
> Hi Greg,
> 
> On Tue, Jan 22, 2019 at 03:41:11PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Peng Donglin <dolinux.peng@gmail.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/arm64/include/asm/ptdump.h | 9 +++------
> >  arch/arm64/mm/dump.c            | 4 ++--
> >  arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
> >  3 files changed, 7 insertions(+), 13 deletions(-)
> 
> Are you taking this via your tree, or would you like us to queue it in
> arm64?

What ever is easiest for you is fine with me, I can handle it either
way, just let me know.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
