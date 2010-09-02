From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Sep 2010 10:43:55 +0900
Subject: [PATCH 12/13] ARM: S5P64X0: Add UART serial support for S5P6450
In-Reply-To: <1283324960-21629-13-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<1283324960-21629-13-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTimxmodJGBQbQONOx870runSEKn5S7Du8Jrsxe1n@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 4:09 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch adds UART serial port support for S5P6450 SoC.
> The S5P6450 has 6 UARTs, so adds resource of UART4 and UART5.
> And to fix membase which is in serial/samsung.c is from Ben Dooks.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> ?arch/arm/plat-s5p/dev-uart.c | ? 58 ++++++++++++++++++++++++++++++++++++++++++
> ?drivers/serial/Kconfig ? ? ? | ? ?7 +++--
> ?drivers/serial/samsung.c ? ? | ? ?2 +-
> ?3 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
> index a89331e..6a73428 100644
> --- a/arch/arm/plat-s5p/dev-uart.c
> +++ b/arch/arm/plat-s5p/dev-uart.c
> @@ -119,6 +119,56 @@ static struct resource s5p_uart3_resource[] = {
> ?#endif
> ?};
>
> +static struct resource s5p_uart4_resource[] = {
> +#if CONFIG_SERIAL_SAMSUNG_UARTS > 4
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= S5P_PA_UART4,
> + ? ? ? ? ? ? ? .end ? ?= S5P_PA_UART4 + S5P_SZ_UART,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_RX4,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_RX4,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_TX4,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_TX4,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> + ? ? ? [3] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_ERR4,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_ERR4,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> +#endif
> +};
> +
> +static struct resource s5p_uart5_resource[] = {
> +#if CONFIG_SERIAL_SAMSUNG_UARTS > 5
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= S5P_PA_UART5,
> + ? ? ? ? ? ? ? .end ? ?= S5P_PA_UART5 + S5P_SZ_UART,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_RX5,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_RX5,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_TX5,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_TX5,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> + ? ? ? [3] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_S5P_UART_ERR5,
> + ? ? ? ? ? ? ? .end ? ?= IRQ_S5P_UART_ERR5,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> +#endif
> +};
> +
> ?struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
> ? ? ? ?[0] = {
> ? ? ? ? ? ? ? ?.resources ? ? ?= s5p_uart0_resource,
> @@ -136,4 +186,12 @@ struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
> ? ? ? ? ? ? ? ?.resources ? ? ?= s5p_uart3_resource,
> ? ? ? ? ? ? ? ?.nr_resources ? = ARRAY_SIZE(s5p_uart3_resource),
> ? ? ? ?},
> + ? ? ? [4] = {
> + ? ? ? ? ? ? ? .resources ? ? ?= s5p_uart4_resource,
> + ? ? ? ? ? ? ? .nr_resources ? = ARRAY_SIZE(s5p_uart4_resource),
> + ? ? ? },
> + ? ? ? [5] = {
> + ? ? ? ? ? ? ? .resources ? ? ?= s5p_uart5_resource,
> + ? ? ? ? ? ? ? .nr_resources ? = ARRAY_SIZE(s5p_uart5_resource),
> + ? ? ? },
> ?};
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 12900f7..3198c53 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -458,6 +458,7 @@ config SERIAL_SAMSUNG_UARTS
> ? ? ? ?int
> ? ? ? ?depends on ARM && PLAT_SAMSUNG
> ? ? ? ?default 2 if ARCH_S3C2400
> + ? ? ? default 6 if ARCH_S5P6450
> ? ? ? ?default 4 if SERIAL_SAMSUNG_UARTS_4
> ? ? ? ?default 3
> ? ? ? ?help

How about to remove SERIAL_SAMSUNG_UARTS_4 and use the
SERIAL_SAMSUNG_UARTS only?

> @@ -526,12 +527,12 @@ config SERIAL_S3C24A0
> ? ? ? ? ?Serial port support for the Samsung S3C24A0 SoC
>
> ?config SERIAL_S3C6400
> - ? ? ? tristate "Samsung S3C6400/S3C6410/S5P6440/S5PC100 Serial port support"
> - ? ? ? depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440 || CPU_S5PC100)
> + ? ? ? tristate "Samsung S3C6400/S3C6410/S5P6440/S5P6450/S5PC100 Serial port support"
> + ? ? ? depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440 || CPU_S5P6450 || CPU_S5PC100)
> ? ? ? ?select SERIAL_SAMSUNG_UARTS_4
> ? ? ? ?default y
> ? ? ? ?help
> - ? ? ? ? Serial port support for the Samsung S3C6400, S3C6410, S5P6440
> + ? ? ? ? Serial port support for the Samsung S3C6400, S3C6410, S5P6440, S5P6450
> ? ? ? ? ?and S5PC100 SoCs
>
> ?config SERIAL_S5PV210
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index b1156ba..7ac2bf5 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -1101,7 +1101,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> ? ? ? ?dbg("resource %p (%lx..%lx)\n", res, res->start, res->end);
>
> ? ? ? ?port->mapbase = res->start;
> - ? ? ? port->membase = S3C_VA_UART + res->start - (S3C_PA_UART & 0xfff00000);
> + ? ? ? port->membase = S3C_VA_UART + (res->start & 0xfffff);
> ? ? ? ?ret = platform_get_irq(platdev, 0);
> ? ? ? ?if (ret < 0)
> ? ? ? ? ? ? ? ?port->irq = 0;
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
