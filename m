From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 17:52:05 +0000
Subject: [PATCH 1/9] SPEAr13xx: Add header files
In-Reply-To: <7c9115d4111ddc27f9088e668dbca409bebc9e70.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <7c9115d4111ddc27f9088e668dbca409bebc9e70.1334942163.git.viresh.kumar@st.com>
Message-ID: <201204201752.05657.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Viresh Kumar wrote:
> diff --git a/arch/arm/mach-spear13xx/include/mach/dma.h b/arch/arm/mach-spear13xx/include/mach/dma.h
> new file mode 100644
> index 0000000..383ab04
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/include/mach/dma.h
> @@ -0,0 +1,128 @@

> +#ifndef __MACH_DMA_H
> +#define __MACH_DMA_H
> +
> +/* request id of all the peripherals */
> +enum dma_master_info {
> +	/* Accessible from only one master */
> +	DMA_MASTER_MCIF = 0,
> +	DMA_MASTER_FSMC = 1,
> +	/* Accessible from both 0 & 1 */
> +	DMA_MASTER_MEMORY = 0,
> +	DMA_MASTER_ADC = 0,
> +	DMA_MASTER_UART0 = 0,
> +	DMA_MASTER_SSP0 = 0,
> +	DMA_MASTER_I2C0 = 0,

Ideally we wouldn't have this file and put all the data into
the device tree of course but we're still lacking bindings for
that, so it's still ok for v3.5.

> diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
> new file mode 100644
> index 0000000..ddf5721
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
> @@ -0,0 +1,23 @@
> +
> +#ifndef __MACH_IRQS_H
> +#define __MACH_IRQS_H
> +
> +#define IRQ_LOCALTIMER			29

I think we can now probe localtimer from devicetree so you should
not need this one any more.

> +#define SPEAR13XX_IRQ_GPT0_TMR0		69
> +#define SPEAR13XX_IRQ_GPT0_TMR1		70

I'd also prefer if you could add bindings for GPT and probe
these interrupts and the GPT address from the devicetree
for the three spear platforms, that would make the code much
nicer in this area.

> +#define PERIP_GRP2_BASE				UL(0xB3000000)
> +#define VA_PERIP_GRP2_BASE			UL(0xFE000000)
> +#define MCIF_SDHCI_BASE				UL(0xB3000000)
> +#define SYSRAM0_BASE				UL(0xB3800000)
> +#define VA_SYSRAM0_BASE				UL(0xFE800000)
> +#define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
> +
> +#define PERIP_GRP1_BASE				UL(0xE0000000)
> +#define VA_PERIP_GRP1_BASE			UL(0xFD000000)
> +#define UART_BASE				UL(0xE0000000)
> +#define VA_UART_BASE				UL(0xFD000000)
> +#define ADC_BASE				UL(0xE0080000)
> +#define SSP_BASE				UL(0xE0100000)
> +#define I2C_BASE				UL(0xE0280000)
> +#define KBD_BASE				UL(0xE0300000)
> +#define GPT0_BASE				UL(0xE0380000)
> +#define GPIO0_BASE				UL(0xE0600000)
> +#define GPIO1_BASE				UL(0xE0680000)
> +#define MISC_BASE				UL(0xE0700000)
> +#define VA_MISC_BASE				IOMEM(UL(0xFD700000))
> +#define SYSRAM1_BASE				UL(0xE0800000)
> +
> +#define A9SM_AND_MPMC_BASE			UL(0xEC000000)
> +#define VA_A9SM_AND_MPMC_BASE			UL(0xFC000000)
> +
> +/* A9SM peripheral offsets */
> +#define A9SM_PERIP_BASE				UL(0xEC800000)
> +#define VA_A9SM_PERIP_BASE			UL(0xFC800000)
> +#define VA_SCU_BASE				(VA_A9SM_PERIP_BASE + 0x00)
> +#define GIC_CPU_BASE				(A9SM_PERIP_BASE + 0x100)
> +#define GLOBAL_TMR_BASE				(A9SM_PERIP_BASE + 0x200)
> +#define LOCAL_TMR_BASE				(A9SM_PERIP_BASE + 0x600)
> +#define GIC_DIST_BASE				(A9SM_PERIP_BASE + 0x1000)
> +
> +#define L2CC_BASE				UL(0xED000000)
> +#define VA_L2CC_BASE				IOMEM(UL(0xFB000000))
> +
> +/* others */
> +#define GETH_BASE				UL(0xE2000000)
> +#define DMAC0_BASE				UL(0xEA800000)
> +#define DMAC1_BASE				UL(0xEB000000)
> +#define MCIF_CF_BASE				UL(0xB2800000)
> +
> +/* Devices present in SPEAr1310 */
> +#ifdef CONFIG_MACH_SPEAR1310
> +#define SPEAR1310_RAS_GRP1_BASE			UL(0xD8000000)
> +#define VA_SPEAR1310_RAS_GRP1_BASE		UL(0xFA000000)
> +#define SPEAR1310_RAS_BASE			UL(0xD8400000)
> +#define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))

Can you go through this list one more time and check which ones are
still needed here? I think most of them can just get removed.

> +/* RAS Area Control Register */
> +#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
> +	#define SPEAR1310_GPT64_SYNC_ENB		0
> +	#define SPEAR1310_GPT64_SYNC_ENB_MASK		1
> +	#define SPEAR1310_GPT64_SYNC_ENB_SHIFT		31
> +	#define SPEAR1310_SSP1_CS_SEL_CS0		0
> +	#define SPEAR1310_SSP1_CS_SEL_CS1		1
> +	#define SPEAR1310_SSP1_CS_SEL_MASK		3
> +	#define SPEAR1310_SSP1_CS_SEL_SHIFT		30
> +	#define SPEAR1310_SSP1_CS_VAL_MASK		1
> +	#define SPEAR1310_SSP1_CS_VAL_SHIFT		28
> +	#define SPEAR1310_SSP1_CS_CTL_HW		0
> +	#define SPEAR1310_SSP1_CS_CTL_SW		1

Why are the RAS control registers in a global header? It looks like you
only use them from the clock driver, so they can be moved into a local
header file there.

	Arnd
