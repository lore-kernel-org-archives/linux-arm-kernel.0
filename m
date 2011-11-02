From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 2 Nov 2011 09:39:21 -0700
Subject: [PATCH] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote by Wednesday, November 02, 2011 9:38 AM:
> Tegra30 has 1 extra legacy interrupt controller. Use the GIC ITLinesNumber
> field to determine how many interrupt controllers we have and initialize
> appropriately. Also make room for the extra tegra30 interrupts by moving
> the GPIO IRQ base. This shouldn't affect existing code as it determines the
> correct IRQ number for GPIOs using TEGRA_GPIO_TO_IRQ()
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

After fixing one small issue I comment on below,
Acked-by: Stephen Warren <swarren@nvidia.com>

I was previously concerned that renumbering the interrupt IDs would cause
some kind of backwards compatibility problems, but thinking more, I don't
think there's an issue; for a DT-based system, all the IRQ and GPIO numbers
are specified relative to the controller, and the relative numbering isn't
changing here. For a non-DT-based system, any IRQ numbers for any GPIO
should indeed be generated using TEGRA_GPIO_TO_IRQ (or the run-time
equivalent) and hence should also work OK after this patch.

> diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
...
>  #define NR_BOARD_IRQS			32
> -
> -#define NR_IRQS				(INT_BOARD_BASE + NR_BOARD_IRQS)
> -#endif
> +#define NR_IRQS                         (INT_BOARD_BASE + NR_BOARD_IRQS)

The indentation change to NR_IRQS seems like a mistake; the existing code
looks OK.

-- 
nvpublic
