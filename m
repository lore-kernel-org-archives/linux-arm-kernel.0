From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 26 Jul 2012 08:32:32 +0300
Subject: [PATCH] ARM: mxs: fix compile error caused by prom_update_property
 change
In-Reply-To: <1342160035-24170-1-git-send-email-shawn.guo@linaro.org>
References: <1342160035-24170-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <5010D670.6070303@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/13/2012 09:13 AM, Shawn Guo wrote:
> The commit 475d009 (of: Improve prom_update_property() function)
> changed prom_update_property interface, and causes the compile
> error below.
>
>    CC      arch/arm/mach-mxs/mach-mxs.o
> arch/arm/mach-mxs/mach-mxs.c: In function ?update_fec_mac_prop?:
> arch/arm/mach-mxs/mach-mxs.c:216:4: error: too many arguments to function ?prom_update_property?
> include/linux/of.h:263:12: note: declared here
>
> Update the caller update_fec_mac_prop to fix the error.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> The error is seen on next-20120712 where commit 475d009 (of: Improve
> prom_update_property() function) emerges.

What's the status of this patch? Current Torvald's master is unbuildable 
for mxs because of this issue.

Compiler gives an error:
arch/arm/mach-mxs/mach-mxs.c: In function 'update_fec_mac_prop':
arch/arm/mach-mxs/mach-mxs.c:213: error: too many arguments to function 
'prom_update_property'
make[1]: *** [arch/arm/mach-mxs/mach-mxs.o] Error 1

Best regards,
Lauri Hintsala


>
>   arch/arm/mach-mxs/mach-mxs.c |    8 ++------
>   1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 648bdd0..8dabfe8 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -162,7 +162,7 @@ enum mac_oui {
>   static void __init update_fec_mac_prop(enum mac_oui oui)
>   {
>   	struct device_node *np, *from = NULL;
> -	struct property *oldmac, *newmac;
> +	struct property *newmac;
>   	const u32 *ocotp = mxs_get_ocotp();
>   	u8 *macaddr;
>   	u32 val;
> @@ -208,11 +208,7 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
>   		macaddr[4] = (val >> 8) & 0xff;
>   		macaddr[5] = (val >> 0) & 0xff;
>
> -		oldmac = of_find_property(np, newmac->name, NULL);
> -		if (oldmac)
> -			prom_update_property(np, newmac, oldmac);
> -		else
> -			prom_add_property(np, newmac);
> +		prom_update_property(np, newmac);
>   	}
>   }
>
>
