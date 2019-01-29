Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC31C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D485820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LCbdxzSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D485820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RVJrVYwZT4j9ctjwl3cqOT/GmfBtYs7PLHH6pfNhzPM=; b=LCbdxzSupw6UfQ
	RT054Yckizjk1UZk2CxACTK1p8X3k9LPB3pq4Yi/FA8aKBnoWnkcwiotjxMOLGkfWXfD0MX4GbejT
	6GlL1pzZmAXuh+sN15T3djZkbP11HLjsSHxPyu88P0Cz5FgxqCp+g6FXivkhbGTLLRHNO7RMtd06z
	R0M3kraDT+MAoqQVySAt28vdMrlHo/8LddiVsmDEBjJLC37PaO8HKXT/lPiLP78drSL0kQbOHiHH4
	MLWTiRpFkBExXMQhxkEv4uoNSkAsuoAJIaZRPnFB5d4vOYroTt97CvLWXno7ksNU1ooRRV8cf1BQ0
	z6dt7Qe1620s6DejuhHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTem-00042Q-UW; Tue, 29 Jan 2019 13:42:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTeg-00040N-SC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:42:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BF1EBD;
 Tue, 29 Jan 2019 05:42:21 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D253F59C;
 Tue, 29 Jan 2019 05:42:19 -0800 (PST)
Subject: Re: [PATCH] arm64: fix potential deadlock in
 arm64-provide-pseudo-NMI-with-GICv3
To: Wei Li <liwei391@huawei.com>, linux-arm-kernel@lists.infradead.org
References: <20190129131223.32505-1-liwei391@huawei.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <37962c23-75a9-a0a1-7810-3abfb702be72@arm.com>
Date: Tue, 29 Jan 2019 13:42:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129131223.32505-1-liwei391@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_054223_044265_AE6FAE8C 
X-CRM114-Status: GOOD (  22.17  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, jason@lakedaemon.net,
 marc.zyngier@arm.com, catalin.marinas@arm.com, thunder.leizhen@huawei.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
 guohanjun@huawei.com, dave.martin@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wei,

Thanks testing the series.

On 29/01/2019 13:12, Wei Li wrote:
> In some exception handlers, the interrupt is not reenabled by daifclr at first.
> The later process may call local_irq_enable() to enable the interrupt, like
> gic_handle_irq(). As we known, function local_irq_enable() just change the pmr now.

This is not yet in, so it might be useful to point to the series that
adds this:
https://lkml.org/lkml/2019/1/21/1060

> The following codes what i found may cause a deadlock or some issues else:
> 
> do_sp_pc_abort			<- el0_sp_pc
> do_el0_ia_bp_hardening	<- el0_ia
> kgdb_roundup_cpus		<- el1_dbg
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/kernel/kgdb.c | 4 ++++
>  arch/arm64/mm/fault.c    | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..119fbf2c0788 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -25,6 +25,7 @@
>  #include <linux/kgdb.h>
>  #include <linux/kprobes.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/irqchip/arm-gic-v3.h>
>  
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
> @@ -291,6 +292,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>  
>  void kgdb_roundup_cpus(unsigned long flags)

Hmm, I don't see this function defined in arch/arm64/kernel/kgdb.c in
v5.0-rc*. Was it removed? or is that something in your local tree.

>  {
> +	if (gic_prio_masking_enabled())
> +		gic_arch_enable_irqs();
> +
>  	local_irq_enable();

Seeing we introduce the daifflags functions, with the relation described
at the top of arch/arm64/include/asm/daifflags.h. I think just calling
local_irq_enable() might not comply with this, as PSR.I would be clear
while PSR.D is set.

Maybe it should be using:

	local_daif_restore(DAIF_PROCCTX);

>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>  	local_irq_disable();

and here
	local_daif_mask();

Although I'd like to understand what you are applying the pseudo-NMI
series on first.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 97ba2ba78aee..f7c39a0b28bc 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -32,6 +32,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/irqchip/arm-gic-v3.h>
>  
>  #include <asm/bug.h>
>  #include <asm/cmpxchg.h>
> @@ -780,6 +781,8 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
>  	if (addr > TASK_SIZE)
>  		arm64_apply_bp_hardening();
>  
> +	if (gic_prio_masking_enabled())
> +		gic_arch_enable_irqs();
>  	local_irq_enable();

This is not in mainline, in v5.0-rc1 there is:

	local_daif_restore(DAIF_PROCCTX);

Which my series updates to modify both DAIF and PMR if needed.

So you wouldn't need to have the gic_arch_enable_irqs().

>  	do_mem_abort(addr, esr, regs);
>  }
> @@ -794,6 +797,9 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
>  	if (user_mode(regs)) {
>  		if (instruction_pointer(regs) > TASK_SIZE)
>  			arm64_apply_bp_hardening();
> +
> +		if (gic_prio_masking_enabled())
> +			gic_arch_enable_irqs();
>  		local_irq_enable();

Same here.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
