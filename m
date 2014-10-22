From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 21 Oct 2014 22:53:26 -0700
Subject: [PATCH] ARM: don't set unused name in struct flash_platform_data
In-Reply-To: <1411993853-6309-1-git-send-email-zajec5@gmail.com>
References: <1411993853-6309-1-git-send-email-zajec5@gmail.com>
Message-ID: <20141022055326.GB16128@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 02:30:53PM +0200, Rafa? Mi?ecki wrote:
> Loading correct SPI driver (m25p80) is handled using modalias from the
> struct spi_board_info. There is no point of setting name in the
> platform_data, m25p80 ignores it anyway.

Wait, is 'name' actually ignored? It looks to me like it sets the MTD
name. See the comments in include/linux/spi/flash.h and
arch/arm/include/asm/mach/flash.h (BTW, why do we have two definitions
for this??):

  @name: optional flash device name (eg, as used with mtdparts=)

And I think it's used for exactly that in m25p80.c:

	if (data && data->name)
		flash->mtd.name = data->name;

> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c    | 1 -
>  arch/arm/mach-davinci/board-da850-evm.c    | 1 -
>  arch/arm/mach-davinci/board-mityomapl138.c | 1 -
>  arch/arm/mach-shmobile/board-bockw.c       | 1 -
>  arch/arm/mach-shmobile/board-koelsch.c     | 1 -
>  arch/arm/mach-shmobile/board-lager.c       | 1 -
>  arch/arm/mach-w90x900/dev.c                | 1 -
>  7 files changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 5623131..263004a 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -567,7 +567,6 @@ static struct mtd_partition da830evm_spiflash_part[] = {
>  };
>  
>  static struct flash_platform_data da830evm_spiflash_data = {
> -	.name		= "m25p80",
>  	.parts		= da830evm_spiflash_part,
>  	.nr_parts	= ARRAY_SIZE(da830evm_spiflash_part),
>  	.type		= "w25x32",
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 234c5bb..721ff2b 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -104,7 +104,6 @@ static struct mtd_partition da850evm_spiflash_part[] = {
>  };
>  
>  static struct flash_platform_data da850evm_spiflash_data = {
> -	.name		= "m25p80",
>  	.parts		= da850evm_spiflash_part,
>  	.nr_parts	= ARRAY_SIZE(da850evm_spiflash_part),
>  	.type		= "m25p64",
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 96fc00a..3c93b65 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -350,7 +350,6 @@ static struct mtd_partition spi_flash_partitions[] = {
>  };
>  
>  static struct flash_platform_data mityomapl138_spi_flash_data = {
> -	.name		= "m25p80",
>  	.parts		= spi_flash_partitions,
>  	.nr_parts	= ARRAY_SIZE(spi_flash_partitions),
>  	.type		= "m24p64",
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 8a83eb3..e25af56 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -266,7 +266,6 @@ static struct mtd_partition m25p80_spi_flash_partitions[] = {
>  };
>  
>  static struct flash_platform_data spi_flash_data = {
> -	.name		= "m25p80",
>  	.type		= "s25fl008k",
>  	.parts		= m25p80_spi_flash_partitions,
>  	.nr_parts	= ARRAY_SIZE(m25p80_spi_flash_partitions),
> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index b7d5bc7..a494a00 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
> @@ -207,7 +207,6 @@ static struct mtd_partition spi_flash_part[] = {
>  };
>  
>  static const struct flash_platform_data spi_flash_data = {
> -	.name		= "m25p80",
>  	.parts		= spi_flash_part,
>  	.nr_parts	= ARRAY_SIZE(spi_flash_part),
>  	.type		= "s25fl512s",
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index e1d8215..3575731 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -315,7 +315,6 @@ static struct mtd_partition spi_flash_part[] = {
>  };
>  
>  static const struct flash_platform_data spi_flash_data = {
> -	.name           = "m25p80",
>  	.parts          = spi_flash_part,
>  	.nr_parts       = ARRAY_SIZE(spi_flash_part),
>  	.type           = "s25fl512s",
> diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
> index e65a80a..9745a73 100644
> --- a/arch/arm/mach-w90x900/dev.c
> +++ b/arch/arm/mach-w90x900/dev.c
> @@ -249,7 +249,6 @@ static struct mtd_partition nuc900_spi_flash_partitions[] = {
>  };
>  
>  static struct flash_platform_data nuc900_spi_flash_data = {
> -	.name = "m25p80",
>  	.parts =  nuc900_spi_flash_partitions,
>  	.nr_parts = ARRAY_SIZE(nuc900_spi_flash_partitions),
>  	.type = "w25x16",

Brian
