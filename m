From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 27 Mar 2012 16:47:59 -0700
Subject: [V2 2/4] rtc: fix 88pm860x rtc irq enable callback
In-Reply-To: <1331259874-26503-1-git-send-email-jtzhou@marvell.com>
References: <1329997662-2931-1-git-send-email-jtzhou@marvell.com>
 <1331259874-26503-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120327164759.ec04c62e.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Mar 2012 10:24:34 +0800
"Jett.Zhou" <jtzhou@marvell.com> wrote:

> According to 88pm860x spec, rtc alarm irq enable control is bit3 for
> RTC_ALARM_EN, so fix it.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  drivers/rtc/rtc-88pm860x.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
> index f04761e..8b72b4c 100644
> --- a/drivers/rtc/rtc-88pm860x.c
> +++ b/drivers/rtc/rtc-88pm860x.c
> @@ -72,9 +72,9 @@ static int pm860x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  	struct pm860x_rtc_info *info = dev_get_drvdata(dev);
>  
>  	if (enabled)
> -		pm860x_set_bits(info->i2c, PM8607_RTC1, ALARM, ALARM);
> +		pm860x_set_bits(info->i2c, PM8607_RTC1, ALARM_EN, ALARM_EN);
>  	else
> -		pm860x_set_bits(info->i2c, PM8607_RTC1, ALARM, 0);
> +		pm860x_set_bits(info->i2c, PM8607_RTC1, ALARM_EN, 0);
>  	return 0;
>  }

It's surprising that the driver has been in-tree for a year and nobody
has noticed this bug.  This makes me wonder if the fix is wrong.

Has the patch been runtime tested?
