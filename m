From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Jan 2013 15:08:49 +0100
Subject: [PATCH] arm: plat-orion: fix printing of "MPP config unavailable
 on this hardware"
In-Reply-To: <1358949059-10803-1-git-send-email-gerlando.falauto@keymile.com>
References: <1358949059-10803-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <20130123140849.GJ13482@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 02:50:59PM +0100, Gerlando Falauto wrote:
> Commit 3cff484d4b264ff467a3b45c544cbbbab69f0bf8
> ARM: dove: Consolidate mpp code with platform mpp.
> 
> refactored printing of the kernel warning
> "orion_mpp_conf: requested MPP%u config unavailable on this hardware\n"
> which is not to be printed in case of variant_mask = 0 (unknown variant).
> This check should be performed using a logical AND (&&) as opposed
> to a bitwise AND (&).
> Otherwise, test would fail (and message would be printed) if variant_mask != 1
> 
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Holger Brunck <holger.brunck@keymile.com>
> ---
>  arch/arm/plat-orion/mpp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
> index 3b1e17b..78ea76c 100644
> --- a/arch/arm/plat-orion/mpp.c
> +++ b/arch/arm/plat-orion/mpp.c
> @@ -48,7 +48,7 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
>  					"number (%u)\n", num);
>  			continue;
>  		}
> -		if (variant_mask & !(*mpp_list & variant_mask)) {
> +		if (variant_mask && !(*mpp_list & variant_mask)) {
>  			printk(KERN_WARNING
>  			       "orion_mpp_conf: requested MPP%u config "
>  			       "unavailable on this hardware\n", num);
> -- 
> 1.7.10.1
> 

Acked-by: Andrew Lunn <andrew@lunn.ch>

Looks like it should only affect dove, but interesting, there are no
users of dove_mpp_conf(), so we can probably throw away
mach-dove/mpp.[ch].

	Andrew
