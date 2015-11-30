From: dcashman@google.com (Daniel Cashman)
Date: Mon, 30 Nov 2015 15:40:10 -0800
Subject: [PATCH] ARM: avoid ARCH_MMAP_RND_BITS for NOMMU
In-Reply-To: <2874133.c4GDUf0t6t@wuerfel>
References: <2874133.c4GDUf0t6t@wuerfel>
Message-ID: <CAJQetW5j4+XPyJMyFFVKyxOaLOKtA4pnKZsZTrxDKqYJ-mtDkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for this.  I will add this to the recently posted patchset
v4.   Without CONFIG_MMU, arch_pick_mmap_layout() is a no-op and the
arch/$ARCH/mm/mmap.c source is not included, so this change makes
sense.  In addition, we should drop the nommu default and add
depends-on for the Kconfig portions.

-Dan

On Fri, Nov 27, 2015 at 6:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> ARM kernels with MMU disabled fail to build because of CONFIG_ARCH_MMAP_RND_BITS:
>
> kernel/built-in.o:(.data+0x754): undefined reference to `mmap_rnd_bits'
> kernel/built-in.o:(.data+0x76c): undefined reference to `mmap_rnd_bits_min'
> kernel/built-in.o:(.data+0x770): undefined reference to `mmap_rnd_bits_max'
>
> This changes the newly added line to only select this allow for
> MMU-enabled kernels.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 14570b3fd31a ("arm: mm: support ARCH_MMAP_RND_BITS")
> ---
> Found on yesterday's linux-next with ARM randconfig. The commit that
> introduced this is currently in Andrew's tree.
>
> If you don't already have a fix, please either apply this patch on top,
> or fold it into the original patch.
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b64f64d124c4..5a0957e3ea36 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -34,7 +34,7 @@ config ARM
>         select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>         select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> -       select HAVE_ARCH_MMAP_RND_BITS
> +       select HAVE_ARCH_MMAP_RND_BITS if MMU
>         select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_BPF_JIT
>



-- 
Dan Cashman
