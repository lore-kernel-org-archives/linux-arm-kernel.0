Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A561FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3C32085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BfL61+Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3C32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u84y/YIU2qG4Z1fYJBQYqhniqsaso6BPUjfdf/b4dSM=; b=BfL61+QaAByt13
	YoNrqQOois5Tb8riuZTgkXyIT33n8AFcZtyafewYNWvFfNEY9TXCu+NjBc4gm+aaMJa2BgMWAo2nu
	VqTvAKk4jyJyq49xu952NCekhSTuCCpUT+ENMWxQ7Zh9fNUvjXhB4P0cfnJ7cpj96mG4vbt0QLoBA
	dfPo+L26SGGCcCxddCEtN4B+tl8bDz4Toncr0wH0Io85rVp1Ph2aTy24vXs0FjRD+HWVzNYrs5D6B
	DfSxfOPG/G7sJOWRX9t+HdMT6QNJVvS5ar2ZH4d8YUJvsZSY8VckRDOLcSx3LrjhxViFY0VWHCurC
	i0K7yLRjeAlzCS7DiZng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLpN-0001tR-0U; Wed, 23 Jan 2019 16:56:37 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLoy-0001YT-KU
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:56:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB282EBD;
 Wed, 23 Jan 2019 08:56:11 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CF03F237;
 Wed, 23 Jan 2019 08:56:09 -0800 (PST)
Date: Wed, 23 Jan 2019 16:56:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123165607.GB55887@lakrids.cambridge.arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_085613_368981_C2154C96 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> call to stop the CPU. This call ensures L1/L2 cache flush,
> CPUs cache-cohenrecy setting w.r.to interconnect.
> 
> Apart from this, this gives control to f/w to reduce power consumption
> by take appropriate decesion on power rails for plugging-out core.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  arch/arm64/kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1598d6f..360e52b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -822,8 +822,13 @@ static void ipi_cpu_stop(unsigned int cpu)
>  	local_daif_mask();
>  	sdei_mask_local_cpu();
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (cpu_ops[cpu]->cpu_die)
> +		cpu_ops[cpu]->cpu_die(cpu);
> +#else
>  	while (1)
>  		cpu_relax();
> +#endif

If cpu_ops[cpu]->cpu_die is NULL, this change makes ipi_cpu_stop()
return, which is not correct.

Regardless, I don't think that there is sufficient rationale for this
change, especially given that your commit message describes
platform-specific assumptions which do not hold in general.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
