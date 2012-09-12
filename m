From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Sep 2012 15:20:49 -0500
Subject: [PATCH 11/12] ARM: initial multiplatform support
In-Reply-To: <201209121949.49109.arnd@arndb.de>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-12-git-send-email-robherring2@gmail.com>
 <201209121949.49109.arnd@arndb.de>
Message-ID: <5050EEA1.5050205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 02:49 PM, Arnd Bergmann wrote:
> On Thursday 06 September 2012, Rob Herring wrote:
> 
>> +machine-$(CONFIG_ARCH_EXYNOS4)         += exynos
>> +machine-$(CONFIG_ARCH_EXYNOS5)         += exynos
> 
>> +machine-$(CONFIG_MACH_SPEAR1310)       += spear13xx
>> +machine-$(CONFIG_MACH_SPEAR1340)       += spear13xx
> 
>> +machine-$(CONFIG_MACH_SPEAR300)                += spear3xx
>> +machine-$(CONFIG_MACH_SPEAR310)                += spear3xx
> 
>> +machine-$(CONFIG_MACH_SPEAR320)                += spear3xx
>> +machine-$(CONFIG_MACH_SPEAR600)                += spear6xx
> 
> I did a little bit of testing and got this message:
> 
> /home/arnd/linux-arm/Makefile:774: target `arch/arm/mach-spear13xx' given more than once in the same rule.
> arch/arm/mach-spear13xx/built-in.o:(.init.data+0x0): multiple definition of `spear13xx_smp_ops'
> arch/arm/mach-spear13xx/built-in.o:(.init.data+0x0): first defined here
> 
> The patch below ensures that each machine is only listed once.
> Please fold this into your patch.
> 
> 	Arnd
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 32a6485..ff5fb29 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -233,7 +233,7 @@ ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
>  MACHINE  :=
>  endif
>  
> -machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
> +machdirs := $(sort $(patsubst %,arch/arm/mach-%/,$(machine-y)))
>  platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
>  
>  ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)

Found this one as well. My fix is to use CONFIG_ARCH_EXYNOS,
CONFIG_ARCH_SPEAR3XX, etc. instead and remove the multiple lines.

I want to get this into -next and plan to send you a pull request soon.
Are you happy with the kconfig parts?

Rob
