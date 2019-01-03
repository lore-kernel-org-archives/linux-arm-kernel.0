Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:33:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374DA20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IegGP/44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374DA20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yfjVkuPhRWHuBeMbyrnYfWIIpDX88Rja4pA7oLnZQnE=; b=IegGP/44BvBMAk
	+QXSWMCTrekAADwCzG35ahCc94zXZe8V2/mVK8jfbGrMgobPJtb+ofg17xpVnBVoilQ7WK7+YwCdl
	Ho2zsnzqfrmQbsK+jWnH+OApgs7PF5cR/VF2mibNYBw/8TEXVQnPq9p4+/YgE3fH1BKPLK8+z2ccc
	I0VUhYiJxYdz+uY3vCLp3Ufi7DzfnNvzQWol8q+7U0rsj34WGP5zee43+hK50NxBtW6quY4DxafT1
	V//GGHA/jD0JM6mPbbF81VPjv2x4qDA7ast125306YwKABcxoH0Y3fVJmY0BDEdG/jMRZ2rMmvqZp
	nNuEMtmq10L8z4Vmnm/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf0K0-0003bw-Hm; Thu, 03 Jan 2019 10:33:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf0Jx-0003a1-Iw
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:33:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A1D780D;
 Thu,  3 Jan 2019 02:33:47 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8EF13F5D4;
 Thu,  3 Jan 2019 02:33:44 -0800 (PST)
Date: Thu, 3 Jan 2019 10:33:39 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Message-ID: <20190103103318.GA23511@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_023349_644437_BF06CC88 
X-CRM114-Status: GOOD (  21.68  )
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
Cc: nm@ti.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Quentin Perret <quentin.perret@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Douglas Raillard <Douglas.Raillard@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 12:35:14PM +0530, Viresh Kumar wrote:

[...]

> @Sudeep: Please help review it as well.
> 
> -- 
> viresh
> 
> -------------------------8<-------------------------
> 
> From f3913738618031e9d71ebf64461cee22909e6e20 Mon Sep 17 00:00:00 2001
> Message-Id: <f3913738618031e9d71ebf64461cee22909e6e20.1546498940.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 3 Jan 2019 12:28:26 +0530
> Subject: [PATCH] cpufreq: scpi: Fix freeing of OPPs
> 
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table().
> 
> The OPPs for scpi cpufreq driver aren't getting freed currently, fix
> that by adding a new callback scpi_ops->remove_device_opps() which will
> remove those OPPs.
> 
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/scpi-cpufreq.c |  4 ++--
>  drivers/firmware/arm_scpi.c    | 15 +++++++++++++++
>  include/linux/scpi_protocol.h  |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..1bfd168de0b2 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  out_free_priv:
>  	kfree(priv);
>  out_free_opp:
> -	dev_pm_opp_cpumask_remove_table(policy->cpus);
> +	scpi_ops->remove_device_opps(cpu_dev);
>  
>  	return ret;
>  }
> @@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  	clk_put(priv->clk);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	kfree(priv);
> -	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> +	scpi_ops->remove_device_opps(priv->cpu_dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index c7d06a36b23a..963f2ffbd820 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -716,6 +716,20 @@ static int scpi_dvfs_add_opps_to_device(struct device *dev)
>  	return 0;
>  }
>  
> +static void scpi_dvfs_remove_device_opps(struct device *dev)
> +{
> +	int idx;
> +	struct scpi_opp *opp;
> +	struct scpi_dvfs_info *info = scpi_dvfs_info(dev);
> +
> +	/* We already added OPPs successfully, this data can't be invalid */

As you already state the checks are unnecessary, if we drop them we don't need
to add any firmware specific callbacks. I am thinking if it makes sense to
add a generic helper function to remove the OPPs from a device. If we have
that any driver needing that can use it. The main reason I think helper is
useful is that we need exactly same fix for SCMI driver too.

Thoughts ?

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
