Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD80C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06A82084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y8xyqjfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06A82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DAtrjzbcaCkvF8s771kRekJ+0mOd3TT2plkEngoGiZg=; b=Y8xyqjfB72mQ+t
	+xTPnT2wcwrg76Hh2fa23RHBIgUWmVSRM7S6wClWC7468sxKSOOSeTvVbB069YkVLaQ9vlMfZdn2S
	cWGTCB/MCyjgsNgmDgKRvj10+t1D98SNVxaQjoorcltXSwHudnhociH48U+boQuYwHrXS+zqZlUFn
	J4KjBQgxGa4VaOWADcvGW6wZzVoJTTHKmR7nwAioY56+NKUFS2gVtNwsU4euCFE1rKCkyTdwSmw1a
	gcjfHn2Yr36jpJYl3JgwgNPfEP2y+wHfyzKJ6N51Z2tGYYrcV6A/60hBJqxMozJatYHS5nBiy/wSo
	/V6PcE/nr2IZzRfB1xeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTij-0006WT-KA; Fri, 01 Feb 2019 07:58:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTig-0006VO-92
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 07:58:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F00FCA78;
 Thu, 31 Jan 2019 23:58:36 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 615523F71E;
 Thu, 31 Jan 2019 23:58:36 -0800 (PST)
Date: Fri, 1 Feb 2019 08:58:34 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190201075834.GQ13482@e113682-lin.lund.arm.com>
References: <20190125094656.5026-3-christoffer.dall@arm.com>
 <20190129160347.fcbry76igwyatqzx@kamzik.brq.redhat.com>
 <20190130093431.GE13482@e113682-lin.lund.arm.com>
 <20190130152721.7fbiza3glifvzlqk@kamzik.brq.redhat.com>
 <20190131074353.GI13482@e113682-lin.lund.arm.com>
 <20190131101254.rh23ntvwxtq3yqsz@kamzik.brq.redhat.com>
 <20190131115156.GP13482@e113682-lin.lund.arm.com>
 <20190131125712.pwupvf4favbqi6hu@kamzik.brq.redhat.com>
 <b356cded-fc12-d996-a860-1ef94b6a8ffb@arm.com>
 <20190131170609.3e7pvmyrcsm2xgq2@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131170609.3e7pvmyrcsm2xgq2@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_235838_327046_66362DD7 
X-CRM114-Status: GOOD (  27.26  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 06:06:09PM +0100, Andrew Jones wrote:
> On Thu, Jan 31, 2019 at 02:52:11PM +0000, Marc Zyngier wrote:
> > On 31/01/2019 12:57, Andrew Jones wrote:
> > > On Thu, Jan 31, 2019 at 12:51:56PM +0100, Christoffer Dall wrote:
> > 
> > [...]
> > 
> > >> I don't think there's anything very unconventional here.
> > > 
> > > Normally if a thread observes a change to vcpu->requests, then we ensure a
> > > change to some accompanying data is also observable. We're reversing that
> > > here, which adds a need for additional barriers and a strict request
> > > checking order.
> > > 
> > >>
> > >> Let's try this:  If you have a better way of implementing this, how
> > >> about you write a patch?
> > > 
> > > It would just be this patch minus the unnecessary barriers. I can send it
> > > if you like, but I wouldn't want to change the authorship for such a small
> > > change.
> > 
> > Having these barriers makes it explicit (at least to me) what data we
> > expect to be visible in other threads and in which order. You keep
> > saying that order doesn't matter and we disagree on this. Yes, you've
> > listed cases where we can survive things coming in out of order, but
> > that's not a proof that we don't need them.
> > 
> > So at the end of the day, and unless you can prove that the barriers are
> > not necessary by providing the same form of validation tool, I'm
> > inclined to go with the verified approach.
> 
> I don't know how to compile and run the litmus test, but I'd be happy to
> try if given some pointers.

You can look in tools/memory-model/README as a start.


> If I did know how, I would add vcpu->mode to
> the P1 inputs and some additional lines that look similar to what's in
> "Ensuring Requests Are Seen" of Documentation/virtual/kvm/vcpu-requests.rst
> Even without the litmus test please allow me to try again to describe why
> I think the barriers may be removed.
> 
> Any vcpu we're attempting to power on must be on its way to sleep with a
> SLEEP request, or already be sleeping. This means that it's outside guest
> mode, or will be shortly. If the vcpu observes power_off=false in
> vcpu_req_sleep(), whether it was awaken or never even got to sleep, we
> know that observation is taking place with vcpu->mode != IN_GUEST_MODE.
> 
> We now no longer need to be concerned with the relationship between
> power_off and the RESET vcpu request. 

I disagree.  That argument requires more explanation.

If you set power_off = false before posting the reset
request, then if the VCPU thread is awoken (for any reason) it can run
the VCPU without observing the reset request and that's the problem.

If you are making assumptions about only being woken up as a result of a
reset request, or the interaction with the pause flag, or setting the
sleep request to prevent the guest from executing again, that is a more
complex argument (which you haven't made yet!) and I add that it's a
brittle construction.

What we have here are three pieces of state:

  reset_state->reset
  vcpu->requests
  vcpu->arch.power_state

They must be written to, and the writes must be observed, in that
particular order without any additional assumptions.

You keep arguing that you can enforce an ordering between these three
states with a single barrier which is clearly not possible.

So this boils down to you making additional assumptions (see above,
brittle) without explaining what they are.  I suspect you want this to
fit in your mental model of how vcpu requests solve the world, otherwise
I'm not sure what your concern with this patch, which we all agree is
correct, really is.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
