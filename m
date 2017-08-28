From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Aug 2017 14:42:23 +0200
Subject: [PATCH 3/4] nvmem: rockchip: add support for RK3368
In-Reply-To: <20170828121604.15968-4-romain.perier@collabora.com>
References: <20170828121604.15968-1-romain.perier@collabora.com>
 <20170828121604.15968-4-romain.perier@collabora.com>
Message-ID: <2766234.AhINhDhIBZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

Am Montag, 28. August 2017, 14:16:03 CEST schrieb Romain Perier:
> This adds the necessary functions and data for handling support on RK3368
> SoCs.

Would need a lot more explanation regarding the special use for
SMC calls for efuse access.


> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +
>  drivers/nvmem/rockchip-efuse.c                     | 80
> ++++++++++++++++++++++ 2 files changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt index
> 1ff02afdc55a..60bec4782806 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> @@ -6,6 +6,7 @@ Required properties:
>    - "rockchip,rk3188-efuse" - for RK3188 SoCs.
>    - "rockchip,rk3228-efuse" - for RK3228 SoCs.
>    - "rockchip,rk3288-efuse" - for RK3288 SoCs.
> +  - "rockchip,rk3368-efuse" - for RK3368 SoCs.
>    - "rockchip,rk3399-efuse" - for RK3399 SoCs.
>  - reg: Should contain the registers location and exact eFuse size
>  - clocks: Should be the clock id of eFuse
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index 63e3eb55f3ac..4e11f251035f 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -14,6 +14,7 @@
>   * more details.
>   */
> 
> +#include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -46,9 +47,17 @@
>  #define REG_EFUSE_CTRL		0x0000
>  #define REG_EFUSE_DOUT		0x0004
> 
> +/* SMC function IDs for SiP Service queries */
> +#define ROCKCHIP_SIP_ACCESS_REG	0x82000002
> +
> +/* SIP access registers: read or write */
> +#define ROCKCHIP_SIP_SECURE_REG_RD	0x0
> +#define ROCKCHIP_SIP_SECURE_REG_WR	0x1
> +

Going through SMC calls does _not_ look right.

For one even the newest rk3399 can handle its efuse using
regular means, so the rk3368 being  somehow special feels strange.

And even if that is a sanctioned approach, the smc calls are not
part of the upstream arm-trusted-firmware at this moment
and we definitly don't want to codify private unreviewed
interfaces between the mainline kernel and firmware.

See empty smc calls for rk3368 on [0] and used smc-calls on the rk3399
in [1] and I also didn't see any open pull request for something like this.


Heiko

[0] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3368/plat_sip_calls.c
[1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3399/plat_sip_calls.c
