Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD73214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i00pEFFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD73214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vQt3RzNqDt8L39vr2WtYHwXHg1heulojCkpiY1VjaM4=; b=i00pEFFr4WhL5R
	MvZ/ge/d//ypOBOG4GlsndU9BqrmUbfHh9Y7+9RhhnIRSwZBvjVcJTAqa64dKe7o7PwTFaFIzsWXG
	jDJvduyIwByTlG9Eu9c2EH4y0lInQKrZXV0gSzRTTvrJJUS7hDwlqQ159zhpIalyu/F6ZVAazpGss
	qORQSO9X59rgnUYbMpo8SXtFvcOrHZD/Htgezw6auD7GBjS+fmiTcZ2oe+sd4EIgpFenfbs2AnxwW
	fk/Sb75iX7gpuJBeZuNyM5SRT02jikwIDncibDYFhap8QPPqOoz4TjiXXOhK/9mwPxfyehbHBc3MC
	2Bu4AJBwlWKGNQf1IPEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvHd-0005hI-3M; Tue, 08 Jan 2019 17:35:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvHY-0005gp-Vc
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:35:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B82CA78;
 Tue,  8 Jan 2019 09:35:14 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A32A33F5AF;
 Tue,  8 Jan 2019 09:35:13 -0800 (PST)
Date: Tue, 8 Jan 2019 17:35:08 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: kpti: Avoid rewriting early page tables when
 KASLR is enabled
Message-ID: <20190108173508.GA781@fuggles.cambridge.arm.com>
References: <20190108163753.32418-1-will.deacon@arm.com>
 <CAKv+Gu_d8FGCRwcYAVmRZupWv-b9uOxHzAbfSGsTFDfMYq_zNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_d8FGCRwcYAVmRZupWv-b9uOxHzAbfSGsTFDfMYq_zNQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_093517_053796_B71A6DAC 
X-CRM114-Status: GOOD (  26.67  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 06:27:25PM +0100, Ard Biesheuvel wrote:
> On Tue, 8 Jan 2019 at 17:38, Will Deacon <will.deacon@arm.com> wrote:
> >
> > A side effect of commit c55191e96caa ("arm64: mm: apply r/o permissions
> > of VM areas to its linear alias as well") is that the linear map is
> > created with page granularity, which means that transitioning the early
> > page table from global to non-global mappings when enabling kpti can
> > take a significant amount of time during boot.
> >
> > Given that most CPU implementations do not require kpti, this mainly
> > impacts KASLR builds where kpti is forcefully enabled. However, in these
> > situations we know early on that non-global mappings are required and
> > can avoid the use of global mappings from the beginning. The only gotcha
> > is Cavium erratum #27456, which we must detect based on the MIDR value
> > of the boot CPU.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reported-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/mmu.h          | 37 +++++++++++++++++++++++++++++++++++
> >  arch/arm64/include/asm/pgtable-prot.h |  4 ++--
> >  arch/arm64/kernel/cpu_errata.c        |  2 +-
> >  arch/arm64/kernel/cpufeature.c        |  7 ++++++-
> >  4 files changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 43596b1a5897..06a0c84718d6 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -16,6 +16,8 @@
> >  #ifndef __ASM_MMU_H
> >  #define __ASM_MMU_H
> >
> > +#include <asm/cputype.h>
> > +
> >  #define MMCF_AARCH32   0x1     /* mm context flag for AArch32 executables */
> >  #define USER_ASID_BIT  48
> >  #define USER_ASID_FLAG (UL(1) << USER_ASID_BIT)
> > @@ -44,6 +46,41 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
> >                cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> >  }
> >
> > +static inline bool arm64_kernel_use_ng_mappings(void)
> > +{
> > +       bool tx1_bug = false;
> > +
> > +       /* What's a kpti? Use global mappings if we don't know. */
> > +       if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> > +               return false;
> > +
> > +       /*
> > +        * Note: this function is called before the CPU capabilities have
> > +        * been configured, so our early mappings will be global. If we
> > +        * later determine that kpti is required, then the page tables
> > +        * will be rewritten by kpti_install_ng_mappings().
> > +        */
> > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > +               return arm64_kernel_unmapped_at_el0();
> > +
> > +       /*
> > +        * KASLR is enabled so we're going to be enabling kpti on non-broken
> > +        * CPUs regardless of their susceptibility to Meltdown. Rather
> > +        * than force everybody to go through the G -> nG dance later on,
> > +        * just put down non-global mappings from the beginning.
> > +        */
> > +       if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
> > +               extern const struct midr_range cavium_erratum_27456_cpus[];
> > +
> > +               tx1_bug = static_branch_likely(&arm64_const_caps_ready) ?
> > +                         cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456) :
> > +                         is_midr_in_range_list(read_cpuid_id(),
> > +                                               cavium_erratum_27456_cpus);
> 
> This breaks modules due to cavium_erratum_27456_cpus not being exported.

Oh, yuck. By the time we're loading modules, the cap is sufficient so I'll
try to think of a way to solve this without exporting the symbol.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
