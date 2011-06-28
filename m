From: svenkatr@ti.com (S, Venkatraman)
Date: Tue, 28 Jun 2011 17:07:05 +0530
Subject: [PATCH] OMAP: HSMMC: Fix GPIO muxing
In-Reply-To: <1309250759-18472-1-git-send-email-silesh@ti.com>
References: <1309250759-18472-1-git-send-email-silesh@ti.com>
Message-ID: <BANLkTin39hkDNa+v=29PLMZRdBtWGCfseA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 2:15 PM, Silesh C V <silesh@ti.com> wrote:
> Use generic gpio call to check the validity of the gpio. Note that
> this includes gpio 0 also which was missing before.
>
> Signed-off-by: Silesh C V <silesh@ti.com>
> ---
> ?arch/arm/mach-omap2/hsmmc.c | ? ?7 +++----
> ?1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 66868c5..a9b45c7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -13,6 +13,7 @@
> ?#include <linux/slab.h>
> ?#include <linux/string.h>
> ?#include <linux/delay.h>
> +#include <linux/gpio.h>
> ?#include <mach/hardware.h>
> ?#include <plat/mmc.h>
> ?#include <plat/omap-pm.h>
> @@ -213,12 +214,10 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
> ?static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
> ? ? ? ? ? ? ? ? ? ? ? ?int controller_nr)
> ?{
> - ? ? ? if ((mmc_controller->slots[0].switch_pin > 0) && \
> - ? ? ? ? ? ? ? (mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
> + ? ? ? if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
> ? ? ? ? ? ? ? ?omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP_PIN_INPUT_PULLUP);
> - ? ? ? if ((mmc_controller->slots[0].gpio_wp > 0) && \
> - ? ? ? ? ? ? ? (mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
> + ? ? ? if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
> ? ? ? ? ? ? ? ?omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP_PIN_INPUT_PULLUP);
> ? ? ? ?if (cpu_is_omap34xx()) {
> --
> 1.7.1
>

Looks good to me.
Reviewed-by: Venkatraman S <svenkatr@ti.com>
