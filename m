From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 17 Jul 2014 12:06:20 +0200
Subject: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140717081232.GH18374@atomide.com>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
 <20140717070859.GD18374@atomide.com> <20140717074219.GA29193@linutronix.de>
 <20140717081232.GH18374@atomide.com>
Message-ID: <53C7A01C.50107@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2014 10:12 AM, Tony Lindgren wrote:
> Hmm it could be that it works for a while because the clocks are on
> from the bootloader and pm_runtime calls won't do anything. This
> could happen if the interconnect data based on the ti,hwmods entry
> is not getting matched to the new driver. This gets initialized when
> the device entry gets created in omap_device_build_from_dt().
> 
> Or maybe something now affects the clock aliases? It seems that we
> are still missing the clocks entries in the .dtsi files, see the
> mappings with $ git grep uart drivers/clk/ti/

I've been looking for something completely different while I noticed
this:

in drivers/tty/serial/omap-serial.c
| static struct platform_driver serial_omap_driver = {
|         .driver         = {
|                 .name   = DRIVER_NAME,
|         },
| };
|

and DRIVER_NAME should come from include/linux/platform_data/serial-omap.h
Looking further, I've found arch/arm/mach-omap2/serial.c:
| void __init omap_serial_init_port(struct omap_board_data *bdata,
|                         struct omap_uart_port_info *info)
| {
|         char *name
?
|	name = DRIVER_NAME;
?
|	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size);
?
|

Would this explain it?

> Regards,
> 
> Tony

Sebastian
