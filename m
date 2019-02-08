Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:28:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCC720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fkwl8R6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=habKG+2qtB5YX1cw2ccdqZSEbqhikkXLeQHtbB2iyQw=; b=fkwl8R6rqYx2Aw
	DhSGnKGloqtDIu9eyGi6yjWECafu13ABmk2pUk4yY+F8rJRp2Y/wnZqV7E0EnQ2yy/nQXREJcRk63
	4aq1Dg5S6NonBibvsLIsPxN4F5UP9oJ80YPabsBNevWHrZDuZMaEwamhq8Lud1GsqDwCxfKq4DGDg
	7P0w2RIA/0IFBC53bhpEOYUg9ljYLNuHbbm5VpP6ZarvIZSGwHeYJ451lquP8XK9w72TXDNFnN4cG
	ZKewaF4jrzm/LYtpLfJv7QU8qBjsOnB/zn9nhCTKuelR/ncnA0FfAj2ihq6ve8We7pKtJuVmI7MHs
	4Vmm/KgYUgnOjCXGsCNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsBoy-00050w-Hd; Fri, 08 Feb 2019 19:28:20 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsBov-000501-1e
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 19:28:18 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gsBom-0001wK-R1; Fri, 08 Feb 2019 20:28:09 +0100
Date: Fri, 8 Feb 2019 20:28:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190208173539.GD24375@fuggles.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_112817_235196_89DD0CEA 
X-CRM114-Status: GOOD (  19.75  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Will,

On Fri, 8 Feb 2019, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> > Anyway, moving the counter read into the protected region is a little fiddly
> > because the memory barriers we have in there won't give us the ordering we
> > need. We'll instead need to do something nasty, like create a dependency
> > from the counter read to the read of the seqlock:
> > 
> > Maybe the untested crufty hack below, although this will be a nightmare to
> > implement in C.
> 
> We discussed this in person this week, but you couldn't recall the details
> off the top of your head so I'm replying here. Please could you clarify what
> your concern was with the existing code, and whether or not I've got the
> wrong end of the stick?

If you just collect the variables under the seqcount protection and have
the readout of the timer outside of it then you are not guaranteeing
consistent state.

The problem is:

	do {
		seq = read_seqcount_begin(d->seq);
		last = d->cycle_last;
		mult = d->mult;
		shift = d->shift;
		ns = d->ns_base;
	while (read_seqcount_retry(d->seq, seq));

	ns += ((read_clock() - last) * mult);
	ns >>= shift;

So on the first glance this looks consistent because you collect all data
and then do the read and calc outside the loop.

But if 'd->mult' gets updated _before_ read_clock() then you can run into a
situation where time goes backwards with the next read.

Here is the flow you need for that:

t1 = gettime()
     {
	collect_data()

     ---> Interrupt, updates mult (mult becomes smaller)

     	  This can expand over a very long time when the task is scheduled
     	  out here and there are multiple updates in between. The farther
     	  out the read is delayed, the more likely the problem is going to
     	  observable.

     	read_clock_and_calc()
     }

t2 = gettime()
     {
	collect_data()
     	read_clock_and_calc()
     }

This second read uses updated data, i.e. the smaller mult. So depending on
the distance of the two reads and the difference of the mult, the caller
can observe t2 < t1, which is a NONO. You can observe it on a single
CPU. No virt, SMP, migration needed at all.

Thanks,

	tglx


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
