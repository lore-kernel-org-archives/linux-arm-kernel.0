From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 12 Jun 2018 10:19:29 -0700
Subject: [v2,4/6] ARM: drop no-thumb-interwork in EABI mode
In-Reply-To: <20180325180959.28008-5-stefan@agner.ch>
References: <20180325180959.28008-5-stefan@agner.ch>
Message-ID: <20180612171929.GA7829@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2018 at 08:09:57PM +0200, Stefan Agner wrote:
> According to GCC documentation -m(no-)thumb-interwork is
> meaningless in AAPCS configurations. Also clang does not

It appears that this is only correct for recent versions of gcc.

With gcc 4.9.2, this patch causes the qemu collie emulation
to fail with collie_defconfig+CONFIG_AEABI.

qemu-system-arm: Trying to execute code outside RAM or ROM at 0x02000000
This usually means one of the following happened:
...

With gcc 7.3.0, the emulation works as expected. Reverting the patch
fixes the problem with gcc 4.9.2. Not that it matters much to me - I can
and will switch to gcc 7.3.0 for my testing - but effectively this means
that older versions of gcc are no longer supported for all configurations.

Maybe $(call cc-option,-mno-thumb-interwork,) would have been safer ?

Guenter

> support the flag:
>   clang-5.0: error: unknown argument: '-mno-thumb-interwork'
> 
> Just drop -mno-thumb-interwork in AEABI configuration.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e83f5161fdd8..e9e3fde3c657 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -106,7 +106,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
>  tune-y := $(tune-y)
>  
>  ifeq ($(CONFIG_AEABI),y)
> -CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
> +CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
>  else
>  CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
>  endif
