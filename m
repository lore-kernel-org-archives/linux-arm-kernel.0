From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 10 Oct 2009 22:54:44 +0100
Subject: [PATCH 6/8] bcmring: add gpio headers in include/mach/csp
	directory
In-Reply-To: <20091009211308.GE24851@broadcom.com>
References: <20091009211308.GE24851@broadcom.com>
Message-ID: <20091010215444.GP31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2009 at 02:13:08PM -0700, Leo (Hao) Chen wrote:
> 
> >From 5e9bb08c283d14926be3902c96968ca46c4ddb8d Mon Sep 17 00:00:00 2001
> From: Leo Chen <leochen@broadcom.com>
> Date: Fri, 9 Oct 2009 10:23:09 -0700
> Subject: [PATCH] bcmring: add gpio support
> 
> add gpio headers in include/mach/csp directory.
> 
> Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
> ---
>  .../mach-bcmring/include/mach/csp/gpioHw_inline.h  |  345 ++++++++++++++++++
>  .../arm/mach-bcmring/include/mach/csp/gpioHw_reg.h |  381 ++++++++++++++++++++
>  arch/arm/mach-bcmring/include/mach/csp/gpiomux.h   |  221 ++++++++++++
>  3 files changed, 947 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
>  create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpioHw_reg.h
>  create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpiomux.h
> 
> diff --git a/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
> new file mode 100644
> index 0000000..e400ee3
> --- /dev/null
> +++ b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
> @@ -0,0 +1,345 @@
> +/*****************************************************************************
> +* Copyright 2003 - 2008 Broadcom Corporation.  All rights reserved.
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

Hmm, is that actually GPLv2 compliant (the second block?)

> +#ifndef GPIOHW_INLINE_H
> +#define GPIOHW_INLINE_H
> +
> +#ifndef GPIOHW_H
> +#error *** Do not include gpioHw_inline.h directly. Use gpioHw.h instead. ***
> +#endif
> +
> +/* ---- Include Files ---------------------------------------------------- */
> +#include <mach/csp/mm_io.h>
> +#include <mach/csp/gpioHw_reg.h>
> +#include <csp/reg.h>
> +
> +/* ---- Public Constants and Types --------------------------------------- */
> +/* ---- Public Variable Externs ------------------------------------------ */
> +/* ---- Public Function Prototypes --------------------------------------- */
> +
> +static inline void GpioHwReg_SetDirOutput(volatile GPIOHW_REG_t *regp,
> +					  unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> +	/* Set bit to set to output direction */
> +	reg32_modify_or(&regp->gpioDir, gpioMask);
> +}

Do not use volatile, at the best these should be 'void __iomem *' and you
should be using the proper register accessors such as __raw_{read,write} or
suchlike.


