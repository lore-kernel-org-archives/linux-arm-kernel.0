From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Jun 2017 13:20:49 +0200
Subject: [PATCH v3] drivers/char: kmem: disable on arm64
In-Reply-To: <1497941940-2699-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1497941940-2699-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_nOo3VfjHistipR7vhaTnO89M8X1rrePgk3jhK0xnYVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2017 at 08:59, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> As it turns out, arm64 deviates from other architectures in the way it
> maps the VMALLOC region: on most (all?) other architectures, it resides
> strictly above the kernel's direct mapping of DRAM, but on arm64, this
> is the other way around. For instance, for a 48-bit VA configuration,
> we have
>
>   modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
>   vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
>   ...
>   vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
>             0xffff7e0000000000 - 0xffff7e0003ff0000   (    63 MB actual)
>   memory  : 0xffff800000000000 - 0xffff8000ffc00000   (  4092 MB)
>
> This has mostly gone unnoticed until now, but it does appear that it
> breaks an assumption in the kcore

s/kcore/kmem/

> read/write code, which does something
> like
>
>   if (p < (unsigned long) high_memory) {
>     ... use straight copy_[to|from]_user() using p as virtual address ...
>   }
>   ...
>   if (count > 0) {
>     ... use vread/vwrite for accesses past high_memory ...
>   }
>
> The first condition will inadvertently hold for the VMALLOC region if
> VMALLOC_START < PAGE_OFFSET [which is the case on arm64], but the read
> or write will subsequently fail the virt_addr_valid() check, resulting
> in a -ENXIO return value.
>
> Given how kmem seems to be living in borrowed time anyway, and given
> the fact that nobody noticed that the read/write interface is broken
> on arm64 in the first place, let's not bother trying to fix it, but
> simply disable the /dev/kmem interface entirely for arm64.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: improve commit log
> v2: disable /dev/kmem entirely rather than bandaiding it
>
>  drivers/char/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 31adbebf812e..8102ee7b3247 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -17,6 +17,8 @@ config DEVMEM
>
>  config DEVKMEM
>         bool "/dev/kmem virtual device support"
> +       # On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
> +       depends on !ARM64
>         help
>           Say Y here if you want to support the /dev/kmem device. The
>           /dev/kmem device is rarely used, but can be used for certain
> --
> 2.7.4
>
