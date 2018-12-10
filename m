Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59446C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:50:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA4420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+EpOkrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA4420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9yEL6+/bM60dn62oZaF58CMut1TssnkkPwBoEO1DUKo=; b=R+EpOkrFhw8iLZ
	XQjPZFz7X0x02AKcZ7HIHP54DBY9sb196viCHxFCM6yB5CTwXVKoBaGnCFsWprx1gAbgZFIeYcc6I
	b9yEgn9QsfsPOsSlEX8W4IdNPwXL/wnokOA7rLcaRoEDzymOJUKeK19XL7d4Js4h8BKLQtlaom2uj
	3PAEA8EsK+HmfNkwmxreaw8Oo3FnjsETKyrUuM98h2tH4dND92KqyHOsu68qgXT5cCH8qP2UAxZAr
	+U6aTQXJJT3c4C/TqriWFhSFDV7UgSRvDwnQKvtQdZQUyRi0VtrFHzYssZlFM1RPjW5vo1GnLNd89
	Yfu+JWrM3FkQANgjQg5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK54-0008KB-AO; Mon, 10 Dec 2018 11:50:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK51-0008J1-DS
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:50:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B54E15AD;
 Mon, 10 Dec 2018 03:50:24 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0C2F3F6A8;
 Mon, 10 Dec 2018 03:50:23 -0800 (PST)
Date: Mon, 10 Dec 2018 12:50:21 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 7/8] arm64: KVM: Handle ARM erratum 1165522 in TLB
 invalidation
Message-ID: <20181210115021.GO30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-8-marc.zyngier@arm.com>
 <20181210101912.GK30263@e113682-lin.lund.arm.com>
 <50e6a07d-868b-db43-fd4e-4b6359a5128e@arm.com>
 <c71d902b-c748-770a-5e6e-f33a204dcb8d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c71d902b-c748-770a-5e6e-f33a204dcb8d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035031_460312_45545313 
X-CRM114-Status: GOOD (  20.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 11:15:00AM +0000, James Morse wrote:
> Hi Marc, Christoffer,
> 
> On 10/12/2018 10:46, Marc Zyngier wrote:
> > On 10/12/2018 10:19, Christoffer Dall wrote:
> >> On Thu, Dec 06, 2018 at 05:31:25PM +0000, Marc Zyngier wrote:
> >>> In order to avoid TLB corruption whilst invalidating TLBs on CPUs
> >>> affected by erratum 1165522, we need to prevent S1 page tables
> >>> from being usable.
> >>>
> >>> For this, we set the EL1 S1 MMU on, and also disable the page table
> >>> walker (by setting the TCR_EL1.EPD* bits to 1).
> >>>
> >>> This ensures that once we switch to the EL1/EL0 translation regime,
> >>> speculated AT instructions won't be able to parse the page tables.
> 
> >>> @@ -64,11 +93,18 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
> >>>  	write_sysreg(0, vttbr_el2);
> >>>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> >>>  	isb();
> >>> -	local_irq_restore(flags);
> >>> +
> >>> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
> >>> +		/* Restore the guest's registers to what they were */
> >>
> >> host's ?
> > 
> > Hum... Yes, silly thinko.
> 
> I thought these were the guests registers because they are EL1 registers and
> this is a VHE-only path.
> 'interrupted guest' was how I read this. This stuff can get called if memory is
> allocated for guest-A while a vcpu is loaded, and reclaims memory from guest-B
> causing an mmu-notifier call for stage2. This is why we have to put guest-A's
> registers back as we weren't pre-empted, and we expect EL1 to be untouched.
> 
> I agree they could belong to no-guest if a vcpu isn't loaded at all... is host
> the term used here?
> 

Ah, you're right.  Host is not the right term either.

I haven't done the call path analysis, so not sure about all the
possible contexts where all this can be called, but if it's really truly
only in guest context, then we don't need to save the values to a
temporary struct at all, but can save them on the vcpu.

We can also just side-step the whole thing and just say "Restore the
registers to what they were".


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
