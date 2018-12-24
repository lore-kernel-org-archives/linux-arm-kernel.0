Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF9121721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H3P7ypf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF9121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m3/enTBkudcqOp28kVJX9PoMkf4X7fQiICYxNZsXprI=; b=H3P7ypf5PcG2NM
	CbUlqXN86x9iUEDta4+4WgSo4/WCdnhixpohts6sJfQezBNzp1DULcMVWWCHsu2F4PnSaaGhZWPl0
	5X6P5jlV8TLVnyZ2edHsnc6fl08SESF17MHFzktmCH/273SkwOmLAbHWq2QkmyPLk8OqE++PgymJY
	1dagI6n7E9WjFinJZLgLZbW7nelcl6Cn3mQzI+rXpePXvsul7vucxtQy1jgvggwM+lNcGLHWjJgnh
	mPHo7nY7ce1r7rYmZB3G39Ku6st5w85oLgI1t5AhFjpdA2OBNQMt0PcbL5RANRYa2Zdyg7KvSAX/K
	NpEL64gxIMqaJRukmxtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbM0v-0000oE-40; Mon, 24 Dec 2018 08:55:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbM0q-0000Yq-Rh; Mon, 24 Dec 2018 08:55:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id AE2D520A46; Mon, 24 Dec 2018 09:54:48 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6CC1F20A2E;
 Mon, 24 Dec 2018 09:54:48 +0100 (CET)
Message-ID: <eaad72f27b69259c9d460f031a2c7c392f19a969.camel@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Dec 2018 09:54:48 +0100
In-Reply-To: <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_005501_036449_8F1701DA 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2018-12-21 at 09:52 -0800, Florian Fainelli wrote:
> On 12/21/18 4:11 AM, Paul Kocialkowski wrote:
> > The driver's interrupt handler checks whether a message is currently
> > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > is considered to be unexpected. Similarly, the i2c_start_transfer
> > routine checks for the remaining number of messages to handle in
> > num_msgs.
> > 
> > However, these values are never cleared and always keep the message and
> > number relevant to the latest transfer (which might be done already and
> > the underlying message memory might have been freed).
> > 
> > When an unexpected interrupt hits with the DONE bit set, the isr will
> > then try to access the flags field of the curr_msg structure, leading
> > to a fatal page fault.
> > 
> > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > driver-wide device structure when a transfer is considered complete.
> 
> Should not this get a Fixes tag?

Yes it totally should! Thanks for the suggestion.

Cheers,

Paul

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > index 44deae78913e..5486252f5f2f 100644
> > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > +	i2c_dev->curr_msg = NULL;
> > +	i2c_dev->num_msgs = 0;
> > +
> >  	if (!i2c_dev->msg_err)
> >  		return num;
> >  
> > 
> 
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
