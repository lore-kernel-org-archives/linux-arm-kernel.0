Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5314C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E0C2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P7KzYXN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E0C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I8FLw1dsRZ1r4jh+Vu/nbGKtYItSOee41r+hnXb8b2k=; b=P7KzYXN/ncyXie
	BFSNvQCq4rAlVoZdrepzicWGnf4a0DgoP4kViuKTbWHxuYpyOa9tLpZOPMzdhPLPg8eFtNjHK1NVo
	tI4xxtJSOIavV+aWEJAe5Y3xMNtEPfHi6jU/vJa39aLWjmeptdprq7auIQmLPV9tvzG+XFEr1RyNO
	aA6SoxHRt4G7lB5xBLHLQA8olwxDkf4GV4e4QVxzWwkv5GIUmWPerWMIihfsQWnFiIiwrHZTlW5TT
	V2ou4a2zy8ueEMoOF+nu3oxUfs/LzzqYNO3Cl44KLSEzmDyXpwAOQeGEXEPArsWaHKWtCmGc5IKrX
	oMT1XZRPISt2KC7lfuWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfrv-0000XW-L5; Mon, 04 Feb 2019 15:09:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfrr-0000Wl-DI
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:09:05 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7C1783F40;
 Mon,  4 Feb 2019 15:09:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 649FB101963B;
 Mon,  4 Feb 2019 15:09:00 +0000 (UTC)
Date: Mon, 4 Feb 2019 16:08:57 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190204150857.wea2t5z7ogt7bdgq@kamzik.brq.redhat.com>
References: <20190129160347.fcbry76igwyatqzx@kamzik.brq.redhat.com>
 <20190130093431.GE13482@e113682-lin.lund.arm.com>
 <20190130152721.7fbiza3glifvzlqk@kamzik.brq.redhat.com>
 <20190131074353.GI13482@e113682-lin.lund.arm.com>
 <20190131101254.rh23ntvwxtq3yqsz@kamzik.brq.redhat.com>
 <20190131115156.GP13482@e113682-lin.lund.arm.com>
 <20190131125712.pwupvf4favbqi6hu@kamzik.brq.redhat.com>
 <b356cded-fc12-d996-a860-1ef94b6a8ffb@arm.com>
 <20190131170609.3e7pvmyrcsm2xgq2@kamzik.brq.redhat.com>
 <20190201075834.GQ13482@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201075834.GQ13482@e113682-lin.lund.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 15:09:02 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_070903_494212_D195662E 
X-CRM114-Status: GOOD (  38.37  )
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

On Fri, Feb 01, 2019 at 08:58:34AM +0100, Christoffer Dall wrote:
> On Thu, Jan 31, 2019 at 06:06:09PM +0100, Andrew Jones wrote:
> > On Thu, Jan 31, 2019 at 02:52:11PM +0000, Marc Zyngier wrote:
> > > On 31/01/2019 12:57, Andrew Jones wrote:
> > > > On Thu, Jan 31, 2019 at 12:51:56PM +0100, Christoffer Dall wrote:
> > > 
> > > [...]
> > > 
> > > >> I don't think there's anything very unconventional here.
> > > > 
> > > > Normally if a thread observes a change to vcpu->requests, then we ensure a
> > > > change to some accompanying data is also observable. We're reversing that
> > > > here, which adds a need for additional barriers and a strict request
> > > > checking order.
> > > > 
> > > >>
> > > >> Let's try this:  If you have a better way of implementing this, how
> > > >> about you write a patch?
> > > > 
> > > > It would just be this patch minus the unnecessary barriers. I can send it
> > > > if you like, but I wouldn't want to change the authorship for such a small
> > > > change.
> > > 
> > > Having these barriers makes it explicit (at least to me) what data we
> > > expect to be visible in other threads and in which order. You keep
> > > saying that order doesn't matter and we disagree on this. Yes, you've
> > > listed cases where we can survive things coming in out of order, but
> > > that's not a proof that we don't need them.
> > > 
> > > So at the end of the day, and unless you can prove that the barriers are
> > > not necessary by providing the same form of validation tool, I'm
> > > inclined to go with the verified approach.
> > 
> > I don't know how to compile and run the litmus test, but I'd be happy to
> > try if given some pointers.
> 
> You can look in tools/memory-model/README as a start.

Thanks. Neat tool.

> 
> 
> > If I did know how, I would add vcpu->mode to
> > the P1 inputs and some additional lines that look similar to what's in
> > "Ensuring Requests Are Seen" of Documentation/virtual/kvm/vcpu-requests.rst
> > Even without the litmus test please allow me to try again to describe why
> > I think the barriers may be removed.
> > 
> > Any vcpu we're attempting to power on must be on its way to sleep with a
> > SLEEP request, or already be sleeping. This means that it's outside guest
> > mode, or will be shortly. If the vcpu observes power_off=false in
> > vcpu_req_sleep(), whether it was awaken or never even got to sleep, we
> > know that observation is taking place with vcpu->mode != IN_GUEST_MODE.
> > 
> > We now no longer need to be concerned with the relationship between
> > power_off and the RESET vcpu request. 
> 
> I disagree.  That argument requires more explanation.
> 
> If you set power_off = false before posting the reset
> request, then if the VCPU thread is awoken (for any reason) it can run
> the VCPU without observing the reset request and that's the problem.
> 
> If you are making assumptions about only being woken up as a result of a
> reset request, or the interaction with the pause flag, or setting the
> sleep request to prevent the guest from executing again, that is a more
> complex argument (which you haven't made yet!) and I add that it's a
> brittle construction.

Yes, I was attempting to integrate more of the expected state of the
is / will be sleeping vcpu into the analysis. I was hoping that it was
provable to make stronger statements about the use of vcpu requests.
I failed to do so though, both with logical arguments and I couldn't
come up with a way to model outside-guest mode with the litmus test.

> 
> What we have here are three pieces of state:
> 
>   reset_state->reset
>   vcpu->requests
>   vcpu->arch.power_state
> 
> They must be written to, and the writes must be observed, in that
> particular order without any additional assumptions.
> 
> You keep arguing that you can enforce an ordering between these three
> states with a single barrier which is clearly not possible.

There's also the mode state and barriers in place that ensure the order
of observation for that and requests, but as I said I couldn't model it
well enough to prove anything.

> 
> So this boils down to you making additional assumptions (see above,
> brittle) without explaining what they are.  I suspect you want this to
> fit in your mental model of how vcpu requests solve the world, otherwise
> I'm not sure what your concern with this patch, which we all agree is
> correct, really is.

Well, I don't expect the vcpu requests to solve the world (if only!),
but I was hoping that they could be used with a simpler pattern. I.e.
on the sending side the vcpu request is fired off (probably with a kick
too) and then forgotten. On the receiving side path only a check and
handler need to be added, with no concern for the order of the handlers
nor of other data that we cannot observe without also observing the
request. I surrender though, because I do agree there's nothing wrong
with the additional barriers in this patch, only that it no longer fits
my opinion of the simplest pattern.

Anyway, thanks for your patience and sorry for the noise.

drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
