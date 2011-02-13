From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 13 Feb 2011 13:08:55 +0200
Subject: [PATCH 2/2] ARM: tegra: add TrimSlice board
In-Reply-To: <AANLkTim5-dmpF8r9uZp8iDsT6p61D0iaJZuHvRLfUL6Y@mail.gmail.com>
References: <cover.1297063443.git.mike@compulab.co.il>	<c61e1816027e51acfb5bda1e498225a4da37d92d.1297063443.git.mike@compulab.co.il>
	<AANLkTim5-dmpF8r9uZp8iDsT6p61D0iaJZuHvRLfUL6Y@mail.gmail.com>
Message-ID: <4D57BBC7.4070306@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/11 04:43, Colin Cross wrote:
> On Mon, Feb 7, 2011 at 12:10 AM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Add basic support for CompuLab TrimSlice platform
>>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  arch/arm/mach-tegra/Kconfig                  |    6 +
>>  arch/arm/mach-tegra/Makefile                 |    3 +
>>  arch/arm/mach-tegra/board-trimslice-pinmux.c |  145 ++++++++++++++++++++++++++
>>  arch/arm/mach-tegra/board-trimslice.c        |  104 ++++++++++++++++++
>>  arch/arm/mach-tegra/board-trimslice.h        |   22 ++++
>>  5 files changed, 280 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-tegra/board-trimslice-pinmux.c
>>  create mode 100644 arch/arm/mach-tegra/board-trimslice.c
>>  create mode 100644 arch/arm/mach-tegra/board-trimslice.h
>>
>> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
>> index acd9552..f0fda77 100644
>> --- a/arch/arm/mach-tegra/Kconfig
>> +++ b/arch/arm/mach-tegra/Kconfig
>> @@ -27,6 +27,12 @@ config MACH_HARMONY
>>        help
>>          Support for nVidia Harmony development platform
>>
>> +config MACH_TRIMSLICE
>> +       bool "TrimSlice board"
>> +       select TEGRA_PCI
>> +       help
>> +         Support for CompuLab TrimSlice platform
>> +
>>  choice
>>         prompt "Low-level debug console UART"
>>         default TEGRA_DEBUG_UART_NONE
>> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
>> index cdbc68e..0e1844b 100644
>> --- a/arch/arm/mach-tegra/Makefile
>> +++ b/arch/arm/mach-tegra/Makefile
>> @@ -19,3 +19,6 @@ obj-$(CONFIG_TEGRA_PCI)                       += pcie.o
>>  obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
>>  obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
>>  obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
>> +
>> +obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice.o
>> +obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice-pinmux.o
>> diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
>> new file mode 100644
>> index 0000000..6d4fc9f
>> --- /dev/null
>> +++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
>> @@ -0,0 +1,145 @@
>> +/*
>> + * arch/arm/mach-tegra/board-trimslice-pinmux.c
>> + *
>> + * Copyright (C) 2011 CompuLab, Ltd.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <mach/pinmux.h>
>> +
>> +#include "board-trimslice.h"
>> +
>> +static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
>> +       {TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_CDEV1, TEGRA_MUX_OSC,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_DTA,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DTB,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DTC,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DTD,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DTE,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GMB,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_GMC,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GMD,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GME,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_GPU,   TEGRA_MUX_UARTA,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LCSN,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_PTA,   TEGRA_MUX_RSVD3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_SPDI,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPDO,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIA,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIB,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIC,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
>> +       {TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +       {TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>> +};
>> +
>> +void __init trimslice_pinmux_init(void)
>> +{
>> +       tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
>> +}
>> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
>> new file mode 100644
>> index 0000000..ef233b2
>> --- /dev/null
>> +++ b/arch/arm/mach-tegra/board-trimslice.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * arch/arm/mach-tegra/board-trimslice.c
>> + *
>> + * Copyright (C) 2011 CompuLab, Ltd.
>> + * Author: Mike Rapoport <mike@compulab.co.il>
>> + *
>> + * Based on board-harmony.c
>> + * Copyright (C) 2010 Google, Inc.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/io.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/setup.h>
>> +
>> +#include <mach/iomap.h>
>> +
>> +#include "board.h"
>> +#include "clock.h"
>> +
>> +#include "board-trimslice.h"
>> +
>> +static struct plat_serial8250_port debug_uart_platform_data[] = {
>> +       {
>> +               .membase        = IO_ADDRESS(TEGRA_UARTA_BASE),
>> +               .mapbase        = TEGRA_UARTA_BASE,
>> +               .irq            = INT_UARTA,
>> +               .flags          = UPF_BOOT_AUTOCONF,
>> +               .iotype         = UPIO_MEM,
>> +               .regshift       = 2,
>> +               .uartclk        = 216000000,
>> +       }, {
>> +               .flags          = 0
>> +       }
>> +};
>> +
>> +static struct platform_device debug_uart = {
>> +       .name   = "serial8250",
>> +       .id     = PLAT8250_DEV_PLATFORM,
>> +       .dev    = {
>> +               .platform_data  = debug_uart_platform_data,
>> +       },
>> +};
>> +
>> +static struct platform_device *trimslice_devices[] __initdata = {
>> +       &debug_uart,
>> +};
>> +
>> +static void __init tegra_trimslice_fixup(struct machine_desc *desc,
>> +       struct tag *tags, char **cmdline, struct meminfo *mi)
>> +{
>> +       mi->nr_banks = 2;
>> +       mi->bank[0].start = PHYS_OFFSET;
>> +       mi->bank[0].size = 448 * SZ_1M;
>> +       mi->bank[1].start = SZ_512M;
>> +       mi->bank[1].size = SZ_512M;
>> +}
>> +
>> +static __initdata struct tegra_clk_init_table trimslice_clk_init_table[] = {
>> +       /* name         parent          rate            enabled */
>> +       { "uarta",      "pll_p",        216000000,      true },
>> +       { NULL,         NULL,           0,              0},
>> +};
>> +
>> +static int __init tegra_trimslice_pci_init(void)
>> +{
>> +       return tegra_pcie_init(true, true);
>> +}
>> +subsys_initcall(tegra_trimslice_pci_init);
>> +
>> +static void __init tegra_trimslice_init(void)
>> +{
>> +       tegra_common_init();
>> +
>> +       tegra_clk_init_from_table(trimslice_clk_init_table);
>> +
>> +       trimslice_pinmux_init();
>> +
>> +       platform_add_devices(trimslice_devices, ARRAY_SIZE(trimslice_devices));
>> +}
>> +
>> +MACHINE_START(TRIMSLICE, "trimslice")
>> +       .boot_params    = 0x00000100,
>> +       .fixup          = tegra_trimslice_fixup,
>> +       .init_irq       = tegra_init_irq,
>> +       .init_machine   = tegra_trimslice_init,
>> +       .map_io         = tegra_map_common_io,
>> +       .timer          = &tegra_timer,
>> +MACHINE_END
>> diff --git a/arch/arm/mach-tegra/board-trimslice.h b/arch/arm/mach-tegra/board-trimslice.h
>> new file mode 100644
>> index 0000000..16ec0f0
>> --- /dev/null
>> +++ b/arch/arm/mach-tegra/board-trimslice.h
>> @@ -0,0 +1,22 @@
>> +/*
>> + * arch/arm/mach-tegra/board-trimslice.h
>> + *
>> + * Copyright (C) 2011 CompuLab, Ltd.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef _MACH_TEGRA_BOARD_TRIMSLICE_H
>> +#define _MACH_TEGRA_BOARD_TRIMSLICE_H
>> +
>> +void trimslice_pinmux_init(void);
>> +
>> +#endif
>> --
>> 1.7.3.1
> 
> Ack, the machine type is merged so I'll put this in for-next.  Do you
> want it enabled in tegra_defconfig?

If 'select TEGRA_PCI' does not trouble you, I'd be glad to have the TrimSlice in
tegra_defconfig :)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
