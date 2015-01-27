From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Jan 2015 11:42:08 -0300
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <54C7A3C0.6020507@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2015 11:10 AM, Antoine Tenart wrote:
> The nand controller on Marvell Berlin SoC reuse the pxa3xx nand driver
> as it quite close. The process of sending commands can be compared to
> the one of the Marvell armada 370: read and write commands are done in
> chunks.
> 
> But the Berlin nand controller has some other specificities which
> require some modifications of the pxa3xx nand driver:
> - there are no IRQ available so we need to poll the status register: we
>   have to use our own cmdfunc Berlin function, and early on the probing
>   function.
> - PAGEPROG are very different from the one used in the pxa3xx driver,
>   so we're using a specific process for this one
> - the SEQIN command is equivalent to a READ0 command
> - the RNDOUT command must be used to perform a read operation, and the
>   command is not NAND_CMD_RNDOUT
> - the ERASE1 command is specific (0xd060)
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 287 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 261 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index b2783b1f663c..62ea369dc524 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -109,6 +109,8 @@
>  #define NDCB0_EXT_CMD_TYPE(x)	(((x) << 29) & NDCB0_EXT_CMD_TYPE_MASK)
>  #define NDCB0_CMD_TYPE_MASK	(0x7 << 21)
>  #define NDCB0_CMD_TYPE(x)	(((x) << 21) & NDCB0_CMD_TYPE_MASK)
> +#define NDCB0_CMD_XTYPE_MASK	(0x7 << 29)
> +#define NDCB0_CMD_XTYPE(x)	(((x) << 29) & NDCB0_CMD_XTYPE_MASK)
>  #define NDCB0_NC		(0x1 << 20)
>  #define NDCB0_DBC		(0x1 << 19)
>  #define NDCB0_ADDR_CYC_MASK	(0x7 << 16)
> @@ -117,13 +119,20 @@
>  #define NDCB0_CMD1_MASK		(0xff)
>  #define NDCB0_ADDR_CYC_SHIFT	(16)
>  
> -#define EXT_CMD_TYPE_DISPATCH	6 /* Command dispatch */
> -#define EXT_CMD_TYPE_NAKED_RW	5 /* Naked read or Naked write */
> -#define EXT_CMD_TYPE_READ	4 /* Read */
> -#define EXT_CMD_TYPE_DISP_WR	4 /* Command dispatch with write */
> -#define EXT_CMD_TYPE_FINAL	3 /* Final command */
> -#define EXT_CMD_TYPE_LAST_RW	1 /* Last naked read/write */
> -#define EXT_CMD_TYPE_MONO	0 /* Monolithic read/write */
> +#define EXT_CMD_TYPE_LAST_PAGEPROG	10
> +#define EXT_CMD_TYPE_CHUNK_PAGEPROG	9
> +#define EXT_CMD_TYPE_LAST_RNDOUT	8
> +#define EXT_CMD_TYPE_CHUNK_RNDOUT	7
> +#define EXT_CMD_TYPE_DISPATCH		6 /* Command dispatch */
> +#define EXT_CMD_TYPE_NAKED_RW		5 /* Naked read or Naked write */
> +#define EXT_CMD_TYPE_READ		4 /* Read */
> +#define EXT_CMD_TYPE_DISP_WR		4 /* Command dispatch with write */
> +#define EXT_CMD_TYPE_FINAL		3 /* Final command */
> +#define EXT_CMD_TYPE_LAST_RW		1 /* Last naked read/write */
> +#define EXT_CMD_TYPE_MONO		0 /* Monolithic read/write */
> +
> +#define BERLIN_NAND_CMD_RNDOUT		0x3000
> +#define BERLIN_NAND_CMD_ERASE1		0xd060
>  
>  /* macros for registers read/write */
>  #define nand_writel(info, off, val)	\
> @@ -158,6 +167,7 @@ enum {
>  enum pxa3xx_nand_variant {
>  	PXA3XX_NAND_VARIANT_PXA,
>  	PXA3XX_NAND_VARIANT_ARMADA370,
> +	PXA3XX_NAND_VARIANT_BERLIN2,
>  };
>  
>  struct pxa3xx_nand_host {
> @@ -244,10 +254,13 @@ module_param(use_dma, bool, 0444);
>  MODULE_PARM_DESC(use_dma, "enable DMA for data transferring to/from NAND HW");
>  
>  static struct pxa3xx_nand_timing timing[] = {
> -	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
> -	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
> -	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
> -	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
> +	{ 40, 80, 60, 100, 80, 100,  90000, 400, 40, },
> +	{ 10,  0, 20,  40, 30,  40,  11123, 110, 10, },
> +	{ 10, 25, 15,  25, 15,  30,  25000,  60, 10, },
> +	{ 10, 35, 15,  25, 15,  25,  25000,  60, 10, },
> +	{  5, 20, 10,  12, 10,  12,  60000,  60, 10, },
> +	{  5, 20, 10,  12, 10,  12, 200000, 120, 10, },
> +	{  5, 15, 10,  15, 10,  15,  60000,  60, 10, },
>  };
>  
>  static struct pxa3xx_nand_flash builtin_flash_types[] = {
> @@ -260,6 +273,20 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
>  { "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
>  { "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
>  { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
> +{ },
> +};
> +
> +static struct pxa3xx_nand_flash berlin_builtin_flash_types[] = {
> +{ "2GiB 8-bit",    0xd5ec, 128, 8192,  8,  8, 2048, &timing[4] },
> +{ "2GiB 8-bit",    0xd598, 128, 8192,  8,  8, 2048, &timing[5] },
> +{ "2GiB 8-bit",    0x482c, 256, 4096,  8,  8, 2048, &timing[6] },
> +{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096, &timing[5] },
> +{ "8GiB 8-bit",    0xdeec, 128, 8192,  8,  8, 4096, &timing[5] },
> +{ "4GiB 8-bit",    0xd7ad, 256, 8192,  8,  8, 2048, &timing[5] },
> +{ "4GiB 8-bit",    0x682c, 256, 4096,  8,  8, 4096, &timing[6] },
> +{ "8GiB 8-bit",    0x882c, 256, 8192,  8,  8, 4096, &timing[6] },
> +{ "8GiB 8-bit",    0xdead, 256, 8192,  8,  8, 4096, &timing[6] },
> +{ },
>  };
>  

IMO, this sucks. I was hoping to see this old style probing go away,
instead of be augmented.

There are proper ways to set timings.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
