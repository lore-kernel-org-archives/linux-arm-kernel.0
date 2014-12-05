From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 5 Dec 2014 14:38:27 +0100
Subject: [PATCH v2 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY.
In-Reply-To: <1417783941-2418-2-git-send-email-lyz@rock-chips.com>
References: <1417783941-2418-1-git-send-email-lyz@rock-chips.com>
 <1417783941-2418-2-git-send-email-lyz@rock-chips.com>
Message-ID: <CABgxDoLe2RxCjD53uvTgYZ=tNOKHLeGoZE5Aa5XvaUYvNX=HYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some quick comments

2014-12-05 13:52 GMT+01:00 Yunzhi Li <lyz@rock-chips.com>:
> This patche to add a generic PHY driver for ROCKCHIP usb PHYs,
> currently this driver can support RK3288. The RK3288 SoC have
> three independent USB PHY IPs which are all configured through a
> set of registers located in the GRF (general register files)
> module.
>
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
> ---
>
>  drivers/phy/Kconfig            |   7 ++
>  drivers/phy/Makefile           |   1 +
>  drivers/phy/phy-rockchip-usb.c | 179 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/phy/phy-rockchip-usb.c
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index ccad880..e3a5857 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -239,6 +239,13 @@ config PHY_QCOM_IPQ806X_SATA
>         depends on OF
>         select GENERIC_PHY
>
> +config PHY_ROCKCHIP_RK3288_USB2
> +       tristate "Rockchip USB2 RK3288 PHY Driver"
> +       depends on ARCH_ROCKCHIP && OF
> +       select GENERIC_PHY
> +       help
> +         Enable this to support the Rockchip USB 2.0 PHY.
> +


The C module is named phy-rockchip-usb.c, why did you call the config
entry PHY_ROCKCHIP_RK3288_USB2 ? why RK3288 ? this driver might be
ported to old SoCs later.
I think that PHY_ROCKCHIP_USB would be enough.

> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#define ROCKCHIP_RK3288_UOC(n) (0x320 + n * 0x14)
> +
> +#define SIDDQ_MSK              (1 << (13 + 16))
> +#define SIDDQ_ON               (1 << 13)

You could probably use BIT(13) and BIT(13+16) here.

Thanks,
Romain
