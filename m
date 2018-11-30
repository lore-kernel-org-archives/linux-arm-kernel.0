Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A21C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3162220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEhXSP7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3162220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=be4energy.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MeIVNPCJocGLAFdmn2GnCTMB8JCDaCYBiaG2cOOoDSY=; b=pEhXSP7QHCrPJl
	u0PRaxWW0U+dk6gWTd9OWjKZpjkvjEZtC7Wxj2FdmOeE7xO5gkLLOfN8UVG2BJhkFMjr8WYUB3cQn
	zoaOr3o2qMnoBpZXYh6l8ROcs37NCHyjICQvr0E3KU7/w4pibwj75NeBS80JTixxHWWaLNns2bEyf
	8NIa7e5JV9Tk6NvDICZ8SlIepSbDu36NFeIru+LGKbEULA34w9Jp67Nyj7h78A40r3cVRUm1t1HVY
	4w/1uC6NA4INlX/Kwc+MTu4QSoQXlwoleMYVmDgn2mhUlF7jPHQovI/yBbUBzqqKpAGeEhDc3Xkhk
	J+pgw7G9uzNN468++WIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfiG-0003by-2z; Fri, 30 Nov 2018 10:07:56 +0000
Received: from mail.be4energy.com ([217.6.180.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfiD-0003ar-5A
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:07:54 +0000
Received: from linux-7rm0.localnet (172.16.135.185) by SVRDC01.be4energy.local
 (172.16.135.100) with Microsoft SMTP Server id 14.3.361.1;
 Fri, 30 Nov 2018 11:07:40 +0100
From: Mario Forner <m.forner@be4energy.com>
To: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date: Fri, 30 Nov 2018 11:07:39 +0100
Message-ID: <3059696.Xnxl6OxYbg@linux-7rm0>
Organization: be4energy GmbH
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.135.185]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_020753_199955_525D0F57 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, stable@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, 27. November 2018, 17:06:34 CET schrieb Richard Genoud:
> The leak was found when opening/closing a serial port a great number of
> time, increasing kmalloc-32 in slabinfo.
> 
> Each time the port was opened, dma_request_slave_channel() was called.
> Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
> never freed. (Well, it was free at module unload, but that's not what we
> want).
> So, here, kzalloc is more suited for the job since it has to be freed in
> atc_free_chan_resources().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
> Reported-by: Mario Forner <m.forner@be4energy.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

After testing I installed an updated kernel on a production machine, which
worked fine. The memory leak has been repaired successfully.  There have been
no adverse side-effects.

Thank you for providing the patch.

> ---
>  drivers/dma/at_hdmac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7cbac6e8c113..1b7f0ca0d5cd 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1641,6 +1641,12 @@ static void atc_free_chan_resources(struct dma_chan *chan)
>  	atchan->descs_allocated = 0;
>  	atchan->status = 0;
>  
> +	/*
> +	 * Free atslave allocated in at_dma_xlate()
> +	 */
> +	kfree(chan->private);
> +	chan->private = NULL;
> +
>  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
>  }
>  
> @@ -1675,7 +1681,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
> +	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
>  	if (!atslave)
>  		return NULL;
>  
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
