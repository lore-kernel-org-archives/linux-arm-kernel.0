Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D24C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE282086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9cwIevW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE282086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UZ9T60lhcDfLbto9tcIS+Qq+cVtiKaP9Qm0FB65QXgU=; b=o9cwIevW/Veyt5czVs0LD7x3l
	W/JRuOURkjwabqMypj+FfMiOAzk8ouV3+P3owO22HCdhVEqsApu4EQckMJy54JwDcm8AW8Y8tk85A
	LdlfOHGNV000DEjdTWNHHq+uWkDzNhad8CRbHpkbeF+TRyowgYDm/I2jln2jIoJOagVRLpmVGWuT0
	K7omJR61TipOMsyzpSt0e1dAyj+bRVUvoxoUJIq+2X7WEKbTkHvyf/vVqAzi/P2oFXLO6C3s5nMVe
	qnrWFSiR6UkvuNHLKZJc6uMpupLdxuEuP+PjFCi1SzkFxu0eMi0Dwsj9l0vGAkKhCuN564GsUVs9w
	TzdaKz1ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozWl-000749-3T; Wed, 30 Jan 2019 23:44:19 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozWh-00073Y-8A
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:44:17 +0000
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UNi6Mq059918;
 Thu, 31 Jan 2019 08:44:06 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Thu, 31 Jan 2019 08:44:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UNi57q059914
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Thu, 31 Jan 2019 08:44:06 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
 <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <d507fe24-c2ba-0c38-4985-7f8f4bf89958@katsuster.net>
Date: Thu, 31 Jan 2019 08:44:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_154415_523141_96F4B319 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stephen,

Thank you for your comment.
I'll add detail description and send it.

Best Regards,
Katsuhiro Suzuki

On 2019/01/30 6:55, Stephen Boyd wrote:
> Quoting Katsuhiro Suzuki (2019-01-07 05:21:24)
>> Custom approximation of fractional-divider may not need parent clock
>> rate checking. For example Rockchip SoCs work fine using grand parent
>> clock rate evne if target rate is greater than parent.
>>
>> This patch removes parent clock rate check from custom approximation.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   drivers/clk/clk-fractional-divider.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
>> index 545dceec0bbf..b0fc5509e0ff 100644
>> --- a/drivers/clk/clk-fractional-divider.c
>> +++ b/drivers/clk/clk-fractional-divider.c
>> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>>          unsigned long m, n;
>>          u64 ret;
>>   
>> -       if (!rate || rate >= *parent_rate)
>> +       if (!rate)
> 
> Is your fraction multiplying the rate up? If it's a divider it shouldn't
> be increasing the rate more than whatever the parent is supplying so
> this looks odd. How does the grandparent matter here? Maybe you can show
> the example in the commit text so we can all understand what's going on
> here.
> 
>>                  return *parent_rate;
>>   
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
