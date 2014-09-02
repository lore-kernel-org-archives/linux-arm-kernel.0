From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 14:32:23 +0200
Subject: [PATCH 3/8 v2] power: reset: driver for the Versatile syscon
 reboot
In-Reply-To: <1409659354-23553-4-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
 <1409659354-23553-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <3488091.4DXvj6mC51@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 14:02:29 Linus Walleij wrote:
> +enum versatile_reboot {
> +       REALVIEW_REBOOT_EB,
> +       REALVIEW_REBOOT_PB1176,
> +       REALVIEW_REBOOT_PB11MP,
> +       REALVIEW_REBOOT_PBA8,
> +       REALVIEW_REBOOT_PBX,
> +};
> +static const struct of_device_id versatile_reboot_of_match[] = {
> +       {
> +               .compatible = "arm,realview-eb-syscon",
> +               .data = (void *)REALVIEW_REBOOT_EB,
> +       },
...
> +};
> +
> +static void versatile_reboot(enum reboot_mode mode, const char *cmd)
> +{
> +       /* Unlock the reset register */
> +       regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
> +                    REALVIEW_SYS_LOCK_VAL);
> +       /* Then hit reset on the different machines */
> +       switch (versatile_reboot_type) {
> +       case REALVIEW_REBOOT_EB:
> +               regmap_write(syscon_regmap,
> +                            REALVIEW_SYS_RESETCTL_OFFSET, 0x0008);
> +               break;
> ...
> +       }
> +       dsb();

Looks ok to me. Just an idea for further simplification, we could easily encode
the writes into the .data field:

	{
		.compatible = "arm,realview-eb-syscon",
		.data = (void *)0x00080000,
	},
	...
	{
               .compatible = "arm,realview-pbx-syscon",
               .data = (void *)0x00f000f4,
        },


static void versatile_reboot(enum reboot_mode mode, const char *cmd)
{

	/* Unlock the reset register */
	regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
		     REALVIEW_SYS_LOCK_VAL);

	regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
					versatile_reboot_type >> 16);

	if (versatile_reboot_type & 0xffff)
		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
			     versatile_reboot_type >> 16);

	dsb();
}

It's definitely shorter, you can decide if you like it better or not,
and add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' whichever you choose.

	Arnd
