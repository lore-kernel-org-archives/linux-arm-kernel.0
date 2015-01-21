From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jan 2015 10:03:29 +0100
Subject: [PATCH RFC] ARM: BCM5301X: add restart support
In-Reply-To: <1421829866-9769-1-git-send-email-zajec5@gmail.com>
References: <1421829866-9769-1-git-send-email-zajec5@gmail.com>
Message-ID: <1539307.ZYqgppcXBA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 09:44:26 Rafa? Mi?ecki wrote:
> 
> +static void bcm5301x_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       struct bcma_bus *bus = bcm5301x_get_bcma_bus();
> +
> +       if (bus)
> +               bcma_chipco_watchdog_timer_set(&bus->drv_cc, 1);
> +       else
> +               pr_warn("Unable to access bcma bus\n");
> +
> +       while (1)
> +               ;
> +}
> +

Please move the restart implementation into the driver that provides
the bcma_chipco_watchdog_timer_set() function, and use the new
restart notifier to hook it up, instead of the machine_descriptor
field.

	Arnd
