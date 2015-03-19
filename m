From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Mar 2015 15:46:29 +0100
Subject: [PATCH] driver core / PM: Add callbacks for PM domain
 initialization/cleanup
In-Reply-To: <Pine.LNX.4.44L0.1503191017590.1135-100000@iolanthe.rowland.org>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1503191017590.1135-100000@iolanthe.rowland.org>
Message-ID: <CAMuHMdWcOXEjSb39D2y8KCGRuvfWZj0-4Qr8xk1ZKcE9hbP9BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 3:20 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> There are two alternatives to them.  One is to do PM domain attach/detach in
>> the bus type's ->probe and ->remove, but that's suboptimal, because it is
>> then carried out every time a driver is probed/removed for a device.  The
>> other one would be to have each interested bus type register a bus type
>> notifier for itself, but that would be rather ugly, wouldn't it?
>
> Driver probing and removal is not a hot path.  Successful probes
> usually occur only once for each device.  I don't know how many
> unsuccessful probes there are on average, but probably not many.

Do not underestimate the power of deferred probing:

sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer cd
sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/sd at ee100000[0]' - status (0)
sh_mobile_sdhi ee100000.sd: Got CD GPIO
sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer wp
sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
of_get_named_gpiod_flags: parsed 'wp-gpios' property of node
'/sd at ee100000[0]' - status (0)
sh_mobile_sdhi ee100000.sd: Got WP GPIO
platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
...
sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer cd
sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/sd at ee100000[0]' - status (0)
sh_mobile_sdhi ee100000.sd: Got CD GPIO
sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer wp
sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
of_get_named_gpiod_flags: parsed 'wp-gpios' property of node
'/sd at ee100000[0]' - status (0)
sh_mobile_sdhi ee100000.sd: Got WP GPIO
gpio_rcar e6055400.gpio: sense irq = 6, type = 3
sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
