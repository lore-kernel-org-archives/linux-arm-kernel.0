From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 3 Feb 2011 08:35:16 -0800
Subject: [PATCH RFC] ARM: Make VMALLOC_END a variable
In-Reply-To: <AANLkTinadBvmnjN=kUt82e=hmM0xumFs8WP_ca8V-e8Y@mail.gmail.com>
References: <AANLkTinadBvmnjN=kUt82e=hmM0xumFs8WP_ca8V-e8Y@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E8E3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote at Tuesday, January 25, 2011 2:01 PM:
> 
> VMALLOC_END is machine specific and is preventing multiple SoCs from
> being built together. This patch makes it into a global variable and
> is initially defined in 'struct machine_desc' (.vmalloc_end).  Each board
> file must define this. As a result, machine specific vmalloc.h are
> no longer needed and thus are removed.

> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -118,6 +118,7 @@ MACHINE_START(HARMONY, "harmony")
>  	.fixup		= tegra_harmony_fixup,
>  	.init_irq       = tegra_init_irq,
>  	.init_machine   = tegra_harmony_init,
> +	.vmalloc_end	= 0xfe000000UL,
>  	.map_io         = tegra_map_common_io,
>  	.timer          = &tegra_timer,
>  MACHINE_END

It seems slightly unfortunate to replace a single define per SoC with a
cut/paste copy of the value in every machine description. At least for Tegra,
there's only a single machine description right now, but I can foresee a great
many more in the future.

Instead, perhaps instead of deleting .../include/mach/vmalloc.h, it could be
moved from arch/arm/mach-tegra/include/mach to arch/arm/mach-tegra (i.e. made
into a "private" header), and the machine/board files could include it to get
the define (or merge the value into some other pre-existing header if there is
an appropriate one).

Alternatively, can tegra_harmony_init (which calls tegra_common_init) set
this up during initialization, or is the value needed earlier than that?

Alternatively, perhaps there should be a SoC definition similar to the machine
Definition, which defines this, and the machine definitions point at the SoC
definition? I don't know if this is worth it; is there other information that
could usefully be placed in such a SoC definition?

Either way, I won't object strongly to this, but just some food for thought.

-- 
nvpublic
