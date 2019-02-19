Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68472147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ApXuDAVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68472147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qBoSIXU5Q8YvTHapmWJwnSiCBXZ71bW9+20Q0OzF7t8=; b=ApXuDAVi+5p8VZ
	KXeGXFFRqGoCKP0Zyr/HI91Rfx6NzWyUlOdwSy6ZDbk94GGgmpIGIo6XoYe0sbLmkmwayZauBPoYR
	gHF7GRtI3KCQ6z5pCl/v7Sx+THIpEU2mxPW1czrKwAOGX2YZumqQl+x2W6cp0CBmdiulFDOzUprql
	26NyyIMM1IWeaSIO6iyoMd1CrjAV0/JGe7NbokWu2iYTkaRygzpEImCaKdiN4ltqjGRYegqb71BU+
	BL0CwfiKHuxjkAFDw0nQ9ctfOE9Ie5pw/NG8ZnCMMpd2CrfVKgrZFvUKZdRVF3MrKhZ2a8Y4ZEAXs
	SqxqZvswd3So0wfKI34w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw9Dv-00061J-3y; Tue, 19 Feb 2019 17:30:27 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw9Dq-00060S-Jw
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:30:24 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544482800"; d="scan'208";a="296689475"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 18:30:06 +0100
Date: Tue, 19 Feb 2019 18:30:03 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference leak
In-Reply-To: <20190219170516.GL15711@atomide.com>
Message-ID: <alpine.DEB.2.20.1902191824410.27989@hadrien>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
 <20190219170516.GL15711@atomide.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_093022_951682_7084A924 
X-CRM114-Status: GOOD (  22.08  )
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
Cc: Rob Herring <robh@kernel.org>, Peng Hao <peng.hao2@zte.com.cn>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org,
 wen.yang99@zte.com.cn, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On Tue, 19 Feb 2019, Tony Lindgren wrote:

> Hi,
>
> Adding devicetree list, Julia, Rob and Tomi to Cc.
>
> * Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> > of_find_device_by_node() takes a reference to the struct device
> > when it finds a match via get_device.When returning error we should
> > call put_device.
> >
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  arch/arm/mach-omap2/display.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> > index f86b72d..c6aa9ed 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
> >  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> >  	if (r) {
> >  		pr_err("Unable to populate DSS submodule devices\n");
> > +		put_device(&pdev->dev);
> >  		return r;
> >  	}
>
> In general, if the device tree node is never used afterwards,
> should this be just:
>
> 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> 	of_node_put(dev_node);

Are these solving the same problems?  The of_node_put looks clearly
necessary, whether there is a success or failure.  I'm not familiar with
put_device.  I see that it does a kobject_put, but I don't know what
happens because of that.  But it looks like an inconsistency that Peng's
patch only considers the failure case, while your suggestion happens
always.

I guess Peng's patch is motivated by a Coccinelle script that Wen Yang
(also from ZTE) has been working on.  Perhaps there is a need to adjust
what is suggested by that script.

[Wen Yang added to CC]

julia

> 	if (r) {
> 		...
> 	}
>
> If so, Julia might have a Coccinelle recpipe for it?
>
> Regards,
>
> Tony
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
