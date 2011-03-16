From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Mar 2011 11:19:51 -0300
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110316083326.GF13316@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
Message-ID: <AANLkTik8J6geSa1E==otDfsYDaBj5FQMcOzPmXqOGO7t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/3/16 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
> This function is a bit confusing:
>
> ? ? ? ?/* Bring USB hub out of reset */
> ? ? ? ?ret = gpio_request(BABBAGE_USB_HUB_RESET, "GPIO1_7");
> ? ? ? ?if (ret) {
> ? ? ? ? ? ? ? ?...
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
> ? ? ? ?gpio_direction_output(BABBAGE_USB_HUB_RESET, 0);
> ? ? ? ?/* USB HUB RESET - De-assert USB HUB RESET_N */
> ? ? ? ?msleep(1);
> ? ? ? ?gpio_set_value(BABBAGE_USB_HUB_RESET, 0);
> ? ? ? ?msleep(1);
> ? ? ? ?gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
>
> IMHO the comments are misleading. ?I'd suggest:
>
> ? ? ? ?ret = gpio_request_one(BABBAGE_USB_HUB_RESET,
> ? ? ? ? ? ? ? ? ? ? ? ?GPIOF_DIR_OUT | GPIOF_INIT_LOW, "USB hub reset#");
> ? ? ? ?if (ret) {
> ? ? ? ? ? ? ? ?pr_err("failed to request gpio for USB hub reset#: %d\n", ret);
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
> ? ? ? ?msleep(2);
> ? ? ? ?gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
>
> Fabio?

Ok, I was not the author of this original code, but will send a new
patch for fixing it.

Thanks for the review.

Regards,

Fabio Estevam
