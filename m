From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 31 Mar 2013 17:23:35 -0400
Subject: [PATCH 2/2] Fix GE0/GE1 init on ix2-200 as GE0 has no PHY
In-Reply-To: <1364703204-14982-3-git-send-email-nigel@nobiscuit.com>
References: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
 <1364703204-14982-3-git-send-email-nigel@nobiscuit.com>
Message-ID: <20130331212335.GM13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nigel,

On Sun, Mar 31, 2013 at 03:13:24PM +1100, Nigel Roberts wrote:

Please include a description here about the problem and how this fixed
it.

Also, please Cc: Alan Butler alanbutty12 at gmail.com, he's the original
author of the support for this board.  I'd like to know why it
(hopefully) worked for him, but doesn't work for you.

> ---
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> index f655b26..e5f7041 100644
> --- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> +++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> @@ -20,10 +20,15 @@ static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
>  	.duplex         = DUPLEX_FULL,
>  };
>  
> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
> +        .phy_addr       = MV643XX_ETH_PHY_ADDR(11),
> +};
> +
>  void __init iomega_ix2_200_init(void)
>  {
>  	/*
>  	 * Basic setup. Needs to be called early.
>  	 */
> -	kirkwood_ge01_init(&iomega_ix2_200_ge00_data);
> +	kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
> +	kirkwood_ge01_init(&iomega_ix2_200_ge01_data);

This looks a lot more legit, have you tried removing .speed and .duplex
from ge00?  We see that a lot with boards converted from out-of-tree
legacy board files, I'm not certain those declarations are necessary.

thx,

Jason.
