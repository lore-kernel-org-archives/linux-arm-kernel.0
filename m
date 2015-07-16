From: poggi.raph@gmail.com (=?UTF-8?Q?Rapha=C3=ABl_Poggi?=)
Date: Thu, 16 Jul 2015 22:34:20 +0200
Subject: [PATCH] ARM: VDSO: fix regression with toolchains lacking ld.bfd
 executable
In-Reply-To: <1436934852-27547-1-git-send-email-nathan_lynch@mentor.com>
References: <1436934852-27547-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <CACqcpZBnU+17Ob85hYhikQUdNxtNiUs47PGQXfZDQyXYrTgnyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

I just tested it right now and it works, you can add my:

Tested-by: Rapha?l Poggi <poggi.raph@gmail.com>

2015-07-15 6:34 GMT+02:00 Nathan Lynch <nathan_lynch@mentor.com>:
> The Sourcery CodeBench Lite 2014.05 toolchain (gcc 4.8.3, binutils
> 2.24.51) has a GCC which implements -fuse-ld, and it doesn't include
> the gold linker, but it lacks an ld.bfd executable in its
> installation.  This means that passing -fuse-ld=bfd fails with:
>
>       VDSO    arch/arm/vdso/vdso.so.raw
>     collect2: fatal error: cannot find 'ld'
>
> Arguably this is a deficiency in the toolchain, but I suspect it's
> commonly used enough that it's worth accommodating: just use
> cc-ldoption (to cause a link attempt) instead of cc-option to test
> whether we can use -fuse-ld.  So -fuse-ld=bfd won't be used with this
> toolchain, but the build will rightly succeed, just as it does for
> toolchains which don't implement -fuse-ld (and don't use gold as the
> default linker).
>
> Note: this will change the failure mode for a corner case I was trying
> to handle in d2b30cd4b722, where the toolchain defaults to the gold
> linker and the BFD linker is not found in PATH, from:
>
>       VDSO    arch/arm/vdso/vdso.so.raw
>     collect2: fatal error: cannot find 'ld'
>
> i.e. the BFD linker is not found, to:
>
>       OBJCOPY arch/arm/vdso/vdso.so
>     BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>     linking with -N
>
> that is, we fail to prevent gold from being used as the linker, and it
> produces an object that objcopy can't digest.
>
> Reported-by: Baruch Siach <baruch@tkos.co.il>
> Tested-by: Baruch Siach <baruch@tkos.co.il>
> Fixes: d2b30cd4b722 ("ARM: 8384/1: VDSO: force use of BFD linker")
> Cc: stable at vger.kernel.org
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 9d259d94e429..1160434eece0 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -14,7 +14,7 @@ VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
>  VDSO_LDFLAGS += -nostdlib -shared
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> -VDSO_LDFLAGS += $(call cc-option, -fuse-ld=bfd)
> +VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
>
>  obj-$(CONFIG_VDSO) += vdso.o
>  extra-$(CONFIG_VDSO) += vdso.lds
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
