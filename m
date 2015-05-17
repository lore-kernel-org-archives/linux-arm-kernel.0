From: eddie.huang@mediatek.com (Eddie Huang)
Date: Sun, 17 May 2015 18:44:58 +0800
Subject: [PATCH] rtc: mt6397: fix build on some 32bits platforms
In-Reply-To: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1431859498.31486.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 22:51 +0200, Alexandre Belloni wrote:
> On some !ARM 32bits platforms, the following compilation error happens
> because of the division on a 64bits value in mtk_rtc_read_time():
> 
> drivers/built-in.o: In function `mtk_rtc_read_time':
> rtc-mt6397.c:(.text+0x265d13f): undefined reference to `__divdi3'
> rtc-mt6397.c:(.text+0x265d150): undefined reference to `__moddi3'
> 
> Use div_s64() as done in rtc_time64_to_tm() to solve that.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 8bed852e4961..c0090b698ff3 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -150,7 +150,7 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	time64_t time;
>  	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> -	int sec, ret;
> +	int days, sec, ret;
>  
>  	do {
>  		ret = __mtk_rtc_read_time(rtc, tm, &sec);
> @@ -171,7 +171,8 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	/* rtc_tm_to_time64 covert Gregorian date to seconds since
>  	 * 01-01-1970 00:00:00, and this date is Thursday.
>  	 */
> -	tm->tm_wday = (time / 86400 + 4) % 7;
> +	days = div_s64(time, 86400);
> +	tm->tm_wday = (days + 4) % 7;
>  
>  exit:
>  	return ret;

Acked-by: Eddie Huang <eddie.huang@mediatek.com>
