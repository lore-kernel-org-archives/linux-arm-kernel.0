From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Dec 2010 08:57:34 +0200
Subject: [PATCH 06/10] ARM: mx28: update clocks for dual fec support
In-Reply-To: <1293548155-16328-7-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-7-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101229065734.GC31010@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Dec 28, 2010 at 10:55:51PM +0800, Shawn Guo wrote:
> * Change fec clock registration to use con_id only for looking up,
>   so that dual fec driver can find the same clock for both fec0
>   and fec1.
> 
> * Explicitly call clk_enable for some clocks that have been on to
>   reflect the clock status and get usecount updated. Otherwise,
>   clocks could be turned off by pair call of clk_enable/clk_disable
>   in drivers, because of the incorrect initial usecount.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index dd6d158..6b77aff 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -603,7 +603,7 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
>  
>  static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("uart", NULL, uart_clk)
> -	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> +	_REGISTER_CLOCK(NULL, "fec_clk", fec_clk)

Looks like a wrong use of the clk API. You should define define two clocks 
"fec.0" and "fec.1".

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