> +	/*
> +	 * The hardware ignores sets to the data register when the pin is configured as an
> +	 * input, so we need to set the direction before setting the value.
> +	 */
> +	GpioHwReg_SetDirOutput(regp, gpioNum);
> +	GpioHwReg_SetVal(regp, gpioNum, setVal);
> +	REG_LOCAL_IRQ_RESTORE;
> +}
> +
> +static inline int GpioHwReg_GetVal(volatile GPIOHW_REG_t *regp,
> +				   unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +	return (regp->gpioData & gpioMask) ? 1 : 0;
> +}
> +
> +static inline void GpioHwReg_IrqEnable(volatile GPIOHW_REG_t *regp,
> +				       unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> +	/* Set register bit to unmask interrupt */
> +	reg32_modify_or(&regp->gpioIe, gpioMask);
> +}
> +
> +static inline void GpioHwReg_IrqDisable(volatile GPIOHW_REG_t *regp,
> +					unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> +	/* Clear register bit to mask interrupt */
> +	reg32_modify_and(&regp->gpioIe, ~gpioMask);
> +}
> +
> +static inline GPIOHW_IRQ_MASK_STATE GpioHwReg_IsIrqEnabled(volatile GPIOHW_REG_t
> +							   *regp,
> +							   unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +	return (regp->
> +		gpioIe & gpioMask) ? GPIOHW_IRQ_MASKED_INTERRUPT :
> +	    GPIOHW_IRQ_UNMASKED_INTERRUPT;
> +}
> +
> +static inline void GpioHwReg_IrqClear(volatile GPIOHW_REG_t *regp,
> +				      unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +
> +	/* Raise register bit to clear interrupt status */
> +	regp->gpioIc |= gpioMask;
> +}
> +
> +static inline void GpioHwReg_IrqClearReg(volatile GPIOHW_REG_t *regp,
> +					 uint32_t mask)
> +{
> +	/* Raise register bit to clear interrupt status */
> +	regp->gpioIc |= mask;
> +}
> +
> +static inline int GpioHwReg_GetRawIrqStatus(volatile GPIOHW_REG_t *regp,
> +					    unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +	return (regp->gpioRis & gpioMask) ? 1 : 0;
> +}
> +
> +static inline int GpioHwReg_GetMaskIrqStatus(volatile GPIOHW_REG_t *regp,
> +					     unsigned int gpioNum)
> +{
> +	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
> +	return (regp->gpioMis & gpioMask) ? 1 : 0;
> +}
> +
> +static inline uint32_t GpioHwReg_GetRawIrqRegStatus(volatile GPIOHW_REG_t *
> +						    regp)
> +{
> +	return regp->gpioRis;
> +}
> +
> +static inline uint32_t GpioHwReg_GetMaskIrqRegStatus(volatile GPIOHW_REG_t *
> +						     regp)
> +{
> +	return regp->gpioMis;
> +}
> +
> +/****************************************************************************/
> +/**
> +*     Note: The following are inline functions to help decipher the block to
> +*     perform the operation requested upon based on the gpio pin or block
> +*     passed in the parameters.
> +*/
> +/****************************************************************************/
> +
> +/* Helper function to return register pointer and modified gpio number */
> +static inline unsigned int GpioHw_GetGpioNumAndRegp(unsigned int gpioNum,
> +						    volatile GPIOHW_REG_t **regpp)
> +{
> +	unsigned int num = gpioNum;
> +
> +	if (num < GPIOHW_NUM_PINS_LOWER_BLOCK) {
> +		*regpp = gpioRegP(GPIOHW_BLOCK_LOW);
> +	} else {
> +		*regpp = gpioRegP(GPIOHW_BLOCK_HIGH);
> +		num &= GPIOHW_BLOCK_PINS_MASK;
> +	}
> +	return num;
> +}

Why not wrap the gpiolib chip in a structure that tells you this info?


> +static inline GPIOHW_DIRECTION GpioHw_GetDir(unsigned int gpioNum)
> +{

Yeurk, this file's style stinks.

> +typedef struct {
> +	uint32_t gpioData;
> +	uint32_t gpioDummy[255];
> +	uint32_t gpioDir;
> +	uint32_t gpioIs;
> +	uint32_t gpioIbe;
> +	uint32_t gpioIev;
> +	uint32_t gpioIe;
> +	uint32_t gpioRis;
> +	uint32_t gpioMis;
> +	uint32_t gpioIc;
> +	uint32_t gpioAfSel;
> +
> +} GPIOHW_REG_t;

Argh, my eyes, they bleed.

Do not typedef structures
Do not use structures to access hardware registers.

> +*  @brief   GpioHwReg_SetValReg
> +*
> +*  This function is used to set the value for the GPIO pins specified
> +*
> +*  @return
> +*     None
> +*/
> +/****************************************************************************/

Not even kerneldoc style

Half this code probably shouldn't even be in the header files in the
first place, it seems specific to either the irq or the gpiolib code.

The gpiomux stuff looks ok, pitty there's not really a good way of dealing
with this stuff in the kernel generically.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
