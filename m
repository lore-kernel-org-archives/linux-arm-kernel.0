Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B9C2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dd83bGLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9C2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RImqBXosxCWg0pbJMGL2Q0LXczCNtg3AGzGpakODAD8=; b=Dd83bGLEavsGQU
	5e6nXPVRYo2hgfrBsN+wlyexplqWtOVZAFizc7C7JmZzNQYwdw7ikpU9RT3Bnoi81Y78asCmzP2dx
	Q62O1thY2PwzwmeX1+liAKLmT9PGvRS7YDBr14cR66FBds3h8v2E2DibuTjN1y09EVeu++3/GVFcW
	VHh6cgSJoXDkuz0Dhwe/5tI36OhEkR4MFin8HvFPeyj5lfv2TeVJawaWsNfjGuBYbtWvL3xPPwDeA
	w5OBN4bXFMAYg1VLsKNWP1pX92D2cYwTHrt3Y3lc/NeMvvr45XTHabkuJsyLkAiLjtOuPS8Luil1d
	53bhnkC+CX9lRwUFEDJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZre-0003yn-5I; Wed, 19 Dec 2018 11:18:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZrZ-0003xm-Nw
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:18:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5F8EBD;
 Wed, 19 Dec 2018 03:17:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC293F5C0;
 Wed, 19 Dec 2018 03:17:49 -0800 (PST)
Date: Wed, 19 Dec 2018 11:17:44 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
Message-ID: <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-25-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_031805_792549_68558AFA 
X-CRM114-Status: GOOD (  27.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-kernel@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 06:46:57PM +0100, Ulf Hansson wrote:
> When the hierarchical CPU topology is used and when a CPU has been put
> offline (hotplug), that same CPU prevents its PM domain and thus also
> potential master PM domains, from being powered off. This is because genpd
> observes the CPU's struct device to remain being active from a runtime PM
> point of view.
> 
> To deal with this, let's decrease the runtime PM usage count by calling
> pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> offline. Consequentially, we must then increase the runtime PM usage for
> the CPU, while putting it online again.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Make it work when the hierarchical CPU topology is used, which may be
> 	  used both for OSI and PC mode.
> 	- Rework the code to prevent "BUG: sleeping function called from
> 	  invalid context".
> ---
>  drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index b03bccce0a5d..f62c4963eb62 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
> @@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
>  
>  static int psci_cpu_off(u32 state)
>  {
> +	struct device *dev;
>  	int err;
>  	u32 fn;
>  
> +	/*
> +	 * When the hierarchical CPU topology is used, decrease the runtime PM
> +	 * usage count for the current CPU, as to allow other parts in the
> +	 * topology to enter low power states.
> +	 */
> +	if (psci_dt_topology) {
> +		dev = get_cpu_device(smp_processor_id());
> +		pm_runtime_put_sync_suspend(dev);
> +	}
> +
>  	fn = psci_function_id[PSCI_FN_CPU_OFF];
>  	err = invoke_psci_fn(fn, state, 0, 0);
>  	return psci_to_linux_errno(err);
> @@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
>  
>  static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  {
> +	struct device *dev;
>  	int err;
>  	u32 fn;
>  
> @@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>  	/* Clear the domain state to start fresh. */
>  	psci_set_domain_state(0);
> +
> +	/* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> +	if (!err && psci_dt_topology) {
> +		dev = get_cpu_device(cpuid);

I do not like adding this code in the cpu_{on/off} method themselves, I will
have a look at the patchset as whole to see how we can restructure it.

More to the point, using cpuid as a logical cpu id is wrong, it is a
physical id that you should convert to a logical id through
get_logical_index().

Lorenzo

> +		pm_runtime_get_sync(dev);
> +	}
> +
>  	return psci_to_linux_errno(err);
>  }
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
