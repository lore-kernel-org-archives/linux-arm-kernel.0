From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:24:50 +0100
Subject: [PATCH 4/5] rtc: rtc-s3c: Fix on RTC initialization method
In-Reply-To: <1283837381-9575-5-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C86C9C2.20603@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 06:29, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> This patch changes RTC initialization method on probe() as
> per Wan ZongShun's suggestion. The 'rtc_valid_tm(tm)' can
> check whether RTC BCD is valid or not.
> 
> And should be changed the method of check because previous
> method cannot validate RTC BCD registers properly.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> ---
>  drivers/rtc/rtc-s3c.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index c078548..7f15073 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -458,8 +458,8 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
>  static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  {
>  	struct rtc_device *rtc;
> +	struct rtc_time rtc_tm;
>  	struct resource *res;
> -	unsigned int tmp, i;
>  	int ret;
>  
>  	pr_debug("%s: probe=%p\n", __func__, pdev);
> @@ -540,11 +540,17 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  
>  	/* Check RTC Time */
>  
> -	for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> -		tmp = readb(s3c_rtc_base + i);
> +	s3c_rtc_gettime(NULL, &rtc_tm);
>  
> -		if ((tmp & 0xf) > 0x9 || ((tmp >> 4) & 0xf) > 0x9)
> -			writeb(0, s3c_rtc_base + i);
> +	if (rtc_valid_tm(&rtc_tm)) {
> +		rtc_tm.tm_year	= 100;
> +		rtc_tm.tm_mon	= 0;
> +		rtc_tm.tm_mday	= 1;
> +		rtc_tm.tm_hour	= 0;
> +		rtc_tm.tm_min	= 0;
> +		rtc_tm.tm_sec	= 0;
> +
> +		s3c_rtc_settime(NULL, &rtc_tm);

I think a dev_warn() in this path is good to alert the user
to bad things happening, esp if the system should have a valid
time, it marks he posibility the rtc battery has gone.
