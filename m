From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Mar 2013 22:05:15 +0900
Subject: [PATCH/RFC] ARM: shmobile: Disallow PINCTRL without GPIOLIB
In-Reply-To: <20130318135818.23765.51686.sendpatchset@w520>
References: <20130318135818.23765.51686.sendpatchset@w520>
Message-ID: <20130320130514.GI16436@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:58:18PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Modify mach-shmobile to only select PINCTRL in case of
> ARCH_WANT_OPTIONAL_GPIOLIB is set.
> 
> This fixes a build error triggered when adding a new SoC
> lacking GPIO software support (ARCH_WANT_OPTIONAL_GPIOLIB=n):
> 
>  CC      drivers/tty/vt/keyboard.o
> In file included from drivers/pinctrl/core.c:30:0:
> include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
> include/asm-generic/gpio.h:270:2: error: implicit declaration of function '__gpio_get_value'
> include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
> include/asm-generic/gpio.h:276:2: error: implicit declaration of function '__gpio_set_value'
> drivers/pinctrl/core.c: In function 'pinctrl_ready_for_gpio_range':
> drivers/pinctrl/core.c:297:9: error: implicit declaration of function 'gpio_to_chip'
> drivers/pinctrl/core.c:297:27: warning: initialization makes pointer from integer without a cast
> drivers/pinctrl/core.c:304:45: error: dereferencing pointer to incomplete type
> drivers/pinctrl/core.c:305:26: error: dereferencing pointer to incomplete type
> drivers/pinctrl/core.c:305:39: error: dereferencing pointer to incomplete type
> make[2]: *** [drivers/pinctrl/core.o] Error 1
> make[1]: *** [drivers/pinctrl] Error 2
> make[1]: *** Waiting for unfinished jobs....
>   LD      drivers/sh/built-in.o
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Laurent, could you review this please?

> ---
> 
>  Using renesas.git "next" 811689afc214564c4a5f238ecf4d8bdc0e52b615
> 
>  Trigger using the r8a73a4 patches that lack GPIO and PFC support.
> 
>  I am more than happy to replace this patch with something cleaner.
> 
>  arch/arm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/arch/arm/Kconfig
> +++ work/arch/arm/Kconfig	2013-03-18 14:56:17.000000000 +0900
> @@ -725,7 +725,7 @@ config ARCH_SHMOBILE
>  	select MULTI_IRQ_HANDLER
>  	select NEED_MACH_MEMORY_H
>  	select NO_IOPORT
> -	select PINCTRL
> +	select PINCTRL if ARCH_WANT_OPTIONAL_GPIOLIB
>  	select PM_GENERIC_DOMAINS if PM
>  	select SPARSE_IRQ
>  	help
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
