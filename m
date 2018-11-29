Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F06C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:16:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDB621104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvweK3et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDB621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvI6Ro9IjmlUUTtxehf2QGNIOSVxQHjdOWB0StWkKLk=; b=VvweK3etU1I2rw
	xmecsVfGiYypuqwPMzDnSmCrQSxZXb+4vGUJgV8CVwb698b5JvqWiuFWo99V+Y2BzURm7quO+x5gg
	1s5+7xWK8pZ/4DP5bv/s5bqnW07Pjs6VegVxtJjllmfBte/s1Vr0HBVogWL0tXbhQSMMp0rLDLlKe
	rCgqZSmNKJ4fS+X6S6xOIvICWV+tI+LaYTGhXgYmHdm0Xm52EAZVC8bsNS99EVjzPUGtWs09mpyFI
	NVjJN0raQH3/W3Xl/zaUe3byk34RCicVqYYAvcSmA+Bo4mYeWon9cHHzk9CENtvc6CVso9s4EQXaY
	W6wImbI/Lg7A4ebzkRuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSRn8-0007Nf-Jh; Thu, 29 Nov 2018 19:16:02 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSRkw-0003gb-46
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:13:53 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6791D80EA;
 Thu, 29 Nov 2018 19:13:37 +0000 (UTC)
Date: Thu, 29 Nov 2018 11:13:32 -0800
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181129191332.GY53235@atomide.com>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_111347_002659_FD1DEA7B 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> >
> > "DMA-API: mapping sg segment longer than device claims to support"
> >
> > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> >
> > Let's do a sanity check for max_seg_size being higher than what DMA
> > supports in mmc_add_host() and lower it as needed.
> >
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -13,6 +13,7 @@
> >   */
> >
> >  #include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/err.h>
> >  #include <linux/idr.h>
> >  #include <linux/of.h>
> > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> >
> >  EXPORT_SYMBOL(mmc_alloc_host);
> >
> > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > +{
> > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> 
> Is dma_get_max_seg_size() really intended to be called for any struct
> device (representing the mmc controller) like this?
> 
> My understanding is that the dma_get_max_seg_size() is supposed to be
> called by using the DMA engine device, no?

Oh good catch sounds like I'm calling it for the wrong device,
need to check. In that case sounds like this can't be generic?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
