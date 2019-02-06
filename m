Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B71C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6821206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qTRv8Mo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6821206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/x/iDvv5Pd8oxiDKQak1iuNVn0kXZysh+E3W0LA10J4=; b=qTRv8Mo2wzrb+N
	iIp/VcBYCDWYUJ6sdwknGrRXcFwWbzlfOPUGX6jrLWXsf4tPuH54bfyXWumJsjPuX8ShLMDhPsdKc
	luaYbEPzc9pSpNas35P4MAKutI+E8IoXCe4OD2SQxVJwNTUDEkf+rskFzZj0TQHm2IQX7Dk0FFx9m
	QVOC0WLqWZ6lreEUVSkZg+R1eWZJIpbu+FVbou03dyd9ItwLisKAGBQG48dj05x2XX44AdVoCPwpu
	KwOc/NBu54c4PgofXBhbW4w6iMtSAUsl7Zf4l4JCO6KKADwA7JKx533DeGA3kwnIlITA+HtMjIoRF
	aeJtyZGRRTnQ89F7D5xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKY5-0002pR-9r; Wed, 06 Feb 2019 10:35:21 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKY1-0002p6-RL
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:35:19 +0000
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d97ed51e97c75656; Wed, 6 Feb 2019 11:35:15 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] PM/runtime: Optimize pm_runtime_autosuspend_expiration()
Date: Wed, 06 Feb 2019 11:34:03 +0100
Message-ID: <4091828.IqCJ3qcF9B@aspire.rjw.lan>
In-Reply-To: <20190130214017.GA5038@lenoch>
References: <20190130214017.GA5038@lenoch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_023518_076951_AE87934B 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, January 30, 2019 10:40:17 PM CET Ladislav Michl wrote:
> pm_runtime_autosuspend_expiration calls ktime_get_mono_fast_ns
> even when its returned value may be unused. Therefore get
> current time later and remove gotos while there.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  This patch is based on top of bleeding-edge branch, where
>  "[PATCH v2 ] PM-runtime: fix deadlock with ktime" is sitting.
>  I expect v3 of that patch, which should not harm this one.
>  It is meant to replace "PM/runtime: Do not needlessly call ktime_get"
>  sent earlier.
> 
>  drivers/base/power/runtime.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 65e2b5f48e0c..7bbe28faca8d 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -145,24 +145,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>  	int autosuspend_delay;
> -	u64 last_busy, expires = 0;
> -	u64 now = ktime_get_mono_fast_ns();
> +	u64 expires;
>  
>  	if (!dev->power.use_autosuspend)
> -		goto out;
> +		return 0;
>  
>  	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
>  	if (autosuspend_delay < 0)
> -		goto out;
> -
> -	last_busy = READ_ONCE(dev->power.last_busy);
> +		return 0;
>  
> -	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
> -	if (expires <= now)
> -		expires = 0;	/* Already expired. */
> +	expires  = READ_ONCE(dev->power.last_busy);
> +	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
> +	if (expires > ktime_get_mono_fast_ns())
> +		return expires;	/* Expires in the future */
>  
> - out:
> -	return expires;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>  
> 

Applied, thanks!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
