Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4846D20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHElCv2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4846D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vI4m8dpHuhnGOjCUNLS66rzPB2jUOYp/33FPowtJz4A=; b=KHElCv2qbdMDkM
	mNCSCeVEYhKq+01ujq2IcTRPmdcpRpvgVJPXNtQP3mFlvuiGRmggv62eWbgRyiDjMzdsEshRg4CV+
	PnK24UhV24dzSz88fqDMuSVoLZlX2LEE8HtWDR5lQHdJDcX/MRp6FAC4gL05H3aA/YIFFxoE5ZSq3
	afQph6pGCkhPBHTasCgBoqwkIJ9g16DHsW6S5a/89ihoxfKiVeH7Ef+6NzxyFmTD2YMJUJw/hKB3D
	IEFDdDo//fQ3Gi4g7w0kOc7FGC32nSA2FRxGY+HEBky2jSKmMzJRqLfC8z3r1OqhKk3e0vUkN//Ji
	s8hJGrhk/hlFdddqEw0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwR1-0007WX-JJ; Tue, 08 Jan 2019 18:49:07 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwQw-0007W7-MF; Tue, 08 Jan 2019 18:49:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1C99320289CC1; Tue,  8 Jan 2019 19:49:01 +0100 (CET)
Date: Tue, 8 Jan 2019 19:49:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20190108184901.GA1900@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
 <20190108104841.GD6808@hirez.programming.kicks-ass.net>
 <7300f0af-b532-5546-a6f4-fec69cb91a0f@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7300f0af-b532-5546-a6f4-fec69cb91a0f@oracle.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Shawn Guo <shawnguo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrew Murray <andrew.murray@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 jgross@suse.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 11:36:33AM -0500, Boris Ostrovsky wrote:
> On 1/8/19 5:48 AM, Peter Zijlstra wrote:

> > On the various exclude options; they are as follows (IIUC):
> >
> >   - exclude_guest: we're a HV/host-kernel and we don't want the counter
> >                    to run when we run a guest context.
> >
> >   - exclude_host: we're a HV/host-kernel and we don't want the counter
> >                   to run when we run in host context.
> >
> >   - exclude_hv: we're a guest and don't want the counter to run in HV
> >                 context.
> >
> > Now, KVM always implies exclude_hv afaict (for guests), I'm not sure
> > what, if anything Xen does on x86 (IIRC Brendan Gregg once said perf
> > works on Xen) -- nor quite sure who to ask, Boris, Jeurgen?
> 
> perf does work inside guests.
> 
> VPMU is managed by the Xen and it presents to the guest only samples
> that are associated with the guest. So from that perspective exclude_hv
> doesn't seem to be needed.
> 
> There is a VPMU mode that allows profiling whole system (host and
> guests) from dom0, and this where exclude_hv might be useful. But this
> mode, ahem, needs some work.

Thanks Boris!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
