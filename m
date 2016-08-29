From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Aug 2016 14:57:53 +0200
Subject: [PATCH 1/2] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <20160829110456.12206-1-sr@denx.de>
References: <20160829110456.12206-1-sr@denx.de>
Message-ID: <20160829125753.GC12465@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 01:04:55PM +0200, Stefan Roese wrote:
> This patch provides a stub function for mvebu_mbus_get_io_win_info(),
> which will be used for all non-Orion (ARM32 MVEBU) platforms for
> compile test coverage.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Marcin Wojtas <mw@semihalf.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
>  include/linux/mbus.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mbus.h b/include/linux/mbus.h
> index d610232..a884405 100644
> --- a/include/linux/mbus.h
> +++ b/include/linux/mbus.h
> @@ -55,6 +55,8 @@ struct mbus_dram_target_info
>  #ifdef CONFIG_PLAT_ORION
>  extern const struct mbus_dram_target_info *mv_mbus_dram_info(void);
>  extern const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(void);
> +int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size, u8 *target,
> +			       u8 *attr);
>  #else
>  static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
>  {
> @@ -64,14 +66,17 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(vo
>  {
>  	return NULL;
>  }
> +static inline int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size,
> +					     u8 *target, u8 *attr)
> +{
> +	return 0;
> +}
>  #endif

Hi Stefan

If i understand it correctly, this should never be used for real, it
is here only for compile testing?

Maybe add a WARN_ON_ONCE(1) here? And a comment, why it should never
happen.

Thanks

      Andrew
