Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:22:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24C920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X4NzM48e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24C920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6WGTS7Pe6gmX1eX32g2pZpkBvs2NPJngZEwpHU8hg1w=; b=X4NzM48eVUtU9e
	NJ9CfW3+TkeDfgUYCIQoFUBZ3G+3SaRh3ejIqS9glhNm9YDB0M13bTXws3WCYXetkjengNWoyPBwC
	bA0ijBigMufYWzeEv3YQcmXON+QcQh0NLydB+ML8iqkD252EMRVcIosyr/Fm1bjB9I5nTzluU0h5Y
	aTpTxaQf7J7b2+gomDgU3YUVDw+0s6/kmRT+v7nqNn9RpuJwv8dK098JnxY2V9R+BfQP9VK7gu898
	IPLFo56LCfrFcL1faqRrNpVEomvz7fZJtJJ3T8dIWe1SEpLcuOyy5T6ff7cNcV0hV5ilQynXwHOKs
	sy+NPZ0lxKoILL6+TYwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRIV-000463-U8; Fri, 18 Jan 2019 10:22:47 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRIS-00045O-2K
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:22:45 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gkRIO-0001vk-GG; Fri, 18 Jan 2019 11:22:40 +0100
Message-ID: <1547806960.2626.9.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 18 Jan 2019 11:22:40 +0100
In-Reply-To: <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1547801609.2626.5.camel@pengutronix.de>
 <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_022244_265983_11F65850 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, den 18.01.2019, 09:54 +0000 schrieb Aisheng Dong:
> > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Friday, January 18, 2019 4:53 PM
> > Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > > One irqsteer channel can support up to 8 output interrupts.
> > 
> > This has been discussed when upstreaming the driver. The controller may
> > support multiple output IRQs, but only one them is actually used depending on
> > the CHANCTRL config. There is no use in hooking up all the output IRQs in DT, if
> > only one of them is actually used. Some of the outputs may not even be visible
> > to the Linux system, but may belong to a Cortex M4 subsystem. All of those
> > configurations can be described in DT by changing the upstream interrupt and
> > "fsl,channel" in a coherent way.
> > 
> > Please correct me if my understanding is totally wrong.
> 
> I'm afraid your understanding of CHAN seems wrong.
> (Binding doc of that property needs change as well).
> 
> On QXP DC SS, the IRQSTEER supports 512 interrupts with 8 interrupt output
> Conntected to GIC.
> The current driver does not support it as it assumes only one interrupt output used.

Okay, so let's take a step back. The description in the QXP RM is
actually better than what I've seen until now. Still it's totally
confusing that the "channel" terminology used with different meanings
in docs. Let's try to avoid this as much as possible.

So to get things straight: Each irqsteer controller has a number of IRQ
groups. All the input IRQs of one group are ORed together to form on
output IRQ. Depending on the SoC integration, a group can contain 32 or
64 IRQs, where DCSS irqsteer on MX8M and the big 512 input controllers
on QXP and QM both use 64 IRQs per group. You are claiming that the
smaller controllers on both QXP am QM have only 32 IRQs per group,
right?

So the only change that is needed is that the driver needs to know the
number of input IRQs per group, with a default of 64 to not break DT
compatibility.

Also if the connection between IRQ group and output IRQ is fixed, the
driver should be more clever about handling the chained IRQ. If you
know which of the upstream IRQs fired you only need to look at the 32
or 64 IRQ status registers of that specific group, not all of them.

Can you please clarify what the CHANCTRL setting changes in this setup?

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
