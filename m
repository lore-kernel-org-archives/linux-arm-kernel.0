Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC77C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3662173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDGrIVys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3662173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6rzlA+3Ym6oIpN1EMSBa/YCO3hA24NftsLdPZICUzE=; b=gDGrIVysEH7Zkf
	jzI/aslnLKSsFatMYqvZVUEmX+sm+BMFNdOrsrGV04QmhnSQSzEOmBfkdswuFzeXJ1etVu4khlIJY
	js2fkbym5Jn3FNJ0zWrejsNqPlvbYgWQHt7RT8RQhXCwBck7LJ/VPT425J3nuL9uUnuNzR7EmxYHN
	WKP0y6JLvBG/tLDbQGeKXVQYbJTEHU6hzUq8ucByNRPyMa3MeBQZnau4WjaGH6b8bYsdWjkH3H4/D
	PYwflXvnFgmG6omvxhi8onOBBCagxRZLumX2RMwnf2FRh9XTwQN3cGw7BPW5kKzUgY70hSDz5w4VB
	uWGrahQCTVQ9gcM8W1Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjVZ-0004F9-01; Mon, 18 Feb 2019 14:02:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjVR-0004EM-65
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:02:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30597A78;
 Mon, 18 Feb 2019 06:02:48 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29363F720;
 Mon, 18 Feb 2019 06:02:38 -0800 (PST)
Date: Mon, 18 Feb 2019 14:02:11 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 5/5] KVM: arm/arm64: support chained PMU counters
Message-ID: <20190218140211.066b2d70@why.wild-wind.fr.eu.org>
In-Reply-To: <20190218120305.GH54124@e119886-lin.cambridge.arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-6-git-send-email-andrew.murray@arm.com>
 <11a8c800-5c1d-08ce-9d85-402ca89727a3@arm.com>
 <236797c3-9f3a-91d4-c859-e8eb4d3eb3ee@arm.com>
 <20190218120305.GH54124@e119886-lin.cambridge.arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060249_231971_C20E8286 
X-CRM114-Status: GOOD (  23.86  )
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
Cc: julien.thierry@arm.com, kvmarm@lists.cs.columbia.edu,
 christoffer.dall@arm.com, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 12:03:05 +0000
Andrew Murray <andrew.murray@arm.com> wrote:

> On Thu, Feb 14, 2019 at 11:42:15AM +0000, Suzuki K Poulose wrote:
> > 
> > 
> > On 05/02/2019 14:33, Julien Thierry wrote:  
> > > Hi Andrew,
> > > 
> > > On 04/02/2019 16:53, Andrew Murray wrote:  
> > > > Emulate chained PMU counters by creating a single 64 bit event counter
> > > > for a pair of chained KVM counters.
> > > > 
> > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > > ---
> > > >   include/kvm/arm_pmu.h |   1 +
> > > >   virt/kvm/arm/pmu.c    | 321 +++++++++++++++++++++++++++++++++++++++++---------
> > > >   2 files changed, 269 insertions(+), 53 deletions(-)
> > > > 
> > > > diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> > > > index b73f31b..8e691ee 100644
> > > > --- a/include/kvm/arm_pmu.h
> > > > +++ b/include/kvm/arm_pmu.h
> > > > @@ -29,6 +29,7 @@ struct kvm_pmc {
> > > >   	u8 idx;	/* index into the pmu->pmc array */
> > > >   	struct perf_event *perf_event;
> > > >   	u64 bitmask;
> > > > +	u64 overflow_count;
> > > >   };
> > > >   struct kvm_pmu {
> > > > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > > > index a64aeb2..9318130 100644
> > > > --- a/virt/kvm/arm/pmu.c
> > > > +++ b/virt/kvm/arm/pmu.c
> > > > @@ -24,9 +24,25 @@
> > > >   #include <kvm/arm_pmu.h>
> > > >   #include <kvm/arm_vgic.h>
> > > > +#define ARMV8_PMUV3_PERFCTR_CHAIN 0x1E  
> > > 
> > > I find it a bit awkward to have this redefined here.
> > > 
> > > Maybe we could define a helper in kvm_host.h:
> > > bool kvm_pmu_typer_is_chain(u64 typer);
> > > 
> > > That would always return false for arm32?  
> > 
> > We don't support ARMv7 host, so that doesn't matter. But
> > it is a good idea to wrap it in a function here.  
> 
> I'm not sure kvm_host.h is the right place for this as this really relates
> to the ARM PMU drivers. Seeing that armv8pmu_filter_match in
> arch/arm64/kernel/perf_event.c would also benefit from this new function I'll
> add it to arch/arm64/include/asm/perf_event.h and stub it out in arm_pmu.c
> for the ARM32 case.

Doing that is going to create a dependency with the perf subsystem,
and will need an Ack from the maintainer (Will).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
