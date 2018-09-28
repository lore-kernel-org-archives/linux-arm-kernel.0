From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 17:52:06 +0200
Subject: [PATCH] arm: support big-endian for the virt architecture
In-Reply-To: <20180926135110.13061-1-Jason@zx2c4.com>
References: <20180926135110.13061-1-Jason@zx2c4.com>
Message-ID: <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 3:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This architecture, used for running in QEMU, runs just fine when
> compiled in big-endian mode. So enable it. This is enabled in exactly
> the same way that it is for other platforms (such as vexpress) that also
> support big-endian mode in QEMU successfully.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Personally, I'm using this as part of WireGuard's CI, and patching
> kernels to include this is a bit annoying. Any chance this can get into
> 4.19?
>
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..b8c6062ca0c1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -701,6 +701,7 @@ config ARCH_VIRT
>         select ARM_GIC_V3_ITS if PCI
>         select ARM_PSCI
>         select HAVE_ARM_ARCH_TIMER
> +       select ARCH_SUPPORTS_BIG_ENDIAN

Applied for 4.20 with subject line changed s/arm/ARM/, thanks!

We don't really handle this well in general, by allowing a big-endian
build if any of the enabled platforms select ARCH_SUPPORTS_BIG_ENDIAN,
rather than making sure that /all/ of them do.

I think most people just build a 'defconfig' kernel, which includes
multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.

A better way to do this might be to assume ARCH_SUPPORTS_BIG_ENDIAN
for ARCH_MULTIPLATFORM, and then mark all platforms that are
known to be broken as 'depends on !CPU_BIG_ENDIAN'.

Your patch is certainly fine for 4.20, but since we haven't decided
what the proper fix should be, I didn't want to push this for 4.19.

        Arnd
