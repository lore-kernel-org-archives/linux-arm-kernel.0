Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:14:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DCA20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gFieQGXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DCA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0b3sv4mbeoaveTaqlOAP2o+s5C6z7rClVPKCqbC1+D4=; b=gFieQGXBFd5efR
	2ikBuTeZUYgRnHsbREww+dzmUh8q/rNVOV65vhzXB6jgSZJuxsZg2Gqx7YGwlS/an1Lrxs8l/yN6W
	gNHwuyxPGwaddhHkYHG/uiqz7EneW3EAyS0PtRiNDpOjK8lpDVVOTvtD4B34LyYptx5jQu5NDM8sc
	gOQU7yorTJH6mITzOwCuWESXtkszvRiJ82xDyRcUV3M6XGyOd2uzF/YYn8/uLZSXUbmAZfv0CSBLo
	KWabz46swD6qYEPOog6y1k9OcZuKNXWq+QWS2baPa5dMGB9g/iASBowCqbAS3z2Gj3ht/XNyapkE+
	ArZdEVUNUEhU5F+Mp3mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6uv-0007Wm-MO; Fri, 22 Feb 2019 09:14:49 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6us-0007Vo-5o
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:14:47 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gx6uj-0004DO-0F; Fri, 22 Feb 2019 10:14:37 +0100
Message-ID: <fa4d10499733fe96361a0b61ff3e8ba0dd62c837.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: imx6q: cpuidle: fix bug that CPU may not wake up
From: Lucas Stach <l.stach@pengutronix.de>
To: Kohji Okuno <okuno.kohji@jp.panasonic.com>, 
 linux-arm-kernel@lists.infradead.org
Date: Fri, 22 Feb 2019 10:14:34 +0100
In-Reply-To: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_011446_376782_E2C29BCF 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Am Freitag, den 22.02.2019, 17:49 +0900 schrieb Kohji Okuno:
> Hi,
> I found the bug in cpuidle-imx6q.c. Could you check my patch?
> 
>  In the current cpuidle implementation for i.MX6q, the CPU that sets
> "WAIT_UNCLOCKED" and the CPU that returns to "WAIT_CLOCKED" are
> always
> the same. While the CPU that sets "WAIT_UNCLOCKED" is in IDLE state
> of
> "WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
> istead of "WAIT", this CPU can not wake up at expired time.
>  Because, in the case of "WFI", the CPU must be waked up by the local
> timer interrupt. But, while "WAIT_UNCLOCKED" is set, the local timer
> is stopped, when all CPUs execute "wfi" instruction. As a result, the
> local timer interrupt is not fired.
>  In this situation, this CPU will wake up by IRQ different from local
> timer. (e.g. broacast tiemr)
> 
> So, this fix changes CPU to return to "WAIT_CLOCKED".

Please send patches inline, instead of attachments. That makes review a
lot easier.

I agree that the patch does the right thing, while simplifying the code
at the same time, which is always a good sign. The only (rather minor)
issue that I could spot is that the "master" variable name isn't
matching what it does anymore, as there is no master CPU anymore. It is
more like the last man standing turning the clock off, while the first
one to wake up will switch it back on. But then I also fail to come up
with a better naming.

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
