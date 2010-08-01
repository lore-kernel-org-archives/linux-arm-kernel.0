From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Sun, 1 Aug 2010 23:23:35 +0200
Subject: [PATCH 01/11] ARM: cam60: move cam60_spi_devices to .init.data
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTi=hPg-12w9ihz-RsvD0d6Zawus14qF9hamA6nES@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> cam60_spi_devices is passed to at91_add_device_spi which calls
> spi_register_board_info. ?The latter makes a copy of it, so living in
> .init.data is OK.

The  copy still maintains a pointers to
"cam60_spi_flash_platform_data", so I'm wondering if that and
"cam60_spi_partitions" should maybe not be marked as __initdata.


Regards,
  Andrew Victor



> ---
> ?arch/arm/mach-at91/board-cam60.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
> index 02138af..05c7072 100644
> --- a/arch/arm/mach-at91/board-cam60.c
> +++ b/arch/arm/mach-at91/board-cam60.c
> @@ -98,14 +98,14 @@ static struct mtd_partition __initdata cam60_spi_partitions[] = {
> ? ? ? ?},
> ?};
>
> -static struct flash_platform_data __initdata cam60_spi_flash_platform_data = {
> +static struct flash_platform_data cam60_spi_flash_platform_data __initdata = {
> ? ? ? ?.name ? ? ? ? ? = "spi_flash",
> ? ? ? ?.parts ? ? ? ? ?= cam60_spi_partitions,
> ? ? ? ?.nr_parts ? ? ? = ARRAY_SIZE(cam60_spi_partitions)
> ?};
> ?#endif
>
> -static struct spi_board_info cam60_spi_devices[] = {
> +static struct spi_board_info cam60_spi_devices[] __initdata = {
> ?#if defined(CONFIG_MTD_DATAFLASH)
> ? ? ? ?{ ? ? ? /* DataFlash chip */
> ? ? ? ? ? ? ? ?.modalias ? ? ? = "mtd_dataflash",
