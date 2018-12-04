Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AEAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CBA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwzdbmX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CBA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1/q3uHj3h7O++DoZRjFi1Yqpf1L5rnY3FEeyZO5hYnw=; b=gwzdbmX4K3KPzT
	Ejax4H3FcbYgujwHxCKuWcamy243xPDHKV2cuRN7+Cit64r8FrjuyEZZzgZuCO5KOaJUY+ps5d2i+
	4RBxS88Y2kML9Pppl9D1fUOcO0TUedtJ6tuRuw8EljW46BZYUzZzE3h9UcO68E1ssq/hl1OxSsMRb
	mfcDxz7IMXdaGxKE563n0pxFwXCiK63e26RAr2p3HWILgYz30G2Bs5X0qAWtRpBFCa8Oa4C3vS+iu
	hqnU33tg36D6JAJMTc139OZPgn6pNIsNvLaY/AQGVgV1b+j+s9QxsnAQ9PtSI4kdvOW0u33sM7+j8
	a4Pdx7PRkVVPBZBXksfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFMX-0001ke-G9; Tue, 04 Dec 2018 18:24:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFMU-0001jc-8K
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:23:59 +0000
Received: from vmware.local.home (unknown [208.91.3.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60FFE2081B;
 Tue,  4 Dec 2018 18:23:47 +0000 (UTC)
Date: Tue, 4 Dec 2018 13:23:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204132344.2fcf13c3@vmware.local.home>
In-Reply-To: <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home>
 <20181204111242.GA32596@arm.com>
 <20181204122627.225befaa@vmware.local.home>
 <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_102358_308397_D04612D3 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 19:07:16 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:


> > > > +   schedulable = !irqs_disabled() & !preempt_count();  
> > >
> > > Looks suspiciously like a bitwise preemptible() to me!  
> >
> > Ah, thanks. Yeah, that should have been &&. But what did you expect.
> > I didn't even compile this ;-)
> >  


> > If it does, then I'll add it. Or take a patch for it ;-)  
> 
> I tested your patch. it worked.
> 
> I'll send a patch shortly.
>

Thanks. Please add a comment above the schedulable test stating that
some archs call this with interrupts or preemption disabled, but
other archs don't and this can cause a tremendous unneeded latency.

-- Steve
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
