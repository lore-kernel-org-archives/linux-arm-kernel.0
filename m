From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jun 2014 17:33:15 +0100
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <53AAE632.3020806@mvista.com>
References: <53AAE632.3020806@mvista.com>
Message-ID: <20140625163315.GH15240@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 04:09:38PM +0100, arun chandran wrote:
> From 85134076eb06b90e295e46b083dc180a91c61ea2 Mon Sep 17 00:00:00 2001
> From: Arun Chandran <achandran@mvista.com>
> Date: Wed, 25 Jun 2014 19:36:54 +0530
> Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
> 
> Selecting CPU_BIG_ENDIAN and building the kernel fails just after
> building it for little endian with the message
> 
>   VDSOA arch/arm64/kernel/vdso/gettimeofday.o
>   VDSOL arch/arm64/kernel/vdso/vdso.so.dbg
> /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> arch/arm64/kernel/vdso/note.o: compiled for a little endian system and
> target is big endian
> /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> failed to merge target specific data of file
> arch/arm64/kernel/vdso/note.o
> /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system
> and target is big endian
> /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> failed to merge target specific data of file
> arch/arm64/kernel/vdso/sigreturn.o
> collect2: error: ld returned 1 exit status
> make[2]: *** [arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
> make[1]: *** [arch/arm64/kernel/vdso] Error 2
> make: *** [arch/arm64/kernel] Error 2
> make: *** Waiting for unfinished jobs....
>
> Fix it by 'Forcing' the build in arch/arm64/kernel/vdso/Makefile

I see that Documentation/kbuild/makefiles.txt describes that if_changed
requires FORCE, and forgetting FORCE is a common mistake. See "6.7
Commands useful for building a boot image".

It's probably worth mentioning that in the commit message.

I was able to build and boot LE, BE, and LE arm64 (defconfig) kernels in
turn with this patch applied, and I didn't receive any unexpected errors
from gcc or ld.

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> Signed-off-by: Arun Chandran <achandran@mvista.com>
> ---
>  arch/arm64/kernel/vdso/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 6d20b7d..a268a9a 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  	$(call if_changed,vdsosym)
>  
>  # Assembly rules for the .S files
> -$(obj-vdso): %.o: %.S
> +$(obj-vdso): %.o: %.S FORCE
>  	$(call if_changed_dep,vdsoas)
>  
>  # Actual build commands
> -- 
> 1.7.9.5
