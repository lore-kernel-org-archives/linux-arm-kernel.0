Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:37:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D6220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZWoWjITs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D6220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xN3ETpgdgrKDRrR6G5KUfS3vG9ZCreEX3X9e1kI//To=; b=ZWoWjITsq4ZJ3S
	wvE8mJhv89nODpkFrfDnIIBu7L99Fo1+SNOliv79ULdHlDqhaHK//6Ujbb/sgQ/GMqzM2bxj+9rDE
	NdfwZEVnW1ODOC99ZFVAp/Ccbz3geZvsDiRmEUvFWTRaHxky9yWkGJU9WCZrgH2hS2Kl3Uwj1aURK
	fLu03V6au36TKzqR7JaCkXK4AIA4fBkl0EQJQodiNkPkgJRhv4Elymq0PKsV6HcE4RH+DWYcVy9OV
	7+y9yEsrcs8o2/iNK6cJgs4i+UQ1HNHDVDg5vVOo2qsW8HXwiElyDskik6Qr9CQ4dD3Qrqf5xBIiA
	WnOOTL/EGtlM28OppLMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMgs-0003kV-Mp; Mon, 10 Dec 2018 14:37:46 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMgo-0003js-2u
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:37:44 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gWMgQ-0005PL-QO; Mon, 10 Dec 2018 15:37:18 +0100
Date: Mon, 10 Dec 2018 15:37:18 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Message-ID: <20181210143718.plwd36vdxxd7q2el@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209004138.GC9507@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_063742_265390_070E231E 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: linux-arm-msm@vger.kernel.org, Barry Song <baohua@kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 ext Tony Lindgren <tony@atomide.com>, Frank Rowand <frank.rowand@am.sony.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, David Brown <david.brown@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>,
 viresh kumar <viresh.kumar@linaro.org>, Xu Wei <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-09 00:41:39 [+0000], Russell King - ARM Linux wrote:
> So, really _both_ these things are really really specific to ARM
> development platforms, and have nothing to do with modern production
> hardware.
> 
> No one should _ever_ copy the ARM reference platform SMP hotplug
> code.  Needing that code is quite simply a sign that the platform is
> quite simply not production hardware.
> 
> I really don't get how we've ended up with so many copies of this.
> Maybe the code isn't being properly reviewed?  Maybe the process for
> merging new platforms is way too lenient?  Whatever, the fact that
> we're ending up with new copies of the pen release and boot lock
> stuff demonstrably illustrates that the review process for new
> platforms is very broken.

Okay. So the whole patch won't get applied, right? If so, may I please
get the
	arch/arm/plat-versatile/platsmp.c

hunk applied? The remaining platforms would have then either justify why
they have the same problems like the ARM devel board or rework their
code.

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
