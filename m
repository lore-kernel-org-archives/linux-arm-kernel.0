From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 15:06:07 +0200
Subject: [PATCH 1/2 v3] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <20160905072500.30112-1-sr@denx.de> (Stefan Roese's message of
 "Mon, 5 Sep 2016 09:24:59 +0200")
References: <20160905072500.30112-1-sr@denx.de>
Message-ID: <8760pyd41s.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., sept. 05 2016, Stefan Roese <sr@denx.de> wrote:

> This patch provides a stub function for mvebu_mbus_get_io_win_info(),
> which will be used for all non-Orion (ARM32 MVEBU) platforms for
> compile test coverage.
>
> On such platforms this function will return an error so that drivers
> might detect a potential problem.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Vinod, if you happy with the second patch of the series you can apply
both patches on your tree. It will allow to keep the bisactibility, and
as I didn't have any commit modifying these file in my trees it won't
generate merge conflict.

Thanks,

Gregory

>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Marcin Wojtas <mw@semihalf.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
> v3:
> - Include errno.h to fix the compile breakage on ARM64
> - Change comment as suggested by Andrew
> - Added Andrew to Cc
>
> v2:
> - Return error code in stub function. This may be useful on Armada 3700
>   boards. As Armada 3700 does not implement the MBus driver but some
>   device driver might call into these functions anyways (e.g. mvneta).
>
>  include/linux/mbus.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mbus.h b/include/linux/mbus.h
> index d610232..2931aa4 100644
> --- a/include/linux/mbus.h
> +++ b/include/linux/mbus.h
> @@ -11,6 +11,8 @@
>  #ifndef __LINUX_MBUS_H
>  #define __LINUX_MBUS_H
>  
> +#include <linux/errno.h>
> +
>  struct resource;
>  
>  struct mbus_dram_target_info
> @@ -55,6 +57,8 @@ struct mbus_dram_target_info
>  #ifdef CONFIG_PLAT_ORION
>  extern const struct mbus_dram_target_info *mv_mbus_dram_info(void);
>  extern const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(void);
> +int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size, u8 *target,
> +			       u8 *attr);
>  #else
>  static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
>  {
> @@ -64,14 +68,24 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(vo
>  {
>  	return NULL;
>  }
> +static inline int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size,
> +					     u8 *target, u8 *attr)
> +{
> +	/*
> +	 * On all ARM32 MVEBU platforms with MBus support, this stub
> +	 * function will not get called. The real function from the
> +	 * MBus driver is called instead. ARM64 MVEBU platforms like
> +	 * the Armada 3700 could use the mv_xor device driver which calls
> +	 * into this function
> +	 */
> +	return -EINVAL;
> +}
>  #endif
>  
>  int mvebu_mbus_save_cpu_target(u32 __iomem *store_addr);
>  void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
>  void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
>  int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr);
> -int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size, u8 *target,
> -			       u8 *attr);
>  int mvebu_mbus_add_window_remap_by_id(unsigned int target,
>  				      unsigned int attribute,
>  				      phys_addr_t base, size_t size,
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
