Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21742C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:41:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41C32145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TnDlkJx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41C32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HdiflVeMmaTBSRVKgggeRa8DY96An5yYp28/LOlMcIA=; b=TnDlkJx06iKzMSR1QbAeXXM6J
	dTudHyoUIqG/ZDRp2N6KdP+Fh09cCdDAkQ65nBTenjXhl3D1Qclx3LWY5fVlUM8V8Ml8fXWgUIgsP
	oAw/nw4w74j+PP0U+X8NI322/YDL0knQ60cbwlbpp70orkSPdHqCCCFb5QXIeonIh4BhHN/T2D30d
	YX6Di8RLazGSadq9XQpcBbyVu62uE/gveAJ9eOKY2jthrtk8Jugr4N0ANtkubse0FPwLuboQ496Id
	dTkPMuFRPOYa7Pu606qNFQbZkGHKWARmxX/Pc+zQwY+I8hNpIBmuRvZ8z20WyDw5z9waVIzUnEjCq
	PmP25kRmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsrES-0008Ea-B2; Sun, 10 Feb 2019 15:41:24 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsrEO-0008EA-3X
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 15:41:21 +0000
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1AFfHlu071760;
 Mon, 11 Feb 2019 00:41:17 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 11 Feb 2019 00:41:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1AFfHZB071756
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Mon, 11 Feb 2019 00:41:17 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
References: <20190130235022.21949-1-katsuhiro@katsuster.net>
 <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <079d43be-0643-a55b-5d88-3e5e900529ed@katsuster.net>
Date: Mon, 11 Feb 2019 00:41:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_074120_525315_68BC805C 
X-CRM114-Status: GOOD (  21.78  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Heiko Stuebner <heiko@sntech.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stephen,

Thanks a lot for your review. I choose clk_hw_can_set_parent_rate()
macro and fix typo and patch description. And I post v2 patch.

Best Regards,
Katsuhiro Suzuki

On 2019/02/07 4:40, Stephen Boyd wrote:
> +Heiko because it mentions Rockchip
> 
> Quoting Katsuhiro Suzuki (2019-01-30 15:50:22)
>> Custom approximation of fractional-divider may not need parent clock
>> rate checking. For example Rockchip SoCs work fine using grand parent
>> clock rate even if target rate is greater than parent.
>>
>> This patch removes parent clock rate check from custom approximation.
>>
>> For detailied example, clock tree of Rockchip I2S audio hardware.
> 
> s/detailied/detailed/
> 
>>    - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
>>      Initialize divider value is 1.
> 
> s/Initialize/Initial/
> 
>>    - A i2s1_frac is fractional divider can divide input to x/y, x and
>>      y are 16bit integer.
>>    - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>>
>> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
>> GPLL --> |          | ,--------------'    |          |
>>                        `--> i2s1_frac ---> |          |
>>
>> Clock mux system try to choose suitable one from i2s1_div and
>> i2s1_frac for master clock (MCLK) of I2S1.
>>
>> Bad scenario as follows:
>>    - Try to set MCLK to 8.192MHz (32kHz audio replay)
>>      Candidate setting is
>>      - i2s1_div : GPLL / 60           = 8.192MHz
>>      i2s1_div is same as target clock rate, so mux choose this.
>>      i2s1_div output rate is changed 491.52MHz -> 8.192MHz
>>
>>    - After that try to set to 11.2896MHz (44.1kHz audio replay)
>>      Candidate settings are
>>      - i2s1_div : CPLL / 107 = 11.214945MHz
>>      - i2s1_frac: i2s1_div   = 8.192MHz
>>        This is because clk_fd_round_rate() thinks target rate
>>        (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
>>        and returns parent clock rate.
>>      Clock mux system choose i2s1_div, but this clock rate is not
>>      acceptable for I2S driver, so users cannot replay audio.
>>
>> Expected behavior is:
>>    - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>>      Candidate settings are
>>      - i2s1_div : CPLL / 107          = 11.214945MHz
>>      - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
>>                   (change i2s1_div to GPLL / 1 = 491.52MHz)
>>        If apply this commit, clk_fd_round_rate() calls custom
>>        approximate function of Rockchip even if target rate is higher
>>        than parent. Custom function changes both grand parent
>>        (i2s1_div) and parent (i2s_frac) settings at same time.
> 
> Can you indicate what that function is? Is this merged upstream or
> something you're developing now?
> 
>>      Clock mux system can choose i2s1_frac and audio works fine.
> 
> I think this last paragraph from "If apply this commit" can be
> unindented from the expected behavior section.
> 
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
>>                  return *parent_rate;
> 
> Ok. I think it would be clearer if we had
> 
> 	unsigned long flags = clk_hw_get_flags()
> 
> 	if (!rate ||
> 	    !(flags & CLK_SET_PARENT_RATE) && rate >= *parent_rate)
> 
> indicating that the parent of the clk isn't expected to change rate so
> we can only achieve that much frequency. Plus some sort of comment to
> this effect would be helpful too.
> 
> We could also introduce macros to check clk flags. Then it would read
> nicer:
> 
> 	if (!rate || clk_hw_can_set_parent_rate(hw) && rate >= ...)
> 
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
