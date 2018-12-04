Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC136C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:31:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3076206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZNWTWIpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3076206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4TLdo0Z61jfeLNmOa8nV8Y10uJ5jvKOL9SpsWX3pWjg=; b=ZNWTWIpEj19rmq
	lpEW8tIWqLQSau0HGs6K8DOOZqhh0ZX/x3PpAs/W6zGaAL3qxZou0MXpl1ghrFbaIkFMX9adEmhKm
	LszqB9SNdKPnNOnK2+ffEZF/SfZlWCQHeDh/lNpvZHuf6DKpvLOEMUX7lDShLqsCkGV8P76SENjFb
	WL49aq+yq5pgF4+oggybmhxkI8mw+nsCpOOz02SSYrG5WLBdbiTeN97HqKeuAfAxUNMlZkP6rZYTd
	p1QGd0WvyHPHxj1Zcwp3EAD8wRFqPkb/xQeANE0kF8o7u7wZ/bkdD7/Y/SJvWVIJEuoxqiIfdqXuI
	4lsREZx06LtX4L4SYIlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGPP-0003co-7g; Tue, 04 Dec 2018 19:31:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGNv-0000o4-EH
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:29:47 +0000
Received: from vmware.local.home (unknown [208.91.3.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A97CE206B7;
 Tue,  4 Dec 2018 19:29:20 +0000 (UTC)
Date: Tue, 4 Dec 2018 14:29:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181204142918.12c087b4@vmware.local.home>
In-Reply-To: <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com>
References: <20181204191229.6851-1-anders.roxell@linaro.org>
 <20181204141908.76e7afa5@vmware.local.home>
 <20181204142142.4e2e2169@vmware.local.home>
 <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112931_954482_FF8688FF 
X-CRM114-Status: GOOD (  14.33  )
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

On Tue, 4 Dec 2018 20:25:31 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> On Tue, 4 Dec 2018 at 20:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 4 Dec 2018 14:19:08 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> > > >                     /* Stop processing */
> > > >                     return;
> > > >             }
> > > > +           /*
> > > > +            * Some archs calls this function with interrupts or preemption
> > > > +            * disabled. Howeve, other archs don't and this can cause a  
> >
> > typo "However". But could you write it this way:
> >
> >         "However, for other archs that can preempt, this can cause an
> >         tremendous unneeded latency."
> >  
> 
> I'll fix this and move it up (where I added it in the first place but
> moved it) =)
>

I also noticed a grammar issue:

	"Some archs call this function .."

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
