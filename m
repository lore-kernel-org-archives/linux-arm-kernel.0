Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F2820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IOieQeMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8UqMOrjLmbjA0tqEn1xGABrxAH89PMNJEtxW6hzGE6U=; b=IOieQeMjdaVT0a
	+H+rNJFRp3EYsOlNPyAuRNq0jQOHLI5w6mhnYiVLEpUvhlHvLOTvi6f60bY934j35FNlcmID0HXBt
	Wfoj62QArvUgXWVcoIW2QZTthRh5kKtS2ZWiZWgigCAfOToUf/lwj5799CYlSCG51IsE+A8icNcbL
	L4t8JOF1Aiw2/sowJ+EgCk5do/PkNWbNGWKTxavPhP+9K86tbEqTKwfANtavUqcg/aFS/6N0LxE1J
	y2ES05POQznMBCneqzYidBsvmmdDXGRGtQ1MoS4ylxCUauVNE+nDYDUMcpZ8QT2MM5t3v6G/G+SKz
	uWIqm6oxXXG/5qFUswVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCsf-0003nm-PW; Thu, 31 Jan 2019 13:59:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCr4-0002NA-5b
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:58:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B03EA78;
 Thu, 31 Jan 2019 05:58:09 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B173F589;
 Thu, 31 Jan 2019 05:58:08 -0800 (PST)
Date: Thu, 31 Jan 2019 13:58:05 +0000
From: Will Deacon <will.deacon@arm.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190131135805.GD21965@fuggles.cambridge.arm.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
 <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
 <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_055810_310815_67470CF3 
X-CRM114-Status: GOOD (  26.93  )
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Russell, Paul,

On Sun, Jan 27, 2019 at 03:28:50PM +0000, Russell King - ARM Linux admin wrote:
> On Sun, Jan 27, 2019 at 01:15:31AM +0000, Paul Walmsley wrote:
> > On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:
> > > On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > > > There was some concern in the past that WFE, like WFI, might cause the 
> > > > core to assert an external signal that might cause the SoC integration to 
> > > > place the core into a low-power mode from which it might not be able to 
> > > > wake up.  This could happen on OMAP, for example, with WFI.
> > > > 
> > > > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > > > reached?
> > > 
> > > First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> > > low power state that it may not be able to wake up from, all our
> > > spinlocks would be unsafe.
> > 
> > Good point.  WFE must not assert the external signal that indicates 
> > that the core is inactive.
> > 
> > > Next, in all of the situations in this patch, we're executing an
> > > infinite loop.  If it were to cause the core to go into a low power
> > > mode, surely that's a good thing, rather than the core endlessly
> > > executing NOPs?  The only way out of that is for the core to receive
> > > a reset _anyway_.
> > 
> > Makes sense.  
> > 
> > Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?
> 
> I think there may be an erratum for this which specifies 10 NOPs as
> its workaround, but I don't have its number.

The erratum hits because cpu_relax() is a DMB instruction due to erratum
754327. That then triggers erratum 794072 because a tight loop of DMB
instructions can cause a denial of service. One of the conditions for that
to occur is:

  | * No more than 10 instructions other than the DMB are executed between
  |   each DMB

Digging up the workaround:

  |  This erratum can be worked round by setting bit[4] of the undocumented
  |  Diagnostic Control Register to 1. This register is encoded as
  |  CP15 c15 0 c0 1. This bit can be written in Secure state only, with the
  |  following Read/Modify/Write code sequence:
  |
  |	MRC p15,0,rt,c15,c0,1
  |	ORR rt,rt,#0x10
  |	MCR p15,0,rt,c15,c0,1
  |
  |  When it is set, this bit causes the DMB instruction to be decoded and
  |  executed like a DSB. Using this software workaround is not expected to
  |  have any impact on the overall performance of the processor on a typical
  |  code base.
  |
  |  Other workarounds are also available for this erratum, to either prevent
  |  or interrupt the continuous stream of DMB instructions that causes the
  |  deadlock.
  |
  |  For example:
  |	* Inserting a non-conditional Load or Store instruction in the loop
  |	  between each DMB
  |	* Inserting additional instructions in the loop, such as NOPs, to
  |       avoid the processor seeing back to back DMB instructions.
  |	* Making the processor executing the short loop take regular
  |	  interrupts.

So the reason I prefer the NOPs is because that's guaranteed by the h/w folks
to do the trick, whereas they say nothing about WFE. It should be dead easy to
use NOPs instead, so I'm not sure why we're not just following the workaround
here. We could even use NOPs + WFE if you like!

Will "archaeologist" Deacon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
