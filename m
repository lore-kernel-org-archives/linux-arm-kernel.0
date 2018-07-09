From: labbott@redhat.com (Laura Abbott)
Date: Mon, 9 Jul 2018 16:24:42 -0700
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <20180709200956.31158-1-labbott@redhat.com>
References: <20180709200956.31158-1-labbott@redhat.com>
Message-ID: <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2018 01:09 PM, Laura Abbott wrote:
> This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> 
> This breaks compilation with Fedora gcc-8 tool chains:
> 
>    CHK     include/generated/compile.h
>    LD [M]  arch/arm64/crypto/sha512-ce.o
> aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> 
> Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> A bit rushed and I'm still debugging but I wanted to send this out
> before anyone else gets hit since it is -rc4. Seeing this on both native
> and cross compiles.

The answer appears to be that Fedora binutils does not package the assembly
scripts. The logic behind this is not immediately obvious but it's been
removed since 2004. Obviously this is a packaging issue on Fedora's side
but I'd still like to revert since it is a build breakage and fixing
this might require some coordination. I'll send a v2 with clarified
commit text if there's agreement.

Thanks,
Laura

> ---
>   arch/arm64/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7976d2d242fa..f476d52ad8d6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>   KBUILD_CPPFLAGS	+= -mbig-endian
>   CHECKFLAGS	+= -D__AARCH64EB__
>   AS		+= -EB
> -LDFLAGS		+= -EB -maarch64elfb
> +LDFLAGS		+= -EB -maarch64linuxb
>   UTS_MACHINE	:= aarch64_be
>   else
>   KBUILD_CPPFLAGS	+= -mlittle-endian
>   CHECKFLAGS	+= -D__AARCH64EL__
>   AS		+= -EL
> -LDFLAGS		+= -EL -maarch64elf
> +LDFLAGS		+= -EL -maarch64linux
>   UTS_MACHINE	:= aarch64
>   endif
>   
> 
