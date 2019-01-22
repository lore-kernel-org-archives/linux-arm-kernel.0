Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E41C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C87221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OOB4exew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C87221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jUSQkI9GlPQICI2WOp/1AisqGHM6pA+UTFjS889//Ts=; b=OOB4exewdz0dj0
	vCz/9KjIDfCkAkI3eeG2F5yTKXse4PmI9NlBg/d66947XXYLcowZkhSGMmfjXG/5Pv5njuyn7MTWv
	LN75efO4oiK5nWJYBbA/d7x7u+eyxqu2xapBqH3QqVi9XLx21rfvzysGAarX1RtHC1TuuismH5PrA
	bTasT5enHuIO73eG2CYzolg053TL/eYNUHUs8K5n/NiKFDqnIXNjO9UAwAp9/6GWqJqObuLnoh87h
	C6gdtvhUFlpXN9kQ1ep8ihgaPdl6gqFsjXXdhwkv+hYs9xMM17Lp0a94gzyYRBcBFrd37P9tBJJTJ
	Wqk845MF4JuLE46+5dPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0OA-0000Sx-Ms; Tue, 22 Jan 2019 18:03:06 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0O6-0000SP-VZ
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:03:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BE6E7207AB; Tue, 22 Jan 2019 19:02:59 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6BC6920654;
 Tue, 22 Jan 2019 19:02:59 +0100 (CET)
Date: Tue, 22 Jan 2019 19:02:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] rtc: fix a missing check of clk_prepare
Message-ID: <20190122180258.GE16702@piout.net>
References: <20181226024333.72236-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181226024333.72236-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_100303_170321_CA9E5E85 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 pakki001@umn.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/12/2018 20:43:33-0600, Kangjie Lu wrote:
> clk_prepare() could fail, so let's check its status and if it fails
> return its error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/rtc/rtc-coh901331.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
