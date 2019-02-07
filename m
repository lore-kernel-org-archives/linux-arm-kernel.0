Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689EFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:08:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2721020857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CfreIpBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2721020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qdSlesKFFBxk29x974fyKv8bS3iQHPHQjG7Yeexpa4Q=; b=CfreIpBSULOb2S
	xfa/jLcpo7DhF3g/8SFr5WIH0a28kqU4jnL88uUS0GGKJjIug1Cx9V0TxIP2XmnFV/VLbslaxnqbu
	EySoO4vzLVWracuSSfgrHdLuzTY8XpWD2YCcxIezw1HJbDetbutSVIcGC8kbJ6R6uAUdZQMK7Ata0
	zTxHywnx5pYyK+04SgIIc78elUUj/a8Qonw0R7n2eIu/RnKiyKJch3lSgCLpGBuv35V6iwWjBA4lf
	M1epq4Pr4mgTsLq8WS0HsBHqR6fCYY9o7YM68jlvQAu5CsicNkadqSBMMg2L3EpYFdUkjt7QfWa5x
	rkCdfvLwNsOopmKpWFIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpyf-0006rs-82; Thu, 07 Feb 2019 20:08:53 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpyc-0006rj-5n; Thu, 07 Feb 2019 20:08:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8164E2059AC77; Thu,  7 Feb 2019 21:08:48 +0100 (CET)
Date: Thu, 7 Feb 2019 21:08:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-tip 15/22] locking/rwsem: Merge owner into count on x86-64
Message-ID: <20190207200848.GH32477@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-16-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549566446-27967-16-git-send-email-longman@redhat.com>
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 02:07:19PM -0500, Waiman Long wrote:
> On 32-bit architectures, there aren't enough bits to hold both.
> 64-bit architectures, however, can have enough bits to do that. For
> x86-64, the physical address can use up to 52 bits. That is 4PB of
> memory. That leaves 12 bits available for other use. The task structure
> pointer is also aligned to the L1 cache size. That means another 6 bits
> (64 bytes cacheline) will be available. Reserving 2 bits for status
> flags, we will have 16 bits for the reader count.  That can supports
> up to (64k-1) readers.

64k readers sounds like a number that is fairly 'easy' to reach, esp. on
64bit. These are preemptible locks after all, all we need to do is get
64k tasks nested on enough CPUs.

I'm sure there's some willing Java proglet around that spawns more than
64k threads just because it can. Run it on a big enough machine (ISTR
there's a number of >1k CPU systems out there) and voila.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
