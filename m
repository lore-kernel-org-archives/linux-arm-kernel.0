From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 Dec 2016 01:43:08 +0100
Subject: [PATCH v2] rtc: armada38x: Followed the new recommendation for
 errata implementation
In-Reply-To: <20161213112510.25692-1-gregory.clement@free-electrons.com>
References: <20161213112510.25692-1-gregory.clement@free-electrons.com>
Message-ID: <20161221004308.terkq5u5pb2hbcbw@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/12/2016 at 12:25:10 +0100, Gregory CLEMENT wrote :
> According to RES-3124064:
> 
> The device supports CPU write and read access to the RTC time register.
> However, due to this restriction, read and write from/to internal RTC
> register may fail.
> 
> Workaround:
> General setup:
> 1. Configure the RTC Mbus Bridge Timing Control register (offset 0x184A0)
>    to value 0xFD4D4FFF
>    Write RTC WRCLK Period to its maximum value (0x3FF)
>    Write RTC WRCLK setup to 0x29
>    Write RTC WRCLK High Time to 0x53 (default value)
>    Write RTC Read Output Delay to its maximum value (0x1F)
>    Mbus - Read All Byte Enable to 0x1 (default value)
> 2. Configure the RTC Test Configuration Register (offset 0xA381C) bit3
>    to '1' (Reserved, Marvell internal)
> 
> For any RTC register read operation:
> 1. Read the requested register 100 times.
> 2. Find the result that appears most frequently and use this result
>    as the correct value.
> 
> For any RTC register write operation:
> 1. Issue two dummy writes of 0x0 to the RTC Status register (offset
>    0xA3800).
> 2. Write the time to the RTC Time register (offset 0xA380C).
> 
> This patch is based on the work of Shaker Daibes
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> this patch followed the patch series sent here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473232.html
> 
> For now I kept the patch 2 converting to time64_t apart after Russell
> King feedback.
> 
> I merged the patch 1 and 3 and I also substantially modified the 1st
> patch with I think a better implementation.
> 
> - First I do not put anymore more a big array onto the stack as
>   suggested by Andrew Lunn.
> - Then I optimize the way to find the correct value.
> 
> Gregory
> 
> 
> drivers/rtc/rtc-armada38x.c | 121 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 97 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 9a3f2a6f512e..458ef8da0484 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -29,50 +29,119 @@
>  #define RTC_TIME	    0xC
>  #define RTC_ALARM1	    0x10
>  
> +#define SOC_RTC_BRIDGE_TIMING_CTL   0x0
> +#define SOC_RTC_PERIOD_OFFS		0
> +#define SOC_RTC_PERIOD_MASK		(0x3FF << SOC_RTC_PERIOD_OFFS)
> +#define SOC_RTC_READ_DELAY_OFFS		26
> +#define SOC_RTC_READ_DELAY_MASK		(0x1F << SOC_RTC_READ_DELAY_OFFS)
> +
>  #define SOC_RTC_INTERRUPT   0x8
>  #define SOC_RTC_ALARM1		BIT(0)
>  #define SOC_RTC_ALARM2		BIT(1)
>  #define SOC_RTC_ALARM1_MASK	BIT(2)
>  #define SOC_RTC_ALARM2_MASK	BIT(3)
>  
> +

Unnecessary blank line ;)

> +#define SAMPLE_NR 100
> +
> +struct value_to_freq {
> +	u32 value;
> +	u8 freq;
> +};
> +
>  struct armada38x_rtc {
>  	struct rtc_device   *rtc_dev;
>  	void __iomem	    *regs;
>  	void __iomem	    *regs_soc;
>  	spinlock_t	    lock;
>  	int		    irq;
> +	struct value_to_freq *val_to_freq;
>  };
>  
>  /*
>   * According to the datasheet, the OS should wait 5us after every
>   * register write to the RTC hard macro so that the required update
>   * can occur without holding off the system bus
> + * According to errata FE-3124064, Write to any RTC register
> + * may fail. As a workaround, before writing to RTC
> + * register, issue a dummy write of 0x0 twice to RTC Status
> + * register.
>   */
> +
>  static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
>  {
> +	writel(0, rtc->regs + RTC_STATUS);
> +	writel(0, rtc->regs + RTC_STATUS);
>  	writel(val, rtc->regs + offset);
>  	udelay(5);
>  }
>  
> +/* Update RTC-MBUS bridge timing parameters */
> +static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
> +{
> +	uint32_t reg;
> +

u32 is preferable.

[...]

> @@ -182,7 +244,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
>  	val = readl(rtc->regs_soc + SOC_RTC_INTERRUPT);
>  
>  	writel(val & ~SOC_RTC_ALARM1, rtc->regs_soc + SOC_RTC_INTERRUPT);
> -	val = readl(rtc->regs + RTC_IRQ1_CONF);
> +	val = read_rtc_register_wa(rtc, RTC_IRQ1_CONF);
>  	/* disable all the interrupts for alarm 1 */
>  	rtc_delayed_write(0, rtc, RTC_IRQ1_CONF);
>  	/* Ack the event */
> @@ -196,7 +258,6 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
>  		else
>  			event |= RTC_PF;
>  	}
> -

Unrelated change.

>  	rtc_update_irq(rtc->rtc_dev, 1, event);
>  
>  	return IRQ_HANDLED;
> @@ -221,6 +282,11 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  	if (!rtc)
>  		return -ENOMEM;
>  
> +	rtc->val_to_freq = devm_kcalloc(&pdev->dev, SAMPLE_NR,
> +				sizeof(struct value_to_freq), GFP_KERNEL);
> +	if (!rtc->val_to_freq)
> +		return -ENOMEM;
> +

The whole struct armada38x_rtc is already allocated just before. Maybe
you can put the whole array inside the structure instead of doing a new
allocation.

>  	spin_lock_init(&rtc->lock);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc");
> @@ -253,6 +319,9 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  	if (rtc->irq != -1)
>  		device_init_wakeup(&pdev->dev, 1);
>  
> +	/* Update RTC-MBUS bridge timing parameters */
> +	rtc_update_mbus_timing_params(rtc);
> +
>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
>  					&armada38x_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(rtc->rtc_dev)) {
> @@ -260,6 +329,7 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
>  		return ret;
>  	}
> +

Unrelated change.

>  	return 0;
>  }
>  
> @@ -280,6 +350,9 @@ static int armada38x_rtc_resume(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
>  
> +		/* Update RTC-MBUS bridge timing parameters */
> +		rtc_update_mbus_timing_params(rtc);
> +
>  		return disable_irq_wake(rtc->irq);
>  	}
>  
> -- 
> 2.10.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
