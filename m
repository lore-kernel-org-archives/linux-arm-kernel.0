Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD28EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FB720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EPXaWfI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FB720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Tfuefiw+M/deY0kfF3lWALFdz720juq+sXxOB3TpE0=; b=EPXaWfI7WJDr4Z
	MrdoC/xyNrz12zvGlWX0ZFD6uvqy3F4Te5ah2xbvTqE0EfaMUWiExfDsk73YOfYF/rQi4qxY1qake
	guJ1/qQEATMz34WTZReSAlP8fAbc7fY2Sv7AtT6mfBW2E689JQ7E8c4MKlWFbEKPYKB71we0c/9WJ
	fNNqKkagkf3OQmiw9h7Te5AF9HpvWZd787MZjEpxEk0KwvdqbnV8hRdOSYNtDLV/92rqR41z1lmBw
	/dGxAUCTeEnOJQ2rFCKNZdPagDkZaMgK2LYjRHz4Mv1Xvt9MZ9nykWZ6TJgZGZ+T6KAkp6uLcG/Ha
	B113XzLdTlbkTZvSEbig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUErY-0005PX-2V; Tue, 04 Dec 2018 17:52:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUErV-0005O4-Na
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:51:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232EC15BE;
 Tue,  4 Dec 2018 09:51:47 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7ABC73F59C; Tue,  4 Dec 2018 09:51:45 -0800 (PST)
Date: Tue, 4 Dec 2018 17:51:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 15/24] arm64: Switch to PMR masking when starting CPUs
Message-ID: <20181204175142.GD19210@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-16-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-16-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_095157_774609_D1C6317C 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:57:06AM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 8dc9dde..e495360 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -35,6 +35,7 @@
>  #include <linux/smp.h>
>  #include <linux/seq_file.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/arm-gic-v3.h>
>  #include <linux/percpu.h>
>  #include <linux/clockchips.h>
>  #include <linux/completion.h>
> @@ -175,6 +176,25 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> +static void init_gic_priority_masking(void)
> +{
> +	u32 gic_sre = gic_read_sre();
> +	u32 cpuflags;
> +
> +	if (WARN_ON(!(gic_sre & ICC_SRE_EL1_SRE)))
> +		return;
> +
> +	WARN_ON(!irqs_disabled());
> +
> +	gic_write_pmr(GIC_PRIO_IRQOFF);
> +
> +	cpuflags = read_sysreg(daif);
> +
> +	/* We can only unmask PSR.I if we can take aborts */
> +	if (!(cpuflags & PSR_A_BIT))
> +		write_sysreg(cpuflags & ~PSR_I_BIT, daif);

I don't understand this. If you don't switch off PSR_I_BIT here, where
does it happen? In which scenario do we actually have the A bit still
set? At a quick look, smp_prepare_boot_cpu() would have the A bit
cleared previously by setup_arch(). We have secondary_start_kernel()
where you call init_gic_priority_masking() before local_daif_restore().

So what happens if you always turn off PSR_I_BIT here?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
