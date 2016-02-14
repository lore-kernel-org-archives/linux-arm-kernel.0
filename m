From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 14 Feb 2016 18:04:47 +0900
Subject: [PATCH] ARM: exynos: clarify KEYBOARD_SAMSUNG selection
In-Reply-To: <1455204662-1017820-1-git-send-email-arnd@arndb.de>
References: <1455204662-1017820-1-git-send-email-arnd@arndb.de>
Message-ID: <56C0432F.6040409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 12.02.2016 o 00:30, Arnd Bergmann pisze:
> The samsung-keypad driver is implicitly selected by ARCH_EXYNOS4 (why?),
> but this fails if CONFIG_INPUT is a loadable module:

How about removing the select entirely and adding it in defconfigs? It
was introduced by 49b999711ee7 ("ARM: EXYNOS: change HAVE_SAMSUNG_KEYPAD
to KEYBOARD_SAMSUNG") which looks like a mistake. The intention was to
indicate a HAVE, not to select a driver.

Moreover the Exynos3250 also has keypad but it is not selected.

Can you send a patch removing select and changing exynos+multi_v7
defconfigs?

Best regards,
Krzysztof

> 
> drivers/input/built-in.o: In function `samsung_keypad_remove':
> drivers/input/keyboard/samsung-keypad.c:461: undefined reference to `input_unregister_device'
> drivers/input/built-in.o: In function `samsung_keypad_irq':
> drivers/input/keyboard/samsung-keypad.c:137: undefined reference to `input_event'
> drivers/input/built-in.o: In function `samsung_keypad_irq':
> include/linux/input.h:389: undefined reference to `input_event'
> drivers/input/built-in.o: In function `samsung_keypad_probe':
> drivers/input/keyboard/samsung-keypad.c:358: undefined reference to `devm_input_allocate_device'
> drivers/input/built-in.o:(.debug_addr+0x34): undefined reference to `input_set_capability'
> 
> This changes the 'select' statement so we don't do it if CONFIG_INPUT=m.
> The problem does not happen on mainline kernels, as we don't normally
> build built-in input drivers when CONFIG_INPUT=m, but I am experimenting
> with a patch to change this, and the samsung keypad driver showed up
> as one example that was silently broken before.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-exynos/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 8434a0f6334c..b63e64581c24 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -59,7 +59,7 @@ config ARCH_EXYNOS4
>  	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
>  	select CPU_EXYNOS4210
>  	select GIC_NON_BANKED
> -	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
> +	select KEYBOARD_SAMSUNG if INPUT=y && INPUT_KEYBOARD
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Samsung EXYNOS4 (Cortex-A9) SoC based systems
> 
