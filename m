From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 16:02:18 +0000
Subject: [PATCH 11/16 v2] ARM: ux500: Do not attempt to register
 non-existent i2c devices on Snowball
In-Reply-To: <4F8D8FD6.1070508@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
 <4F8D8FD6.1070508@linaro.org>
Message-ID: <201204171602.19386.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Mon, 16 Apr 2012 15:26:55 +0100
> Subject: [PATCH 11/16] ARM: ux500: Do not attempt to register non-existent
>  i2c devices on Snowball
> 
> This patch prevents i2c devices which are not present on the Snowball
> low-cost development board from being registered. Devices such as;
> tc3589x, bu1780 and lp5521 are present on other supported boards,
> but are not located on Snowball.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> @@ -831,13 +830,16 @@ static void __init u8500_init_machine(void)
>                                 ARRAY_SIZE(mop500_platform_devs));
>  
>                 hrefv60_sdi_init(parent);
> +
> +               i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
> +               i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
> +
> +               i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
> +               i2c_register_board_info(2, mop500_i2c2_devices,
> +                                       ARRAY_SIZE(mop500_i2c2_devices));
>         }
>         mop500_i2c_init(parent);

You could still simplify this and get rid of the i2c0_devs variable, but
this version is fine too, since it does match the hrefv60_init_machine()
function that has the same code in it.

	Arnd
