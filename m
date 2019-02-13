Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91969C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E2D218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oU16+Mwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E2D218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VGTfAS3kKtqlF2yOgOgoi0JyFFZgFikfwiTb3fY7ttI=; b=oU16+Mwmn09MTX
	fW5FwZwoVKHtIxnKKywRVsGy0XwTnn0iqt1wYcb83Zf6f3Z2CX8awNlYUoZF5WonV5FHxPRo0R0Dj
	ga00QqIrV7sxnhc1qZThovCWKAMtgR9HGm+cegKrOysBmwOZuNYhIxkpP1hTfj+iW+2xr9dJMeGj5
	oVIxC/B710Nc0A4e1+XHdbVUPEVH5+VMjUAcX5Bt6W13a48cKQBffrgaofFqErXaDvCtaj+43y9GK
	VURNbMhJsN4mgHy89wNOCPBQypBLfvdrDgKygvt0YoDwlWa8T8Gs7IJuPug1AsfF2Kzf5SRDmn0pS
	Srkp52bCNIDZqXbIQRyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuqk-0007en-Pj; Wed, 13 Feb 2019 13:45:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuqf-0007de-Vz; Wed, 13 Feb 2019 13:45:16 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3AC4218D3;
 Wed, 13 Feb 2019 13:45:12 +0000 (UTC)
Date: Wed, 13 Feb 2019 08:45:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on printk_format.
Message-ID: <20190213084511.45b86e15@gandalf.local.home>
In-Reply-To: <1550040585.12645.9.camel@mtkswgap22>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
 <20190212204113.5ecaa2a1@gandalf.local.home>
 <1550033650.7648.2.camel@mtkswgap22>
 <1550040585.12645.9.camel@mtkswgap22>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_054514_045601_D6C9B4C1 
X-CRM114-Status: UNSURE (   7.02  )
X-CRM114-Notice: Please train this message.
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

On Wed, 13 Feb 2019 14:49:45 +0800
Mars Cheng <mars.cheng@mediatek.com> wrote:


> After some grep, I found event_trace_printk() not used in 5.0-rc*. But
> trace_printk() is still used in several places.

event_trace_printk() is an abomination, but trace_printk() is an
extremely useful tool. Don't touch that!

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
