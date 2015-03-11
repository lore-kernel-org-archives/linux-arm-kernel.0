From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 11 Mar 2015 09:37:01 +0000
Subject: [PATCH v2 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <1426064430-5826-2-git-send-email-carlo@caione.org>
References: <1426064430-5826-1-git-send-email-carlo@caione.org>
 <1426064430-5826-2-git-send-email-carlo@caione.org>
Message-ID: <55000CBD.9050909@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/15 09:00, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch adds support for the AmLogic Meson8b SoC.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/pinctrl/meson/Makefile          |    2 +-
>  drivers/pinctrl/meson/pinctrl-meson.c   |    4 +
>  drivers/pinctrl/meson/pinctrl-meson.h   |    1 +
>  drivers/pinctrl/meson/pinctrl-meson8b.c | 1013 +++++++++++++++++++++++++++++++
>  include/dt-bindings/gpio/meson8b-gpio.h |   31 +
>  5 files changed, 1050 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson8b.c
>  create mode 100644 include/dt-bindings/gpio/meson8b-gpio.h
> 
> diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefile
> index eafc216..c751d22 100644
> --- a/drivers/pinctrl/meson/Makefile
> +++ b/drivers/pinctrl/meson/Makefile
> @@ -1,2 +1,2 @@
> -obj-y	+= pinctrl-meson8.o
> +obj-y	+= pinctrl-meson8.o pinctrl-meson8b.o
>  obj-y	+= pinctrl-meson.o
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index a2bf49c..79f35f3 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -544,6 +544,10 @@ static const struct of_device_id meson_pinctrl_dt_match[] = {
>  		.compatible = "amlogic,meson8-pinctrl",
>  		.data = &meson8_pinctrl_data,
>  	},
> +	{
> +		.compatible = "amlogic,meson8b-pinctrl",
> +		.data = &meson8b_pinctrl_data,
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_pinctrl_dt_match);
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
> index bfea8ad..c06d9d0 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.h
> +++ b/drivers/pinctrl/meson/pinctrl-meson.h
> @@ -207,3 +207,4 @@ struct meson_pinctrl {
>  #define MESON_PIN(x) PINCTRL_PIN(PIN_ ## x, #x)
>  
>  extern struct meson_pinctrl_data meson8_pinctrl_data;
> +extern struct meson_pinctrl_data meson8b_pinctrl_data;
> diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
> new file mode 100644
> index 0000000..8a91e59
> --- /dev/null
> +++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
> @@ -0,0 +1,1013 @@
> +/*
> + * Pin controller and GPIO driver for Amlogic Meson8b.
> + *
> + * Copyright (C) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <dt-bindings/gpio/meson8b-gpio.h>
> +#include "pinctrl-meson.h"
> +
> +#define AO_OFFSET	120
> +#define DIF_OFFSET	135
> +
> +#define PIN_GPIOX_0	GPIOX_0
> +#define PIN_GPIOX_1	GPIOX_1
> +#define PIN_GPIOX_2	GPIOX_2
> +#define PIN_GPIOX_3	GPIOX_3
> +#define PIN_GPIOX_4	GPIOX_4
> +#define PIN_GPIOX_5	GPIOX_5
> +#define PIN_GPIOX_6	GPIOX_6
> +#define PIN_GPIOX_7	GPIOX_7
> +#define PIN_GPIOX_8	GPIOX_8
> +#define PIN_GPIOX_9	GPIOX_9
> +#define PIN_GPIOX_10	GPIOX_10
> +#define PIN_GPIOX_11	GPIOX_11
> +/* hole */
> +#define PIN_GPIOX_16	GPIOX_16
> +#define PIN_GPIOX_17	GPIOX_17
> +#define PIN_GPIOX_18	GPIOX_18
> +#define PIN_GPIOX_19	GPIOX_19
> +#define PIN_GPIOX_20	GPIOX_20
> +#define PIN_GPIOX_21	GPIOX_21
> +
> +#define PIN_GPIOY_0	GPIOY_0
> +#define PIN_GPIOY_1	GPIOY_1
> +/* hole */
> +#define PIN_GPIOY_3	GPIOY_3
> +/* hole */
> +#define PIN_GPIOY_6	GPIOY_6
> +#define PIN_GPIOY_7	GPIOY_7
> +#define PIN_GPIOY_8	GPIOY_8
> +#define PIN_GPIOY_9	GPIOY_9
> +#define PIN_GPIOY_10	GPIOY_10
> +#define PIN_GPIOY_11	GPIOY_11
> +#define PIN_GPIOY_12	GPIOY_12
> +#define PIN_GPIOY_13	GPIOY_13
> +#define PIN_GPIOY_14	GPIOY_14
> +
> +/* hole */
> +#define PIN_GPIODV_9	GPIODV_9
> +/* hole */
> +#define PIN_GPIODV_24	GPIODV_24
> +#define PIN_GPIODV_25	GPIODV_25
> +#define PIN_GPIODV_26	GPIODV_26
> +#define PIN_GPIODV_27	GPIODV_27
> +#define PIN_GPIODV_28	GPIODV_28
> +#define PIN_GPIODV_29	GPIODV_29
> +
> +#define PIN_GPIOH_0	GPIOH_0
> +#define PIN_GPIOH_1	GPIOH_1
> +#define PIN_GPIOH_2	GPIOH_2
> +#define PIN_GPIOH_3	GPIOH_3
> +#define PIN_GPIOH_4	GPIOH_4
> +#define PIN_GPIOH_5	GPIOH_5
> +#define PIN_GPIOH_6	GPIOH_6
> +#define PIN_GPIOH_7	GPIOH_7
> +#define PIN_GPIOH_8	GPIOH_8
> +#define PIN_GPIOH_9	GPIOH_9
> +
> +#define PIN_CARD_0	CARD_0
> +#define PIN_CARD_1	CARD_1
> +#define PIN_CARD_2	CARD_2
> +#define PIN_CARD_3	CARD_3
> +#define PIN_CARD_4	CARD_4
> +#define PIN_CARD_5	CARD_5
> +#define PIN_CARD_6	CARD_6
> +
> +#define PIN_BOOT_0	BOOT_0
> +#define PIN_BOOT_1	BOOT_1
> +#define PIN_BOOT_2	BOOT_2
> +#define PIN_BOOT_3	BOOT_3
> +#define PIN_BOOT_4	BOOT_4
> +#define PIN_BOOT_5	BOOT_5
> +#define PIN_BOOT_6	BOOT_6
> +#define PIN_BOOT_7	BOOT_7
> +#define PIN_BOOT_8	BOOT_8
> +#define PIN_BOOT_9	BOOT_9
> +#define PIN_BOOT_10	BOOT_10
> +#define PIN_BOOT_11	BOOT_11
> +#define PIN_BOOT_12	BOOT_12
> +#define PIN_BOOT_13	BOOT_13
> +#define PIN_BOOT_14	BOOT_14
> +#define PIN_BOOT_15	BOOT_15
> +#define PIN_BOOT_16	BOOT_16
> +#define PIN_BOOT_17	BOOT_17
> +#define PIN_BOOT_18	BOOT_18
> +
> +#define PIN_DIF_0_P	(DIF_OFFSET + DIF_0_P)
> +#define PIN_DIF_0_N	(DIF_OFFSET + DIF_0_N)
> +#define PIN_DIF_1_P	(DIF_OFFSET + DIF_1_P)
> +#define PIN_DIF_1_N	(DIF_OFFSET + DIF_1_N)
> +#define PIN_DIF_2_P	(DIF_OFFSET + DIF_2_P)
> +#define PIN_DIF_2_N	(DIF_OFFSET + DIF_2_N)
> +#define PIN_DIF_3_P	(DIF_OFFSET + DIF_3_P)
> +#define PIN_DIF_3_N	(DIF_OFFSET + DIF_3_N)
> +#define PIN_DIF_4_P	(DIF_OFFSET + DIF_4_P)
> +#define PIN_DIF_4_N	(DIF_OFFSET + DIF_4_N)
> +
> +#define PIN_GPIOAO_0	(AO_OFFSET + GPIOAO_0)
> +#define PIN_GPIOAO_1	(AO_OFFSET + GPIOAO_1)
> +#define PIN_GPIOAO_2	(AO_OFFSET + GPIOAO_2)
> +#define PIN_GPIOAO_3	(AO_OFFSET + GPIOAO_3)
> +#define PIN_GPIOAO_4	(AO_OFFSET + GPIOAO_4)
> +#define PIN_GPIOAO_5	(AO_OFFSET + GPIOAO_5)
> +#define PIN_GPIOAO_6	(AO_OFFSET + GPIOAO_6)
> +#define PIN_GPIOAO_7	(AO_OFFSET + GPIOAO_7)
> +#define PIN_GPIOAO_8	(AO_OFFSET + GPIOAO_8)
> +#define PIN_GPIOAO_9	(AO_OFFSET + GPIOAO_9)
> +#define PIN_GPIOAO_10	(AO_OFFSET + GPIOAO_10)
> +#define PIN_GPIOAO_11	(AO_OFFSET + GPIOAO_11)
> +#define PIN_GPIOAO_12	(AO_OFFSET + GPIOAO_12)
> +#define PIN_GPIOAO_13	(AO_OFFSET + GPIOAO_13)
> +
> +#define PIN_GPIO_BSD_EN	(AO_OFFSET + GPIO_BSD_EN)
> +#define PIN_GPIO_TEST_N	(AO_OFFSET + GPIO_TEST_N)

Could we just have sets of PIN_GPIOAO(x)
there's a lot of code in here which could be compressed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
