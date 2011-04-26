From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 26 Apr 2011 17:18:47 +0530
Subject: [PATCH 15/15] OMAP: GPIO: cleanup show revision, remove cpu_is
	checks, display only once
In-Reply-To: <1303513327-14532-16-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-16-git-send-email-khilman@ti.com>
Message-ID: <BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Remove cpu_is_* checks from gpio_show_revision() by passing in the
> revision address offset from platform data. ?SoCs with no revision
> register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.
>
> While here, all GPIO banks are assumed to be the same revision, so fix
> show_revision() to only show the revision for the first bank it finds.
> This removes duplicate GPIO revision prints during boot.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap1/gpio15xx.c ? ? ? ? | ? ?2 ++
> ?arch/arm/mach-omap1/gpio16xx.c ? ? ? ? | ? ?2 ++
> ?arch/arm/mach-omap1/gpio7xx.c ? ? ? ? ?| ? ?2 ++
> ?arch/arm/mach-omap2/gpio.c ? ? ? ? ? ? | ? ?2 ++
> ?arch/arm/plat-omap/gpio.c ? ? ? ? ? ? ?| ? 14 ++++++--------
> ?arch/arm/plat-omap/include/plat/gpio.h | ? ?1 +
> ?6 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index 9175624..6f77c36 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
> ?};
>
> ?static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
> + ? ? ? .revision ? ? ? = -1,

Assigning -1 to u16 type. Instead you may want to use 0xffff?

> ? ? ? ?.direction ? ? ?= OMAP_MPUIO_IO_CNTL,
> ? ? ? ?.datain ? ? ? ? = OMAP_MPUIO_INPUT_LATCH,
> ? ? ? ?.dataout ? ? ? ?= OMAP_MPUIO_OUTPUT,
> @@ -75,6 +76,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
> ?};

<<snip>>

> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 7a3f067..91e8de3 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -175,6 +175,7 @@ struct omap_gpio_dev_attr {
> ?};
>
> ?struct omap_gpio_reg_offs {
> + ? ? ? u16 revision;
> ? ? ? ?u16 direction;
> ? ? ? ?u16 datain;
> ? ? ? ?u16 dataout;

-V Charulatha
