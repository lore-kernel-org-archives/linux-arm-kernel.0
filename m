From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 19:29:06 +0100
Subject: [PATCH v4 5/5] init: efi: arm: enable (U)EFI runtime services on
 arm
In-Reply-To: <1389445524-30623-6-git-send-email-leif.lindholm@linaro.org>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-6-git-send-email-leif.lindholm@linaro.org>
Message-ID: <201401131929.07236.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 January 2014, Leif Lindholm wrote:
> diff --git a/init/main.c b/init/main.c
> index febc511..1331829 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -905,6 +905,10 @@ static noinline void __init kernel_init_freeable(void)
>         smp_prepare_cpus(setup_max_cpus);
>  
>         do_pre_smp_initcalls();
> +
> +       if (IS_ENABLED(CONFIG_ARM) && efi_enabled(EFI_BOOT))
> +               efi_enter_virtual_mode();

What is the dependency on CONFIG_ARM here? Wouldn't most other
architectures need the same? I'd rather not see this turn into
a long list of CONFIG_$(ARCH) checks if other architectures
enable it in the same place.

I also wonder why the three architectures implementing it all
call this from wildly different places during init/main.c, namely
(very early) setup_arch() on ia64, (relatively early) start_kernel
on x86 and (relatively late) kernel_init_freeable on arm.

In general, I'd be happy with adding this as late in the startup
code as possible, but it may be better to use the same place as
x86 in order to avoid surprises with unexpected dependencies.
One such dependency that may cause problems is the fact that
we (try to) call efi_late_init() before efi_enter_virtual_mode()
now.

	Arnd
