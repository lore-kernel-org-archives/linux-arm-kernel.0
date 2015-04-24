From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Apr 2015 09:16:12 +0200
Subject: [PATCH 5/9] ARM: BCM2836: Add io map initialization for bcm2836.
In-Reply-To: <1429639796-2169-6-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-6-git-send-email-eric@anholt.net>
Message-ID: <3157838.P6rILgE4M2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 April 2015 11:09:52 Eric Anholt wrote:
> +
> +DT_MACHINE_START(BCM2836, "BCM2836")
> +       .map_io = bcm2836_map_io,
> +       .init_irq = irqchip_init,
> +       .init_machine = bcm2835_init,
> +       .restart = bcm2835_restart,
> +       .dt_compat = bcm2836_compat
> +MACHINE_END

I've just looked at the other callbacks you have here, and I think
it would be easy enough to remove them as well:

- .init_irq is already pointless, you can just remove the line here
  without any effect

- bcm2835_restart can be moved to the drivers/watchdog/bcm2835_wdt.c
  driver, which already knows the registers. Just use
  register_restart_handler() in its probe function, and perhaps add
  a 'select' statement to ensure that the driver is included in kernel
  builds

- I'm not completely sure about the plans for the clock handler, but
  no proper clock driver has surfaced so far, and the clocks could just
  all be declared in DT as fixed rate clocks.

  Is anyone working on a proper clk driver here?

- once bcm2835_restart is gone from bcm2835.c and the clocks are handled
  in DT, the bcm2835_init() function can be removed as well.

	Arnd
