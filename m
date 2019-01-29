Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A64421473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iajmQ6CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A64421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TY8uhJKAgExbueW6mDIi/zrY7wsr2nP5JAtu3nUydrQ=; b=iajmQ6CC2Kqmk1
	zk8UPsCfnfeQaJBAWJFZi2i8uwom8VqYt4ovl9wR92nWhAc9SgVGiZpPPsE4i4jeVdkJspj2Us4B0
	BPe6KeIYcHI/K8TTYePA3E2X7CGVCdadlE2dcVseZvy/rctrdh55Okg4Zw5lcYhvHtU6sFYXvHDAZ
	O29gEhcRLcVMGeB6U/yrlrxpEG2c4Vqg0dWA/YkULABw3DIFhjd+XfZ52ioAVBvOWpRWLJuewYN5e
	1ehGMKGSsrtfuvLrInjeaB7ZBLDU8Vi9NI/4srj6de82/KbEgweOg680D/5LaS3cXbq8w/UcdCCL9
	4nlBWd18iqYRuIJ/SUpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPJ3-0001DG-G3; Tue, 29 Jan 2019 09:03:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPIw-0001CV-M1
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:03:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0EE80D;
 Tue, 29 Jan 2019 01:03:38 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946403F7A6;
 Tue, 29 Jan 2019 01:03:35 -0800 (PST)
Date: Tue, 29 Jan 2019 09:03:34 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190128190251.GH81583@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128190251.GH81583@google.com>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_010338_729247_660D087E 
X-CRM114-Status: GOOD (  23.75  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Matthias,

On Monday 28 Jan 2019 at 11:02:51 (-0800), Matthias Kaehlcke wrote:
> > +/**
> > + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> > + * @mW:		pointer to the power estimate in milli-watts
> > + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> 
> nit: should be kHz

Right, I can change that :-)

> 
> > + * @cpu:	CPU for which power needs to be estimated
> > + *
> > + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> > + * and updates @KHz and @mW accordingly.
> > + *
> > + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> > + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> > + * respectively the voltage and frequency of the OPP.
> > + *
> > + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > + * calculation failed because of missing parameters, 0 otherwise.
> > + */
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> 
> I think it is more common to put the input parameters first, then the
> output ones, i.e. cpu, kHz, mW.

Hmm, the issue is this must match the expectations of the EM framework:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62

So, I don't really have a choice. Or we can change the core code if this
_really_ is a problem -- we don't have users yet so now is the best time
to do so I guess ...

> 
> > +{
> > +	unsigned long mV, Hz, MHz;
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
> > +	u32 cap;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return -ENODEV;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> > +	of_node_put(np);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	Hz = *KHz * 1000;
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +	if (IS_ERR(opp))
> > +		return -EINVAL;
> > +
> > +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	MHz = Hz / 1000000;
> > +	tmp = (u64)cap * mV * mV * MHz;
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
> > +	*KHz = Hz / 1000;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index 0a2a88e5a383..fedde14f5187 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
> >  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> >  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> >  int of_get_required_opp_performance_state(struct device_node *np, int index);
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
> >  #else
> >  static inline int dev_pm_opp_of_add_table(struct device *dev)
> >  {
> > @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
> >  {
> >  	return -ENOTSUPP;
> >  }
> > +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> >  #endif
> >  
> >  #endif		/* __LINUX_OPP_H__ */
> 
> Besides the nits above:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Thank you !
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
