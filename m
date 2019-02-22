Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051DE2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qMdk3bKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051DE2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+dlunk9/iFgZ/Q6xfoLPHnPm4PzoBcp0ecJwSF3g/ew=; b=qMdk3bKbCP8b4o
	tcouClPO+fb0LXj+JpayfzLmoWEXhwOBCzewmnJq/3jzlhxoO8iyu7YbGYD9TPGaj/1kHQT74ZzzT
	A8KTl5JkbaFHaQ2oiyUhH0eW5TmYKx8bViEn/lgAGmOjBAPk4oyi1kVuIH7CTC1ldccAcfLtdSo92
	LMBySKGrZh6+/CL6WcHRbil4WJanGa1hbMKITu506W53Ykrv4oBl367rGlCCObixTgzY04RpK3OTa
	OuScqOOhbbz3Uh8jxUvYCWhaQNhR63T/OJ/aQXgr9App8Hfyt3l5HMjjQJgKeg+/Yaa5tMqSmfnGw
	wNFBwj8La9ePCArcob3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9ij-0001i3-Q0; Fri, 22 Feb 2019 12:14:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9ig-0001hk-QY
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:14:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DD9A78;
 Fri, 22 Feb 2019 04:14:22 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB15A3F690;
 Fri, 22 Feb 2019 04:14:20 -0800 (PST)
Date: Fri, 22 Feb 2019 12:14:16 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH 06/14] KVM: arm/arm64: Factor out VMID into struct kvm_vmid
Message-ID: <20190222121416.6ec76543@why.wild-wind.fr.eu.org>
In-Reply-To: <44bd2df6-8011-c77f-a83a-95c3529287c0@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-7-christoffer.dall@arm.com>
 <1978ee57-c7bd-e55a-4e77-ad0b4b62d1d1@arm.com>
 <20190222091848.21f7f8e6@why.wild-wind.fr.eu.org>
 <44bd2df6-8011-c77f-a83a-95c3529287c0@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_041422_866384_504392D1 
X-CRM114-Status: GOOD (  21.08  )
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 11:42:46 +0000
Julien Grall <julien.grall@arm.com> wrote:

> Hi Marc,
> 
> On 22/02/2019 09:18, Marc Zyngier wrote:
> > On Thu, 21 Feb 2019 11:02:56 +0000
> > Julien Grall <Julien.Grall@arm.com> wrote:
> > 
> > Hi Julien,
> >   
> >> Hi Christoffer,
> >>
> >> On 24/01/2019 14:00, Christoffer Dall wrote:  
> >>> Note that to avoid mapping the kvm_vmid_bits variable into hyp, we
> >>> simply forego the masking of the vmid value in kvm_get_vttbr and rely on
> >>> update_vmid to always assign a valid vmid value (within the supported
> >>> range).  
> >>
> >> [...]
> >>  
> >>> -	kvm->arch.vmid = kvm_next_vmid;
> >>> +	vmid->vmid = kvm_next_vmid;
> >>>    	kvm_next_vmid++;
> >>> -	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
> >>> -
> >>> -	/* update vttbr to be used with the new vmid */
> >>> -	pgd_phys = virt_to_phys(kvm->arch.pgd);
> >>> -	BUG_ON(pgd_phys & ~kvm_vttbr_baddr_mask(kvm));
> >>> -	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
> >>> -	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
> >>> +	kvm_next_vmid &= (1 << kvm_get_vmid_bits()) - 1;  
> >>
> >> The arm64 version of kvm_get_vmid_bits does not look cheap. Indeed it required
> >> to read the sanitized value of SYS_ID_AA64MMFR1_EL1 that is implemented using
> >> the function bsearch.
> >>
> >> So wouldn't it be better to keep kvm_vmid_bits variable for use in update_vttbr()?  
> > 
> > How often does this happen? Can you measure this overhead at all?
> > 
> > My understanding is that we hit this path on rollover only, having IPIed
> > all CPUs and invalidated all TLBs. I seriously doubt you can observe
> > any sort of overhead at all, given that it is so incredibly rare. But
> > feel free to prove me wrong!  
> 
> That would happen on roll-over and the first time you allocate VMID for the VM.
> 
> I am planning to run some test with 3-bit VMIDs and provide them next week.

Sure, but who implements 3 bit VMIDs? I'm only interested in
performance on real HW, and the minimal implementation allowed is
8bits.

So don't bother testing this with such contrived conditions. Test it
for real, on a system that can run enough stuff concurrently to quickly
exhaust its VMID space and provoke rollovers.

Alternatively, measure the time it takes to create a single VM that
exits immediately. On its own, that'd be a useful unit test for
extremely short-lived VMs.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
