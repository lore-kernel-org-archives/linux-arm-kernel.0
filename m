Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27831C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9E02084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hs+l42QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9E02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yT8dnWEJIqJDyrIiGx7hTZnDuCpQd7uHPx+HLiZ+IgA=; b=Hs+l42QDm3HBeE
	Qc4gTBFUiCaV58HGe9jOAVvmXLvL+QskqZBmOX+/levgyS0ZKfPEbn/wP+DabVsbcg/m1ffWM59HH
	oJD7iAHTfFOXtnYDJZMSrIegQFHX2zgcXSGgcj5KoMlBaMBhN++IojuFzUcrB29pYXhIcBQ5B6FBO
	2YLg8pa8MUru2o7EY7SNFXtWbfkFj4KUDCbEgekw+DEFXaumw/IlPvDGAfbEKimHvBEyjo9uKjD6l
	rY9Mra1h9bujLRNH7K1E1Tm/EWtdUBuM270+rnIcStmRe4P/rCtMbPm7PXopL1pErYJxPFJvjjGHG
	g/RAvVkguFByQPrYefKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goruN-00077Y-RD; Wed, 30 Jan 2019 15:36:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goruK-00077D-K2
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:36:10 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37F4981F13;
 Wed, 30 Jan 2019 15:36:08 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFE6D100164E;
 Wed, 30 Jan 2019 15:36:06 +0000 (UTC)
Date: Wed, 30 Jan 2019 16:36:04 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 5/5] arm/arm64: KVM: Don't panic on failure to properly
 reset system registers
Message-ID: <20190130153604.l3ro4gdfsot2glnb@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-6-christoffer.dall@arm.com>
 <20190129163337.nbwivspcvlcmzrmo@kamzik.brq.redhat.com>
 <b2c0fa37-37ad-3696-e862-5d0434496d1f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2c0fa37-37ad-3696-e862-5d0434496d1f@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 30 Jan 2019 15:36:08 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_073608_739558_93930705 
X-CRM114-Status: GOOD (  23.73  )
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

On Wed, Jan 30, 2019 at 10:56:19AM +0000, Marc Zyngier wrote:
> On 29/01/2019 16:33, Andrew Jones wrote:
> > On Fri, Jan 25, 2019 at 10:46:56AM +0100, Christoffer Dall wrote:
> >> From: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> Failing to properly reset system registers is pretty bad. But not
> >> quite as bad as bringing the whole machine down... So warn loudly,
> >> but slightly more gracefully.
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> >> ---
> >>  arch/arm/kvm/coproc.c     | 4 ++--
> >>  arch/arm64/kvm/sys_regs.c | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> >> index 222c1635bc7a..e8bd288fd5be 100644
> >> --- a/arch/arm/kvm/coproc.c
> >> +++ b/arch/arm/kvm/coproc.c
> >> @@ -1450,6 +1450,6 @@ void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
> >>  	reset_coproc_regs(vcpu, table, num);
> >>  
> >>  	for (num = 1; num < NR_CP15_REGS; num++)
> >> -		if (vcpu_cp15(vcpu, num) == 0x42424242)
> >> -			panic("Didn't reset vcpu_cp15(vcpu, %zi)", num);
> >> +		WARN(vcpu_cp15(vcpu, num) == 0x42424242,
> >> +		     "Didn't reset vcpu_cp15(vcpu, %zi)", num);
> >>  }
> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index 86096774abcd..4f067545c7d2 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -2609,6 +2609,6 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
> >>  	reset_sys_reg_descs(vcpu, table, num);
> >>  
> >>  	for (num = 1; num < NR_SYS_REGS; num++)
> >> -		if (__vcpu_sys_reg(vcpu, num) == 0x4242424242424242)
> >> -			panic("Didn't reset __vcpu_sys_reg(%zi)", num);
> >> +		WARN(__vcpu_sys_reg(vcpu, num) == 0x4242424242424242,
> >> +		     "Didn't reset __vcpu_sys_reg(%zi)\n", num);
> >>  }
> >> -- 
> >> 2.18.0
> >>
> > 
> > If we only get halfway through resetting, then we'll get a warn splat,
> > complete with a backtrace, for each register. Should we do something
> > like the following instead?
> > 
> >   for (num = 1; num < NR_SYS_REGS; num++)
> >      if (__vcpu_sys_reg(vcpu, num) == 0x4242424242424242)
> >         failed++;
> >   WARN(failed, "Didn't reset %d system registers", failed);
> 
> And doing so we'd loose the important bit of information, which is the
> position in the table that doesn't get initialized.
> 
> The vcpu reset issue is rare enough that nobody noticed it yet (I only
> reproduced it twice), and having it to scream 200 times is not really a
> concern. What I want to catch is the case where someone has added a new
> sysreg in the table, and has failed to provide a working init function.

OK, Christoffer also said that information was useful. Would any following
registers also be useful? Or should it be something like

  for (num = 1; num < NR_SYS_REGS; num++) {
       WARN(__vcpu_sys_reg(vcpu, num) == 0x4242424242424242,
            "Didn't reset __vcpu_sys_reg(%zi)\n", num);
       break;
   }

to ensure the first one, the most important one, is there, and that it
doesn't get pushed out of the buffer by hundreds of more lines?

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
