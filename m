From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Wed, 29 May 2013 06:57:43 +0000
Subject: [PATCH v4] tty: serial: add Freescale lpuart driver support
In-Reply-To: <20130529034913.GF370@S2101-09.ap.freescale.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130529034913.GF370@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>> +static int __init lpuart_serial_init(void) {
>> +	int ret;
>> +
>> +	pr_info("serial: Freescale lpuart driver\n");
>> +
>> +	ret = uart_register_driver(&lpuart_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = platform_driver_register(&lpuart_uart_driver);
>> +	if (ret)
>> +		uart_unregister_driver(&lpuart_reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit lpuart_serial_exit(void) {
>> +	platform_driver_unregister(&lpuart_uart_driver);
>> +	uart_unregister_driver(&lpuart_reg);
>> +}
>> +
>> +module_init(lpuart_serial_init);
>> +module_exit(lpuart_serial_exit);
>
>I think you can call uart_register_driver and uart_unregister_driver
>in .probe and .remove hook, and then you can simply use
>module_platform_driver for lpuart_uart_driver.
[Lu Jingchang-B35083] 
  For multiple dts uart nodes, each node will call .probe once. If the uart_register_driver is called from .probe without any conditioning check, it will then be called more than once, but the uart_register_deiver can only register the same uart driver once. So I think current arrangement will be more reasonable. Thanks!
