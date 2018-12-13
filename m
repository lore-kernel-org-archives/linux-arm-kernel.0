Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F694C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7E320880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uPWJH1Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7E320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LPTaqfb5oxIis3vymGvcEKQOBYF4+hxsuPAkwP9W2QM=; b=uPWJH1CuNXB3PY
	wtdk6F63/3fqnahqQ/QTDsx+ThfXJG2K6x/SuDePGrBCoM3DRoDP04iha9wW54DpbcM6kkZAtZsr5
	0n+OBuJmsvNyCvsk+Z94FFqqK0SYK7Fs3lOdtii/pt0SiSS0SnJizr8MWuH89dMDo6OMVQIASjzhx
	U0+LHKhOGxeh/8ZY2yKrwdw5HFUlyawMq7rCnXwWipFTMAaJZ0Vp6GoS7pQ3YtRigUNh85G2fjmnr
	q1qRppG0SCkfVqgdDtXDq81X560mJM6W6NYmV8Dg/KhBbnTDZKAf8dW15esS/wPVrfRpGLjw63ekM
	Se27OWqIF/X+63uuflZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQKb-0001M3-RE; Thu, 13 Dec 2018 12:43:09 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQKY-0000up-Ik
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:43:08 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gXQK2-0008Fw-Dk; Thu, 13 Dec 2018 13:42:34 +0100
Date: Thu, 13 Dec 2018 13:42:34 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Message-ID: <20181213124234.gwzl3zft332svaxo@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
 <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
 <20181211212930.kcap5kx6bff6bpuu@linutronix.de>
 <20181213114842.GJ9507@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213114842.GJ9507@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_044306_761928_4B6E5DCC 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 viresh kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, David Brown <david.brown@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Xu Wei <xuwei5@hisilicon.com>,
 ext Tony Lindgren <tony@atomide.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-13 11:48:42 [+0000], Russell King - ARM Linux wrote:
> On Tue, Dec 11, 2018 at 10:29:30PM +0100, Sebastian Andrzej Siewior wrote:
> > I just resent the versatile hunk. Should I really split up and resend
> > the other platforms? Russell was not very amused about it.
> 
> Just the Versatile bit, and no I don't see any point in fixing the
> other SoCs - it's an incentive for them to fix up their code.

Okay. I already resent that.

> The rest aren't something that could just be ripped out without
> the involvement of the SoC maintainer to test the changes - so
> I'm of the opinion that we should just send SoC maintainers
> patches that remove the pen_release and boot_lock crap.  If they
> blindly accept the patches, so be it.
> 
> I'm preparing a series to attack some of this.

Thank you.

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
