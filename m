Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13273C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0B5222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZP4Gvsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B5222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NyMwO1ALQSJNUP99mgOSoMk2iEK0vbzrCPyFOryStJg=; b=ZZP4Gvsc9jDWFh
	ZxIIs4MPNgctst/jLAE///6fU20K2eBZbZldHaUs3q9ldhDlpnn2osFDEeioKNFFFmm+3KHT+2L4z
	NJMoWdRcK/cKjvNYfKJ6injnHBhVIYRgFAiaLTc2AWuytvFY9dlzmrV09XpF1Ye7wdSu+T7KeXQfB
	C5+DdXW2SBLIf83XCqYiWmUuqlfoi6kZEGi67qmR/w2cPjKYU0XWXSYtzi4gQR+pJ3mtB1Vi/6HiI
	di+kTutxyuxXKoMjPCZdOMiuLTqoW/nfHhJuMXfMaUzQoPavNibhfJ4sI13MOkCMjgfVUhhbq+a6z
	aPg8Xu4Bfl2qiIjq69Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtoN1-0004cc-6Y; Wed, 13 Feb 2019 06:50:11 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoMw-0003s2-0C; Wed, 13 Feb 2019 06:50:08 +0000
X-UUID: 2bbfeedfb7f34d11bebe5e144f3338e3-20190212
X-UUID: 2bbfeedfb7f34d11bebe5e144f3338e3-20190212
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <mars.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 868390852; Tue, 12 Feb 2019 22:49:48 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 22:49:47 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 14:49:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 14:49:45 +0800
Message-ID: <1550040585.12645.9.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on printk_format.
From: Mars Cheng <mars.cheng@mediatek.com>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 13 Feb 2019 14:49:45 +0800
In-Reply-To: <1550033650.7648.2.camel@mtkswgap22>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
 <20190212204113.5ecaa2a1@gandalf.local.home>
 <1550033650.7648.2.camel@mtkswgap22>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_225006_106208_777A42FE 
X-CRM114-Status: GOOD (  25.40  )
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

Hi Steve

On Wed, 2019-02-13 at 12:54 +0800, Mars Cheng wrote:
> Hi Steve
> 
> On Tue, 2019-02-12 at 20:41 -0500, Steven Rostedt wrote:
> > On Tue, 12 Feb 2019 19:41:57 +0800
> > Mars Cheng <mars.cheng@mediatek.com> wrote:
> > 
> > > From: Andress Kuo <andress.kuo@mediatek.com>
> > > 
> > > If fmt on event_trace_printk is not a constant, It means that something not
> > > guaranteed, so the compiler optimizes the fmt out, and then the
> > > __trace_printk_fmt section is not filled. if __trace_printk_fmt is not
> > > filled, the kernel will not allocate the special buffers needed for the
> > > event_trace_printk() and then not shown in the file output
> > > sys/kernel/debug/tracing/print_formats.
> > > 
> > > Adding a "__used" to the variable in the __trace_printk_fmt section on
> > > event_trace_printk() will keep it around, even though it is set to NULL.
> > > This will keep the string from being printed in the
> > > sys/kernel/debug/tracing/printk_formats section.
> > > 
> > > We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
> > > to print when not using bprintk()")that it had similar issue on path of
> > > trace_printk().
> > 
> > Honestly, I don't even remember why that macro was created. I think
> > it's a remnant from the creation of the trace events. I think the best
> > solution is just to nuke it. It shouldn't be used anymore.
> > 
> > I'll dig a bit deeper into the history of that macro, but I'm thinking
> > it shouldn't exist anymore.
> > 
> > [ /me returns from walking down memory lane ]
> > 
> > Wow, that brings back some wild memories. Yes, that macro must die, and
> > I wish the history of it could die along with it ;-) The horror of the
> > old ways I tell you. The event_trace_printk() was the original way we
> > displayed events! No real formatting, no parsing my userspace tools. It
> > was just a glamorized printk. It was called TRACE_FORMAT() which was
> > deprecated by today's TRACE_EVENT().
> > 
> > That macro should have been removed by commit b8e65554d80b4.
> > 
> > Please just send a patch to delete that macro. Let's not be maintaining
> > it. It gives me nightmares.
> > 
> > -- Steve
> 
> Got it, I will send another patch to remove the nightmares. :-)
> 
> Thanks.

After some grep, I found event_trace_printk() not used in 5.0-rc*. But
trace_printk() is still used in several places.

kernel/trace/ring_buffer_benchmark.c:415: trace_printk("Sleeping for 10
secs\n");
...
drivers/gpu/drm/i915/i915_gem.h:66:#define GEM_TRACE(...)
trace_printk(__VA_ARGS__)
drivers/hwtracing/stm/dummy_stm.c:30:   trace_printk("[%u:%u] [pkt: %x/%
x] (%llx)\n", master, channel,
...

since they are similar functions, do you prefer remove both of them or
just remove event_trace_printk()? the former approach might affect some
modules, and the latter approach keeps nightmares, right?

Thanks.
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
