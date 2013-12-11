From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 23:51:24 +0100
Subject: [PATCH 03/12] SPEAr13xx: Add SPEAr1310 PCIe register definitions
In-Reply-To: <3a008bd5223b1da9f17ceac745b3fc08b6b842e3.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <3a008bd5223b1da9f17ceac745b3fc08b6b842e3.1386752447.git.mohit.kumar@st.com>
Message-ID: <201312112351.24603.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Mohit Kumar wrote:
> diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
> index 4526f75..c236cef 100644
> --- a/arch/arm/mach-spear/include/mach/spear.h
> +++ b/arch/arm/mach-spear/include/mach/spear.h
> @@ -140,6 +140,79 @@
>                         (SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
>                         SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
>  
> +#define VA_SPEAR1310_PCIE_SATA_CFG             (VA_MISC_BASE + 0x3A4)
> +       #define SPEAR1310_PCIE_SATA2_SEL_PCIE           (0 << 31)
> +       #define SPEAR1310_PCIE_SATA1_SEL_PCIE           (0 << 30)
> +       #define SPEAR1310_PCIE_SATA0_SEL_PCIE           (0 << 29)
> +       #define SPEAR1310_PCIE_SATA2_SEL_SATA           (1 << 31)
> +       #define SPEAR1310_PCIE_SATA1_SEL_SATA           (1 << 30)
> +       #define SPEAR1310_PCIE_SATA0_SEL_SATA           (1 << 29)

These should definitely be part of the PHY driver.

Regarding style, don't use a hardcoded VA_MISC_BASE constant here,
but find the right address in the driver, and instead of shifting
bits, just use hexadecimal notation:

#define SPEAR1310_PCIE_SATA2_SEL_PCIE           0x80000000
#define SPEAR1310_PCIE_SATA1_SEL_PCIE           0x40000000
...

However, if you have a "reset" driver, you can use #reset-cells=<1>
and pass the bit as the reset specifier.

	Arnd
