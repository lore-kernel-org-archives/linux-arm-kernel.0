Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD54C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:10:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB2721B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPzk/ko+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB2721B24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pBcACreK+6J5AYU2LXnCH0z1+DGaK0luCmJgFtVshbU=; b=MPzk/ko+U8l5Ku7FpgC7GQ6WU
	F+h3BnMWtIONYxQvQB1tK3Ud5pImSlUbIaxOr2ut1EjQaFV1oYl0DGX4RxAiFfXB1eBYDR/a0tCxb
	9Ah6GMphBepXD4LgbZl+OIUp4VzkpuIUeDQttjfBisW5P+bbWLhnmtzRUbrJMWteComaZ3RR2bqfd
	BJMnPF/rVbDOazZ51KXzzfALu7SHgEOgJL5pKudy7zTw8JV4TaLLbko7lO4fXwIVoA7oDAfUnJn/q
	r2zHQN3EERDKx8T6G63tOOCr59FaNeLuK55i9q75/rIEGBJATxNHc/etSBjQ9E7RHntjxu9nnjsMg
	8pzMfzzOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtG1m-0004VT-3C; Mon, 11 Feb 2019 18:09:58 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtG1j-0004Uq-GI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:09:57 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2019 10:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; d="scan'208";a="274201006"
Received: from unknown (HELO [10.7.153.148]) ([10.7.153.148])
 by orsmga004.jf.intel.com with ESMTP; 11 Feb 2019 10:09:53 -0800
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To: Wolfram Sang <wsa@the-dreams.de>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
Date: Mon, 11 Feb 2019 10:09:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190208214849.GH12451@kunai>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_100955_570510_927FEA13 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Hmmm, the #ifdeffery quite increases with this patch. Maybe it is easier
> to select I2C_SLAVE in Kconfig? I'll let you decide.
> 
> My code checkers found this:
> 
>      CPPCHECK
> drivers/i2c/busses/i2c-aspeed.c:694:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
> 

Hi Wolfram,

Yes, cppcheck pointed it out correctly. The assignment on the variable
'ret' is not needed at there. Actually, the code should not be wrapped
using I2C_SLAVE because a bus can also be in multi-master environment
even when slave is not enabled. So the warning can be removed by below
fix.

---
diff --git a/drivers/i2c/busses/i2c-aspeed.c 
b/drivers/i2c/busses/i2c-aspeed.c
index 9253ebccb008..882c4ab1d18a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -655,7 +655,6 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
  {
         struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
         unsigned long time_left, flags;
-       int ret;

         spin_lock_irqsave(&bus->lock, flags);
         bus->cmd_err = 0;
@@ -664,6 +663,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
         if (!bus->multi_master &&
             (readl(bus->base + ASPEED_I2C_CMD_REG) &
              ASPEED_I2CD_BUS_BUSY_STS)) {
+               int ret;
+
                 spin_unlock_irqrestore(&bus->lock, flags);
                 ret = aspeed_i2c_recover_bus(bus);
                 if (ret)
@@ -691,7 +692,7 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
                 if (bus->multi_master &&
                     (readl(bus->base + ASPEED_I2C_CMD_REG) &
                      ASPEED_I2CD_BUS_BUSY_STS))
-                       ret = aspeed_i2c_recover_bus(bus);
+                       aspeed_i2c_recover_bus(bus);

                 return -ETIMEDOUT;
---

The reason of adding changes at line 658 and 667 is to remove below
cppcheck warning when the change at 694 is applied.

[drivers/i2c/busses/i2c-aspeed.c:670]: (style) The scope of the variable 
'ret' can be reduced.

Can you please apply above changes on top of this patch? Or I can submit
v2 with it.

Thanks,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
