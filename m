From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Nov 2018 14:31:39 -0600
Subject: [PATCH v3 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Message-ID: <20181105203139.GA21852@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 12:28:37PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> Changes in v3:
> 
> - use C conditionals in drivers/of/fdt.c
> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
>   whether initrd_start must be populated
> - fixed a build warning with ARC that was just missing an (unsigned
>   long) cast
> 
> Changes in v2:
> 
> - get rid of ARCH_HAS_PHYS_INITRD and instead define
>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
> 
> - make __early_init_dt_declare_initrd() account for ARM64 specific
>   behavior with __va() when having CONFIG_DEBUG_VM enabled
> 
> - consolidate early_initrd() command line parsing into
>   init/do_mounts_initrd.c
> 
> Because phys_initrd_start/phys_initrd_size are now compiled in
> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
> we need to be a bit careful about the uses throughout architecture
> specific code.
> 
> Previous discussions/submissions list here:
> 
> v3:
> https://www.spinics.net/lists/arm-kernel/msg683566.html
> v2:
> https://lkml.org/lkml/2018/10/25/4
> 
> Florian Fainelli (6):
>   nds32: Remove phys_initrd_start and phys_initrd_size
>   arch: Make phys_initrd_start and phys_initrd_size global variables
>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
>   arm64: Utilize phys_initrd_start/phys_initrd_size
>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
>   arch: Move initrd= parsing into do_mounts_initrd.c

This all looks good to me. I can take it via the DT if you want. I'll 
give folks some more time to review though.

Rob

> 
>  arch/arc/mm/init.c              | 25 +++++--------------------
>  arch/arm/mm/init.c              | 28 ++--------------------------
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 33 +++++++--------------------------
>  arch/nds32/mm/init.c            |  2 --
>  arch/unicore32/mm/init.c        | 24 +++++-------------------
>  drivers/of/fdt.c                | 17 ++++++++++++-----
>  include/linux/initrd.h          |  3 +++
>  init/do_mounts_initrd.c         | 20 ++++++++++++++++++++
>  9 files changed, 54 insertions(+), 106 deletions(-)
> 
> -- 
> 2.17.1
> 
