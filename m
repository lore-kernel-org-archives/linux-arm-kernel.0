Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622BBC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300B72190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RcDzKGbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B72190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7O4tNTIgQTSSbDnT8g9uvUzor1MeUaucWBkogfRkug=; b=RcDzKGbfJuZjRa
	XXYbq7J15CnHVm1wHQ+0jQ/Lqeyd+IPFEWTKl5S7RtIgFFxTJk59uHrDdMK7ge9FfeJwdq3OZpGjl
	M0MTclrvIw/xMowzVjjByTmzTPY1xcruBh2wo4oYvCei4AuyKJd5m6eHS/DfIpmUzSaBCighzKJcH
	qWaPOT27o8mVJ35Li2J8+Ou1DwZpbRnKYPV4DllEozcUkQrXZNHDHVL2QHUZtYegi9XQnTc1RZHnM
	xBGD8XkriA/+rApMYBQPYnJHMYCksYZwCTiwGou0i8TXp9Ln2zYku+JSwNz3uPMGEf5j7Ptg038ei
	6Tm4ETzbCP2ohZzTKRQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtjY7-0000Yg-Li; Wed, 13 Feb 2019 01:41:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtjY4-0000YH-Ll; Wed, 13 Feb 2019 01:41:18 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C4402190A;
 Wed, 13 Feb 2019 01:41:14 +0000 (UTC)
Date: Tue, 12 Feb 2019 20:41:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on printk_format.
Message-ID: <20190212204113.5ecaa2a1@gandalf.local.home>
In-Reply-To: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_174116_728462_DB904EC4 
X-CRM114-Status: GOOD (  21.27  )
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
Cc: Andress Kuo <andress.kuo@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 19:41:57 +0800
Mars Cheng <mars.cheng@mediatek.com> wrote:

> From: Andress Kuo <andress.kuo@mediatek.com>
> 
> If fmt on event_trace_printk is not a constant, It means that something not
> guaranteed, so the compiler optimizes the fmt out, and then the
> __trace_printk_fmt section is not filled. if __trace_printk_fmt is not
> filled, the kernel will not allocate the special buffers needed for the
> event_trace_printk() and then not shown in the file output
> sys/kernel/debug/tracing/print_formats.
> 
> Adding a "__used" to the variable in the __trace_printk_fmt section on
> event_trace_printk() will keep it around, even though it is set to NULL.
> This will keep the string from being printed in the
> sys/kernel/debug/tracing/printk_formats section.
> 
> We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
> to print when not using bprintk()")that it had similar issue on path of
> trace_printk().

Honestly, I don't even remember why that macro was created. I think
it's a remnant from the creation of the trace events. I think the best
solution is just to nuke it. It shouldn't be used anymore.

I'll dig a bit deeper into the history of that macro, but I'm thinking
it shouldn't exist anymore.

[ /me returns from walking down memory lane ]

Wow, that brings back some wild memories. Yes, that macro must die, and
I wish the history of it could die along with it ;-) The horror of the
old ways I tell you. The event_trace_printk() was the original way we
displayed events! No real formatting, no parsing my userspace tools. It
was just a glamorized printk. It was called TRACE_FORMAT() which was
deprecated by today's TRACE_EVENT().

That macro should have been removed by commit b8e65554d80b4.

Please just send a patch to delete that macro. Let's not be maintaining
it. It gives me nightmares.

-- Steve

> 
> Signed-off-by: Andress Kuo <andress.kuo@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  include/linux/trace_events.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731..26bd7c4 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -551,7 +551,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
>  	__trace_printk_check_format(fmt, ##args);			\
>  	tracing_record_cmdline(current);				\
>  	if (__builtin_constant_p(fmt)) {				\
> -		static const char *trace_printk_fmt			\
> +		static const char *trace_printk_fmt __used		\
>  		  __attribute__((section("__trace_printk_fmt"))) =	\
>  			__builtin_constant_p(fmt) ? fmt : NULL;		\
>  									\


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
