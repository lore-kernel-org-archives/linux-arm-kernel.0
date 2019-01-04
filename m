Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D05218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uaGykmv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D05218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O9Ln5qDEhDgVQ67e0OooLg6xcyExmyqmhQZY6nu+oOY=; b=uaGykmv3IYSbUL
	/U7CtwiQqGJDHdIr8ZMwUEtOmZwR05hGlIws7zQe/mw9f5FmTNYHqS28YnBco1CSMlLRrXIliO6BQ
	5AM4UKprLCPf4ZvsPyDjDIkb4xAI8xTYkh9mEtfP8HdSzaJSnY0yKS9fT/+iOjnEpLv8/9Ztz7Bsm
	H0OEWdVoCjym0Um++83KiG0fJopN7nkVszzJDK1zPFdoTg3D+rwQblCAnsyXBTaxS4x+9cuUzAvaG
	Q7b9Ng70cuW+cLy7vtvFEZYnuLng8LKFPrJK03MxFv4vC6gKqUyXP/WQiwQn1bz9NKedMN1hsd3+W
	lZ/7kO2itXmiYaVsiZbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTs0-0002nf-GV; Fri, 04 Jan 2019 18:06:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTrw-0002kB-RG
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:06:54 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D612218D3;
 Fri,  4 Jan 2019 18:06:50 +0000 (UTC)
Date: Fri, 4 Jan 2019 13:06:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190104130648.02657f3f@gandalf.local.home>
In-Reply-To: <20190104175017.GA7157@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_100652_900334_96DB267E 
X-CRM114-Status: GOOD (  13.21  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 17:50:18 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> At Linux Plumbers, I had a conversation with Steve Rostedt, and we came
> to the conclusion that (withut heavyweight synchronization) patching two
> NOPs at runtime isn't safe, since a CPU might have executed the first
> NOP as a NOP before another CPU patches both instructions. So a CPU
> might execute:
> 
> 	NOP
> 	BL	ftrace_regs_caller
> 
> ... rather than the expected:
> 
> 	MOV	X9, X30
> 	BL	ftrace_regs_caller
> 
> ... and therefore X9 contains some UNKNOWN value, rather than the
> original LR value.
> 
> I wonder if we could solve that by patching the kernel at build-time, to
> add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> could also update the addresses to pooint at the second NOP, simplifying
> the changes to the runtime code.

You can also patch it at boot up when there's only one CPU running, and
interrupts are disabled.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
