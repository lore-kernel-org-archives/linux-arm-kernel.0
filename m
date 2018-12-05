Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF00C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:34:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802CA2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtfIBGMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802CA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rpiskwpmBf5PRVM+cx/wYi8HXZ5n/BAqxTefYDy32D8=; b=rtfIBGMZsKP17s
	nDORxLrWsbCTduRQEKyTdEq288SiBpm6FjFwuvn7qBadsqID8hKTNiG8t6P2hM7Yd9737sQ2Dl7zR
	CRoy3ZJN1zx9mpSVWOhCCqhU7rSLtyPkMJZYtb7FvN7JJjc0QPbaUODYSL7ZjZ/3T7lQ2dqkUvfcB
	bJzA6q/Mv4gyDS2CZRUGK5+y5m+oTwfX/AYzia/rIIXPtnK1x42DST1B5VtlZ9hmzYLzL9p6k7FUb
	0f+G21PXzMjbE50duHB1L9xMcGHw0JsgWd1JaxQWo5z5GuQWA/6/jFQe4N5HjIb0giAHgtQUEkdl5
	wr4qHd7sWmTp+FnizjgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUa7b-0004Hb-JY; Wed, 05 Dec 2018 16:33:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUa7Y-0004DK-4D
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:33:57 +0000
Received: from vmware.local.home (unknown [208.91.3.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AF542084C;
 Wed,  5 Dec 2018 16:33:45 +0000 (UTC)
Date: Wed, 5 Dec 2018 11:33:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181205113342.00ed69a5@vmware.local.home>
In-Reply-To: <CADYN=9+-z=_5Gn9hJcGi8UwbNxS2jK+OXe5DE0pGxscuZA_8tg@mail.gmail.com>
References: <20181204192903.8193-1-anders.roxell@linaro.org>
 <20181205095445.GA14317@arm.com>
 <CADYN=9+-z=_5Gn9hJcGi8UwbNxS2jK+OXe5DE0pGxscuZA_8tg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_083356_179204_F239B30F 
X-CRM114-Status: GOOD (  13.24  )
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

On Wed, 5 Dec 2018 11:43:12 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> > > +     schedulable = !irqs_disabled() && !preempt_count();  
> >
> > Is there a reason not to use preemptible() here?  
> 
> As I understand it preemptible() is defined to 0 if
> CONFIG_PREEMPT_COUNT is disabled.
> Thats no good right ?

No it's not, which means this isn't a good approach. I have a much
better idea on how to solve this. I'll post a small patch set in a bit.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
