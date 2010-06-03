From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 03 Jun 2010 11:44:57 +0200
Subject: at91sam9g45 real RTC support
Message-ID: <4C077999.4030601@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As far as I understand RTC support for at91sam9g45 is realized via RTT and GPBR, where base time offset is stored. But the board has real RTC with common RTC registers as stated in the documentation. Why is it not supported directly? Is hardware broken?

The other issue is this code part

/* --------------------------------------------------------------------
 *  RTC
 * -------------------------------------------------------------------- */

#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
static struct platform_device at91sam9g45_rtc_device = {
	.name		= "at91_rtc",
	.id		= -1,
	.num_resources	= 0,
};

static void __init at91_add_device_rtc(void)
{
	platform_device_register(&at91sam9g45_rtc_device);
}
#else
static void __init at91_add_device_rtc(void) {}
#endif

I've tweaked the driver/rtc/Kconfig and could then select the AT91RM9200 RTC driver. I could successfully compile the kernel and the RTC has completed the quick test: hwclock --systohc, poweroff, poweron hwclock. The time was correct.

So what is advantage of the RTT based solution? And why AT91RM9200 RTC driver is not made selectable?

Best regards,
Yegor
