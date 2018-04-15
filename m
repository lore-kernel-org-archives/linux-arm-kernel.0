From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sun, 15 Apr 2018 18:20:11 +0200
Subject: [PATCH] arm64: support __int128 with clang
In-Reply-To: <20171223004323.1986-1-Jason@zx2c4.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
Message-ID: <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Would you review/merge this when you have a chance?

Thanks,
Jason

On Sat, Dec 23, 2017 at 1:43 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Commit fb8722735f50 ("arm64: support __int128 on gcc 5+") added support
> for arm64 __int128 with gcc with a version-conditional, but neglected to
> enable this for clang, which in fact appears to support aarch64 __int128.
> This commit therefore enables it if the compiler is clang, using the
> same type of makefile conditional used elsewhere in the tree.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b481b4a7c011..16c2e8b58546 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -57,7 +57,11 @@ KBUILD_AFLAGS        += $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS  += $(call cc-option,-mabi=lp64)
>
> +ifeq ($(cc-name),clang)
> +KBUILD_CFLAGS  += -DCONFIG_ARCH_SUPPORTS_INT128
> +else
>  KBUILD_CFLAGS  += $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> +endif
>
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
> --
> 2.15.1
>
