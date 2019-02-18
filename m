Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9065BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591B52184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5j8uKVd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JjP2ZR7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591B52184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BK8MRwHiMK3n7hbk8ZH1/K/dpH3mT0YKB0EJMRh4o5M=; b=t5j8uKVd8XTLRw
	Qxt1oRYhJzGf/bwJBUTvca8IhJ7O9bQS3uQ/aRS9VMI0udmJ6lPjzrpZTuBu/+lU1/XIEFVwq/6ff
	0nK445Vf0m81aO45zZisdP+wElSrvzDhmpJXChNqPZz7v6BamN3MWFdacAXax/aNNmg9sW+s//OQ6
	QFo0ZMSVLrDEnmO1QRIFia8CQ/QOJQbWdkM4ww7h2Tuett6ijzmvgIq5SKNSNbD2ThLgRUiPn/KNP
	UaE5a4mUaFsTRLgOLcnlLrtcVf8YTl7qEkUMzTtL7eGz4/7qodzJlWduXnUkfXCZPqFtSSbGyAYZK
	R1vuv8YnNbLWYl5jGM5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvdYa-0000Zv-5U; Mon, 18 Feb 2019 07:41:40 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvdYW-0000ZU-5M
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 07:41:38 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190218074133euoutp02ebbce55bd8d9cbe89b4128a4562e8460~EZW2cpwFa0288002880euoutp02d
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 07:41:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190218074133euoutp02ebbce55bd8d9cbe89b4128a4562e8460~EZW2cpwFa0288002880euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550475693;
 bh=ihsef7MhKQ6odCvg1Y/6R/PqabYPjRxZUCEPgL2b0tg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=JjP2ZR7uEMPtNwmYHvlkB9fXxg8rNsN2G6/KayVULLmG8I4heJRWe7j9nRsM0u44B
 lRETSpjRJxY7rp5TQf7OXVW6joZ1Y9qgrPhWUzMO/pips1OHq7bxifUVA4xO8iaqmH
 14gfK+kCrGiApcpKDeTvVP6q8OtBcrU6KXrybiV4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190218074132eucas1p192dcb42602b3889a7ec1333c4961882c~EZW2DcJpr0892708927eucas1p1s;
 Mon, 18 Feb 2019 07:41:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.5C.04294.CA16A6C5; Mon, 18
 Feb 2019 07:41:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190218074131eucas1p27a8e0e27609d5eaadcacf8391849838d~EZW07DWDW1862918629eucas1p2j;
 Mon, 18 Feb 2019 07:41:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190218074131eusmtrp2ce99e1f63fa616ebdb45b1369df100a2~EZW0sbU6G3044530445eusmtrp2P;
 Mon, 18 Feb 2019 07:41:31 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9d-5c6a61ace0a0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.C9.04284.BA16A6C5; Mon, 18
 Feb 2019 07:41:31 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190218074130eusmtip10c443650976ee59f3f3f8b8be140d16d~EZW0NpTWh2838228382eusmtip1x;
 Mon, 18 Feb 2019 07:41:30 +0000 (GMT)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7b994b86-9a84-39a7-e88d-203c64b30de8@samsung.com>
