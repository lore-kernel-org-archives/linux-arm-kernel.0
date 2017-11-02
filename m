From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Nov 2017 13:47:21 +0000
Subject: [PATCH] arm64: support __int128 on gcc 5+
In-Reply-To: <20171031114319.24436-1-Jason@zx2c4.com>
References: <CAHmME9pE+G0V-nyKchQyG03YXbPjGykL1xX0M8E544Rh7QrgOQ@mail.gmail.com>
 <20171031114319.24436-1-Jason@zx2c4.com>
Message-ID: <20171102134720.GA17333@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Oct 31, 2017 at 12:43:19PM +0100, Jason A. Donenfeld wrote:
> Versions of gcc prior to gcc 5 emitted a __multi3 function call when
> dealing with TI types, resulting in failures when trying to link to
> libgcc, and more generally, horrible performance. However, since gcc 5,
> the compiler supports actually emitting fast instructions, which means
> we can at long last enable this option and receive the speedups.
> 
> The gcc commit that added proper Aarch64 support is:
> https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=d1ae7bb994f49316f6f63e6173f2931e837a351d
> 
> This commit appears to be part of the gcc 5 release.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 939b310913cf..1f8a0fec6998 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -53,6 +53,8 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>  
> +KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__

This breaks an allmodconfig build:

lib/ubsan.o: In function `get_signed_val':
ubsan.c:(.text.unlikely+0x13c): undefined reference to `__ashlti3'
ubsan.c:(.text.unlikely+0x144): undefined reference to `__ashrti3'
make: *** [vmlinux] Error 1

so I'm going to drop it for now. My toolchain is:

gcc version 7.1.1 20170707 (Linaro GCC 7.1-2017.08)

Will
