Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE281C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D31A20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I127iZg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D31A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wvl57QtVxi4na62SqJHEXyMucFSoYOsIAiINBTIkFJI=; b=I127iZg1j7czoz
	ECv9slw8lp5v6rcvw627az/lcuVXzgbCvD63eJ4NAUywDLSCcN0pMQFcCmqZHDTmEfUL4PULecktV
	ijwDv+bWpS7fpk0nN8k+q4U2IN+7jDjgXQeYyqTaSwVKLEXFCLDM7f6jQUJSSRsuJgPmYjbnyyxTN
	b0HnaByQo/WOD8kddTUVYkGy3Hl1ryDXrLFVjAXenzakWITdZCLochkYKyJD9VKYLdDfNQBgMqMp7
	pPiwMQX3QWJC8Tg8wdBx9XNMGJeeFW/6gfa8xVKueqR3k07kAD4oGqdnf3QPWneKI+S7jkHe+MT2R
	psy5pkBkcBL9A6GPjrZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUjNe-00060V-Ll; Thu, 06 Dec 2018 02:27:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUjNY-0005zk-Is
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 02:27:08 +0000
Received: from vmware.local.home (unknown [184.48.106.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A27B20700;
 Thu,  6 Dec 2018 02:26:53 +0000 (UTC)
Date: Wed, 5 Dec 2018 21:26:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Message-ID: <20181205212651.488d9cd4@vmware.local.home>
In-Reply-To: <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_182704_659962_6C29C51C 
X-CRM114-Status: GOOD (  13.99  )
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

On Wed, 5 Dec 2018 17:08:34 -0800
Kees Cook <keescook@chromium.org> wrote:

> > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > index e42892926244..5de3bf596dd7 100644
> > --- a/kernel/stackleak.c
> > +++ b/kernel/stackleak.c
> > @@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
> >         current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
> >  }
> >
> > -void __used stackleak_track_stack(void)
> > +void __used notrace stackleak_track_stack(void)
> >  {
> >         /*
> >          * N.B. stackleak_erase() fills the kernel stack with the poison value,
> > --
> > 2.19.2
> >  
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Steven, I assume this series going via your tree?

??

A notrace addition doesn't make it mine.

I added changes for the cond_resched in a different patch series that
I'll pull in (they are independent from this). I'll Ack the Makefile
change in the tracing directory, but the rest belongs to others.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
