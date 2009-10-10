From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 10 Oct 2009 05:21:31 -0400
Subject: [PATCH 7/8] bcmring: add gpio csp code and header
In-Reply-To: <20091009211317.GF24851@broadcom.com>
References: <20091009211317.GF24851@broadcom.com>
Message-ID: <771cded00910100221g3076fee4xba56ae9c9442cc07@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2009 at 5:13 PM, Leo (Hao) Chen <leochen@broadcom.com> wrote:
>
> From 7ef707eb6d4baf5c23e1b42a07f1f504857e7915 Mon Sep 17 00:00:00 2001
> From: Leo Chen <leochen@broadcom.com>
> Date: Fri, 9 Oct 2009 10:23:56 -0700
> Subject: [PATCH] bcmring: add gpio support
>
> add gpio csp code and header
>
> Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
> ---
> ?arch/arm/mach-bcmring/csp/gpio/Makefile ? ? ? | ? ?1 +
> ?arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c | ?192 +++++++
> ?arch/arm/mach-bcmring/csp/gpiomux/Makefile ? ?| ? ?1 +
> ?arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c ? | ?669 +++++++++++++++++++++++++
> ?arch/arm/mach-bcmring/include/csp/gpioHw.h ? ?| ?383 ++++++++++++++
> ?5 files changed, 1246 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-bcmring/csp/gpio/Makefile
> ?create mode 100644 arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c
> ?create mode 100644 arch/arm/mach-bcmring/csp/gpiomux/Makefile
> ?create mode 100644 arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c
> ?create mode 100644 arch/arm/mach-bcmring/include/csp/gpioHw.h
>
> diff --git a/arch/arm/mach-bcmring/csp/gpio/Makefile b/arch/arm/mach-bcmring/csp/gpio/Makefile
> new file mode 100644
> index 0000000..e0c33b1
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/csp/gpio/Makefile
> @@ -0,0 +1 @@
> +obj-y += gpioHw_pl061.o
> diff --git a/arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c b/arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c
> new file mode 100644
> index 0000000..614c952
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c
> @@ -0,0 +1,192 @@
> +/*****************************************************************************
> +* Copyright 2004 - 2008 Broadcom Corporation. ?All rights reserved.
> +*
> +* Unless you and Broadcom execute a separate written software license
> +* agreement governing use of this software, this software is licensed to you
> +* under the terms of the GNU General Public License version 2, available at
> +* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
> +*
> +* Notwithstanding the above, under no circumstances may you combine this
> +* software in any way with any other Broadcom software provided under a
> +* license other than the GPL, without Broadcom's express prior written
> +* consent.
> +*****************************************************************************/
> +
> +/****************************************************************************/
> +/**
> +* ?@file ? ?gpioHw_pl061.c
> +*
> +* ?@brief ? Lower level GPIO device driver
> +*/
> +/****************************************************************************/
> +
> +/* ---- Include Files ----------------------------------------------------- */
> +#include <csp/stdint.h>
> +
> +#include <mach/csp/mm_io.h>
> +#include <csp/gpioHw.h>
> +#include <csp/reg.h>
> +#include <mach/csp/gpioHw_reg.h>
> +#include <mach/csp/gpioHw_inline.h>
> +
> +/* ---- Private Constants and Types ---------------------------------------- */
> +/* ---- Private Variables ------------------------------------------------ */
> +/* ---- Private Functions ------------------------------------------------- */
> +/* ---- Functions ----------------------------------------------------------*/
> +
> +void GpioHwReg_SetDirReg(volatile GPIOHW_REG_t *regp, uint32_t dirRegVal)
> +{
> + ? ? ? reg32_set_bits(&regp->gpioDir, dirRegVal);
> +}
> +
> +uint32_t GpioHwReg_GetDirReg(volatile GPIOHW_REG_t *regp)
> +{
> + ? ? ? return regp->gpioDir;
> +}
> +
> +void GpioHwReg_SetValReg(volatile GPIOHW_REG_t *regp, uint32_t gpioMask,
> + ? ? ? ? ? ? ? ? ? ? ? ?uint32_t maskVal)
> +{
> + ? ? ? uint32_t curVal = regp->gpioData;
> +
> + ? ? ? /* Change only set bits in the mask to the corresponding maskVal value bit.
> + ? ? ? ?* Bits not set in the mask are to be unchanged.
> + ? ? ? ?*/
> + ? ? ? reg32_write(&regp->gpioData,
> + ? ? ? ? ? ? ? ? ? ((maskVal & gpioMask) | (curVal & ~gpioMask)));
> +}
> +
> +uint32_t GpioHwReg_GetValReg(volatile GPIOHW_REG_t *regp)
> +{
> + ? ? ? return regp->gpioData;
> +}
> +
> +void GpioHwReg_SetModeCtrl(volatile GPIOHW_REG_t *regp, unsigned int gpioNum,
> + ? ? ? ? ? ? ? ? ? ? ? ? ?GPIOHW_MODE_CONTROL_SELECT mode)
> +{
> + ? ? ? uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> + ? ? ? if (mode == GPIOHW_MODE_CONTROL_SELECT_SOFTWARE) {
> + ? ? ? ? ? ? ? reg32_clear_bits(&regp->gpioAfSel, gpioMask);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? reg32_set_bits(&regp->gpioAfSel, gpioMask);
> + ? ? ? }
> +}
> +
> +GPIOHW_MODE_CONTROL_SELECT GpioHwReg_GetModeCtrl(volatile GPIOHW_REG_t *regp,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int gpioNum)
> +{
> + ? ? ? uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> + ? ? ? return (regp->gpioAfSel & gpioMask) ?
> + ? ? ? ? ? GPIOHW_MODE_CONTROL_SELECT_HARDWARE :
> + ? ? ? ? ? GPIOHW_MODE_CONTROL_SELECT_SOFTWARE;
> +}
> +
> +void GpioHwReg_SetIrqType(volatile GPIOHW_REG_t *regp, unsigned int gpioNum,
> + ? ? ? ? ? ? ? ? ? ? ? ? GPIOHW_INTERRUPT_TYPE irqType)
> +{
> + ? ? ? uint32_t gpioMask;
> + ? ? ? uint32_t gpioMaskStateReg;
> +
> + ? ? ? REG_LOCAL_IRQ_SAVE;
> +
> + ? ? ? gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> + ? ? ? /* Store current mask state to revert towards when done */
> + ? ? ? gpioMaskStateReg = regp->gpioIe;
> +
> + ? ? ? /* Mask and clear interrupt before changing type */
> + ? ? ? regp->gpioIe &= ~gpioMask;
> + ? ? ? regp->gpioIc &= ~gpioMask;
> +
> + ? ? ? switch (irqType) {
> + ? ? ? case GPIOHW_INTERRUPT_TYPE_LEVEL_HIGH:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIS = 1 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIEV = 1 */
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIev |= gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIs |= gpioMask;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case GPIOHW_INTERRUPT_TYPE_LEVEL_LOW:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIS = 1 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIEV = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIev &= ~gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIs |= gpioMask;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case GPIOHW_INTERRUPT_TYPE_EDGE_RISING:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIS = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIBE = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIEV = 1 */
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIbe &= ~gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIev |= gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIs &= ~gpioMask;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case GPIOHW_INTERRUPT_TYPE_EDGE_FALLING:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIS = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIBE = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIEV = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIbe &= ~gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIev &= ~gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIs &= ~gpioMask;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case GPIOHW_INTERRUPT_TYPE_EDGE_BOTH:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIS = 0 */
> + ? ? ? ? ? ? ? ? ? ? ? /* GPIOIBE = 1 */
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIbe |= gpioMask;
> + ? ? ? ? ? ? ? ? ? ? ? regp->gpioIs &= ~gpioMask;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? /* Do nothing */
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? /* Restore mask state to gpio interrupt */
> + ? ? ? regp->gpioIe = gpioMaskStateReg;
> +
> + ? ? ? REG_LOCAL_IRQ_RESTORE;
> +}
> +
> +GPIOHW_INTERRUPT_TYPE GpioHwReg_GetIrqType(volatile GPIOHW_REG_t *regp,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int gpioNum)
> +{
> + ? ? ? uint32_t gpioMask;
> + ? ? ? GPIOHW_INTERRUPT_TYPE retType;
> +
> + ? ? ? gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> + ? ? ? if (regp->gpioIs & gpioMask) {
> + ? ? ? ? ? ? ? if (regp->gpioIev & gpioMask) {
> + ? ? ? ? ? ? ? ? ? ? ? retType = GPIOHW_INTERRUPT_TYPE_LEVEL_HIGH;
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? retType = GPIOHW_INTERRUPT_TYPE_LEVEL_LOW;
> + ? ? ? ? ? ? ? }
> + ? ? ? } else {
> + ? ? ? ? ? ? ? if (regp->gpioIbe & gpioMask) {
> + ? ? ? ? ? ? ? ? ? ? ? retType = GPIOHW_INTERRUPT_TYPE_EDGE_BOTH;
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? if (regp->gpioIev & gpioMask) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? retType = GPIOHW_INTERRUPT_TYPE_EDGE_RISING;
> + ? ? ? ? ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? retType = GPIOHW_INTERRUPT_TYPE_EDGE_FALLING;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return retType;
> +}
> diff --git a/arch/arm/mach-bcmring/csp/gpiomux/Makefile b/arch/arm/mach-bcmring/csp/gpiomux/Makefile
> new file mode 100644
> index 0000000..16b1110
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/csp/gpiomux/Makefile
> @@ -0,0 +1 @@
> +obj-y += gpiomux.o
> diff --git a/arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c b/arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c
> new file mode 100644
> index 0000000..015cc9c
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c
> @@ -0,0 +1,669 @@
> +/*****************************************************************************
> +* Copyright 2004 - 2008 Broadcom Corporation. ?All rights reserved.
> +*
> +* Unless you and Broadcom execute a separate written software license
> +* agreement governing use of this software, this software is licensed to you
> +* under the terms of the GNU General Public License version 2, available at
> +* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
> +*
> +* Notwithstanding the above, under no circumstances may you combine this
> +* software in any way with any other Broadcom software provided under a
> +* license other than the GPL, without Broadcom's express prior written
> +* consent.
> +*****************************************************************************/
> +
> +/****************************************************************************/
> +/**
> +* ?@file ? ?gpiomux.c
> +*
> +* ?@brief ? Lower level GPIOMUX utility. Note that critical section protection
> +* ? ? ? ? ? is the responsibility of the higher level software.
> +*/
> +/****************************************************************************/
> +
> +/* ---- Include Files ----------------------------------------------------- */
> +#include <csp/string.h>
> +#include <csp/stdint.h>
> +#include <csp/module.h>
> +#include <mach/csp/mm_io.h>
> +#include <mach/gpio_defs.h>
> +#include <mach/csp/gpiomux.h>
> +#include <mach/csp/chipcHw_inline.h>
> +
> +/* ---- Private Constants and Types ---------------------------------------- */
> +
> +#define GMUX_DEBUG 0
> +
> +#ifdef GMUX_DEBUG
> +#if defined(__KERNEL__)
> +#define DBGPRINT(fmt, args...) printk(KERN_INFO "%s: " fmt, __func__, ##args)
> +#else
> +#include <csp/stdio.h>
> +#define DBGPRINT(fmt, args...) printf("%s: " fmt, __FUNCTION__, ##args)
> +#endif /* defined(__KERNEL__) */
> +#else
> +#define DBGPRINT(level, fmt, args...)
> +#endif /* GMUX_DEBUG */
> +
> +#if defined(__KERNEL__)
> +
> +#define FORCE_CONFLICT_CHECK 1
> +
> +#else
> +
> +/*
> + * For Linux, conflict checking is on by default. For csptest, we can turn it on
> + * with this flag for local testing. Production csptest must turn
> + * this flag off unless the registrations/deregistrations are balanced.
> + */
> +#define FORCE_CONFLICT_CHECK ?0
> +
> +#endif
> +
> +/* ---- Private Variables ------------------------------------------------ */
> +/* init called before other functions check */
> +static int initialized;
> +
> +/*
> + * Following is a number of lists of gpio pins, which are collected
> + * by logical function.
> + */
> +static const gpio_defs_e gphyledList[] = {
> + ? ? ? GPIO00_SCL_MTX_X0_EPHYLED_DATA,
> + ? ? ? GPIO01_SDA_MTX_X1_EPHYLED_CLK
> +};
> +
> +static const gpio_defs_e ext_gphyList[] = {
> + ? ? ? GPIO57_KEY_OUT5_SPIS_SSN_ETM12_EXTPHY_MDC,
> + ? ? ? GPIO58_KEY_OUT6_ETM13_EXTPHY_MDIO
> +};
> +
> +/* Shows up in 2 places below so reduce duplication */
> +#define ETM16_LIST \
> + ? GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL,\
> + ? GPIO44_KEY_IN1_UART0_RTS_B_I2S1LRCIN_ETMCLK_VPMRTCK,\
> + ? GPIO45_KEY_IN2_ETM0_I2S0MCLK,\
> + ? GPIO46_KEY_IN3_ETM1,\
> + ? GPIO47_KEY_IN4_ETM2,\
> + ? GPIO48_KEY_IN5_ETM3,\
> + ? GPIO49_KEY_IN6_SSCL_ETM4,\
> + ? GPIO50_KEY_IN7_SSDA_ETM5,\
> + ? GPIO51_KEY_IN8_SPIS_MISO_ETM6,\
> + ? GPIO52_KEY_OUT0_ETM7,\
> + ? GPIO53_KEY_OUT1_ETM8,\
> + ? GPIO54_KEY_OUT2_ETM9,\
> + ? GPIO55_KEY_OUT3_SPIS_CLK_ETM10,\
> + ? GPIO56_KEY_OUT4_SPIS_MOSI_ETM11,\
> + ? GPIO57_KEY_OUT5_SPIS_SSN_ETM12_EXTPHY_MDC,\
> + ? GPIO58_KEY_OUT6_ETM13_EXTPHY_MDIO,\
> + ? GPIO59_KEY_OUT7_ETM14_USB1_PWRON,\
> + ? GPIO60_KEY_OUT8_ETM15_USB1_PWRFLT
> +
> +static const gpio_defs_e etm16List[] = {
> + ? ? ? ETM16_LIST
> +};
> +
> +static const gpio_defs_e etm32List[] = {
> + ? ? ? ETM16_LIST,
> +
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK,
> + ? ? ? GPIO06_MTX_X6_SDIO1D2_ETM22,
> + ? ? ? GPIO07_MTX_X7_SDIO1D3_ETM23,
> + ? ? ? GPIO10_MTX_X10_SDIO1CMD_ETM16,
> + ? ? ? GPIO11_MTX_X11_SDIO1CLK_ETM17,
> + ? ? ? GPIO16_MTX_Y0_MTX_SCAN_DA_ETM26,
> + ? ? ? GPIO17_MTX_Y1_MTX_SCAN_CLK_ETM27,
> + ? ? ? GPIO18_MTX_Y2_SDIO0D2_ETM28,
> + ? ? ? GPIO19_MTX_Y3_SDIO0D3_ETM29,
> + ? ? ? GPIO20_SPI_SS2_B_MTX_Y4_SDIO0SDCD_B_ETM24,
> + ? ? ? GPIO21_SPI_SS1_B_MTX_Y5_SDIO0WP_ETM25,
> + ? ? ? GPIO27_SDIO1D0_ETM30,
> + ? ? ? GPIO28_SDIO1D1_ETM31
> +};
> +
> +static const gpio_defs_e vpm_jtagList[] = {
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK,
> + ? ? ? GPIO44_KEY_IN1_UART0_RTS_B_I2S1LRCIN_ETMCLK_VPMRTCK
> +};
> +
> +static const gpio_defs_e pcm0List[] = {
> + ? ? ? GPIO08_MTX_X8_PCM0FS_I2S0LRCOUT,
> + ? ? ? GPIO09_MTX_X9_PCM0DI_I2S0DI,
> + ? ? ? GPIO33_PCM0CLK_I2S0BCLK,
> + ? ? ? GPIO34_PCM0D0_I2S0DO
> +};
> +
> +static const gpio_defs_e pcm1List[] = {
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK
> +};
> +
> +static const gpio_defs_e mtx_scanList[] = {
> + ? ? ? GPIO16_MTX_Y0_MTX_SCAN_DA_ETM26,
> + ? ? ? GPIO17_MTX_Y1_MTX_SCAN_CLK_ETM27
> +};
> +
> +static const gpio_defs_e uart0_mdmList[] = {
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK
> +};
> +
> +static const gpio_defs_e uart0_fcList[] = {
> + ? ? ? GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL,
> + ? ? ? GPIO44_KEY_IN1_UART0_RTS_B_I2S1LRCIN_ETMCLK_VPMRTCK
> +};
> +
> +static const gpio_defs_e uart1List[] = {
> + ? ? ? GPIO14_UART1_TXD,
> + ? ? ? GPIO15_UART1_RXD
> +};
> +
> +static const gpio_defs_e uart1_fcList[] = {
> + ? ? ? GPIO12_UART1_CTS_B,
> + ? ? ? GPIO13_UART1_RTS_B
> +};
> +
> +static const gpio_defs_e i2chList[] = {
> + ? ? ? GPIO00_SCL_MTX_X0_EPHYLED_DATA,
> + ? ? ? GPIO01_SDA_MTX_X1_EPHYLED_CLK
> +};
> +
> +static const gpio_defs_e i2ch_v2List[] = {
> + ? ? ? GPIO38_SDA_V2_SPI_V2,
> + ? ? ? GPIO39_SCL_V2_SPI_CLK_V2
> +};
> +
> +static const gpio_defs_e usb0_pwronfltList[] = {
> + ? ? ? GPIO36_USB0_PWRON,
> + ? ? ? GPIO37_USB0_PWRFLT
> +};
> +
> +static const gpio_defs_e usb1_pwronfltList[] = {
> + ? ? ? GPIO59_KEY_OUT7_ETM14_USB1_PWRON,
> + ? ? ? GPIO60_KEY_OUT8_ETM15_USB1_PWRFLT
> +};
> +
> +static const gpio_defs_e spiList[] = {
> + ? ? ? GPIO22_SPI_MISO,
> + ? ? ? GPIO23_SPI_CLK,
> + ? ? ? GPIO24_SPI_MOSI
> +};
> +
> +static const gpio_defs_e spisList[] = {
> + ? ? ? GPIO51_KEY_IN8_SPIS_MISO_ETM6,
> + ? ? ? GPIO55_KEY_OUT3_SPIS_CLK_ETM10,
> + ? ? ? GPIO56_KEY_OUT4_SPIS_MOSI_ETM11
> +};
> +
> +static const gpio_defs_e i2csList[] = {
> + ? ? ? GPIO49_KEY_IN6_SSCL_ETM4,
> + ? ? ? GPIO50_KEY_IN7_SSDA_ETM5
> +};
> +
> +static const gpio_defs_e sdio0_1List[] = {
> + ? ? ? GPIO20_SPI_SS2_B_MTX_Y4_SDIO0SDCD_B_ETM24,
> + ? ? ? GPIO21_SPI_SS1_B_MTX_Y5_SDIO0WP_ETM25,
> + ? ? ? GPIO29_SDIO0CMD,
> + ? ? ? GPIO30_SDIO0CLK,
> + ? ? ? GPIO31_SDIO0D0
> +};
> +
> +static const gpio_defs_e sdio0_4List[] = {
> + ? ? ? GPIO20_SPI_SS2_B_MTX_Y4_SDIO0SDCD_B_ETM24,
> + ? ? ? GPIO21_SPI_SS1_B_MTX_Y5_SDIO0WP_ETM25,
> + ? ? ? GPIO29_SDIO0CMD,
> + ? ? ? GPIO30_SDIO0CLK,
> + ? ? ? GPIO31_SDIO0D0,
> + ? ? ? GPIO32_SDIO0D1,
> + ? ? ? GPIO18_MTX_Y2_SDIO0D2_ETM28,
> + ? ? ? GPIO19_MTX_Y3_SDIO0D3_ETM29
> +};
> +
> +static const gpio_defs_e sdio0_8List[] = {
> + ? ? ? GPIO20_SPI_SS2_B_MTX_Y4_SDIO0SDCD_B_ETM24,
> + ? ? ? GPIO21_SPI_SS1_B_MTX_Y5_SDIO0WP_ETM25,
> + ? ? ? GPIO29_SDIO0CMD,
> + ? ? ? GPIO30_SDIO0CLK,
> + ? ? ? GPIO31_SDIO0D0,
> + ? ? ? GPIO32_SDIO0D1,
> + ? ? ? GPIO18_MTX_Y2_SDIO0D2_ETM28,
> + ? ? ? GPIO19_MTX_Y3_SDIO0D3_ETM29,
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK
> +};
> +
> +static const gpio_defs_e sdio1_1List[] = {
> + ? ? ? GPIO10_MTX_X10_SDIO1CMD_ETM16,
> + ? ? ? GPIO11_MTX_X11_SDIO1CLK_ETM17,
> + ? ? ? GPIO27_SDIO1D0_ETM30
> +};
> +
> +static const gpio_defs_e sdio1_4List[] = {
> + ? ? ? GPIO10_MTX_X10_SDIO1CMD_ETM16,
> + ? ? ? GPIO11_MTX_X11_SDIO1CLK_ETM17,
> + ? ? ? GPIO27_SDIO1D0_ETM30,
> + ? ? ? GPIO28_SDIO1D1_ETM31,
> + ? ? ? GPIO06_MTX_X6_SDIO1D2_ETM22,
> + ? ? ? GPIO07_MTX_X7_SDIO1D3_ETM23
> +};
> +
> +static const gpio_defs_e i2s0List[] = {
> + ? ? ? GPIO08_MTX_X8_PCM0FS_I2S0LRCOUT,
> + ? ? ? GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL,
> + ? ? ? GPIO09_MTX_X9_PCM0DI_I2S0DI,
> + ? ? ? GPIO34_PCM0D0_I2S0DO,
> + ? ? ? GPIO33_PCM0CLK_I2S0BCLK,
> + ? ? ? GPIO45_KEY_IN2_ETM0_I2S0MCLK,
> +};
> +
> +static const gpio_defs_e i2s1List[] = {
> + ? ? ? GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK,
> + ? ? ? GPIO44_KEY_IN1_UART0_RTS_B_I2S1LRCIN_ETMCLK_VPMRTCK,
> + ? ? ? GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
> + ? ? ? GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
> + ? ? ? GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
> + ? ? ? GPIO26_I2S1MCLK,
> +};
> +
> +/*
> + * A table of logical groupings of gpio pins. Each group has an associate group enum, and chipc
> + * gpio function, and a number of pins, followed by the pin numbers in a list. This table is used
> + * by the gpiomux_requestGroup() and gpiomux_freeGroup() functions to check for conflicts
> + * and to make chipc assignments.
> + */
> +const gpiomux_group_t gpiomux_GroupList[] = {
> + ? ? ? {gpiomux_group_gphyled, chipcHw_GPIO_FUNCTION_MISC, ARRAY_LEN(gphyledList), gphyledList},
> + ? ? ? {gpiomux_group_ext_gphy, chipcHw_GPIO_FUNCTION_MISC, ARRAY_LEN(ext_gphyList), ext_gphyList},
> + ? ? ? {gpiomux_group_etm16, chipcHw_GPIO_FUNCTION_ETM, ARRAY_LEN(etm16List), etm16List},
> + ? ? ? {gpiomux_group_etm32, chipcHw_GPIO_FUNCTION_ETM, ARRAY_LEN(etm32List), etm32List},
> + ? ? ? {gpiomux_group_vpm_jtag, chipcHw_GPIO_FUNCTION_MISC, ARRAY_LEN(vpm_jtagList), vpm_jtagList},
> + ? ? ? {gpiomux_group_pcm0, chipcHw_GPIO_FUNCTION_PCM, ARRAY_LEN(pcm0List), pcm0List},
> + ? ? ? {gpiomux_group_pcm1, chipcHw_GPIO_FUNCTION_PCM, ARRAY_LEN(pcm1List), pcm1List},
> + ? ? ? {gpiomux_group_mtx_scan, chipcHw_GPIO_FUNCTION_LEDMTXS, ARRAY_LEN(mtx_scanList), mtx_scanList},
> + ? ? ? {gpiomux_group_uart0_mdm, chipcHw_GPIO_FUNCTION_UART, ARRAY_LEN(uart0_mdmList), uart0_mdmList},
> + ? ? ? {gpiomux_group_uart0_fc, chipcHw_GPIO_FUNCTION_UART, ARRAY_LEN(uart0_fcList), uart0_fcList},
> + ? ? ? {gpiomux_group_uart1, chipcHw_GPIO_FUNCTION_UART, ARRAY_LEN(uart1List), uart1List},
> + ? ? ? {gpiomux_group_uart1_fc, chipcHw_GPIO_FUNCTION_UART, ARRAY_LEN(uart1_fcList), uart1_fcList},
> + ? ? ? {gpiomux_group_i2ch, chipcHw_GPIO_FUNCTION_I2CH, ARRAY_LEN(i2chList), i2chList},
> + ? ? ? {gpiomux_group_i2ch_v2, chipcHw_GPIO_FUNCTION_I2CH, ARRAY_LEN(i2ch_v2List), i2ch_v2List},
> + ? ? ? {gpiomux_group_usb0_pwronflt, chipcHw_GPIO_FUNCTION_MISC, ARRAY_LEN(usb0_pwronfltList), usb0_pwronfltList},
> + ? ? ? {gpiomux_group_usb1_pwronflt, chipcHw_GPIO_FUNCTION_MISC, ARRAY_LEN(usb1_pwronfltList), usb1_pwronfltList},
> + ? ? ? {gpiomux_group_spi, chipcHw_GPIO_FUNCTION_SPI, ARRAY_LEN(spiList), spiList},
> + ? ? ? {gpiomux_group_spis, chipcHw_GPIO_FUNCTION_DEBUG, ARRAY_LEN(spisList), spisList},
> + ? ? ? {gpiomux_group_i2cs, chipcHw_GPIO_FUNCTION_DEBUG, ARRAY_LEN(i2csList), i2csList},
> + ? ? ? {gpiomux_group_sdio0_1, chipcHw_GPIO_FUNCTION_SDIO0, ARRAY_LEN(sdio0_1List), sdio0_1List},
> + ? ? ? {gpiomux_group_sdio0_4, chipcHw_GPIO_FUNCTION_SDIO0, ARRAY_LEN(sdio0_4List), sdio0_4List},
> + ? ? ? {gpiomux_group_sdio0_8, chipcHw_GPIO_FUNCTION_SDIO0, ARRAY_LEN(sdio0_8List), sdio0_8List},
> + ? ? ? {gpiomux_group_sdio1_1, chipcHw_GPIO_FUNCTION_SDIO1, ARRAY_LEN(sdio1_1List), sdio1_1List},
> + ? ? ? {gpiomux_group_sdio1_4, chipcHw_GPIO_FUNCTION_SDIO1, ARRAY_LEN(sdio1_4List), sdio1_4List},
> + ? ? ? {gpiomux_group_i2s0, chipcHw_GPIO_FUNCTION_I2S, ARRAY_LEN(i2s0List), i2s0List},
> + ? ? ? {gpiomux_group_i2s1, chipcHw_GPIO_FUNCTION_I2S, ARRAY_LEN(i2s1List), i2s1List},
> +};
> +
> +/* global init structure */
> +static gpiomux_init_t gInit;
> +
> +/* ---- Private Functions ------------------------------------------------- */
> +/* ---- Functions ----------------------------------------------------------*/
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_Init
> +*
> +* ?Used to initialize the mux table and set all pin functions to GPIO.
> +*
> +* ?@return
> +* ? ? none
> +*/
> +/****************************************************************************/
> +void gpiomux_Init(gpiomux_init_t *initp ? ? ? ?/* [IN] initialization structure pointer */
> + ? ?) {
> + ? ? ? unsigned int i;
> + ? ? ? for (i = 0; i < gpio_defs_MAX_PINS; i++) {
> + ? ? ? ? ? ? ? if ((i != GPIO14_UART1_TXD) && (i != GPIO15_UART1_RXD)) {
> + ? ? ? ? ? ? ? ? ? ? ? chipcHw_setGpioPinFunction((int)i,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?chipcHw_GPIO_FUNCTION_GPIO);
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? gInit = *initp; ? ? ? ? /* structure copy */
> + ? ? ? initialized = 1;
> +}
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_request
> +*
> +* ?Used to register a function with the gpiomux. It is acceptable to
> +* ?use the GPIO function as an argument when simple gpio reservations
> +* ?are required, in which case we don't activate the mux.
> +*
> +* ?@return
> +* ? ? success or conflict return code
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_request(gpio_defs_e pin, ?/* [IN] GPIO pin */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?chipcHw_GPIO_FUNCTION_e function, ?/* [IN] GPIO pin function */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *label ?/* [IN] description of pin usage */
> + ? ?) {
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if (pin >= gpio_defs_MAX_PINS) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +#if FORCE_CONFLICT_CHECK
> + ? ? ? if (chipcHw_getGpioPinFunction(pin) != chipcHw_GPIO_FUNCTION_GPIO) {
> + ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ("pin=%d gpiomux_rc_ASSIGNED - chipcHw_getGpioPinFunction(pin) != chipcHw_GPIO_FUNCTION_GPIO\n",
> + ? ? ? ? ? ? ? ? ? ?pin);
> + ? ? ? ? ? ? ? return gpiomux_rc_ASSIGNED; ? ? /* Pin function already assigned, exit */
> + ? ? ? }
> +#endif
> +
> + ? ? ? if ((gInit.request_gpio) && (gInit.request_gpio(pin, label) < 0)) {
> + ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ("pin=%d gpiomux_rc_CONFLICT - (gInit.request_gpio(pin, label) < 0)\n",
> + ? ? ? ? ? ? ? ? ? ?pin);
> + ? ? ? ? ? ? ? return gpiomux_rc_CONFLICT; ? ? /* Could not request this pin externally */
> + ? ? ? }
> +
> + ? ? ? /* Assign new function */
> + ? ? ? chipcHw_setGpioPinFunction((int)pin, function);
> +
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> +
> +EXPORT_SYMBOL(gpiomux_request);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_free
> +*
> +* ?Used to deregister a pin assignment
> +*
> +* ?@return
> +* ? ? success - assigned function was unregistered
> +* ? ? notfound - there was not registered function for this pin
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_free(gpio_defs_e pin ? ? ?/* [IN] GPIO pin */
> + ? ?) {
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if (pin >= gpio_defs_MAX_PINS) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* If a user is reserving a gpio pin for a GPIO function and
> + ? ? ? ?* does not require the mux, then the free must not fail if
> + ? ? ? ?* the assigned function is GPIO, so we don't need to do a
> + ? ? ? ?* conflict check here similar to the gpiomux_freeGroup() (to
> + ? ? ? ?* make sure the current function is assigned).
> + ? ? ? ?*/
> +
> + ? ? ? /* Free the pin externally */
> + ? ? ? if (gInit.free_gpio) {
> + ? ? ? ? ? ? ? gInit.free_gpio(pin);
> + ? ? ? }
> +
> + ? ? ? /* Revert back to default gpio function */
> + ? ? ? chipcHw_setGpioPinFunction((int)pin, chipcHw_GPIO_FUNCTION_GPIO);
> +
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> +
> +EXPORT_SYMBOL(gpiomux_free);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_requestGroup
> +*
> +* ?Used to register a logical group of pin functions with the gpiomux
> +*
> +* ?@return
> +* ? ? success or conflict return code
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_requestGroup(const gpiomux_group_e group, /* [IN] GPIO group */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const char *label ? ? /* [IN] description of group usage */
> + ? ?) {
> + ? ? ? unsigned int groupidx;
> + ? ? ? const gpiomux_group_t *groupp;
> +
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if (group >= gpiomux_group_MaxNum) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADGROUP;
> + ? ? ? }
> +
> + ? ? ? /* Check for conflicts before assigning functions */
> + ? ? ? for (groupidx = 0; groupidx < ARRAY_LEN(gpiomux_GroupList); groupidx++) {
> + ? ? ? ? ? ? ? /* Find matching list */
> + ? ? ? ? ? ? ? groupp = &gpiomux_GroupList[groupidx];
> + ? ? ? ? ? ? ? if (groupp->group == group) {
> + ? ? ? ? ? ? ? ? ? ? ? unsigned int pinidx;
> +
> + ? ? ? ? ? ? ? ? ? ? ? for (pinidx = 0; pinidx < groupp->numPins; pinidx++) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const char *str;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int pin = groupp->listp[pinidx];
> +
> +#if FORCE_CONFLICT_CHECK
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (chipcHw_getGpioPinFunction(pin) !=
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chipcHw_GPIO_FUNCTION_GPIO) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ("group=%d pin=%d gpiomux_rc_ASSIGNED - chipcHw_getGpioPinFunction(pin) != chipcHw_GPIO_FUNCTION_GPIO\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?group, pin);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return gpiomux_rc_ASSIGNED; ? ? /* Pin function already assigned, exit */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
> +#endif
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (gInit.is_requested) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? str = gInit.is_requested(pin);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?if (str != NULL) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DBGPRINT ("group=%d pin=%d ggpiomux_rc_CONFLICT -"
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "gInit.is_requested && (gInit.is_requested(pin) != NULL) \'%s\'\n", group, pin, str);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?}
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return gpiomux_rc_CONFLICT; ? ? /* Pin already assigned externally, exit */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? ? ? ? ? /* Pins all unassigned, so assign new functions now. */
> + ? ? ? ? ? ? ? ? ? ? ? for (pinidx = 0; pinidx < groupp->numPins; pinidx++) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int pin = groupp->listp[pinidx];
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int rc =
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? gpiomux_request(pin, groupp->function,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? label);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (rc != 0) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ("ERROR gpiomux_request group=%d pin=%d rc=%d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?group, pin, rc);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return rc;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> +
> +EXPORT_SYMBOL(gpiomux_requestGroup);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_freeGroup
> +*
> +* ?Used to deregister a logical set of pin functions
> +*
> +* ?@return
> +* ? ? success - assigned function was unregistered
> +* ? ? notfound - there was not registered function for this pin
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_freeGroup(gpiomux_group_e group ? /* [IN] GPIO group */
> + ? ?) {
> + ? ? ? unsigned int groupidx;
> + ? ? ? const gpiomux_group_t *groupp;
> +
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if (group >= gpiomux_group_MaxNum) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADGROUP;
> + ? ? ? }
> +
> + ? ? ? /* Check for conflicts before deassigning functions */
> + ? ? ? for (groupidx = 0; groupidx < ARRAY_LEN(gpiomux_GroupList); groupidx++) {
> + ? ? ? ? ? ? ? /* Find matching list */
> + ? ? ? ? ? ? ? groupp = &gpiomux_GroupList[groupidx];
> + ? ? ? ? ? ? ? if (groupp->group == group) {
> + ? ? ? ? ? ? ? ? ? ? ? unsigned int pinidx;
> + ? ? ? ? ? ? ? ? ? ? ? for (pinidx = 0; pinidx < groupp->numPins; pinidx++) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int pin = groupp->listp[pinidx];
> +#if FORCE_CONFLICT_CHECK
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (chipcHw_getGpioPinFunction(pin) ==
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chipcHw_GPIO_FUNCTION_GPIO) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ("group=%d pin=%d gpiomux_rc_UNASSIGNED - chipcHw_getGpioPinFunction(pin) == chipcHw_GPIO_FUNCTION_GPIO\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?group, pin);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return gpiomux_rc_UNASSIGNED; ? /* pin already unassigned, cannot free */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
> +#endif
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /* Do not free an already externally freed pin */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (gInit.is_requested
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? && (gInit.is_requested(pin) == NULL)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DBGPRINT
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ("group=%d pin=%d gpiomux_rc_CONFLICT - gInit.is_requested && (gInit.is_requested(pin) != NULL)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?group, pin);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return gpiomux_rc_CONFLICT; ? ? /* Pin already assigned externally, exit */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? /* Pins all unassigned, so revert to GPIO function now. */
> + ? ? ? ? ? ? ? ? ? ? ? for (pinidx = 0; pinidx < groupp->numPins; pinidx++) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int pin = groupp->listp[pinidx];
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? gpiomux_free(pin); ? ? ?/* cannot fail or we have a logic error */
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> +
> +EXPORT_SYMBOL(gpiomux_freeGroup);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_requestKeypad
> +*
> +* ?Used to register a logical set of pin functions with the gpiomux. If the
> +* ?keypad pins are not sequential, then use the individual setPin functions.
> +* ?Example: gpiomux_requestKeypad(0,5,0,4);
> +*
> +* ?@return
> +* ? ? success or conflict return code
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_requestKeypad(uint8_t in_first, ? /* [IN] keypad_in[in_first] is start of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?uint8_t in_last, ? ? /* [IN] keypad_in[in_last] is end of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?uint8_t out_first, ? /* [IN] keypad_out[out_first] is start of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?uint8_t out_last, ? ?/* [IN] keypad_out[out_last] is end of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *label ? ?/* [IN] description of group usage */
> + ? ?) {
> + ? ? ? int i;
> + ? ? ? gpiomux_rc_e rc;
> +
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if ((in_last > GPIO_MAX_INKEY_IDX) || (in_first > in_last)) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +
> + ? ? ? if ((out_last > GPIO_MAX_OUTKEY_IDX) || (out_first > in_last)) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +
> + ? ? ? for (i = in_first; i < (in_last + 1); i++) {
> + ? ? ? ? ? ? ? rc = gpiomux_request(GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+ i, chipcHw_GPIO_FUNCTION_KEYPAD, label);
> + ? ? ? ? ? ? ? if (rc != gpiomux_rc_SUCCESS) {
> + ? ? ? ? ? ? ? ? ? ? ? DBGPRINT("rc != gpiomux_rc_SUCCESS rc=%d\n", rc);
> + ? ? ? ? ? ? ? ? ? ? ? return rc;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? for (i = out_first; i < (out_last + 1); i++) {
> + ? ? ? ? ? ? ? rc = gpiomux_request(GPIO52_KEY_OUT0_ETM7 + i,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?chipcHw_GPIO_FUNCTION_KEYPAD, label);
> + ? ? ? ? ? ? ? if (rc != gpiomux_rc_SUCCESS) {
> + ? ? ? ? ? ? ? ? ? ? ? DBGPRINT("rc != gpiomux_rc_SUCCESS rc=%d\n", rc);
> + ? ? ? ? ? ? ? ? ? ? ? return rc;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? gpiomux_freeKeypad
> +*
> +* ?Used to deregister a logical set of keypad pin functions
> +*
> +* ?@return
> +* ? ? success - assigned function was unregistered
> +* ? ? notfound - one or more pins were not registered for the keypad
> +*/
> +/****************************************************************************/
> +gpiomux_rc_e gpiomux_freeKeypad(uint8_t in_first, ? ? ?/* [IN] keypad_in[in_first] is start of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint8_t in_last, ? ? ? ?/* [IN] keypad_in[in_last] is end of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint8_t out_first, ? ? ?/* [IN] keypad_out[out_first] is start of array */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint8_t out_last ? ? ? ?/* [IN] keypad_out[out_last] is end of array */
> + ? ?) {
> + ? ? ? int i;
> + ? ? ? gpiomux_rc_e rc;
> +
> + ? ? ? if (!initialized) {
> + ? ? ? ? ? ? ? return gpiomux_rc_UNINITIALIZED;
> + ? ? ? }
> +
> + ? ? ? if ((in_last > GPIO_MAX_INKEY_IDX) || (in_first > in_last)) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +
> + ? ? ? if ((out_last > GPIO_MAX_OUTKEY_IDX) || (out_first > in_last)) {
> + ? ? ? ? ? ? ? return gpiomux_rc_BADPIN;
> + ? ? ? }
> +
> + ? ? ? for (i = in_first; i < (in_last + 1); i++) {
> + ? ? ? ? ? ? ? rc = gpiomux_free(GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL +
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? i);
> + ? ? ? ? ? ? ? if (rc != gpiomux_rc_SUCCESS) {
> + ? ? ? ? ? ? ? ? ? ? ? DBGPRINT("rc != INKEY gpiomux_rc_SUCCESS rc=%d\n", rc);
> + ? ? ? ? ? ? ? ? ? ? ? return rc;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? for (i = out_first; i < (out_last + 1); i++) {
> + ? ? ? ? ? ? ? rc = gpiomux_free(GPIO52_KEY_OUT0_ETM7 + i);
> + ? ? ? ? ? ? ? if (rc != gpiomux_rc_SUCCESS) {
> + ? ? ? ? ? ? ? ? ? ? ? DBGPRINT("rc != OUTKEY gpiomux_rc_SUCCESS rc=%d\n", rc);
> + ? ? ? ? ? ? ? ? ? ? ? return rc;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return gpiomux_rc_SUCCESS;
> +}
> diff --git a/arch/arm/mach-bcmring/include/csp/gpioHw.h b/arch/arm/mach-bcmring/include/csp/gpioHw.h
> new file mode 100644
> index 0000000..b74ac41
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/include/csp/gpioHw.h
> @@ -0,0 +1,383 @@
> +/*****************************************************************************
> +* Copyright 2004 - 2008 Broadcom Corporation. ?All rights reserved.
> +*
> +* Unless you and Broadcom execute a separate written software license
> +* agreement governing use of this software, this software is licensed to you
> +* under the terms of the GNU General Public License version 2, available at
> +* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
> +*
> +* Notwithstanding the above, under no circumstances may you combine this
> +* software in any way with any other Broadcom software provided under a
> +* license other than the GPL, without Broadcom's express prior written
> +* consent.
> +*****************************************************************************/
> +
> +/****************************************************************************/
> +/**
> +* ?@file ? ?gpioHw.h
> +*
> +* ?@brief ? API definitions for low level gpio device driver
> +*
> +*/
> +/****************************************************************************/
> +
> +#ifndef GPIOHW_H
> +#define GPIOHW_H
> +
> +/* ---- Include Files ----------------------------------------------------- */
> +
> +#include <csp/stdint.h>
> +
> +/* ---- Public Constants and Types ---------------------------------------- */
> +
> +typedef enum {
> + ? ? ? GPIOHW_BLOCK_LOW = 0,
> + ? ? ? GPIOHW_BLOCK_HIGH
> +} GPIOHW_BLOCK_LEVEL;
> +
> +typedef enum {
> + ? ? ? GPIOHW_DIR_INPUT = 0,
> + ? ? ? GPIOHW_DIR_OUTPUT,
> +
> +} GPIOHW_DIRECTION;
> +
> +typedef enum {
> + ? ? ? GPIOHW_IRQ_UNMASKED_INTERRUPT = 0,
> + ? ? ? GPIOHW_IRQ_MASKED_INTERRUPT,
> +
> +} GPIOHW_IRQ_MASK_STATE;
> +
> +typedef enum {
> + ? ? ? GPIOHW_INTERRUPT_TYPE_LEVEL_HIGH = 0,
> + ? ? ? GPIOHW_INTERRUPT_TYPE_LEVEL_LOW,
> + ? ? ? GPIOHW_INTERRUPT_TYPE_EDGE_RISING,
> + ? ? ? GPIOHW_INTERRUPT_TYPE_EDGE_FALLING,
> + ? ? ? GPIOHW_INTERRUPT_TYPE_EDGE_BOTH
> +} GPIOHW_INTERRUPT_TYPE;
> +
> +typedef enum {
> + ? ? ? GPIOHW_MODE_CONTROL_SELECT_SOFTWARE = 0,
> + ? ? ? GPIOHW_MODE_CONTROL_SELECT_HARDWARE
> +} GPIOHW_MODE_CONTROL_SELECT;
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetDirOutput
> +*
> +* ?Used to set the specified GPIO pin to the output mode/direction.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetDirOutput(unsigned int gpioNum ? ?/* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetDirInput
> +*
> +* ?This function is used to set the specified GPIO pin to the input direction.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetDirInput(unsigned int gpioNum ? ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetDirReg
> +*
> +* ?This function is used to set the GPIO pins to the register value specified.
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetDirReg(GPIOHW_BLOCK_LEVEL blockLevel, ? ? /* [IN] GPIO block selected */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint32_t dirRegVal ?/* [IN] Register value */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetDir
> +*
> +* ?This function is used to get the direction of the GPIO pin specified.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? The direction of the GPIO pin of type GPIOHW_DIRECTION
> +*/
> +/****************************************************************************/
> +static inline GPIOHW_DIRECTION GpioHw_GetDir(unsigned int gpioNum ? ? ?/* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetDirReg
> +*
> +* ?This function is used to set the GPIO pins to the register value specified.
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? The register containing bitmapped values of the direction for the GPIO pin block
> +*/
> +/****************************************************************************/
> +static inline uint32_t GpioHw_GetDirReg(GPIOHW_BLOCK_LEVEL blockLevel ?/* [IN] GPIO block selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetVal
> +*
> +* ?This function is used to set the value of a specified GPIO pin.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetVal(unsigned int gpioNum, /* [IN] GPIO pin number selected */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int setVal ? ? /* [IN] Value to set pin */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetValReg
> +*
> +* ?This function is used to set the value for the GPIO pins specified.
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetValReg(uint32_t gpioMask, /* [IN] GPIO mask of pins to set */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint32_t maskVal, ? /* [IN] Value of the register */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GPIOHW_BLOCK_LEVEL blockLevel ? ? ? /* [IN] GPIO block selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetVal
> +*
> +* ?This function is used to get the value of a specified GPIO pin.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? 1 if the pin is set high, 0 if low
> +*/
> +/****************************************************************************/
> +static inline int GpioHw_GetVal(unsigned int gpioNum ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetValReg
> +*
> +* ?This function is used to set the value of a specified GPIO pin
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? Register of bits indicating current value of all pins for the block specified
> +*/
> +/****************************************************************************/
> +static inline uint32_t GpioHw_GetValReg(GPIOHW_BLOCK_LEVEL blockLevel ?/* [IN] GPIO block selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_IrqEnable
> +*
> +* ?This function is used to enable the interrupt of the specified GPIO pin
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_IrqEnable(unsigned int gpioNum ? ? ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_IrqDisable
> +*
> +* ?This function is used to disable the interrupt of the specified GPIO pin
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_IrqDisable(unsigned int gpioNum ? ? ?/* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_IsIrqEnabled
> +*
> +* ?This function is used to query if IRQ is enabled or not for the specified GPIO pin
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? Returns the status of the IRQ of type GPIOHW_IRQ_MASK_STATE
> +*/
> +/****************************************************************************/
> +static inline GPIOHW_IRQ_MASK_STATE GpioHw_IsIrqEnabled(unsigned int gpioNum ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_IrqClear
> +*
> +* ?This function is used to clear the IRQ of the GPIO pin specified
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_IrqClear(unsigned int gpioNum ? ? ? ?/* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetRawIrqStatus
> +*
> +* ?This function is used to retrieve the raw IRQ status (ignores masked status)
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? Return 1 if interrupt triggered, else 0
> +*/
> +/****************************************************************************/
> +static inline int GpioHw_GetRawIrqStatus(unsigned int gpioNum ?/* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetMaskIrqStatus
> +*
> +* ?This function is used to retrieve the masked IRQ status
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? Return 1 if interrupt triggered, else 0 if not triggered or not enabled
> +*/
> +/****************************************************************************/
> +static inline int GpioHw_GetMaskIrqStatus(unsigned int gpioNum /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetRawIrqRegStatus
> +*
> +* ?This function is used to retrieve the block of GPIO pin IRQ raw status
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? Return register set of GPIO pin status. Raised bit indicates interrupt triggered
> +*/
> +/****************************************************************************/
> +static inline uint32_t GpioHw_GetRawIrqRegStatus(GPIOHW_BLOCK_LEVEL blockLevel /* [IN] GPIO block selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHwReg_GetMaskIrqRegStatus
> +*
> +* ?This function is used to retrieve the block of GPIO pin IRQ masked status
> +* ?Executes operation towards specified block.
> +*
> +* ?@return
> +* ? ? Return register set of GPIO pin status. Raised bit indicates
> +* ? ? interrupt triggered
> +*/
> +/****************************************************************************/
> +static inline uint32_t GpioHw_GetMaskIrqRegStatus(GPIOHW_BLOCK_LEVEL blockLevel ? ? ? ?/* [IN] GPIO block selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_IrqClearReg
> +*
> +* ?This function is used to clear a number of simulataneous gpio interrupts.
> +*
> +* ?@return
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_IrqClearReg(GPIOHW_BLOCK_LEVEL blockLevel, ? /* [IN] GPIO block selected */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint32_t mask ? ? /* bitmask of gpio irq bits to clear */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetModeCtrl
> +*
> +* ?This function is used to set the control mode of the GPIO pin
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetModeCtrl(unsigned int gpioNum, ? ?/* [IN] GPIO pin number selected */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GPIOHW_MODE_CONTROL_SELECT mode ? /* [IN] Mode control to select */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHwReg_GetModeCtrl
> +*
> +* ?This function is used to get the control mode of the GPIO pin
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? ? Current mode selected for pin of type GPIOHW_MODE_CONTROL_SELECT
> +*/
> +/****************************************************************************/
> +static inline GPIOHW_MODE_CONTROL_SELECT GpioHw_GetModeCtrl(unsigned int gpioNum ? ? ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_SetIrqType
> +*
> +* ?Sets the IRQ trigger mode (falling edge, rising edge, level). ?Deciphers
> +* ?which block to select based on gpio pin selected. ?IRQ should be disabled
> +* ?before selecting to avoid spurrious interrupts
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? None
> +*/
> +/****************************************************************************/
> +static inline void GpioHw_SetIrqType(unsigned int gpioNum, ? ? /* [IN] GPIO pin number selected */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?GPIOHW_INTERRUPT_TYPE irqType ? ? ?/* [IN] IRQ trigger type */
> + ? ?);
> +
> +/****************************************************************************/
> +/**
> +* ?@brief ? GpioHw_GetIrqType
> +*
> +* ?Retrieves the IRQ trigger mode. ?Deciphers which block to select based on
> +* ?gpio pin selected.
> +* ?Determines the block in which to perform operation.
> +*
> +* ?@return
> +* ? Interrupt trigger mode of type GPIOHW_INTERRUPT_TYPE
> +*
> +*/
> +/****************************************************************************/
> +static inline GPIOHW_INTERRUPT_TYPE GpioHw_GetIrqType(unsigned int gpioNum ? ? /* [IN] GPIO pin number selected */
> + ? ?);
> +
> +#include <mach/csp/gpioHw_inline.h>
> +
> +#endif /* GPIOHW_H */
> --
> 1.6.0.6
>
> Leo Chen
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

I suggested that you should run $(LINUX)/scripts/checkpatch.pl to
check coding style first.

Thanks
Haojian
