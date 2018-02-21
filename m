From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 21 Feb 2018 08:37:04 +0000
Subject: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
In-Reply-To: <20180220215954.4092811-4-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-4-arnd@arndb.de>
Message-ID: <CAKv+Gu-Be_saZeHzpWrjJBdeiOSJih0H-d1pjkpj+sq7ytLVyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2018 at 21:59, Arnd Bergmann <arnd@arndb.de> wrote:
> We need some way to pass -mbig-endian to the linker during the
> LTO link stage, otherwise we get a waning like
>
> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
>
> for each file we link in.
>
> There is probably a better method of passing that flag, I'm just
> adding it to a different hack that I added earlier for x86 LTO
> here.
>

In general, LTO requires that *all* C flags are passed to the linker.
Given that linking now involves code generation, any C flag that
affects code generation must be visible to the linker as well, which
includes all the tweaks and overrides that we add per-file or
per-directory. It is not clear to me how much of this is carried in
the intermediate representation as metadata, but we should probably
err on the side of caution here, and update the Kbuild routines to
pass the complete value of KBUILD_CFLAGS (or whatever it is called) to
ld as well.



> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 33b7eb4502aa..f39c2e2d55c0 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -49,11 +49,13 @@ endif
>
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
>  KBUILD_CPPFLAGS        += -mbig-endian
> +KBUILD_BIARCHFLAGS += -mbig-endian
>  CHECKFLAGS     += -D__ARMEB__
>  AS             += -EB
>  LD             += -EB
>  else
>  KBUILD_CPPFLAGS        += -mlittle-endian
> +KBUILD_BIARCHFLAGS += -mlittle-endian
>  CHECKFLAGS     += -D__ARMEL__
>  AS             += -EL
>  LD             += -EL
> --
> 2.9.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
