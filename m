From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Oct 2012 09:40:06 -0700
Subject: [PATCH v2 06/14] mtd: onenand: omap: use pdata info instead of
 cpu_is
In-Reply-To: <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
References: <cover.1349672877.git.afzal@ti.com>
 <860ba92c34cbb490beccd5442087087c1751a6a2.1349672877.git.afzal@ti.com>
 <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
Message-ID: <20121026164005.GD11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121025 18:50]:
> Hi Afzal
> 
> On Mon, 8 Oct 2012, Afzal Mohammed wrote:
> 
> > platform data now contains a field to indicate whether
> > soc belongs to omap34xx family, use it instead of
> > cpu_is_* check.
> > 
> > This helps in removing dependency of platform specific
> > header file - cpu.h
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> This one breaks an N800 multi-OMAP build here:
> 
>   LD      init/built-in.o
> drivers/built-in.o: In function `omap2_onenand_probe':
> /home/paul/linux-bisect/drivers/mtd/onenand/omap2.c:788: undefined 
> reference to `omap3_onenand_read_bufferram'
> /home/paul/linux-bisect/drivers/mtd/onenand/omap2.c:788: undefined 
> reference to `omap3_onenand_write_bufferram'
> make: *** [vmlinux] Error 1
> 
> A fix is below.

If you can add this too into your fixes branch on top of
omap-for-v3.8/cleanup-headers that would be nice.

Regards,

Tony

> ---
>  drivers/mtd/onenand/omap2.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 53069ae..f87cf39 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -445,13 +445,19 @@ out_copy:
>  
>  #else
>  
> -int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -				 unsigned char *buffer, int offset,
> -				 size_t count);
> +static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> +					unsigned char *buffer, int offset,
> +					size_t count)
> +{
> +	return -ENOSYS;
> +}
>  
> -int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -				  const unsigned char *buffer,
> -				  int offset, size_t count);
> +static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> +					 const unsigned char *buffer,
> +					 int offset, size_t count)
> +{
> +	return -ENOSYS;
> +}
>  
>  #endif
>  
> -- 
> 1.7.10.4
> 
