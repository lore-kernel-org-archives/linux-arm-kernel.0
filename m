Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8913C3168B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:23:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE1C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RQMmLhIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE1C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2TROjJlUSnDp4ZwBOIQqQMaVYgsqqZJ+cLeS/9nppnY=; b=RQMmLhIypW58av
	SVhziasDxXPb2x0FB47zLfiJuQZ85Bhmeox8gN+QeBgiFs6ayOhjJqlJCnFqjGUOqNlSm4LQgMrIU
	cuWYTpevgpzw8phIR4a/bGgSwGxgccd/ic9sjsrLkI19ii7qE6YNnSmkb1dP3KDKbukYUqQR7D3M2
	au/JiDh3TT+wAtVzjeg12drlHSl83rLc8dHOZ70eUWI42dLdVVaPnFGR9+1q9YfvxpWSs/3okY3T0
	4KuZbVoDkega3rNcojoAEBjO/DIC+LoRgX41Yt3QpEtjoENm6P51hfJYUG5UuImNX1U4cdZz9ZJ85
	5IEBPHVskvn89X7Pj9Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldIL-00056v-Ff; Mon, 21 Jan 2019 17:23:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldII-00056Y-Au
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:23:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65DD115AB;
 Mon, 21 Jan 2019 09:23:29 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC5593F614;
 Mon, 21 Jan 2019 09:23:27 -0800 (PST)
Date: Mon, 21 Jan 2019 17:23:25 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] drivers/perf: handle multiple CPUs with single interrupts
Message-ID: <20190121172325.GD47506@lakrids.cambridge.arm.com>
References: <20190121144111.22716-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121144111.22716-1-stefan@agner.ch>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_092330_384910_6446D5FE 
X-CRM114-Status: GOOD (  32.16  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On Mon, Jan 21, 2019 at 03:41:11PM +0100, Stefan Agner wrote:
> Currently, if only a single interrupt is available, the code assigns
> this single interrupt to the first CPU. All other CPUs are left
> unsupported. This allows to use perf events only on processes using
> the first CPU. This is not obvious to the user.
> 
> Instead, disable interrupts but support all CPUs. This allows to use
> the PMU on all CPUs for all events other than sampling events which do
> require interrupt support.

Even for non-sampling events we use the overflow interrupt to ensure
that we don't lose count across overflows, and without that interrupt,
we cannot guarantee that the results are accurate.

For example:

	Program counter to 0
	Start program
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	Stop program
	Counter reads as 5


... which we cannot distinguish from:

	Program counter to 0
	Start program
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	< counter overflows, no interrupt >
	Stop program
	Counter reads as 5

... and thus cannot provide any reasonable confidence in results.

In theory, we could use a hrtimer to periodically refresh the events to
prevent this, but this would need to be set at some very high frequency
to account for the fastest potential counter, and would significantly
degrade performance.

I don't think that's going to be reliable, and given that, I don't think
that we can support muxed IRQs in this way.

Thanks,
Mark.

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This has been observed and tested on a i.MX 6DualLite, but is probably
> valid for i.MX 6Quad as well.
> 
> It seems that ux500 once had support for single IRQ on a SMP system,
> however this got removed with:
> Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
> 
> I noticed that with this patch I get an error when trying to use perf stat:
>   # perf top
>   Error:
>   cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> 
> Without this patch perf top seems to work, but it seems not to use any
> sampling events (?):
>   # perf top
> PerfTop:    7215 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
> ....
> 
> Also starting perf top and explicitly selecting cpu-clock seems to work
> and show the same data as before this change.
>   # perf top -e cpu-clock:pppH
> PerfTop:    7214 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
> 
> It seems that perf top falls back to cpu-clock in the old case, but not
> once sampling events are not supported...
> 
> --
> Stefan
> 
> 
>  drivers/perf/arm_pmu_platform.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 933bd8410fc2..80b991417b6e 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -105,23 +105,26 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>  		return num_irqs;
>  	}
>  
> +	if (num_irqs == 1) {
> +		int irq = platform_get_irq(pdev, 0);
> +		if (irq && irq_is_percpu_devid(irq))
> +			return pmu_parse_percpu_irq(pmu, irq);
> +	}
> +
>  	/*
>  	 * In this case we have no idea which CPUs are covered by the PMU.
>  	 * To match our prior behaviour, we assume all CPUs in this case.
> +	 * Multiple CPUs with a single PMU irq are currently not handled.
> +	 * Rather than supporting only the first CPU, support all CPUs but
> +	 * without interrupt capability.
>  	 */
> -	if (num_irqs == 0) {
> -		pr_warn("no irqs for PMU, sampling events not supported\n");
> +	if (num_irqs == 0 || (nr_cpu_ids > 1 && num_irqs == 1)) {
> +		pr_info("No per CPU irqs for PMU, sampling events not supported\n");
>  		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>  		cpumask_setall(&pmu->supported_cpus);
>  		return 0;
>  	}
>  
> -	if (num_irqs == 1) {
> -		int irq = platform_get_irq(pdev, 0);
> -		if (irq && irq_is_percpu_devid(irq))
> -			return pmu_parse_percpu_irq(pmu, irq);
> -	}
> -
>  	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node)) {
>  		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
>  			pdev->dev.of_node);
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
