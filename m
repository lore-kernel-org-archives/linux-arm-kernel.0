Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68746206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oDsPuwjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68746206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zZjO2huRBk5sUy8q88y3yz8EdfYXopj1qJmAmpTCQz0=; b=oDsPuwjreUNEC3
	irkqnbjdvT8iCaMlBP5D4C1DYvTvOuJO/3x1s/mz1p51CDjrB4KYUAT9kzcr/fk0E0H8JRIt/p3Lx
	Mnv7vm08KmFMS7bYdam0UAHhItdzsmu/f1XRmuRgNRMaxwoZn26uEu8AbDQ56pGgFhtq/dApIlxoj
	2gsnqPKyRBPoy5Qgl/U7NYVd8lI5JlopS5vfNpXM7UrynKWG0mJnd16SUNiMdy3hb01s9wAOS1kPS
	BThSsj1sV0yZnlbAuVnvxJScfhyEXRHc3QaMm/Sgbo8zrbmb0l79kqfY57vihOqM88NtqAgg7sdp/
	Z6gl26gax3EKHIMKCGkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMtk-0007XL-KH; Fri, 04 Jan 2019 10:40:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMth-0007WZ-6a
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 10:40:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78EB15AD;
 Fri,  4 Jan 2019 02:40:10 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0B03F575;
 Fri,  4 Jan 2019 02:40:08 -0800 (PST)
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <96b57b5b-7c6f-2118-05a0-8a568d7cb245@arm.com>
Date: Fri, 4 Jan 2019 10:40:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_024013_247508_9E7317D8 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "4 . 20" <stable@vger.kernel.org>,
 dietmar.eggemann@arm.com, quentin.perret@arm.com, Douglas.Raillard@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 04/01/2019 09:44, Viresh Kumar wrote:
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> failures or on invocations of the policy->exit() callback.
> 
> Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> 
> In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> opp_list isn't getting accessed simultaneously from other parts of the
> OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> the opp_table->lock while traversing through the OPP list. And to
> accomplish that, this patch also creates _opp_kref_release_unlocked()
> which can be called from this new helper with the opp_table lock already
> held.
> 
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Gave it a spin on my Juno, and I don't see the refcount warning anymore so:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks for having a look at this.

[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
