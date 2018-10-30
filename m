From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 10:10:59 -0500
Subject: [PATCH 2/6] arch: Make phys_initrd_start and phys_initrd_size
 global variables
In-Reply-To: <20181029235206.30060-3-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
 <20181029235206.30060-3-f.fainelli@gmail.com>
Message-ID: <CAL_JsqKrrmMOQrV62L0QXAPiLGceMbvA7HZ=1U3PW0_MpqtC=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 6:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Make phys_initrd_start and phys_initrd_size global variables that will
> later be referenced by generic code under drivers/of/fdt.c.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/init.c       | 4 ++--
>  arch/unicore32/mm/init.c | 4 ++--
>  include/linux/initrd.h   | 3 +++
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc8e04295a4..8f364aa24172 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -51,8 +51,8 @@ unsigned long __init __clear_cr(unsigned long mask)
>  }
>  #endif
>
> -static phys_addr_t phys_initrd_start __initdata = 0;
> -static unsigned long phys_initrd_size __initdata = 0;
> +phys_addr_t phys_initrd_start __initdata = 0;
> +unsigned long phys_initrd_size __initdata = 0;

I would declare these in common initrd code instead. Then you don't
need a kconfig symbol.

>  static int __init early_initrd(char *p)
>  {
> diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
> index 8f8699e62bd5..4dd26d6f02e5 100644
> --- a/arch/unicore32/mm/init.c
> +++ b/arch/unicore32/mm/init.c
> @@ -31,8 +31,8 @@
>
>  #include "mm.h"
>
> -static unsigned long phys_initrd_start __initdata = 0x01000000;
> -static unsigned long phys_initrd_size __initdata = SZ_8M;
> +phys_addr_t phys_initrd_start __initdata = 0x01000000;
> +unsigned long phys_initrd_size __initdata = SZ_8M;

You'll have to set these at runtime though. However, I seem to
remember that an exact size was needed for decompressing an initrd
which would make these defaults pointless. Maybe that was only certain
compression formats.

Rob
