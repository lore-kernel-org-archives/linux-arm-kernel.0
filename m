Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:44:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7F0213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aJPRQQmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7F0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Foe/756EZAkGNVIFTaLk75ksvtOnyY4PfaungKP2v2I=; b=aJPRQQmvaAGI8F
	nIUoeTjyzqQVh6GKDcT8FiySrKhdUlpJqm2iu1vBY6aYlIssKaSQTjbb0q3wFzFKvixe7pXcEE1Bs
	PmiAkeQPjQj5y7MsD/Wpb8QW/kQPGmZpgUGDdT6aSDQIO2yaae89/F3XgGEooPFqVaNBfqmg7vPxw
	bqLol7cKzBFubgNwqBpROj6xqlrQk9pkTUNhDIE7hg2A9y0bQ1RESV3h+Z45xUcNQOHdcMRKtlgmQ
	MIfwFf3etfQQ+vzTSnLUplThBqm90wNugAENbo7OOOuXu193WJK6KbOF+u5uGFWG+TGAOiOjHMjWy
	KsD0mASLhPVjM271wxng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkZs-0005cc-LJ; Thu, 06 Dec 2018 03:43:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkZm-0005bj-Ki
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:43:50 +0000
Received: from vmware.local.home (unknown [184.48.106.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D5BE213A2;
 Thu,  6 Dec 2018 03:43:35 +0000 (UTC)
Date: Wed, 5 Dec 2018 22:43:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Message-ID: <20181205224333.3c589916@vmware.local.home>
In-Reply-To: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
 <20181205212651.488d9cd4@vmware.local.home>
 <20181205212945.58edee31@vmware.local.home>
 <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_194346_701842_A9D09687 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 19:29:11 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 5 Dec 2018 21:26:51 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > On Wed, 5 Dec 2018 17:08:34 -0800
> > > Kees Cook <keescook@chromium.org> wrote:
> > >  
> >  
> > > I'll Ack the Makefile
> > > change in the tracing directory, but the rest belongs to others.  
> 
> Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
> was directed at you. :)
> 
> I'll grab this one in the gcc-plugins tree.

Should I just take patch 2 then? I'm thinking it's independent too.

I'm collecting patches for the next merge window right now so it wont
really be an issue if I do.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
