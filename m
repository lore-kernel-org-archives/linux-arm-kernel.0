From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 4 Jun 2013 07:36:20 +0300
Subject: [PATCH 3/3] clocksource: dw_apb_timer_of: use clocksource_of_init
In-Reply-To: <201306032159.55685.heiko@sntech.de>
References: <201306032157.40488.heiko@sntech.de>
 <201306032159.55685.heiko@sntech.de>
Message-ID: <20130604043620.GU11798@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Mon, Jun 03, 2013 at 09:59:55PM +0200, Heiko St?bner wrote:
> dw_apb_timer_init used to search the devicetree for matching timer
> devices, making calls to it from board files necessary.
> 
> Change the dw_apb_timer_init to work with CLOCKSOURCE_OF_DECLARE.
> With this change the function gets called once for each timer node
> and tracks these number of calls to attach clockevent and clocksource
> devices to the nodes.
> 
> Also remove the calls to dw_apb_timer_init from all previous users, as
> clocksource_of_init is the default for init_time now.
> 
> Tested on the upcoming rk3066 code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-picoxcell/Kconfig       |    1 +
>  arch/arm/mach-picoxcell/common.c      |    2 -
>  arch/arm/mach-socfpga/Kconfig         |    1 +
>  arch/arm/mach-socfpga/socfpga.c       |    2 -
>  drivers/clocksource/dw_apb_timer_of.c |   41 ++++++++++++++++-----------------
>  include/linux/dw_apb_timer.h          |    1 -
>  6 files changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
> index 13bae78..3ef6bbe 100644
> --- a/arch/arm/mach-picoxcell/Kconfig
> +++ b/arch/arm/mach-picoxcell/Kconfig
> @@ -6,6 +6,7 @@ config ARCH_PICOXCELL
>  	select CPU_V6K
>  	select DW_APB_TIMER
>  	select DW_APB_TIMER_OF
> +	select CLKSRC_OF

Shouldn't DW_APB_TIMER 'select CLKSRC_OF if OF' instead of selecting is for 
each and every platform? While at it we can do the same to DW_APB_TIMER_OF.

baruch


-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
