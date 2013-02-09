From: balbi@ti.com (Felipe Balbi)
Date: Sat, 9 Feb 2013 18:53:35 +0200
Subject: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
In-Reply-To: <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130209165335.GA13338@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 09, 2013 at 01:38:12PM -0300, Ezequiel Garcia wrote:
> Fix gpmc_cs_reserved() so it returns 0 if the chip select
> is available (not reserved) or an error otherwise.
> This allows to use the return value directly and return a proper error code.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index bd3bc93..604c1eb 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -452,12 +452,16 @@ static int gpmc_cs_set_reserved(int cs, int reserved)
>  	return 0;
>  }
>  
> +/* Returns 0 if CS is available (not reseverd) or an error otherwise */

s/reseverd/reserved/

>  static int gpmc_cs_reserved(int cs)
>  {
>  	if (cs > GPMC_CS_NUM)
>  		return -ENODEV;
>  
> -	return gpmc_cs_map & (1 << cs);
> +	if (gpmc_cs_map & (1 << cs))
> +		return -EBUSY;
> +
> +	return 0;

you could use a ternary operator here:

bit = gpmc_cs_map & (1 << cs);

return bit ? -EBUSY : 0;

But to be frank, I'm not sure this makes that much sense, I'd expect
gpmc_cs_reserved() to return 0 or 1 depending on the state (just as it
was before). The name of the method asks for a boolean return value.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130209/5a458fb9/attachment.sig>
