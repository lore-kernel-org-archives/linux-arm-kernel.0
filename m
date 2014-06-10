From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 10:21:09 +0200
Subject: [RFC/PATCH] ARM: mvebu: Don't apply the quirks if the SoC
 revision is unknown
In-Reply-To: <1402342036-9168-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1402342036-9168-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5621673.VW5TXctBgm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 June 2014 16:27:16 Ezequiel Garcia wrote:
> We currently skip the I2C and thermal quirks only if the SoC revision is
> known to be one that does not need them. If the SoC revision cannot be
> obtained, the current behavior is to apply the quirk assuming it's needed.
> 
> This commit changes this, by requiring the SoC revision to be known in order
> to peform a quirk.

This clearly needs a better description if we want to apply it. We had
a rather long discussion when the code was first added exactly this
way and you should explain which of the assumptions we made back then
are now incorrect.

Is it ever wrong (as opposed to inefficient) to apply the quirk even on a
newer SoC?

IIRC, the reasoning was that almost all machines have the new SoC version,
so they should have their DTs marked with the correct IDs already.

	Arnd

> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 594262b..14bf590 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -89,13 +89,15 @@ static void __init i2c_quirk(void)
>  {
>  	struct device_node *np;
>  	u32 dev, rev;
> +	int res;
>  
>  	/*
>  	 * Only revisons more recent than A0 support the offload
>  	 * mechanism. We can exit only if we are sure that we can
>  	 * get the SoC revision and it is more recent than A0.
>  	 */
> -	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > MV78XX0_A0_REV)
> +	res = mvebu_get_soc_id(&dev, &rev);
> +	if (res < 0 || (res == 0 &&  rev > MV78XX0_A0_REV))
>  		return;
>  
>  	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
> @@ -119,8 +121,10 @@ static void __init thermal_quirk(void)
>  {
>  	struct device_node *np;
>  	u32 dev, rev;
> +	int res;
>  
> -	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
> +	res = mvebu_get_soc_id(&dev, &rev);
> +	if (res < 0 || (res == 0 && rev > ARMADA_375_Z1_REV))
>  		return;
>  
>  	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
> 
