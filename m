From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Oct 2010 16:06:23 +0300
Subject: [PATCH] omap3: various code improvements for IGEP v2 board.
In-Reply-To: <1286878570-1973-1-git-send-email-eballetbo@gmail.com>
References: <1286878570-1973-1-git-send-email-eballetbo@gmail.com>
Message-ID: <20101012130623.GP2965@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 12, 2010 at 05:16:10AM -0500, Enric Balletbo i Serra wrote:
>The comments of this post also apply to IGEP v2 board (thanks Laurent)
>
>  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg36402.html
>
>Changes are:
>
>  - Set onenand_setup to NULL instead of adding a no-op function.
>  - On igep2_flash_init() function:
>    - Use 'for' loop instead 'while' loop.
>    - No need to initialize ret to 0, we're assigning it right after.
>    - No need to check for onenandcs < GPMC_CS_NUM here, it will always be true.
>  - omap_board_config_size is implicitly initialized to 0 in
>    plat-omap/common.c, get_config() won't dereference omap_board_config,
>    so we can remove the empty igep2_config array.

you should probably split this patch in a series.

>Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>---
> arch/arm/mach-omap2/board-igep0020.c |   39 ++++++++++++---------------------
> 1 files changed, 14 insertions(+), 25 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
>index 152f757..ddcfd06 100644
>--- a/arch/arm/mach-omap2/board-igep0020.c
>+++ b/arch/arm/mach-omap2/board-igep0020.c
>@@ -136,16 +136,10 @@ static struct mtd_partition igep2_onenand_partitions[] = {
> 	},
> };
>
>-static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
>-{
>-       /* nothing is required to be setup for onenand as of now */
>-       return 0;
>-}
>-
> static struct omap_onenand_platform_data igep2_onenand_data = {
> 	.parts = igep2_onenand_partitions,
> 	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
>-	.onenand_setup = igep2_onenand_setup,
>+	.onenand_setup = NULL,

static variable. Just remove the line ;-)

-- 
balbi
