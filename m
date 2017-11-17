From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:20:02 +0100
Subject: [PATCH 3/4] pinctrl: meson-axg: Add new pinctrl driver for Meson
 AXG SoC
In-Reply-To: <20171108064717.32577-2-yixun.lan@amlogic.com>
References: <20171108064717.32577-1-yixun.lan@amlogic.com>
 <20171108064717.32577-2-yixun.lan@amlogic.com>
Message-ID: <9770393f-a53c-dce0-aab4-a259aada95b6@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2017 07:47, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Add new pinctrl driver for Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/pinctrl/meson/Kconfig             |   6 +
>  drivers/pinctrl/meson/Makefile            |   1 +
>  drivers/pinctrl/meson/pinctrl-meson-axg.c | 976 ++++++++++++++++++++++++++++++
>  include/dt-bindings/gpio/meson-axg-gpio.h | 116 ++++
>  4 files changed, 1099 insertions(+)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg.c
>  create mode 100644 include/dt-bindings/gpio/meson-axg-gpio.h
> 
> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> index fe5e6ca88412..c80951d6caff 100644
> --- a/drivers/pinctrl/meson/Kconfig
> +++ b/drivers/pinctrl/meson/Kconfig
> @@ -38,6 +38,12 @@ config PINCTRL_MESON_GXL
>  config PINCTRL_MESON8_PMX
>  	bool
>  
> +config PINCTRL_MESON_AXG
> +	bool "Meson axg Soc pinctrl driver"
> +	depends on ARM64
> +	select PINCTRL_MESON_AXG_PMX
> +	default y
> +
>  config PINCTRL_MESON_AXG_PMX
>  	bool
>  
> diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefile
> index 8de839512677..3c6580c2d9d7 100644
> --- a/drivers/pinctrl/meson/Makefile
> +++ b/drivers/pinctrl/meson/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_PINCTRL_MESON8B) += pinctrl-meson8b.o
>  obj-$(CONFIG_PINCTRL_MESON_GXBB) += pinctrl-meson-gxbb.o
>  obj-$(CONFIG_PINCTRL_MESON_GXL) += pinctrl-meson-gxl.o
>  obj-$(CONFIG_PINCTRL_MESON_AXG_PMX) += pinctrl-meson-axg-pmx.o
> +obj-$(CONFIG_PINCTRL_MESON_AXG) += pinctrl-meson-axg.o
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> new file mode 100644
> index 000000000000..1f541dc79a04
> --- /dev/null
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -0,0 +1,976 @@
> +/*
> + * Pin controller and GPIO driver for Amlogic Meson AXG SoC.
> + *
> + * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ or MIT)
> + */
> +
> +#include <dt-bindings/gpio/meson-axg-gpio.h>
> +#include "pinctrl-meson.h"
> +#include "pinctrl-meson-axg-pmx.h"
> +

[...]

> +};
> +
> +static const char * const i2c_m0_groups[] = {
> +	"i2c_sck_m0", "i2c_sda_m0",
> +};
> +
> +static const char * const i2c_m1_groups[] = {
> +	"i2c_sck_m1_z", "i2c_sda_m1_z",
> +	"i2c_sck_m1_x", "i2c_sda_m1_x",
> +};
> +
> +static const char * const i2c_m2_groups[] = {
> +	"i2c_sck_m2_x", "i2c_sda_m2_x",
> +	"i2c_sda_m2_a", "i2c_sck_m2_a",
> +};
> +
> +static const char * const i2c_m3_groups[] = {
> +	"i2c_sda_m3_a6", "i2c_sck_m3_a7",
> +	"i2c_sda_m3_a12", "i2c_sck_m3_a13",
> +	"i2c_sda_m3_a19", "i2c_sck_m3_a20",
> +};

Same comment as i2c patchset, you should keep the i2c/A/B/C/D for consistency with GX driver and bindings.

Neil

> +
> +static const char * const eth_groups[] = {
> +	"eth_rxd2_rgmii", "eth_rxd3_rgmii", "eth_rgmii_tx_clk",
> +	"eth_txd2_rgmii", "eth_txd3_rgmii",
> +	"eth_txd0_x", "eth_txd1_x", "eth_txen_x", "eth_rgmii_rx_clk_x",
> +	"eth_rxd0_x", "eth_rxd1_x", "eth_rx_dv_x", "eth_mdio_x",
> +	"eth_mdc_x",
> +	"eth_txd0_y", "eth_txd1_y", "eth_txen_y", "eth_rgmii_rx_clk_y",
> +	"eth_rxd0_y", "eth_rxd1_y", "eth_rx_dv_y", "eth_mdio_y",
> +	"eth_mdc_y",
> +};
> +

[...]

Apart from that,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
