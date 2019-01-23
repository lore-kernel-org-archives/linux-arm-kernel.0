Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E83C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A094721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pPMVoiWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n1QxJODdl8LDXHFQnNzNhT1oZEQVIOpoz+Fqtt68I8E=; b=pPMVoiWaDspDA6
	Z5r9U7FNdaD8h2MjMUUQo06UZV+aiGAcHdF45PgrLDA7UmAHsV+pBbo9Q+FtbYJFDZdhAXnV4ihzA
	rF0OWNuyyx2jsIu2sLqaQNWRXCeDtUnj1JPG/ax1KuK0LZUEjsL78FQNclPGz5D0p+Rnh3royEpBR
	SprjsNqEwQG5R7E/vpGGW4id4kJ261F2Tj1NExLBDH0DyhZgt/PBDirugFuXn9K3oz/DsYpVG9uVf
	aGrkYNXCQQJGHb9g5+KsEh3wB+NVskZOLIu94kK+a2L96LQ3KdB63z/+f5OX6TjUGAbxcCXbFnrln
	eBAwKQYFQ1RlujhgGAGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF0Z-00033n-6w; Wed, 23 Jan 2019 09:39:43 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF0U-00032e-4U
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:39:41 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmF0M-0000Ze-Ku; Wed, 23 Jan 2019 10:39:30 +0100
Message-ID: <1548236366.3904.1.camel@pengutronix.de>
Subject: Re: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Date: Wed, 23 Jan 2019 10:39:26 +0100
In-Reply-To: <20190123003345.13750-3-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
 <20190123003345.13750-3-f.fainelli@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_013938_335854_5161AB4A 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 sfr@canb.auug.org.au, rdunlap@infradead.org, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>, "moderated
 list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

On Tue, 2019-01-22 at 16:33 -0800, Florian Fainelli wrote:
> On 32-bit architectures defining resource_size_t as 64-bit (because of
> PAE), we can run into a linker failure because of the modulo and the
> division against resource_size(), replace the two problematic operations
> with an alignment check on the register resource (instead of modulo),
> and the division with DIV_ROUND_CLOSEST_ULL().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/reset-brcmstb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> index 01ab1f71518b..c4cab8b5052d 100644
> --- a/drivers/reset/reset-brcmstb.c
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) % SW_INIT_BANK_SIZE) {
> +	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
> +	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {

Typo.

>  		dev_err(kdev, "incorrect register range\n");
>  		return -EINVAL;
>  	}
> @@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  	dev_set_drvdata(kdev, priv);
>  
>  	priv->rcdev.owner = THIS_MODULE;
> -	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
> +						      SW_INIT_BANK_SIZE) * 32;

This should be DIV_ROUND_DOWN_ULL.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
