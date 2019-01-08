Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32474C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:25:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06C22183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r2F16O4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06C22183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RlgZyZ92G16T2gdlxV+uREp0QsjCzudcj6l5G817MQc=; b=r2F16O4gDPvfcH
	eW6CJEeDAFtwJ4yZjm1EDERsbFTBi1TJRwI8NyapprU9x51/oQ3aSir3LvojsCQrRV4g5sEu2+u0l
	t176eLz8aXK8K9eb638GScteLqJPQECPOKnMyDXHLSIKWoB1PT5SfmUUb/Ai7oFepK6slPrf7WoUf
	1fjexgM/X2X+akuOCaiZcGOVrUpzpq4dBrH+USn2wa0mTE7MqCUjy+fCq1bFCu3hUl3Xyz0INiD+X
	p+JN0Y1/ngB6de217PgAao8GH8FCV9brKwfaHdtCPvzeBcLgkmrwSKj2wcNuRXOErW6DMUt9pwHFL
	KF9S6vIsmyN6N4mwrN1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggi0h-00031R-ST; Tue, 08 Jan 2019 03:24:59 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggi0d-0002wz-0P; Tue, 08 Jan 2019 03:24:56 +0000
X-UUID: 0a9e92548b5d4b8b96e1180a2473b149-20190107
X-UUID: 0a9e92548b5d4b8b96e1180a2473b149-20190107
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1237339222; Mon, 07 Jan 2019 19:24:46 -0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:24:45 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 11:24:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 11:24:43 +0800
Message-ID: <1546917883.6754.8.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
From: Miles Chen <miles.chen@mediatek.com>
To: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 8 Jan 2019 11:24:43 +0800
In-Reply-To: <20190107150019.GC46743@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
 <20190107150019.GC46743@lakrids.cambridge.arm.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CF316DC2706CB07A686B9BCABA81EC80B486DB3C62FD6C297DC7DBA4C053A0FD2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_192455_055926_E2AF89B3 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: wsd_upstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > Current __virt_to_phys() only print warning messages for non-linear
> > addresses. It's hard to catch all warnings by those messages.
> 
> Why? Are you seeing a large number of warnings somewhere?

Official kernel works fine. I saw some cases in our internal branch and
we're fixing them.

> 
> > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > addresses (e.g., stack addresses)
> > 
> > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > stack addresses: kernel BUG()
> 
> Either:
> 
> * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
>   produce a WARNING() today (and return a junk physical address).
> 
> * Stacks are linear mapped, and cannot be distinguished from other
>   linear mapped addresses. The physical address will be valid.
> 
> ... so I don't understand why you need to change this.

For the first case: for vmap'd stack, __pa() returns a junk
physical address and it might be easier to debug this incorrect address
translation by a BUG() call instead of monitoring the warning log.

Like __phys_addr_symbol() does. __phys_addr_symbol() uses
VIRTUAL_BUG_ON() for non symbol addresses.

> 
> > symbol addresses: kernel warning message
> 
> That should already be the case today, since the kernel image is mapped
> separately from the linear map, so __is_lm_address(symbol_addr) should
> be false.
> 
> > 
> > Maybe we should trap all non-linear address translations in the future.
> > 
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/physaddr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> > index 67a9ba9eaa96..f6b935dad19c 100644
> > --- a/arch/arm64/mm/physaddr.c
> > +++ b/arch/arm64/mm/physaddr.c
> > @@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
> >  	      (void *)x,
> >  	      (void *)x);
> >  
> > +	/* trap all non-linear and non-symbol addresses */
> > +	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
> > +			(x < (unsigned long)KERNEL_START ||
> > +			 x > (unsigned long)KERNEL_END));
> 
> The KERNEL_START and KERNEL_END definitions refer to the kernel image,
> not the linear map, so it doesn't make any sense to permit those here.
> 
> It is *not* valid to call __virt_to_phys() with a symbol address. We
> only support those in __virt_to_phys_nodebug() so that broken code has a
> chance of stumbling on.
> 
> If you want the kernel to die immediately when it hits a warning here,
> please set panic_on_warn.
> 
> Thanks,
> Mark.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
