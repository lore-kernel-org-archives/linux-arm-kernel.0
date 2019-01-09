Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA916C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:04:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769FB21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRofmPud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769FB21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TIwTxvOv9MzDOM6E359ZBdY4G7IrIe0TxPb4swuqnlI=; b=RRofmPudnzhYLj
	tIwyt3ksGWrVesGD03GXKUugF9zZWOblgt4rMNRUDUAIQ1tcu1pvs6n9JrDWhUvvDfIe2+3tp1MGO
	Dqtt4Z/2MP7NPiA70+bz8Pq+mFb/gdOX3r61lvDcYJHJqOINnRs6GeA68hvtu1isKF1vVXMvHA4yD
	PVy9ixiaA6mWWGsz14YsH5nW6m+KbvbltJUi51EW9+Rxb3xT69R//G1ofNMvuUK1SeNvnTdCrwhOC
	rWpQfuQY+VXXuAOdmtPg45qYYBOF+61BLdPt3yTzumW9O6zLsjPDlkUokiwn2LOVCuW4NtYmVK0z9
	s4vLfd/bXXyop3lgNSdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBf5-000491-NQ; Wed, 09 Jan 2019 11:04:39 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBf2-00048Q-I9
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:04:38 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8d689e21cc018528; Wed, 9 Jan 2019 12:04:34 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Wed, 09 Jan 2019 12:03:49 +0100
Message-ID: <1798133.Rn2TxhOzAS@aspire.rjw.lan>
In-Reply-To: <20190109105902.ytnolu2gldhana4c@queper01-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <5435767.4D6MIGYIVi@aspire.rjw.lan>
 <20190109105902.ytnolu2gldhana4c@queper01-lin>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_030436_757395_B8C04AC6 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, qais.yousef@arm.com, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, January 9, 2019 11:59:05 AM CET Quentin Perret wrote:
> On Wednesday 09 Jan 2019 at 11:56:06 (+0100), Rafael J. Wysocki wrote:
> > On Wednesday, January 9, 2019 11:45:11 AM CET Viresh Kumar wrote:
> > > On 09-01-19, 10:42, Quentin Perret wrote:
> > > > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > > > frequency changes to provide scale-invariant load-tracking signals to
> > > > the scheduler. However, in the slow path, it does so while specifying
> > > > the current and max frequencies in different units, hence resulting in a
> > > > broken freq_scale factor.
> > > > 
> > > > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > > > frequency table.
> > > > 
> > > > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > > > message protocol")
> > > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > > ---
> > > >  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > > index 50b1551ba894..3f0693439486 100644
> > > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > > @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > > >  	int ret;
> > > >  	struct scmi_data *priv = policy->driver_data;
> > > >  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> > > > -	u64 freq = policy->freq_table[index].frequency * 1000;
> > > > +	u64 freq = policy->freq_table[index].frequency;
> > > >  
> > > > -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> > > > +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
> > > >  	if (!ret)
> > > >  		arch_set_freq_scale(policy->related_cpus, freq,
> > > >  				    policy->cpuinfo.max_freq);
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > This would be stable-candidate I guess?
> 
> I think so yes. I was hoping the 'Fixes:' tag would be enough ?

It doesn't cause -stable to pick up commits automatically if that's
what you're asking about.

> Or do I still need to CC stable too ?

No, you don't need to (and should not) CC -stable yourself.

You can, however, add a Cc: <stable..> tag to the patch which helps
maintainers a bit.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
