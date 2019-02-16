Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D19FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:32:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A25A222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQDmbbvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A25A222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Xjdr5S2g+EBqpNabcQmKzZo523Wn5jaIwkYhcyEnbs=; b=fQDmbbvrxc+FHW
	Va3oMAa612FWZThXz2kyeYJG8nVkEHhustDiH4jIE1fmP4ALVLHyGYPPnbm8lcLoiS3inRU7LiFs8
	SD4IYaNntpMsxQhyMLOfDssq1vOykWw07EYwt4e2v16JRVBc1Sk+YjmlxDvQ+eMieXGMYDahzXspg
	1RZeXCDqYUh5/0VtNcQhSZO5d5p1rvblqgjSj5Fp4aC2HjTi7jo01b6nxqUeIqPpO/QzGkWBKvX0U
	iyI3CQMDTCxmObikGFct5xBWwvR43WZQHBwJUr2k9QeUwCbUEsyNqgphCLYrgwT47uvtylJVPFK/B
	qtIuJkvm75bFH4/B8DjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guxH9-0004H3-Cp; Sat, 16 Feb 2019 10:32:51 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guxH5-0004Gk-RH; Sat, 16 Feb 2019 10:32:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 28F3C201A4021; Sat, 16 Feb 2019 11:32:46 +0100 (CET)
Date: Sat, 16 Feb 2019 11:32:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190216103246.GS32494@hirez.programming.kicks-ass.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net>
 <20190215233414.GS32534@hirez.programming.kicks-ass.net>
 <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, valentin.schneider@arm.com,
 Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 04:21:46PM -0800, Linus Torvalds wrote:
> Even just a comment about it would be fine. But it might also be good
> to show that it's an explicit eflags value and just use
> X86_EFLAGS_FIXED as the initializer.

That is in fact what I have now; I'll repost on Monday or so.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
