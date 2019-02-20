Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AADFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:23:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F1D208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZqGnyopZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F1D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FPsMvcEHfYx0JLgj4mCiGjT1cltv8omronNQMTEmaFI=; b=ZqGnyopZrIUxkY
	WlXULeYDzMHGhixitj/yHs6JUjnwgqkE/+OEbpAnI4EuI/fqmHYZV0NJ26McKZlysEW3KDQSbeHln
	70BCNXPvgG904lljF/XerikYmTSsxpt5zuSKeKwi+OUzGOSso3oDphF+H3NhUBqwdJoAUZ6NkvN7L
	RSOSqeLATUv/hkLhMp3fhxB0z1DWs5ELlsBIaPkWj3W28kK5jwQtSuqiqEjHCTWlZhcKc7WvUCQiT
	6axgutNKXQ8oGLeGjXxoboaUSmTQ7Vl7r378AbJK84XJfTjJRXEPsihqu0Pi0ijFTxgrWmofYwjuY
	E/hi8ya3GonY7+yezAmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwN9n-0004fm-Ox; Wed, 20 Feb 2019 08:23:07 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwN9Q-0004Fu-Eu
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 08:22:47 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gwN9N-00069q-IH; Wed, 20 Feb 2019 09:22:42 +0100
Message-ID: <00169906c8509779a89dcd611098fbaea14bc7d8.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: Make use of regmap_read_poll_timeout()
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Date: Wed, 20 Feb 2019 09:22:39 +0100
In-Reply-To: <20190220021429.4910-1-andrew.smirnov@gmail.com>
References: <20190220021429.4910-1-andrew.smirnov@gmail.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_002245_247569_7C10B9F8 
X-CRM114-Status: GOOD (  18.98  )
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
Cc: linux-arm-kernel@lists.infradead.org, Chris Healy <cphealy@gmail.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, den 19.02.2019, 18:14 -0800 schrieb Andrey Smirnov:
> Replace explicit polling loop with a call to
> regmap_read_poll_timeout() to avoid code repetition. Also fix
> misspelled "failed" while at it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpcv2.c | 39 ++++++++++++++-------------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 176f473127b6..e06bf12a1e4b 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -136,8 +136,8 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
>  	const bool enable_power_control = !on;
>  	const bool has_regulator = !IS_ERR(domain->regulator);
> -	unsigned long deadline;
>  	int i, ret = 0;
> +	u32 pxx_req;
>  
>  	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>  			   domain->bits.map, domain->bits.map);
> @@ -169,30 +169,19 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>  	 * for PUP_REQ/PDN_REQ bit to be cleared
>  	 */
> -	deadline = jiffies + msecs_to_jiffies(1);
> -	while (true) {
> -		u32 pxx_req;
> -
> -		regmap_read(domain->regmap, offset, &pxx_req);
> -
> -		if (!(pxx_req & domain->bits.pxx))
> -			break;
> -
> -		if (time_after(jiffies, deadline)) {
> -			dev_err(domain->dev, "falied to command PGC\n");
> -			ret = -ETIMEDOUT;
> -			/*
> -			 * If we were in a process of enabling a
> -			 * domain and failed we might as well disable
> -			 * the regulator we just enabled. And if it
> -			 * was the opposite situation and we failed to
> -			 * power down -- keep the regulator on
> -			 */
> -			on = !on;
> -			break;
> -		}
> -
> -		cpu_relax();
> +	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
> +				       !(pxx_req & domain->bits.pxx),
> +				       0, USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to command PGC\n");
> +		/*
> +		 * If we were in a process of enabling a
> +		 * domain and failed we might as well disable
> +		 * the regulator we just enabled. And if it
> +		 * was the opposite situation and we failed to
> +		 * power down -- keep the regulator on
> +		 */
> +		on = !on;
>  	}
>  
>  	if (enable_power_control)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
