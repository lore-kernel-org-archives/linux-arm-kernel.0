Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A998C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 01:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E11214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 01:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdNRLGyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E11214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pwsan.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wC56QwUhY24owlXIuax8rvXgF8Anz7VCR9yhzmFmvVI=; b=RdNRLGyiHFbdYB
	7VUV0HkCsEiy/56irLMeTmEqM9S2EwOkLQs9s0iEFtCXHs9Q7s2V5bINRMXO4TZadW3pPEUvBXlYo
	ywKeWe1wS9Ld7sQjadfXWSfphvtXh0ENdI0gMRwFB0uCKrAxE448MkORCRv1tZfFiFA0cyDvyhBdr
	c01HELCd8guv/cW2T0wS+ywphakTK4/yd8NrgQ3OaWSPOhg8GXN3E2CmfuZNF9i6bQMU7MBt1mHbY
	rcjlgWIQt9Q7F55WpMM8ilKiv2+Se2ja6UymzkcNoEB1oV3Dunz6fctrc62nrEmF8AUU6vkiAfAtu
	RquWTQtoI8tBUpvEi6Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnZ2x-00074c-BF; Sun, 27 Jan 2019 01:15:39 +0000
Received: from utopia.booyaka.com ([74.50.51.50])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnZ2t-00074D-Tg
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 01:15:38 +0000
Received: (qmail 18276 invoked by uid 1019); 27 Jan 2019 01:15:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 27 Jan 2019 01:15:31 -0000
Date: Sun, 27 Jan 2019 01:15:31 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
Message-ID: <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_171536_037039_69860FE2 
X-CRM114-Status: GOOD (  21.89  )
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
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:

> On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > On Fri, 25 Jan 2019, Tony Lindgren wrote:
> > 
> > > * Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
> > > > Executing loops such as:
> > > > 
> > > > 	while (1)
> > > > 		cpu_relax();
> > > > 
> > > > with interrupts disabled results in a livelock of the entire system,
> > > > as other CPUs are prevented making progress.  This is most noticable
> > > > as a failure of crashdump kexec, which stops just after issuing:
> > > > 
> > > > 	Loading crashdump kernel...
> > > > 
> > > > to the system console.  A workaround for this is to use 10 nops in
> > > > cpu_relax().
> > > > 
> > > > We also use wfe() in while (1) loops to avoid burning cycles in a
> > > > tight loop, giving the CPU a hint that we're not doing anything
> > > > useful.
> > > > 
> > > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > > It's been a while since this was posted, Will's suggestion was to use
> > > > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > > > these infinite-not-doing-anything-ever loops.
> > > 
> > > Works for me:
> > > 
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > There was some concern in the past that WFE, like WFI, might cause the 
> > core to assert an external signal that might cause the SoC integration to 
> > place the core into a low-power mode from which it might not be able to 
> > wake up.  This could happen on OMAP, for example, with WFI.
> > 
> > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > reached?
> 
> First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> low power state that it may not be able to wake up from, all our
> spinlocks would be unsafe.

Good point.  WFE must not assert the external signal that indicates 
that the core is inactive.

> Next, in all of the situations in this patch, we're executing an
> infinite loop.  If it were to cause the core to go into a low power
> mode, surely that's a good thing, rather than the core endlessly
> executing NOPs?  The only way out of that is for the core to receive
> a reset _anyway_.

Makes sense.  

Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?


- Paul

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
