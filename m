Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3EBC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:22:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936A920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WbLMkS+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PhIvqUVjSjkVIn/CMiNm3+1EWfRMIhJ+iJxig48VFFs=; b=WbLMkS+t6Dse/N
	B5G9dXj4Htpf5+4JSMyPPz6GmwnWAP48vAdMrqFmKfRX53anZQt5a7jWUMMKMPffxYuyJpKYwQT2s
	5HNJ+78JzyRrtshfj6LnvDMwZyDlVaITK3y5yCGiY8heKKykGSg8DtX2NbfZnsMSfa1i5TxWDplea
	miMRT7eauqexJV0ccd6K8+FMbT4xnLFrlYwWdliHLc4NrrRrx3M0qctiD5Owrr4U64yGJ4b9KCvH9
	3sEvLy8H0fPH/s2yG+tMmjj8O6O/zEBEawwYZOByE7nSAGV6uHUJ36Xziuo6H4T2Ag4FIw3Kl2Wmz
	kYmjtgiYJ1h5v8/nNGww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom4f-0000x5-NO; Wed, 30 Jan 2019 09:22:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom4X-0000qq-1G
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:22:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7BA9A78;
 Wed, 30 Jan 2019 01:22:14 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3824A3F557;
 Wed, 30 Jan 2019 01:22:14 -0800 (PST)
Date: Wed, 30 Jan 2019 10:22:12 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/5] KVM: arm/arm64: Reset the VCPU without preemption
 and vcpu state loaded
Message-ID: <20190130092212.GD13482@e113682-lin.lund.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-2-christoffer.dall@arm.com>
 <20190129154858.docsos3ncoyuld7m@kamzik.brq.redhat.com>
 <867eenv48q.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <867eenv48q.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_012217_190314_749C1BC2 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: Andrew Jones <drjones@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 04:05:25PM +0000, Marc Zyngier wrote:
> Hi Drew,
> 
> On Tue, 29 Jan 2019 15:48:58 +0000,
> Andrew Jones <drjones@redhat.com> wrote:
> > 
> > Hi Christoffer,
> > 
> > On Fri, Jan 25, 2019 at 10:46:52AM +0100, Christoffer Dall wrote:
> > > Resetting the VCPU state modifies the system register state in memory,
> > > but this may interact with vcpu_load/vcpu_put if running with preemption
> > > disabled, which in turn may lead to corrupted system register state.
> >   ^ enabled
> > > 
> > > Address this by disabling preemption and doing put/load if required
> > > around the reset logic.
> > 
> > I'm having trouble understanding how disabling preemption helps here.
> > There shouldn't be an issue with the KVM_ARM_VCPU_INIT case, since the
> > target vcpu is guaranteed not to be loaded and therefore it doesn't
> > have preempt notifiers registered either. Also, KVM_ARM_VCPU_INIT holds
> > the vcpu mutex, so there's no chance for a load to occur until it's
> > complete.
> > 
> > For the PSCI case it makes sense to force a vcpu load after the reset,
> > otherwise the sleeping target vcpu won't have the correct state loaded.
> > The initial put also makes sense in case we're not resetting everything.
> > I don't understand how we're ensuring the target vcpu thread's preemption
> > is disabled though. This modified kvm_reset_vcpu would need to be run
> > from the target vcpu thread to work, but that's not how the PSCI code
> > currently does it.
> 
> And that's exactly where we're going with the following patch in the
> series. Ultimately, we need a vcpu to reset itself, as we otherwise
> have a window where a vcpu can be spuriously loaded whilst being
> reset.
> 
FWIW, I think the confusion here comes from having re-ordered the
patches compared to how the commit text was originally written.  We
should probably explain in the commit message that this is in
preparation for doing the reset from the VCPU itself.

Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
