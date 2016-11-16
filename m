From: jagan@openedev.com (Jagan Teki)
Date: Wed, 16 Nov 2016 23:14:24 +0530
Subject: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S family flash
In-Reply-To: <1471505884-33996-6-git-send-email-B56489@freescale.com>
References: <1471505884-33996-1-git-send-email-B56489@freescale.com>
 <1471505884-33996-6-git-send-email-B56489@freescale.com>
Message-ID: <CAD6G_RTmFksos0Y33U0wsw52z4PqXWxVwFUN6kmOtFxPJGWLPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 1:08 PM, Yunhui Cui <B56489@freescale.com> wrote:
> From: Yunhui Cui <yunhui.cui@nxp.com>
>
> With the physical sectors combination, S25FS-S family flash
> requires some special operations for read/write functions.
>
> Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 56 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d0fc165..495d0bb 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -39,6 +39,10 @@
>
>  #define SPI_NOR_MAX_ID_LEN     6
>  #define SPI_NOR_MAX_ADDR_WIDTH 4
> +/* Added for S25FS-S family flash */
> +#define SPINOR_CONFIG_REG3_OFFSET      0x800004
> +#define CR3V_4KB_ERASE_UNABLE  0x8
> +#define SPINOR_S25FS_FAMILY_EXT_JEDEC  0x81
>
>  struct flash_info {
>         char            *name;
> @@ -78,6 +82,7 @@ struct flash_info {
>  };
>
>  #define JEDEC_MFR(info)        ((info)->id[0])
> +#define EXT_JEDEC(info)        ((info)->id[5])
>
>  static const struct flash_info *spi_nor_match_id(const char *name);
>
> @@ -899,6 +904,7 @@ static const struct flash_info spi_nor_ids[] = {
>          */
>         { "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512, 0)},

Handling normal and parameter sectors on specific chip part look quite
messy, and this patch[1] will erase SECT_4K by seeing whole flash as
normal sectors.

[1] https://patchwork.kernel.org/patch/9266541/

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
