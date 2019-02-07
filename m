Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE89C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB6221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qcOVe0J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB6221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i++VAlDQMo+gDvCyBi8fEteaf1c22Ow2oHeI4T4Rkz4=; b=qcOVe0J3qceEiD
	0fgDKgqkT2Jd99I99iPnpJzL3k/qKDR89NdAzgNGELT2Cs1uQrJe0gGGQtnWkPz5T6UFY77yoUblJ
	zRAtlmm1iiDEjKC5rammTQRxv1zL+WNtDdOFUj2A6OVLV4ha7UUuvcSPnPYKp0Uc7lxv64EF9J2dt
	XVoWMckKF5BDffQYJR413kB29ts5pwKMG/3SqaqzeOX+PkUl+7noDuG+9f/k+WHEfTD9hyx/fvXBx
	+rW2BrpWXJnuvCIXyF2yS7UgVfly8fkZ3Fxd7WTrFJP06xxzCjuBmJqiNFA+WwrkIvw/cXUNy8d6d
	3UcmoBlUk0sd/ReQUukg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grl24-0003XZ-H0; Thu, 07 Feb 2019 14:52:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grl21-0003WY-8n
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:52:02 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C2B521872;
 Thu,  7 Feb 2019 14:51:59 +0000 (UTC)
Date: Thu, 7 Feb 2019 09:51:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190207095157.3dea1086@gandalf.local.home>
In-Reply-To: <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
 <20190206150524.GA28892@lst.de>
 <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_065201_323201_DD134823 
X-CRM114-Status: GOOD (  15.39  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 7 Feb 2019 10:33:50 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> I don't see really much documentation on that function. As far as I can
> tell it is only called once for each site (and if it didn't, we'd always
> be placing the same instruction, but I agree it wouldn't be nice). It
> could depend on how far you can expand the notion of "adjusting" :) .
> 
> Steven, do you have an opinion on whether it would be acceptable to
> modify function entry code in ftrace_call_adjust() ?

Just to make sure I'm on the same page as you are. You want to modify
the function entry code at the time of the ftrace_call_adjust()?

I would update the rec->ip to the offset you want at
ftrace_call_adjust() but not do any modifications. It really isn't safe
to do it there. But right after that is called, you will have the arch
specific call of ftrace_make_nop() called with MCOUNT_ADDR as the
second parameter to let you know that this is the first time the call
is made at this address. This is where you can do that initial
modifications.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