Date: Mon, 18 Feb 2019 08:41:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87prErNiDG63ylpsnLGe1eL6l+es
 FvM+y1qcP7+B3WLT42usFjPO72Oy2LxpKrMDu8emVZ1sHneu7WHzeHfuHLvH5iX1Hn1bVjF6
 fN4kF8AWxWWTkpqTWZZapG+XwJXRPE+5YJZ4xb4DE9kbGDcLdzFyckgImEjM6n7C1sXIxSEk
 sIJRYuqtY0wQzhdGiZuzX7BAOJ8ZJbpefWeFaVm97wZU1XJGiTM7/kH1v2eUmHSqDaxKWCBS
 4sr68+wgtohApcS5tinsIEXMAusZJdYumAdWxCZgKNH1tosNxOYVsJOYdPgoM4jNIqAqcXLa
 YrBmUYEYiSnnjrBD1AhKnJz5hAXE5gSqn7b+JZjNLCAvsf3tHGYIW1zi1pP5YOdJCGxjlzh6
 6Sg7xN0uEgu/7GSBsIUlXh3fAhWXkfi/E6ahmVGifcYsdginh1Fi65wdbBBV1hKHj18EOpsD
 aIWmxPpd+hBhR4nvba/AwhICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkC
 o9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgMjr97/iX
 HYy7/iQdYhTgYFTi4f1QlhkjxJpYVlyZe4hRgoNZSYQ3KDYrRog3JbGyKrUoP76oNCe1+BCj
 NAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAPjsqe/zURXqt7UVDrSxX27NUfmhW5HqMDt
 /i9VIidYSkuV05657ru26ZEo05KNadWTlnDaBHJ6v9++73k11+8YnUsH1H5H2ZSETy3eseHT
 1kyHRoPj/mV7pf+3KJbnyZRkWh70tfsbJFZy+NIvwRur8tY6Zcxd6Nul7yHXxpbaNz3tP9dO
 5jAlluKMREMt5qLiRAAV1HV7QgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7qrE7NiDK484rXYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksXnTVGYHdo9NqzrZPO5c28Pm8e7cOXaPzUvqPfq2rGL0
 +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
 QS+jeZ5ywSzxin0HJrI3MG4W7mLk5JAQMJFYve8GUxcjF4eQwFJGifnX5rNBJGQkTk5rYIWw
 hSX+XOtigyh6yyix6OR/JpCEsECkxJX159m7GDk4RAQqJSYtywapYRZYzyjxef1lRoiGn4wS
 c44eBJvEJmAo0fW2C2wDr4CdxKTDR5lBbBYBVaBti8EGiQrESFw9xwhRIihxcuYTFhCbE6h8
 2vqXYDazgLrEn3mXmCFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlx
 bnpusaFecWJucWleul5yfu4mRmDkbTv2c/MOxksbgw8xCnAwKvHwfijLjBFiTSwrrsw9xCjB
 wawkwhsUmxUjxJuSWFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnApJBXEm9oamhuYWlobmxubGah
 JM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx9s+F/o3filpTvrWrXnn6rt8jbLa6gnHu2qkv
 fniXGfrEJnycmJHQw7FnSZSS8Ba37XrfQnZkR9U/KJylKJr8d2/jD+ed3XmvDMUuMN6/dlgl
 +OvPBu1YgSVTtCd7XK6U3x3JIXT99yOXFX7pSxvlvYR/7rpzVHvJSr8DZxYE3pn+9+K376Wn
 lViKMxINtZiLihMBrXrCCtICAAA=
X-CMS-MailID: 20190218074131eucas1p27a8e0e27609d5eaadcacf8391849838d
X-Msg-Generator: CA
X-RootMTR: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_234136_503448_CEC604D8 
X-CRM114-Status: GOOD (  18.21  )
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On 2019-02-15 17:35, Daniel Lezcano wrote:
> On 15/02/2019 13:52, Marek Szyprowski wrote:
>> Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
>> Architected Timers (arch_timer), because they both share some common
>> hardware blocks (global system counter) and turning on MCT is needed
>> to get ARM Architected Timer working properly. Increase MCT timer rating
>> and hotplug priority over ARM Archictected timer driver to achieve that.
> This is a hack.
>
> There are mechanisms to handle this kind of dependency.
>
> eg. https://www.kernel.org/doc/html/v4.15/driver-api/device_link.html

Sorry, but this is not a hack, but proper way to handle this in
clocksource/timers framework. The ratings assigned to each driver and
cpu hotplug priority list are exactly for managing the requested order
of operations if more than one driver has been registered.

Device links operates on the 'kernel device' objects, which are created
and managed much later than clocksource/timers are initialized. I see no
use of device links in this context.

>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/clocksource/exynos_mct.c | 4 ++--
>>  include/linux/cpuhotplug.h       | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index 49413900b24c..58090f57ada3 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -211,7 +211,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>  
>>  static struct clocksource mct_frc = {
>>  	.name		= "mct-frc",
>> -	.rating		= 400,
>> +	.rating		= 450,
>>  	.read		= exynos4_frc_read,
>>  	.mask		= CLOCKSOURCE_MASK(32),
>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>> @@ -465,7 +465,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>>  	evt->tick_resume = set_state_shutdown;
>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> -	evt->rating = 450;
>> +	evt->rating = 500;
>>  
>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>  
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index fd586d0301e7..bdd544f21102 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -115,10 +115,10 @@ enum cpuhp_state {
>>  	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>>  	CPUHP_AP_PERF_ARM_STARTING,
>>  	CPUHP_AP_ARM_L2X0_STARTING,
>> +	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>>  	CPUHP_AP_JCORE_TIMER_STARTING,
>> -	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>  	CPUHP_AP_ARM_TWD_STARTING,
>>  	CPUHP_AP_QCOM_TIMER_STARTING,
>>  	CPUHP_AP_ARMADA_TIMER_STARTING,
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
