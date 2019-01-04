Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6622173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dav6chek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6622173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYR1R0FuafXcLGI9Ki23RkFd3YusiI5DfZ0rkT3tVzg=; b=Dav6chekpEp4Rs
	I4N0v0PxHOTDLn6IIWGct5jemFKvBDY5l996qKysSW1lE9/FX8MWc6/+zd1kqz3LPx28bGysqHT2D
	cwhte5GZK+M3sP197Ixc9WmsbyAiFonZjqoyYYe1lTVDS1NRJbsNzwPMSHLY+2xTpGjVEox1tnyhJ
	0xdnM3BJrFzLdqS2fa/g4YCzA1Ozvug64Sb4ct80fGyfIrRj08s9Q3Lx1SYyUGFAqtCdogkthTG84
	kpMeXV5IUatbQV2hY6aq0bGtbmIwD638cbXumbVS0VUpekh/NCgnUip3MU7t543XW+vpHTTrGGADY
	f3TNJrPqkW5HSDt0zPZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfYAE-0001Fr-Gc; Fri, 04 Jan 2019 22:42:02 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfYAB-0001Ej-2t
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 22:42:01 +0000
Received: by newverein.lst.de (Postfix, from userid 107)
 id 0C2A268DD2; Fri,  4 Jan 2019 23:41:57 +0100 (CET)
Received: from lst.de (p5B33F989.dip0.t-ipconnect.de [91.51.249.137])
 by newverein.lst.de (Postfix) with ESMTPSA id 91DA567358;
 Fri,  4 Jan 2019 23:41:53 +0100 (CET)
Date: Fri, 4 Jan 2019 23:41:45 +0100
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190104224145.GA28236@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190104130648.02657f3f@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104130648.02657f3f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_144159_282642_C0C54E60 
X-CRM114-Status: GOOD (  17.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 01:06:48PM -0500, Steven Rostedt wrote:
> On Fri, 4 Jan 2019 17:50:18 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > At Linux Plumbers, I had a conversation with Steve Rostedt, and we came
> > to the conclusion that (withut heavyweight synchronization) patching two
> > NOPs at runtime isn't safe, since a CPU might have executed the first
> > NOP as a NOP before another CPU patches both instructions. So a CPU
> > might execute:
> > 
> > 	NOP
> > 	BL	ftrace_regs_caller
> > 
> > ... rather than the expected:
> > 
> > 	MOV	X9, X30
> > 	BL	ftrace_regs_caller
> > 
> > ... and therefore X9 contains some UNKNOWN value, rather than the
> > original LR value.

I'm perfectly aware of that; an earlier version had barriers, attempting
to avoid just that, which Mark(?) wrote weren't neccessary.

But is this a realistic scenario? All function entries are aligned 8 bytes.
Are there arm64 implementations out there that fetch only 4 bytes and
give a chance to mess with the 2nd 4 bytes? You at arm.com should know, and
I won't be surprised if the answer is a weird "yes". Or maybe it's just
another erratum lurking somewhere...

My point is: those 2 insn will _never_ be split by any alignment
boundary > 8; does that mean anything, have you considered this?

> > I wonder if we could solve that by patching the kernel at build-time, to
> > add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> > could also update the addresses to pooint at the second NOP, simplifying
> > the changes to the runtime code.
> 
> You can also patch it at boot up when there's only one CPU running, and
> interrupts are disabled.

May I remind about possible performance hits? Even the NOPs had a tiny impact
on certain in-order implementations. I'd rather switch between the mov and
a "b +2".

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
