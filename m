Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A3E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZTEOMwRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A3E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bg8dedJ6yhTDITy5O/l/SntCO3ws32iNkt+bpHQ23PE=; b=ZTEOMwRfem+hsW
	vIc+unOfYwX+vc6fEGIlAfd+3gbqVfJbnk74YW5HJ/H1/4lzydv4eWBJgP5lqio8QIhPKXZZYlhA4
	zJzPZhDX9RUZsmnVLkLGu1AvpKTmfZj5bFJx8k15QNefj7jfQbyYqhDkxvLST16HpWghlYlZLzRfl
	OP/Va6BUJCevk4q4EEgmXMHkH+Pj/OM5NA6NVBugZUp0j97rIjKFKxWe+d/C48IGfuxMoL/od1aHP
	JSSEPpKvjPYIMbDovAhDVdCFArvlt7ZBTlDYzY4jwTYOknCalfFekxpeaiDVxznk3ujOrdKRzeyht
	NRKL+4a+QgNlsiRXy/xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsMP-0002P2-TD; Thu, 06 Dec 2018 12:02:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsMH-0002OW-6g
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:02:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA5980D;
 Thu,  6 Dec 2018 04:02:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B163F5AF;
 Thu,  6 Dec 2018 04:02:08 -0800 (PST)
Date: Thu, 6 Dec 2018 12:02:06 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
Message-ID: <20181206120206.GW3505@e103592.cambridge.arm.com>
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
 <20181206112026.GV3505@e103592.cambridge.arm.com>
 <CAKv+Gu9oQbJHXThZYWue_Mko-CtfT2dcqXozTxs5TXy_UfaYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9oQbJHXThZYWue_Mko-CtfT2dcqXozTxs5TXy_UfaYRA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_040221_251627_24E00A26 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 12:47:16PM +0100, Ard Biesheuvel wrote:
> On Thu, 6 Dec 2018 at 12:20, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Mon, Dec 03, 2018 at 05:45:06PM +0000, Will Deacon wrote:
> > > On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:

[...]

> > > That looks better to me, although I'm not sure why you're inverted the logic
> > > here:
> > >
> > > >     .ifnc \op, civac
> > > >     .ifnc \op, cvap
> > >
> > > What am I missing?
> >
> > I vote for the .ifc approach.
> >
> > Note, the current works-by-accident approach using == has the odd side-
> > effect of spitting out undefined symbol references in the .o file.  It
> > seems that isn't breaking the link, but I wonder whether there are any
> > side-effects we're not aware of.
> >
> 
> Did you read the commit log at all? :-)

Due to a combination of a mutt snafu and laziness, no.  (However did you
guess? ;)

> > If we don't like the inverted logic, there is always
> >
> >         .set .L__foo_\@, 0
> >         .ifc \op, civac
> >         .set .L__foo_\@, 1
> >         .endif
> >         .ifc \op, cvap
> >         .set .L__foo_\@, 1
> >         .endif
> >
> >         .if .L__foo_\@
> >         // ...
> >         .endif
> >
> > which is ugly.  Either way, the logic could be wrapped as a helper:
> >
> >         .macro if_string_is_either str, cmp1, cmp2, insn:vararg
> >                 .ifnc "\str","\cmp1"
> >                 .ifnc "\str","\cmp2"
> >                 .exitm
> >                 .endif
> >                 .endif
> >
> >                 \insn
> >         .endm
> >
> 
> Yeah, I don't think this is an improvement over using inverted logic.

As a single instance, no.  But if this issue comes up in multiple places
it could be worth wrapping it up.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
