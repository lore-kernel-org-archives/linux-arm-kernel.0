From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 14:50:03 +0000
Subject: [PATCH v2 12/19] ARM: at91/rtc-at91sam9: each SoC can select the
 RTT device to use
In-Reply-To: <bcf67fab836268c6f3a5b5618d44e3fdf3525af0.1329903206.git.nicolas.ferre@atmel.com>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <bcf67fab836268c6f3a5b5618d44e3fdf3525af0.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <201202221450.04390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Nicolas Ferre wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> For the RTT as RTC driver rtc-at91sam9, the platform_device structure
> is filled during SoC initialization. This will allow to convert this
> RTC driver as a standard platform driver.

Can you make this more elaborate? I don't see from this or the code why
you don't just always register the RTT as "rtc-at91sam9". There seems to
be no driver for the "at91_rtt" in tree, so I don't know if there is
an out of tree driver binding to it.

Would it be possible to remove the compile time #if and the resetting
of the device name if both drivers bind to the rtc name and the other
rtt driver binds to both names?
 
>  static int __init at91_rtc_init(void)
>  {
> -	int status;
> -	struct device *rtc;
> -
> -	status = platform_driver_register(&at91_rtc_driver);
> -	if (status)
> -		return status;
> -	rtc = bus_find_device(&platform_bus_type, NULL,
> -			NULL, at91_rtc_match);
> -	if (!rtc)
> -		platform_driver_unregister(&at91_rtc_driver);
> -	return rtc ? 0 : -ENODEV;
> +	return platform_driver_register(&at91_rtc_driver);
>  }
>  module_init(at91_rtc_init);

This can become module_platform_driver().

	Arnd
