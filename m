From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Dec 2013 02:40:58 -0800
Subject: [lm-sensors] [PATCH 1/5] input: Add new sun4i-ts driver for
 Allwinner sunxi SoC's rtp controller
In-Reply-To: <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20131225104058.GA18980@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 11:24:03PM +0100, Hans de Goede wrote:
> Note the sun4i-ts controller is capable of detecting a second touch, but when
> a second touch is present then the accuracy becomes so bad the reported touch
> location is not useable.
> 
> The original android driver contains some complicated heuristics using the
> aprox. distance between the 2 touches to see if the user is making a pinch
> open / close movement, and then reports emulated multi-touch events around
> the last touch coordinate (as the dual-touch coordinates are worthless).
> 
> These kinds of heuristics are just asking for trouble (and don't belong
> in the kernel). So this driver offers straight forward, reliable single
> touch functionality only.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/touchscreen/Kconfig    |  10 ++
>  drivers/input/touchscreen/Makefile   |   1 +
>  drivers/input/touchscreen/sun4i-ts.c | 272 +++++++++++++++++++++++++++++++++++

[ ... ]

> +
> +static int sun4i_ts_probe(struct platform_device *pdev)
> +{
> +	struct sun4i_ts_data *ts;
> +	int ret = -ENOMEM;
> +
> +	ts = kzalloc(sizeof(struct sun4i_ts_data), GFP_KERNEL);

How about using devm_kzalloc() here ? That would simplify the cleanup
path significantly as you could just return from most error cases.

Guenter
