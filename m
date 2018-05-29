From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2018 11:25:02 +0100
Subject: [PATCH] ARM; fix cpu_v7_bugs_init reference
In-Reply-To: <20180529102301.1145470-1-arnd@arndb.de>
References: <20180529102301.1145470-1-arnd@arndb.de>
Message-ID: <20180529102502.GH17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please revalidate against the latest patches, this area has changed.

On Tue, May 29, 2018 at 12:22:06PM +0200, Arnd Bergmann wrote:
> The cpu_v7_bugs_init() function is referenced by the ARMv7 processor
> implementation, but is defined conditionally, leading to a link error when
> CONFIG_HARDEN_BRANCH_PREDICTOR is disabled:
> 
> arch/arm/mm/proc-v7.o:(.init.data+0xc): undefined reference to `cpu_v7_bugs_init'
> arch/arm/mm/proc-v7.o:(.init.data+0x74): undefined reference to `cpu_v7_bugs_init'
> arch/arm/mm/proc-v7-bugs.o: In function `cpu_v7_ca8_ibe':
> proc-v7-bugs.c:(.text+0x14): undefined reference to `cpu_v7_bugs_init'
> arch/arm/mm/proc-v7-bugs.o: In function `cpu_v7_ca15_ibe':
> proc-v7-bugs.c:(.text+0x30): undefined reference to `cpu_v7_bugs_init'
> 
> There is a '.weak' directive for this symbol, which was apparently
> intended to avoid the problem, but the file is lacking an actual global
> definition for the function, so it has no effect.
> 
> This adds an empty function definition for it, which can now get used
> as the fallback.
> 
> Fixes: 8d9267cedb9e ("ARM: spectre-v2: harden user aborts in kernel space")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mm/proc-v7.S | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 6fe52819e014..8f980e8b0867 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -547,6 +547,11 @@ __v7_setup_stack_ptr:
>  	.word	PHYS_RELATIVE(__v7_setup_stack, .)
>  ENDPROC(__v7_setup)
>  
> +	.weak cpu_v7_bugs_init
> +ENTRY(cpu_v7_bugs_init)
> +	ret	lr
> +ENDPROC(cpu_v7_bugs_init)
> +
>  	.bss
>  	.align	2
>  __v7_setup_stack:
> @@ -554,8 +559,6 @@ __v7_setup_stack:
>  
>  	__INITDATA
>  
> -	.weak cpu_v7_bugs_init
> -
>  	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
>  	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1, bugs=cpu_v7_bugs_init
>  
> -- 
> 2.9.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
