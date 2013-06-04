From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 4 Jun 2013 14:32:01 +0300
Subject: [PATCH] rtc: rtc-twl: ensure IRQ is wakeup enabled
In-Reply-To: <1370039827-25033-1-git-send-email-khilman@linaro.org>
References: <1370039827-25033-1-git-send-email-khilman@linaro.org>
Message-ID: <51ADD031.2090808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 06/01/2013 01:37 AM, Kevin Hilman wrote:
> Currently, the RTC IRQ is never wakeup-enabled so is not capable of
> bringing the system out of suspend.
>
> On OMAP platforms, we have gotten by without this because the TWL RTC
> is on an I2C-connected chip which is capable of waking up the OMAP via
> the IO ring when the OMAP is in low-power states.
>
> However, if the OMAP suspends without hitting the low-power states
> (and the IO ring is not enabled), RTC wakeups will not work because
> the IRQ is not wakeup enabled.
As I understand, IRQ wake up capabilities are set/clear simultaneously with
IRQ unmasking/masking on OMAP4+ in omap-wakeupgen.c.
So, it should work without this patch on OMAP4+.
But if TWL is used on non OMAP4+ platform then it is needed.
(OMAP3: I haven't found the place where IRQ wakeup capabilities are 
configured,
would be appreciate if you can point me on)
>
> To fix, ensure the RTC IRQ is wakeup enabled whenever the RTC alarm is
> set.
>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>   drivers/rtc/rtc-twl.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index 8751a52..bbda0fd 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -213,12 +213,24 @@ static int mask_rtc_irq_bit(unsigned char bit)
>   
>   static int twl_rtc_alarm_irq_enable(struct device *dev, unsigned enabled)
>   {
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq = platform_get_irq(pdev, 0);
> +	static bool twl_rtc_wake_enabled;
>   	int ret;
>   
> -	if (enabled)
> +	if (enabled) {
>   		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> -	else
> +		if (device_can_wakeup(dev) && !twl_rtc_wake_enabled) {
> +			enable_irq_wake(irq);
> +			twl_rtc_wake_enabled = true;
> +		}
> +	} else {
>   		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> +		if (twl_rtc_wake_enabled) {
> +			disable_irq_wake(irq);
> +			twl_rtc_wake_enabled = false;
> +		}
> +	}
>   
>   	return ret;
>   }
twl-rtc has suspend/resume callbacks implemented, so I think it's the 
better place
for this code and twl_rtc_wake_enabled can be dropped.
