From: leochen@broadcom.com (Leo Chen)
Date: Fri, 9 Oct 2009 10:23:09 -0700
Subject: [PATCH] bcmring: add gpio support
Message-ID: <mailman.66.1255122804.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpio headers in include/mach/csp directory.

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 .../mach-bcmring/include/mach/csp/gpioHw_inline.h  |  345 ++++++++++++++++++
 .../arm/mach-bcmring/include/mach/csp/gpioHw_reg.h |  381 ++++++++++++++++++++
 arch/arm/mach-bcmring/include/mach/csp/gpiomux.h   |  221 ++++++++++++
 3 files changed, 947 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpioHw_reg.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/csp/gpiomux.h

diff --git a/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
new file mode 100644
index 0000000..e400ee3
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_inline.h
@@ -0,0 +1,345 @@
+/*****************************************************************************
+* Copyright 2003 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+#ifndef GPIOHW_INLINE_H
+#define GPIOHW_INLINE_H
+
+#ifndef GPIOHW_H
+#error *** Do not include gpioHw_inline.h directly. Use gpioHw.h instead. ***
+#endif
+
+/* ---- Include Files ---------------------------------------------------- */
+#include <mach/csp/mm_io.h>
+#include <mach/csp/gpioHw_reg.h>
+#include <csp/reg.h>
+
+/* ---- Public Constants and Types --------------------------------------- */
+/* ---- Public Variable Externs ------------------------------------------ */
+/* ---- Public Function Prototypes --------------------------------------- */
+
+static inline void GpioHwReg_SetDirOutput(volatile GPIOHW_REG_t *regp,
+					  unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Set bit to set to output direction */
+	reg32_modify_or(&regp->gpioDir, gpioMask);
+}
+
+static inline void GpioHwReg_SetDirInput(volatile GPIOHW_REG_t *regp,
+					 unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Clear bit to set to input direction */
+	reg32_modify_and(&regp->gpioDir, ~gpioMask);
+}
+
+static inline GPIOHW_DIRECTION GpioHwReg_GetDir(volatile GPIOHW_REG_t *regp,
+						unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Check register against mask and return if set to input or output */
+	return (regp->
+		gpioDir & gpioMask) ? GPIOHW_DIR_OUTPUT : GPIOHW_DIR_INPUT;
+}
+
+static inline void GpioHwReg_SetVal(volatile GPIOHW_REG_t *regp,
+				    unsigned int gpioNum, int setVal)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	if (setVal) {
+		/* Set data bit */
+		reg32_modify_or(&regp->gpioData, gpioMask);
+	} else {
+		/* Clear data bit */
+		reg32_modify_and(&regp->gpioData, ~gpioMask);
+	}
+}
+
+static inline void GpioHwReg_SetValDirOutput(volatile GPIOHW_REG_t *regp,
+					     unsigned int gpioNum, int setVal)
+{
+	REG_LOCAL_IRQ_SAVE;
+	/*
+	 * The hardware ignores sets to the data register when the pin is configured as an
+	 * input, so we need to set the direction before setting the value.
+	 */
+	GpioHwReg_SetDirOutput(regp, gpioNum);
+	GpioHwReg_SetVal(regp, gpioNum, setVal);
+	REG_LOCAL_IRQ_RESTORE;
+}
+
+static inline int GpioHwReg_GetVal(volatile GPIOHW_REG_t *regp,
+				   unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+	return (regp->gpioData & gpioMask) ? 1 : 0;
+}
+
+static inline void GpioHwReg_IrqEnable(volatile GPIOHW_REG_t *regp,
+				       unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Set register bit to unmask interrupt */
+	reg32_modify_or(&regp->gpioIe, gpioMask);
+}
+
+static inline void GpioHwReg_IrqDisable(volatile GPIOHW_REG_t *regp,
+					unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Clear register bit to mask interrupt */
+	reg32_modify_and(&regp->gpioIe, ~gpioMask);
+}
+
+static inline GPIOHW_IRQ_MASK_STATE GpioHwReg_IsIrqEnabled(volatile GPIOHW_REG_t
+							   *regp,
+							   unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+	return (regp->
+		gpioIe & gpioMask) ? GPIOHW_IRQ_MASKED_INTERRUPT :
+	    GPIOHW_IRQ_UNMASKED_INTERRUPT;
+}
+
+static inline void GpioHwReg_IrqClear(volatile GPIOHW_REG_t *regp,
+				      unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+
+	/* Raise register bit to clear interrupt status */
+	regp->gpioIc |= gpioMask;
+}
+
+static inline void GpioHwReg_IrqClearReg(volatile GPIOHW_REG_t *regp,
+					 uint32_t mask)
+{
+	/* Raise register bit to clear interrupt status */
+	regp->gpioIc |= mask;
+}
+
+static inline int GpioHwReg_GetRawIrqStatus(volatile GPIOHW_REG_t *regp,
+					    unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+	return (regp->gpioRis & gpioMask) ? 1 : 0;
+}
+
+static inline int GpioHwReg_GetMaskIrqStatus(volatile GPIOHW_REG_t *regp,
+					     unsigned int gpioNum)
+{
+	uint32_t gpioMask = GPIOHW_MASK_GENERATE(gpioNum);
+	return (regp->gpioMis & gpioMask) ? 1 : 0;
+}
+
+static inline uint32_t GpioHwReg_GetRawIrqRegStatus(volatile GPIOHW_REG_t *
+						    regp)
+{
+	return regp->gpioRis;
+}
+
+static inline uint32_t GpioHwReg_GetMaskIrqRegStatus(volatile GPIOHW_REG_t *
+						     regp)
+{
+	return regp->gpioMis;
+}
+
+/****************************************************************************/
+/**
+*     Note: The following are inline functions to help decipher the block to
+*     perform the operation requested upon based on the gpio pin or block
+*     passed in the parameters.
+*/
+/****************************************************************************/
+
+/* Helper function to return register pointer and modified gpio number */
+static inline unsigned int GpioHw_GetGpioNumAndRegp(unsigned int gpioNum,
+						    volatile GPIOHW_REG_t **regpp)
+{
+	unsigned int num = gpioNum;
+
+	if (num < GPIOHW_NUM_PINS_LOWER_BLOCK) {
+		*regpp = gpioRegP(GPIOHW_BLOCK_LOW);
+	} else {
+		*regpp = gpioRegP(GPIOHW_BLOCK_HIGH);
+		num &= GPIOHW_BLOCK_PINS_MASK;
+	}
+	return num;
+}
+
+static inline void GpioHw_SetDirOutput(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_SetDirOutput(regp, num);
+}
+
+static inline void GpioHw_SetDirInput(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_SetDirInput(regp, num);
+}
+
+static inline void GpioHw_SetDirReg(GPIOHW_BLOCK_LEVEL blockLevel,
+				    uint32_t dirRegVal)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	GpioHwReg_SetDirReg(regp, dirRegVal);
+}
+
+static inline GPIOHW_DIRECTION GpioHw_GetDir(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetDir(regp, num);
+}
+
+static inline uint32_t GpioHw_GetDirReg(GPIOHW_BLOCK_LEVEL blockLevel)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	return GpioHwReg_GetDirReg(regp);
+}
+
+static inline void GpioHw_SetVal(unsigned int gpioNum, int setVal)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_SetVal(regp, num, setVal);
+}
+
+static inline void GpioHw_SetValDirOutput(unsigned int gpioNum, int setVal)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_SetValDirOutput(regp, num, setVal);
+}
+
+static inline void GpioHw_SetValReg(uint32_t gpioMask, uint32_t maskVal,
+				    GPIOHW_BLOCK_LEVEL blockLevel)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	GpioHwReg_SetValReg(regp, gpioMask, maskVal);
+}
+
+static inline int GpioHw_GetVal(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetVal(regp, num);
+}
+
+static inline uint32_t GpioHw_GetValReg(GPIOHW_BLOCK_LEVEL blockLevel)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	return GpioHwReg_GetValReg(regp);
+}
+
+static inline void GpioHw_IrqEnable(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_IrqEnable(regp, num);
+}
+
+static inline void GpioHw_IrqDisable(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_IrqDisable(regp, num);
+}
+
+static inline GPIOHW_IRQ_MASK_STATE GpioHw_IsIrqEnabled(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_IsIrqEnabled(regp, num);
+}
+
+static inline void GpioHw_IrqClear(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_IrqClear(regp, num);
+}
+
+static inline void GpioHw_IrqClearReg(GPIOHW_BLOCK_LEVEL blockLevel,
+				      uint32_t mask)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	GpioHwReg_IrqClear(regp, mask);
+}
+
+static inline int GpioHw_GetRawIrqStatus(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetRawIrqStatus(regp, num);
+}
+
+static inline int GpioHw_GetMaskIrqStatus(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetMaskIrqStatus(regp, num);
+}
+
+static inline uint32_t GpioHw_GetRawIrqRegStatus(GPIOHW_BLOCK_LEVEL blockLevel)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	return GpioHwReg_GetRawIrqRegStatus(regp);
+}
+
+static inline uint32_t GpioHw_GetMaskIrqRegStatus(GPIOHW_BLOCK_LEVEL blockLevel)
+{
+	volatile GPIOHW_REG_t *regp = gpioRegP(blockLevel);
+	return GpioHwReg_GetMaskIrqRegStatus(regp);
+}
+
+static inline void GpioHw_SetModeCtrl(unsigned int gpioNum,
+				      GPIOHW_MODE_CONTROL_SELECT mode)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_SetModeCtrl(regp, num, mode);
+}
+
+static inline GPIOHW_MODE_CONTROL_SELECT GpioHw_GetModeCtrl(unsigned int
+							    gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetModeCtrl(regp, num);
+}
+
+static inline void GpioHw_SetIrqType(unsigned int gpioNum,
+				     GPIOHW_INTERRUPT_TYPE irqType)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	GpioHwReg_SetIrqType(regp, num, irqType);
+}
+
+static inline GPIOHW_INTERRUPT_TYPE GpioHw_GetIrqType(unsigned int gpioNum)
+{
+	volatile GPIOHW_REG_t *regp;
+	unsigned int num = GpioHw_GetGpioNumAndRegp(gpioNum, &regp);
+	return GpioHwReg_GetIrqType(regp, num);
+}
+#endif /* GPIOHW_INLINE_H */
diff --git a/arch/arm/mach-bcmring/include/mach/csp/gpioHw_reg.h b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_reg.h
new file mode 100644
index 0000000..9d43914
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/csp/gpioHw_reg.h
@@ -0,0 +1,381 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/****************************************************************************/
+/**
+*  @file    gpio_reg.h
+*
+*  @brief   GPIO register definitions
+*
+*/
+/****************************************************************************/
+
+#ifndef GPIOHW_REG_H
+#define GPIOHW_REG_H
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <csp/stdint.h>
+#include <mach/csp/mm_io.h>
+/* ---- Public Constants and Types ---------------------------------------- */
+
+#define  GPIOHW_BLOCK_CNT              2
+#define  GPIOHW_NUM_PINS_LOWER_BLOCK   32
+#define  GPIOHW_NUM_PINS_HIGHER_BLOCK  29
+#define  GPIOHW_TOTAL_NUM_PINS         61
+
+#define  GPIOHW_BLOCK_PINS_MASK        0x1F	/* Masks out number of pins per block */
+#define  GPIOHW_MASK_GENERATE(num)     (1 << num)
+
+typedef struct {
+	uint32_t gpioData;
+	uint32_t gpioDummy[255];
+	uint32_t gpioDir;
+	uint32_t gpioIs;
+	uint32_t gpioIbe;
+	uint32_t gpioIev;
+	uint32_t gpioIe;
+	uint32_t gpioRis;
+	uint32_t gpioMis;
+	uint32_t gpioIc;
+	uint32_t gpioAfSel;
+
+} GPIOHW_REG_t;
+
+#define  gpioRegP(x) (x ? ((volatile GPIOHW_REG_t *)MM_IO_BASE_GPIO1) : ((volatile GPIOHW_REG_t *)MM_IO_BASE_GPIO0))
+
+/* ---- Public Variables -------------------------------------------------- */
+/* ---- Public Function Prototypes ---------------------------------------- */
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetDirOutput
+*
+*  Used to set the specified GPIO pin to the output mode/direction.
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_SetDirOutput(volatile GPIOHW_REG_t *regp,	/* [IN] Pointer to register block */
+					  unsigned int gpioNum	/* [IN] GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetDirInput
+*
+*  This function is used to set the specified GPIO pin to the input direction.
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_SetDirInput(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					 unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetDirReg
+*
+*  This function is used to set the
+*  GPIO pins to the register value specified
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+void GpioHwReg_SetDirReg(volatile GPIOHW_REG_t *regp,	/* [IN] Pointer to register block */
+			 uint32_t dirRegVal	/* [IN] Value of 32-bit register */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetDir
+*
+*  This function is used to get the direction of the GPIO pin specified
+*
+*  @return
+*     The direction of the GPIO pin of type GPIOHW_DIRECTION
+*/
+/****************************************************************************/
+static inline GPIOHW_DIRECTION GpioHwReg_GetDir(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+						unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetDirReg
+*
+*  This function is used to set the GPIO pins to the register value specified
+*
+*  @return
+*     The register containing bitmapped values of the direction for the GPIO pin block
+*/
+/****************************************************************************/
+uint32_t GpioHwReg_GetDirReg(volatile GPIOHW_REG_t *regp	/* [IN]   Pointer to register block */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHw_SetVal
+*
+*  This function is used to set the value of a specified GPIO pin
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_SetVal(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+				    unsigned int gpioNum,	/* [IN]   GPIO pin number selected */
+				    int setVal	/* [IN]   Value of pin to set */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetValDirOutput
+*
+*  This function is used to set the value of a specified GPIO pin and to set
+*  it to be an output, atomically.
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_SetValDirOutput(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					     unsigned int gpioNum,	/* [IN]   GPIO pin number selected */
+					     int setVal	/* [IN]   Value of pin to set */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetValReg
+*
+*  This function is used to set the value for the GPIO pins specified
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+void GpioHwReg_SetValReg(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+			 uint32_t gpioMask,	/* [IN]   GPIO mask of pins to set */
+			 uint32_t maskVal	/* [IN]   Value of the register.  Will only set masked pins */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetVal
+*
+*  This function is used to get the value
+*  of a specified GPIO pin
+*
+*  @return
+*     1 if the pin is set high, 0 if low
+*/
+/****************************************************************************/
+static inline int GpioHwReg_GetVal(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+				   unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetValReg
+*
+*  This function is used to set the value
+*  of a specified GPIO pin
+*
+*  @return
+*     Register of bits indicating current value of all pins for the block specified
+*/
+/****************************************************************************/
+uint32_t GpioHwReg_GetValReg(volatile GPIOHW_REG_t *regp	/* [IN]   Pointer to register block */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_IrqEnable
+*
+*  This function is used to enable the interrupt of the
+*  specified GPIO pin
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_IrqEnable(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+				       unsigned int gpioNum	/* [IN] Number of the GPIO pin to enable interrupt */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_IrqDisable
+*
+*  This function is used to disable the interrupt of the
+*  specified GPIO pin
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_IrqDisable(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					unsigned int gpioNum	/* [IN] Number of the GPIO pin to disable interrupt */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_IsIrqEnabled
+*
+*  This function is used to query if IRQ is enabled or not for the
+*  specified GPIO pin
+*
+*  @return
+*     Returns the status of the IRQ of type GPIOHW_IRQ_MASK_STATE
+*/
+/****************************************************************************/
+static inline GPIOHW_IRQ_MASK_STATE GpioHwReg_IsIrqEnabled(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+							   unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_IrqClear
+*
+*  This function is used to clear the IRQ of the GPIO pin specified
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+static inline void GpioHwReg_IrqClear(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+				      unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetRawIrqStatus
+*
+*  This function is used to retrieve the raw IRQ status (ignores masked status)
+*
+*  @return
+*     Return 1 if interrupt triggered, else 0
+*/
+/****************************************************************************/
+static inline int GpioHwReg_GetRawIrqStatus(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					    unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetMaskIrqStatus
+*
+*  This function is used to retrieve the masked IRQ status
+*
+*  @return
+*     Return 1 if interrupt triggered, else 0 if not triggered or not enabled
+*/
+/****************************************************************************/
+static inline int GpioHwReg_GetMaskIrqStatus(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					     unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetRawIrqRegStatus
+*
+*  This function is used to retrieve the block of GPIO pin IRQ raw status
+*
+*  @return
+*     Return register set of GPIO pin status. Raised bit indicates interrupt triggered
+*/
+/****************************************************************************/
+static inline uint32_t GpioHwReg_GetRawIrqRegStatus(volatile GPIOHW_REG_t *regp	/* [IN]   Pointer to register block */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetMaskIrqRegStatus
+*
+*  This function is used to retrieve the block of GPIO pin IRQ masked status
+*
+*  @return
+*     Return register set of GPIO pin status. Raised bit indicates
+*     interrupt triggered
+*/
+/****************************************************************************/
+static inline uint32_t GpioHwReg_GetMaskIrqRegStatus(volatile GPIOHW_REG_t *regp	/* [IN]   Pointer to register block */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetModeCtrl
+*
+*  This function is used to set the control mode of the GPIO pin
+*
+*  @return
+*     None
+*/
+/****************************************************************************/
+void GpioHwReg_SetModeCtrl(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+			   unsigned int gpioNum,	/* [IN]   GPIO pin number selected */
+			   GPIOHW_MODE_CONTROL_SELECT mode	/* [IN]   mode select for HW or SW */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetModeCtrl
+*
+*  This function is used to get the control mode of the GPIO pin
+*
+*  @return
+*     Current mode selected for pin of type GPIOHW_MODE_CONTROL_SELECT
+*/
+/****************************************************************************/
+GPIOHW_MODE_CONTROL_SELECT GpioHwReg_GetModeCtrl(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+						 unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_SetIrqType
+*
+*  Sets the IRQ trigger mode (falling edge, rising edge, level).  Deciphers
+*  which block to select based on gpio pin selected.  IRQ should be disabled
+*  before selecting to avoid spurrious interrupts
+*
+*  @return
+*   None
+*/
+/****************************************************************************/
+void GpioHwReg_SetIrqType(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+			  unsigned int gpioNum,	/* [IN]   GPIO pin number selected */
+			  GPIOHW_INTERRUPT_TYPE irqType	/* [IN]   Type of IRQ trigger */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   GpioHwReg_GetIrqType
+*
+*  Retrieves the IRQ trigger mode.  Deciphers which block to select based on
+*  gpio pin selected
+*
+*  @return
+*   Interrupt trigger mode of type GPIOHW_INTERRUPT_TYPE
+*
+*/
+/****************************************************************************/
+GPIOHW_INTERRUPT_TYPE GpioHwReg_GetIrqType(volatile GPIOHW_REG_t *regp,	/* [IN]   Pointer to register block */
+					   unsigned int gpioNum	/* [IN]   GPIO pin number selected */
+    );
+
+#endif /* GPIOHW_REG_H */
diff --git a/arch/arm/mach-bcmring/include/mach/csp/gpiomux.h b/arch/arm/mach-bcmring/include/mach/csp/gpiomux.h
new file mode 100644
index 0000000..8eb77ff
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/csp/gpiomux.h
@@ -0,0 +1,221 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/****************************************************************************/
+/**
+*  @file    gpiomux.h
+*
+*  @brief   GPIOMUX utility
+*
+*/
+/****************************************************************************/
+
+#ifndef GPIOMUX_H
+#define GPIOMUX_H
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <csp/stdint.h>
+#include <mach/csp/mm_io.h>
+#include <mach/csp/chipcHw_inline.h>
+#include <mach/gpio_defs.h>
+
+/* ---- Public Constants and Types ---------------------------------------- */
+#ifndef ARRAY_LEN
+#define ARRAY_LEN(x) (sizeof(x)/sizeof(x[0]))
+#endif
+
+/* This is a table of group identifiers. Each group is a logical
+ * entity that contains related gpio functions. */
+typedef enum {
+	gpiomux_group_gphyled = 0,	/* gphyled data/clk */
+	gpiomux_group_ext_gphy,	/* mdc_extgphy/mdio_extgphy */
+	gpiomux_group_etm16,	/* etm 16-bit bus */
+	gpiomux_group_etm32,	/* etm 32-bit bus */
+	gpiomux_group_vpm_jtag,	/* vpm tdi/tdo/tms/tck (rtck done as needed) */
+	gpiomux_group_pcm0,	/* pcm0 clk/fs/di/do */
+	gpiomux_group_pcm1,	/* pcm1 clk/fs/di/do */
+	gpiomux_group_mtx_scan,	/* mtx serial (parallel done individually) */
+	gpiomux_group_uart0_mdm,	/* uart0 dtr/dcd/ri/dsr */
+	gpiomux_group_uart0_fc,	/* uart0 cts/rts */
+	gpiomux_group_uart1,	/* uart1 txd/rxd */
+	gpiomux_group_uart1_fc,	/* uart1 cts/rts */
+	gpiomux_group_i2ch,	/* i2c host - sda/scl */
+	gpiomux_group_i2ch_v2,	/* i2c host V2 - sda/scl */
+	gpiomux_group_usb0_pwronflt,	/* usb0 pwron/pwrflt */
+	gpiomux_group_usb1_pwronflt,	/* usb1 pwron/pwrflt */
+	gpiomux_group_spi,	/* spi master - miso/mosi/clk only (ssn done as needed) */
+	gpiomux_group_spis,	/* spi slave - miso/mosi/clk only (ssn done as needed) */
+	gpiomux_group_i2cs,	/* i2c slave - ssda/sscl */
+	gpiomux_group_sdio0_1,	/* sdio0 cmd/clk, D0 */
+	gpiomux_group_sdio0_4,	/* sdio0 cmd/clk, D0-D3 */
+	gpiomux_group_sdio0_8,	/* sdio0 cmd/clk, D0-D7 */
+	gpiomux_group_sdio1_1,	/* sdio1 cmd/clk, D0 */
+	gpiomux_group_sdio1_4,	/* sdio1 cmd/clk, D0-D3 */
+	gpiomux_group_i2s0,	/* i2s0 sdo/sdi/bclk/lrcout/mclk/lrcin */
+	gpiomux_group_i2s1,	/* i2s1 sdo/sdi/bclk/lrcout/mclk/lrcin */
+	gpiomux_group_MaxNum
+} gpiomux_group_e;
+
+/* A group is a logical collection of pins. They all
+ * are set to the same chipc gpio function. */
+typedef struct {
+	const gpiomux_group_e group;	/* group identifier */
+	const chipcHw_GPIO_FUNCTION_e function;	/* chipc gpio function for this group */
+	const uint8_t numPins;	/* Number of pins for this group */
+	const gpio_defs_e *listp;	/* An array of pins for this group */
+} gpiomux_group_t;
+
+/* Function return codes */
+typedef enum {
+	gpiomux_rc_SUCCESS = 0,
+	gpiomux_rc_UNINITIALIZED,	/* Calling functions before initialization */
+	gpiomux_rc_ASSIGNED,	/* Pin already assigned, cannot request */
+	gpiomux_rc_UNASSIGNED,	/* Pin unassigned, cannot free */
+	gpiomux_rc_CONFLICT,	/* Conflict in external request/free */
+	gpiomux_rc_BADPIN,	/* Bad pin enum parameter */
+	gpiomux_rc_BADGROUP	/* Bad group enum parameter */
+} gpiomux_rc_e;
+
+/* Initialization structure */
+typedef struct {
+	/* If not NULL, this function is called to find out of a gpio pin has already
+	 * been requested. In linux this would presumably call the gpiolib is_requested
+	 * function to find out if a gpio_request() had been called. If the pin has
+	 * not been requested, then the gpiomux request calls should also fail.
+	 * Returns the original label if the function was already requested, else NULL. */
+	const char *(*is_requested) (gpio_defs_e pin);
+
+	/* If not NULL, this function is called to request a gpio pin. In linux this
+	 * would presumably call the gpiolib request_gpio function to allocate the
+	 * pin. This keeps gpiomux and gpiolib in sync, and only gpiomux calls are
+	 * required to both allocate and setup the mux.
+	 * Returns 0 on success, < 0 on failure (busy or invalid pin) */
+	int (*request_gpio) (gpio_defs_e pin, const char *label);
+
+	/* If not NULL, this function is called to free a gpio pin. In linux this
+	 * would presumably call the gpiolib free_gpio function to free the pin. */
+	void (*free_gpio) (gpio_defs_e pin);
+} gpiomux_init_t;
+
+/* ---- Public Variables -------------------------------------------------- */
+extern const gpiomux_group_t gpiomux_GroupList[];
+
+/* ---- Public Function Prototypes ---------------------------------------- */
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_Init
+*
+*  Used to initialize the mux table and set all pin functions to GPIO.
+*
+*  @return
+*     none
+*/
+/****************************************************************************/
+void gpiomux_Init(gpiomux_init_t *initp	/* [IN] initialization structure pointer */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_request
+*
+*  Used to register a chip function with the gpiomux
+*
+*  @return
+*     success or conflict return code
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_request(gpio_defs_e pin,	/* [IN] GPIO pin */
+			     chipcHw_GPIO_FUNCTION_e function,	/* [IN] GPIO pin function */
+			     const char *label	/* [IN] description of pin usage */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_free
+*
+*  Used to deregister a pin assignment
+*
+*  @return
+*     success - assigned function was unregistered
+*     notfound - there was not registered function for this pin
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_free(gpio_defs_e pin	/* [IN] GPIO pin */
+    );
+/****************************************************************************/
+/**
+*  @brief   gpiomux_requestGroup
+*
+*  Used to register a group of pin functions with the gpiomux
+*
+*  @return
+*     success or conflict return code
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_requestGroup(const gpiomux_group_e group,	/* [IN] GPIO group */
+				  const char *label	/* [IN] description of group usage */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_freeGroup
+*
+*  Used to deregister a group of pin assignments
+*
+*  @return
+*     success - assigned group was unregistered
+*     notfound - there was not registered group for this pin
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_freeGroup(gpiomux_group_e group	/* [IN] GPIO group */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_requestKeypad
+*
+*  Used to register a logical set of pin functions with the gpiomux. If the
+*  keypad pins are not sequential, then use the individual setPin functions.
+*  Example: gpiomux_requestKeypad(0,5,0,4);
+*
+*  @return
+*     success or conflict return code
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_requestKeypad(uint8_t in_first,	/* [IN] keypad_in[in_first] is start of array */
+				   uint8_t in_last,	/* [IN] keypad_in[in_last] is end of array */
+				   uint8_t out_first,	/* [IN] keypad_out[out_first] is start of array */
+				   uint8_t out_last,	/* [IN] keypad_out[out_last] is end of array */
+				   const char *label	/* [IN] description of group usage */
+    );
+
+/****************************************************************************/
+/**
+*  @brief   gpiomux_freeKeypad
+*
+*  Used to deregister a logical set of keypad pin functions
+*
+*  @return
+*     success - assigned function was unregistered
+*     notfound - one or more pins were not registered for the keypad
+*/
+/****************************************************************************/
+gpiomux_rc_e gpiomux_freeKeypad(uint8_t in_first,	/* [IN] keypad_in[in_first] is start of array */
+				uint8_t in_last,	/* [IN] keypad_in[in_last] is end of array */
+				uint8_t out_first,	/* [IN] keypad_out[out_first] is start of array */
+				uint8_t out_last	/* [IN] keypad_out[out_last] is end of array */
+    );
+
+#endif /* GPIOMUX_H */
-- 
1.6.0.6

Leo Chen
