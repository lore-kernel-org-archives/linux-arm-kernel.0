From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 19 Jun 2017 07:57:48 +0000
Subject: [PATCH 3/3] rtc: st-lpc: make it robust against y2038/2106 bug
In-Reply-To: <1497621833-9942-4-git-send-email-benjamin.gaignard@linaro.org>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497621833-9942-4-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <ba0475d6-b386-9bb9-0b3b-5a4568633e62@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin

On 06/16/2017 04:03 PM, Benjamin Gaignard wrote:
> Make driver use u64 variables and functions to be sure that
> it will support dates after year 2038.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   drivers/rtc/rtc-st-lpc.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 74c0a33..82b0af1 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -99,7 +99,7 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
>   
>   	lpt = ((unsigned long long)lpt_msb << 32) | lpt_lsb;
>   	do_div(lpt, rtc->clkrate);
> -	rtc_time_to_tm(lpt, tm);
> +	rtc_time64_to_tm(lpt, tm);
>   
>   	return 0;
>   }
> @@ -107,13 +107,10 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
>   static int st_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   {
>   	struct st_rtc *rtc = dev_get_drvdata(dev);
> -	unsigned long long lpt;
> -	unsigned long secs, flags;
> -	int ret;
> +	unsigned long long lpt, secs;
> +	unsigned long flags;
>   
> -	ret = rtc_tm_to_time(tm, &secs);
> -	if (ret)
> -		return ret;
> +	secs = rtc_tm_to_time64(tm);
>   
>   	lpt = (unsigned long long)secs * rtc->clkrate;
>   
> @@ -161,13 +158,13 @@ static int st_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>   {
>   	struct st_rtc *rtc = dev_get_drvdata(dev);
>   	struct rtc_time now;
> -	unsigned long now_secs;
> -	unsigned long alarm_secs;
> +	unsigned long long now_secs;
> +	unsigned long long alarm_secs;
>   	unsigned long long lpa;
>   
>   	st_rtc_read_time(dev, &now);
> -	rtc_tm_to_time(&now, &now_secs);
> -	rtc_tm_to_time(&t->time, &alarm_secs);
> +	now_secs = rtc_tm_to_time64(&now);
> +	alarm_secs = rtc_tm_to_time64(&t->time);
>   
>   	/* Invalid alarm time */
>   	if (now_secs > alarm_secs)
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
