From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 13:07:27 -0500
Subject: [PATCH 09/12] rtc: omap: add support for pmic_power_en
In-Reply-To: <1412881594-25678-10-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-10-git-send-email-johan@kernel.org>
Message-ID: <20141010180721.GV31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 09:06:31PM +0200, Johan Hovold wrote:
> @@ -124,11 +138,18 @@
>   */
>  #define OMAP_RTC_HAS_POWER_UP_RESET	BIT(3)
>  
> +/*
> + * Some RTC IP revisions can control an external PMIC via the pmic_power_en
> + * pin.
> + */
> +#define OMAP_RTC_HAS_PMIC_MODE		BIT(4)
> +
>  static void __iomem	*rtc_base;
>  
>  #define rtc_read(addr)		readb(rtc_base + (addr))
>  #define rtc_write(val, addr)	writeb(val, rtc_base + (addr))
>  
> +#define rtc_readl(addr)		readl(rtc_base + (addr))

looks like this should be part of another patch. Or, at a minimum (since
it's so minor), it deserves a mention on commit log.

>  #define rtc_writel(val, addr)	writel(val, rtc_base + (addr))
>  
>  
> @@ -338,6 +359,61 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	return 0;
>  }
>  
> +static struct platform_device *omap_rtc_power_off_dev;
> +
> +/*
> + * omap_rtc_poweroff: RTC-controlled power off
> + *
> + * The RTC can be used to control an external PMIC via the pmic_power_en pin,
> + * which can be configured to transition to OFF on ALARM2 events.
> + *
> + * Notes:
> + * The two-second alarm offset is the shortest offset possible as the alarm
> + * registers must be set before the next timer update and the offset
> + * calculation is to heavy for everything to be done within a single access

s/to/too

> @@ -425,10 +505,12 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
>  	}
>  
> -	/* clear pending irqs, and set 1/second periodic,
> -	 * which we'll use instead of update irqs
> +	/*
> +	 * disable interrupts
> +	 *
> +	 * NOTE: ALARM2 is not cleared on AM3352 if rtc_write (writeb) is used
>  	 */
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_writel(0, OMAP_RTC_INTERRUPTS_REG);

bug fix, should be part of a separate patch and Cc stable :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/bc17e9ca/attachment.sig>
