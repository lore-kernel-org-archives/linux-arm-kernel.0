Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7148C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00E020883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V9EK2Oe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00E020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/BBSuaaxb3a4eH2RZ2sspLxz9yHzlEDosCcEKPJsL5E=; b=V9EK2Oe3DUqBQ8
	co8SjMJbOk/+b+sAkamEdkHFbkd80COiGjNt6DnYyyv29lrpjBHDphextaAwng9ZZemISWNrZQzF7
	/xb/FZm8mxz+cnI4LzT7ThuV2LJPxgHz9Xev/96q3GpDF3N4b/urp/ZOuOzGW+WDLsBNBKIbEq+6u
	XTVkrAow611aX8+ldhtzas4SxoTE/xcm5ATwwE1hUgAWRcm/Erm/z7Lk0zF70UTdcjohyjkqnLPV5
	k6H6xEi4AWpaWcxYSup/gfFmaKlKbe5Qwsv1o1whqn8iPf6nUekZx2YFa5pxxWz8ON/bddS/5oWOP
	QiNJbH7qOpfyCCXwmXJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBXh-00016k-MS; Wed, 09 Jan 2019 10:57:01 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBXd-00015u-CB
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:56:59 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 193b28f482ec75c2; Wed, 9 Jan 2019 11:56:52 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Wed, 09 Jan 2019 11:56:06 +0100
Message-ID: <5435767.4D6MIGYIVi@aspire.rjw.lan>
In-Reply-To: <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_025657_578017_CE1A5838 
X-CRM114-Status: GOOD (  14.08  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, qais.yousef@arm.com,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, January 9, 2019 11:45:11 AM CET Viresh Kumar wrote:
> On 09-01-19, 10:42, Quentin Perret wrote:
> > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > frequency changes to provide scale-invariant load-tracking signals to
> > the scheduler. However, in the slow path, it does so while specifying
> > the current and max frequencies in different units, hence resulting in a
> > broken freq_scale factor.
> > 
> > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > frequency table.
> > 
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > message protocol")
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index 50b1551ba894..3f0693439486 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  	int ret;
> >  	struct scmi_data *priv = policy->driver_data;
> >  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> > -	u64 freq = policy->freq_table[index].frequency * 1000;
> > +	u64 freq = policy->freq_table[index].frequency;
> >  
> > -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> > +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
> >  	if (!ret)
> >  		arch_set_freq_scale(policy->related_cpus, freq,
> >  				    policy->cpuinfo.max_freq);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

This would be stable-candidate I guess?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
