From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 04 Jul 2011 11:39:31 +0900
Subject: [rtc-linux] [PATCH 2/3] rtc: rtc-s3c: Disable alarm entries that
	are not chosen.
In-Reply-To: <1309175006-9218-3-git-send-email-myungjoo.ham@samsung.com>
References: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
	<1309175006-9218-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <013101cc39f3$9b44b830$d1ce2890$%youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> When rtc_setalarm is called, the entries that are not chosen (entries
> without valid time values) should be disabled. However, in the previous
> rtc-s3c driver, they are not explicitly disabled (did not changed). This
> patch allows to disable such entries even if they were previously used.

This has already been implemented by current code.
The original code you modified only leaves alarm enable bit.
You may misunderstand the code.

Regards,
Changhwan
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 3c8dfa7..be85ea5 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -273,7 +273,8 @@ static int s3c_rtc_setalarm(struct device *dev, struct
> rtc_wkalrm *alrm)
>  		 1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
>  		 tm->tm_hour, tm->tm_min, tm->tm_sec);
> 
> -	alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
> +	/* Disable entires that are not chosen by alrm */
> +	alrm_en = S3C2410_RTCALM_ALMEN;
>  	writeb(0x00, base + S3C2410_RTCALM);
> 
>  	if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
> --
> 1.7.4.1
> 
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
