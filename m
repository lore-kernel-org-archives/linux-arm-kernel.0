Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0972081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUkXjrFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0972081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SowsIWfR0b7JBtTuyll6mYbQHF4PGglnvWlGaWPcvSA=; b=dUkXjrFduS9RUW
	IvLNihXQdhXm72QkTaRdQWnhdT5KCR1OPLKFnXpE1gKMdhyidJe0H7lLE5IUz7Mdg9FpB3NgbIhXy
	Z8kab/qTPEZHxeHcIHanNHYVewhNPVrOz7lDZPCij8L2/nwaNUvwZ8VoKaEUplknyLKNgPprVS4XC
	Kh9OcUIfOOwwOUUOfiiBFILGfOL7KCL752UjbTvD5U67E2hJkg4NPSqeMquoLTaR7R5pmm9y4yvye
	rvt6ECFLLd6pZ9zCY3JjCg9/8XGzta4hdcxH5+fGKTRmhVkUlaoqDaGpd+RmdBUnxsfvrri73ycgR
	epfU9aQYQMtH0FFWb9Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWCby-0002eP-Lm; Mon, 10 Dec 2018 03:52:02 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWCbu-0002dD-1P
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 03:52:00 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Cpz75ClMz9s47;
 Mon, 10 Dec 2018 14:51:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Murray <andrew.murray@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v3 09/12] powerpc: perf/core: use PERF_PMU_CAP_NO_EXCLUDE
 for exclude incapable PMUs
In-Reply-To: <1544114849-47266-10-git-send-email-andrew.murray@arm.com>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
 <1544114849-47266-10-git-send-email-andrew.murray@arm.com>
Date: Mon, 10 Dec 2018 14:51:31 +1100
Message-ID: <87bm5uf398.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_195158_543366_1E2662BF 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Andrew Murray <andrew.murray@arm.com> writes:

> For PowerPC PMUs that do not support context exclusion let's
> advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that
> perf will prevent us from handling events where any exclusion flags
> are set. Let's also remove the now unnecessary check for exclusion
> flags.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c | 10 +---------
>  arch/powerpc/perf/hv-gpci.c | 10 +---------
>  arch/powerpc/perf/imc-pmu.c | 19 +------------------
>  3 files changed, 3 insertions(+), 36 deletions(-)

Looks good.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 72238ee..d2b8e60 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
>  		return -EINVAL;
>  	}
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>  	/* no branch sampling */
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> @@ -1577,6 +1568,7 @@ static struct pmu h_24x7_pmu = {
>  	.start_txn   = h_24x7_event_start_txn,
>  	.commit_txn  = h_24x7_event_commit_txn,
>  	.cancel_txn  = h_24x7_event_cancel_txn,
> +	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>  };
>  
>  static int hv_24x7_init(void)
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 43fabb3..735e77b 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
>  		return -EINVAL;
>  	}
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>  	/* no branch sampling */
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> @@ -285,6 +276,7 @@ static struct pmu h_gpci_pmu = {
>  	.start       = h_gpci_event_start,
>  	.stop        = h_gpci_event_stop,
>  	.read        = h_gpci_event_update,
> +	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>  };
>  
>  static int hv_gpci_init(void)
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 1fafc32b..1dbb0ee 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
>  	if (event->hw.sample_period)
>  		return -EINVAL;
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> @@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
>  	if (event->hw.sample_period)
>  		return -EINVAL;
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> @@ -1069,6 +1051,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>  	pmu->pmu.stop = imc_event_stop;
>  	pmu->pmu.read = imc_event_update;
>  	pmu->pmu.attr_groups = pmu->attr_groups;
> +	pmu->pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE;
>  	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
>  
>  	switch (pmu->domain) {
> -- 
> 2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
