From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 22:35:42 +0200
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
In-Reply-To: <201306212228.29717.arnd@arndb.de>
References: <201306212228.29717.arnd@arndb.de>
Message-ID: <201306212235.43125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Arnd Bergmann wrote:
> This lets us build keystone with CONFIG_THUMB2_KERNEL enabled,
> without the patch we get this error:
> 
> Error: cannot determine Thumb instruction size. Use .inst.n/.inst.w instead
> 
> This follows the same change for all other platforms done
> earlier.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> index 630ab3bd..1800c33 100644
> --- a/arch/arm/mach-keystone/platsmp.c
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -34,7 +34,7 @@ static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
>  		"mov    r0, #0\n"	/* power on cmd	*/
>  		"mov    r1, %1\n"	/* cpu		*/
>  		"mov    r2, %2\n"	/* start	*/
> -		".inst  0xe1600070\n"	/* smc #0	*/
> +		"smc	#0\n"		/* smc #0	*/
>  		"mov    %0, r0\n"
>  		: "=r" (error)
>  		: "r"(cpu), "r"(start)

Ah, damm, now I get this error for building an ARMv6+ARMv7 combined kernel:

/tmp/ccSWHCik.s:55: Error: selected processor does not support ARM mode `smc #0'

I'll add a -march=armv7-a gcc flag as well.

	Arnd
