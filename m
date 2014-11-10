From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Nov 2014 14:28:09 +0100
Subject: [PATCH] ARM: fix multiplatform allmodcompile
In-Reply-To: <1415625349-21472-1-git-send-email-linus.walleij@linaro.org>
References: <1415625349-21472-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2260070.eeki134OoD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014 14:15:49 Linus Walleij wrote:
> Commit 68f3b875f7848f5304472184a4634148c5330cbd
> "ARM: integrator: make the Integrator multiplatform"
> broke allmodconfig like this:
> 
> >> arch/arm/include/asm/cmpxchg.h:114:2: error: #error
> "SMP is not supported on this platform"
> (etc)
> 
> This is due to the fact that as we turned on multiplatform
> for the Integrator, this enabled a lot of non-applicable
> CPU's to be selected for its multiplatform images, due to
> a lot of "depends on ARCH_INTEGRATOR" restrictions in
> arch/arm/mm/Kconfig for the different ARM CPU types.
> 
> Fix this by restricting the CPU selections to respective
> multiplatform config, which now becomes a subset of the
> possible Integrator configurations.
> 
> Reported-by: Build bot for Mark Brown <broonie@kernel.org>
> Reported-by: Kbuild test robot <fengguang.wu@intel.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

However, there is one mistake you need to fix:

> @@ -371,7 +371,7 @@ config CPU_V6
>  
>  # ARMv6k
>  config CPU_V6K
> -	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> +	bool "Support ARM V6K processor" if ARCH_MULTI_V6K || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
>  	select CPU_32v6
>  	select CPU_32v6K
>  	select CPU_ABRT_EV6
> @@ -385,7 +385,7 @@ config CPU_V6K

ARCH_MULTI_V6K does not exist. We should either introduce that or
change the line here to say 'ARCH_MULTI_V6'.

	Arnd
