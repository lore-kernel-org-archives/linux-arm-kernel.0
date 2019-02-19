Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F6C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207112177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JviN1eMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207112177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+n7e8emkesMoFRHYJotjK9+uleCrHpzEc0q9KCijvI=; b=JviN1eMYF2EhIy
	Jj+Fmgnk/gtfm4zInuH+Co1BqTIhI0rGOOizgaXtJGGSPcJP/KmXr0G+7mls0fOB+JE7Dzk0t4HWS
	m2Bop0R1jVCbYW/swt5B3nGfAmcJJT9H9ezObRR9upY5S6XqGYIHK5K+TJtMlimSZNqfFlJ+33/mC
	mRgAQPgV3/LGAhYKAlobeTZEQxqXIA9OSVNQ6VE52L5QbSGFzHi4EswnUmGrDb5tTcNzbenaJR0Z1
	OTmObBP3pINuz5pMG/FkwwaaWu1Hq0gADU9xtvFx+Q5mDC9DCe7c8onzBzAekxcu1JsjPXU4K6E4A
	26929yVAJuytCf1s2JOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2Ve-0002w3-FJ; Tue, 19 Feb 2019 10:20:18 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2Va-0002uv-6f
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:20:16 +0000
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d8048f506a930846; Tue, 19 Feb 2019 11:20:05 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Date: Tue, 19 Feb 2019 11:18:39 +0100
Message-ID: <2386834.BKf6y2r8fF@aspire.rjw.lan>
In-Reply-To: <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
References: <20190216163148.12375-1-tiny.windzz@gmail.com>
 <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_022014_414078_D44399D5 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sudeep.holla@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday, February 18, 2019 5:53:30 AM CET Viresh Kumar wrote:
> On 16-02-19, 11:31, Yangtao Li wrote:
> > This issue was detected with the help of Coccinelle. So
> > change the order of function calls to fix it.
> > 
> > Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index 242c3370544e..9ed46d188cb5 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
> >  
> >  	cpufreq_cooling_unregister(priv->cdev);
> >  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> > -	kfree(priv);
> >  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> > +	kfree(priv);
> >  
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael: Please pick it up for 5.0-rc8 as the bug was introduced
> during 5.0 cycle only.
> 
> The patch it fixes had this tag:
> 
>     Cc: 4.20 <stable@vger.kernel.org> # v4.20
> 
> And so will get applied to 4.20.N, I guess we need to mark this patch
> as well for stable then.

Done now, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
