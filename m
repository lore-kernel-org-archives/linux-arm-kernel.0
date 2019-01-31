Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD06C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1C3218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJhcYJ6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1C3218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ufPqBuvknJ68SQ5HBKufalPp7+JzR3WtBtRhQvQQlHE=; b=AJhcYJ6/4iG3YI
	bQY5aJUKh1yzH6XilE/GWSZLRTpXPKolGpgnyjVpP/uvDCCTK7IzruyxvSzfv0Idah78Pgykyke0C
	TrovHdkXjKf5KHMAw2fhchbkw+7/tDq4OSHT8+0qnZUlir0nQ/3NBxhi78YgzjB6C8kN5UQ0d8t/+
	KyRCZAbB5mZJQuMVDZzTM82ilb+RbWIEqMGPf9VFV0jPfwNAcR2v0Hhbr5oEVkXZC4rHDezJzCr1l
	Sq/EoahXhS1YJutZ+fYQCsH0rh5ibMjO/BEe4oKrtj1rRhHcaF1/Yy56LEn1O+O/mttjMnxIKKkXI
	gDpHXsX7tDOSHQCltJUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFn7-0005PZ-Sf; Thu, 31 Jan 2019 17:06:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFn3-0005Nq-P9
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:06:16 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2FC42CD7E3;
 Thu, 31 Jan 2019 17:06:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E2AE18A50;
 Thu, 31 Jan 2019 17:06:11 +0000 (UTC)
Date: Thu, 31 Jan 2019 18:06:09 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190131170609.3e7pvmyrcsm2xgq2@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-3-christoffer.dall@arm.com>
 <20190129160347.fcbry76igwyatqzx@kamzik.brq.redhat.com>
 <20190130093431.GE13482@e113682-lin.lund.arm.com>
 <20190130152721.7fbiza3glifvzlqk@kamzik.brq.redhat.com>
 <20190131074353.GI13482@e113682-lin.lund.arm.com>
 <20190131101254.rh23ntvwxtq3yqsz@kamzik.brq.redhat.com>
 <20190131115156.GP13482@e113682-lin.lund.arm.com>
 <20190131125712.pwupvf4favbqi6hu@kamzik.brq.redhat.com>
 <b356cded-fc12-d996-a860-1ef94b6a8ffb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b356cded-fc12-d996-a860-1ef94b6a8ffb@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 31 Jan 2019 17:06:13 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_090613_871482_069B44AE 
X-CRM114-Status: GOOD (  23.80  )
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
Cc: kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 02:52:11PM +0000, Marc Zyngier wrote:
> On 31/01/2019 12:57, Andrew Jones wrote:
> > On Thu, Jan 31, 2019 at 12:51:56PM +0100, Christoffer Dall wrote:
> 
> [...]
> 
> >> I don't think there's anything very unconventional here.
> > 
> > Normally if a thread observes a change to vcpu->requests, then we ensure a
> > change to some accompanying data is also observable. We're reversing that
> > here, which adds a need for additional barriers and a strict request
> > checking order.
> > 
> >>
> >> Let's try this:  If you have a better way of implementing this, how
> >> about you write a patch?
> > 
> > It would just be this patch minus the unnecessary barriers. I can send it
> > if you like, but I wouldn't want to change the authorship for such a small
> > change.
> 
> Having these barriers makes it explicit (at least to me) what data we
> expect to be visible in other threads and in which order. You keep
> saying that order doesn't matter and we disagree on this. Yes, you've
> listed cases where we can survive things coming in out of order, but
> that's not a proof that we don't need them.
> 
> So at the end of the day, and unless you can prove that the barriers are
> not necessary by providing the same form of validation tool, I'm
> inclined to go with the verified approach.

I don't know how to compile and run the litmus test, but I'd be happy to
try if given some pointers. If I did know how, I would add vcpu->mode to
the P1 inputs and some additional lines that look similar to what's in
"Ensuring Requests Are Seen" of Documentation/virtual/kvm/vcpu-requests.rst
Even without the litmus test please allow me to try again to describe why
I think the barriers may be removed.

Any vcpu we're attempting to power on must be on its way to sleep with a
SLEEP request, or already be sleeping. This means that it's outside guest
mode, or will be shortly. If the vcpu observes power_off=false in
vcpu_req_sleep(), whether it was awaken or never even got to sleep, we
know that observation is taking place with vcpu->mode != IN_GUEST_MODE.

We now no longer need to be concerned with the relationship between
power_off and the RESET vcpu request. Now we just need to be certain
that if another thread made a RESET vcpu request at some point since
the powering off of the vcpu (the requesting for it to sleep), then
there's no way to miss the reset request before the vcpu reenters guest
mode. And of that we are certain.

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
