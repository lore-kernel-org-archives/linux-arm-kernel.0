From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 21 Apr 2011 09:53:49 -0700
Subject: arm: msm: Convert irq-vic to generic irq chip
In-Reply-To: <20110416211308.455390167@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211308.455390167@linutronix.de>
Message-ID: <4DB0611D.6040902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> This removes a ton of completely useless code. The shadow registers,
> which are set but never used are maintained in the generic chip
> functions on a per chip basis as well.
>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/arm/mach-msm/irq-vic.c |  342 ++++++--------------------------------------
>   1 file changed, 51 insertions(+), 291 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-msm/irq-vic.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-msm/irq-vic.c
> +++ linux-2.6/arch/arm/mach-msm/irq-vic.c
> @@ -12,331 +12,93 @@
>    * GNU General Public License for more details.
>    *
>    */
> -
> -#include<linux/init.h>
> -#include<linux/module.h>
> -#include<linux/sched.h>
>   #include<linux/interrupt.h>
> -#include<linux/ptrace.h>
> -#include<linux/timer.h>
>   #include<linux/irq.h>
>   #include<linux/io.h>
>
> -#include<asm/cacheflush.h>
> -
>   #include<mach/hardware.h>
> -
>   #include<mach/msm_iomap.h>
>
> -#include "smd_private.h"
> -
> -enum {
> -	IRQ_DEBUG_SLEEP_INT_TRIGGER = 1U<<  0,
> -	IRQ_DEBUG_SLEEP_INT = 1U<<  1,
> -	IRQ_DEBUG_SLEEP_ABORT = 1U<<  2,
> -	IRQ_DEBUG_SLEEP = 1U<<  3,
> -	IRQ_DEBUG_SLEEP_REQUEST = 1U<<  4,
> -};
> -static int msm_irq_debug_mask;
> -module_param_named(debug_mask, msm_irq_debug_mask, int,
> -		   S_IRUGO | S_IWUSR | S_IWGRP);
> -
>   #define VIC_REG(off) (MSM_VIC_BASE + (off))
> -#define VIC_INT_TO_REG_ADDR(base, irq) (base + (irq / 32) * 4)
> -#define VIC_INT_TO_REG_INDEX(irq) ((irq>>  5)&  3)
>
> -#define VIC_INT_SELECT0     VIC_REG(0x0000)  /* 1: FIQ, 0: IRQ */
> -#define VIC_INT_SELECT1     VIC_REG(0x0004)  /* 1: FIQ, 0: IRQ */
> -#define VIC_INT_SELECT2     VIC_REG(0x0008)  /* 1: FIQ, 0: IRQ */
> -#define VIC_INT_SELECT3     VIC_REG(0x000C)  /* 1: FIQ, 0: IRQ */
> -#define VIC_INT_EN0         VIC_REG(0x0010)
> -#define VIC_INT_EN1         VIC_REG(0x0014)
> -#define VIC_INT_EN2         VIC_REG(0x0018)
> -#define VIC_INT_EN3         VIC_REG(0x001C)
> -#define VIC_INT_ENCLEAR0    VIC_REG(0x0020)
> -#define VIC_INT_ENCLEAR1    VIC_REG(0x0024)
> -#define VIC_INT_ENCLEAR2    VIC_REG(0x0028)
> -#define VIC_INT_ENCLEAR3    VIC_REG(0x002C)
> -#define VIC_INT_ENSET0      VIC_REG(0x0030)
> -#define VIC_INT_ENSET1      VIC_REG(0x0034)
> -#define VIC_INT_ENSET2      VIC_REG(0x0038)
> -#define VIC_INT_ENSET3      VIC_REG(0x003C)
> -#define VIC_INT_TYPE0       VIC_REG(0x0040)  /* 1: EDGE, 0: LEVEL  */
> -#define VIC_INT_TYPE1       VIC_REG(0x0044)  /* 1: EDGE, 0: LEVEL  */
> -#define VIC_INT_TYPE2       VIC_REG(0x0048)  /* 1: EDGE, 0: LEVEL  */
> -#define VIC_INT_TYPE3       VIC_REG(0x004C)  /* 1: EDGE, 0: LEVEL  */
> -#define VIC_INT_POLARITY0   VIC_REG(0x0050)  /* 1: NEG, 0: POS */
> -#define VIC_INT_POLARITY1   VIC_REG(0x0054)  /* 1: NEG, 0: POS */
> -#define VIC_INT_POLARITY2   VIC_REG(0x0058)  /* 1: NEG, 0: POS */
> -#define VIC_INT_POLARITY3   VIC_REG(0x005C)  /* 1: NEG, 0: POS */
> -#define VIC_NO_PEND_VAL     VIC_REG(0x0060)
> +#define VIC_INT_SELECT0		0x0000		/* 1: FIQ, 0: IRQ */
> +#define VIC_INT_EN0		0x0010
> +#define VIC_INT_ENCLEAR0	0x0020
> +#define VIC_INT_ENSET0		0x0030
> +#define VIC_INT_TYPE0		0x0040		/* 1: EDGE, 0: LEVEL  */
> +#define VIC_INT_POLARITY0	0x0050		/* 1: NEG, 0: POS */
> +#define VIC_INT_CLEAR0		0x00B0
>
>   #if defined(CONFIG_ARCH_MSM_SCORPION)
> -#define VIC_NO_PEND_VAL_FIQ VIC_REG(0x0064)
> -#define VIC_INT_MASTEREN    VIC_REG(0x0068)  /* 1: IRQ, 2: FIQ     */
> -#define VIC_CONFIG          VIC_REG(0x006C)  /* 1: USE SC VIC */
> +#define VIC_INT_MASTEREN	0x0068		/* 1: IRQ, 2: FIQ     */
> +#define VIC_CONFIG		0x006C		/* 1: USE ARM1136 VIC */
>   #else
> -#define VIC_INT_MASTEREN    VIC_REG(0x0064)  /* 1: IRQ, 2: FIQ     */
> -#define VIC_PROTECTION      VIC_REG(0x006C)  /* 1: ENABLE          */
> -#define VIC_CONFIG          VIC_REG(0x0068)  /* 1: USE ARM1136 VIC */
> +#define VIC_INT_MASTEREN	0x0064		/* 1: IRQ, 2: FIQ     */
> +#define VIC_CONFIG		0x0068		/* 1: USE ARM1136 VIC */
>   #endif
>
> -#define VIC_IRQ_STATUS0     VIC_REG(0x0080)
> -#define VIC_IRQ_STATUS1     VIC_REG(0x0084)
> -#define VIC_IRQ_STATUS2     VIC_REG(0x0088)
> -#define VIC_IRQ_STATUS3     VIC_REG(0x008C)
> -#define VIC_FIQ_STATUS0     VIC_REG(0x0090)
> -#define VIC_FIQ_STATUS1     VIC_REG(0x0094)
> -#define VIC_FIQ_STATUS2     VIC_REG(0x0098)
> -#define VIC_FIQ_STATUS3     VIC_REG(0x009C)
> -#define VIC_RAW_STATUS0     VIC_REG(0x00A0)
> -#define VIC_RAW_STATUS1     VIC_REG(0x00A4)
> -#define VIC_RAW_STATUS2     VIC_REG(0x00A8)
> -#define VIC_RAW_STATUS3     VIC_REG(0x00AC)
> -#define VIC_INT_CLEAR0      VIC_REG(0x00B0)
> -#define VIC_INT_CLEAR1      VIC_REG(0x00B4)
> -#define VIC_INT_CLEAR2      VIC_REG(0x00B8)
> -#define VIC_INT_CLEAR3      VIC_REG(0x00BC)
> -#define VIC_SOFTINT0        VIC_REG(0x00C0)
> -#define VIC_SOFTINT1        VIC_REG(0x00C4)
> -#define VIC_SOFTINT2        VIC_REG(0x00C8)
> -#define VIC_SOFTINT3        VIC_REG(0x00CC)
> -#define VIC_IRQ_VEC_RD      VIC_REG(0x00D0)  /* pending int # */
> -#define VIC_IRQ_VEC_PEND_RD VIC_REG(0x00D4)  /* pending vector addr */
> -#define VIC_IRQ_VEC_WR      VIC_REG(0x00D8)
> -
> -#if defined(CONFIG_ARCH_MSM_SCORPION)
> -#define VIC_FIQ_VEC_RD      VIC_REG(0x00DC)
> -#define VIC_FIQ_VEC_PEND_RD VIC_REG(0x00E0)
> -#define VIC_FIQ_VEC_WR      VIC_REG(0x00E4)
> -#define VIC_IRQ_IN_SERVICE  VIC_REG(0x00E8)
> -#define VIC_IRQ_IN_STACK    VIC_REG(0x00EC)
> -#define VIC_FIQ_IN_SERVICE  VIC_REG(0x00F0)
> -#define VIC_FIQ_IN_STACK    VIC_REG(0x00F4)
> -#define VIC_TEST_BUS_SEL    VIC_REG(0x00F8)
> -#define VIC_IRQ_CTRL_CONFIG VIC_REG(0x00FC)
> -#else
> -#define VIC_IRQ_IN_SERVICE  VIC_REG(0x00E0)
> -#define VIC_IRQ_IN_STACK    VIC_REG(0x00E4)
> -#define VIC_TEST_BUS_SEL    VIC_REG(0x00E8)
> -#endif
> -
> -#define VIC_VECTPRIORITY(n) VIC_REG(0x0200+((n) * 4))
> -#define VIC_VECTADDR(n)     VIC_REG(0x0400+((n) * 4))
> -
>   #if defined(CONFIG_ARCH_MSM7X30)
>   #define VIC_NUM_REGS	    4
>   #else
>   #define VIC_NUM_REGS	    2
>   #endif
>
> -#if VIC_NUM_REGS == 2
> -#define DPRINT_REGS(base_reg, format, ...)	      			\
> -	printk(KERN_INFO format " %x %x\n", ##__VA_ARGS__,		\
> -			readl(base_reg ## 0), readl(base_reg ## 1))
> -#define DPRINT_ARRAY(array, format, ...)				\
> -	printk(KERN_INFO format " %x %x\n", ##__VA_ARGS__,		\
> -			array[0], array[1])
> -#elif VIC_NUM_REGS == 4
> -#define DPRINT_REGS(base_reg, format, ...) \
> -	printk(KERN_INFO format " %x %x %x %x\n", ##__VA_ARGS__,	\
> -			readl(base_reg ## 0), readl(base_reg ## 1),	\
> -			readl(base_reg ## 2), readl(base_reg ## 3))
> -#define DPRINT_ARRAY(array, format, ...)				\
> -	printk(KERN_INFO format " %x %x %x %x\n", ##__VA_ARGS__,	\
> -			array[0], array[1],				\
> -			array[2], array[3])
> -#else
> -#error "VIC_NUM_REGS set to illegal value"
> -#endif
> -
> -static uint32_t msm_irq_smsm_wake_enable[2];
> -static struct {
> -	uint32_t int_en[2];
> -	uint32_t int_type;
> -	uint32_t int_polarity;
> -	uint32_t int_select;
> -} msm_irq_shadow_reg[VIC_NUM_REGS];
> -static uint32_t msm_irq_idle_disable[VIC_NUM_REGS];
> -
> -#define SMSM_FAKE_IRQ (0xff)
> -static uint8_t msm_irq_to_smsm[NR_IRQS] = {
> -	[INT_MDDI_EXT] = 1,
> -	[INT_MDDI_PRI] = 2,
> -	[INT_MDDI_CLIENT] = 3,
> -	[INT_USB_OTG] = 4,
> -
> -	[INT_PWB_I2C] = 5,
> -	[INT_SDC1_0] = 6,
> -	[INT_SDC1_1] = 7,
> -	[INT_SDC2_0] = 8,
> -
> -	[INT_SDC2_1] = 9,
> -	[INT_ADSP_A9_A11] = 10,
> -	[INT_UART1] = 11,
> -	[INT_UART2] = 12,
> -
> -	[INT_UART3] = 13,
> -	[INT_UART1_RX] = 14,
> -	[INT_UART2_RX] = 15,
> -	[INT_UART3_RX] = 16,
> -
> -	[INT_UART1DM_IRQ] = 17,
> -	[INT_UART1DM_RX] = 18,
> -	[INT_KEYSENSE] = 19,
> -#if !defined(CONFIG_ARCH_MSM7X30)
> -	[INT_AD_HSSD] = 20,
> -#endif
> -
> -	[INT_NAND_WR_ER_DONE] = 21,
> -	[INT_NAND_OP_DONE] = 22,
> -	[INT_TCHSCRN1] = 23,
> -	[INT_TCHSCRN2] = 24,
> -
> -	[INT_TCHSCRN_SSBI] = 25,
> -	[INT_USB_HS] = 26,
> -	[INT_UART2DM_RX] = 27,
> -	[INT_UART2DM_IRQ] = 28,
> -
> -	[INT_SDC4_1] = 29,
> -	[INT_SDC4_0] = 30,
> -	[INT_SDC3_1] = 31,
> -	[INT_SDC3_0] = 32,
> -
> -	/* fake wakeup interrupts */
> -	[INT_GPIO_GROUP1] = SMSM_FAKE_IRQ,
> -	[INT_GPIO_GROUP2] = SMSM_FAKE_IRQ,
> -	[INT_A9_M2A_0] = SMSM_FAKE_IRQ,
> -	[INT_A9_M2A_1] = SMSM_FAKE_IRQ,
> -	[INT_A9_M2A_5] = SMSM_FAKE_IRQ,
> -	[INT_GP_TIMER_EXP] = SMSM_FAKE_IRQ,
> -	[INT_DEBUG_TIMER_EXP] = SMSM_FAKE_IRQ,
> -	[INT_ADSP_A11] = SMSM_FAKE_IRQ,
> -#ifdef CONFIG_ARCH_QSD8X50
> -	[INT_SIRC_0] = SMSM_FAKE_IRQ,
> -	[INT_SIRC_1] = SMSM_FAKE_IRQ,
> -#endif
> -};
> -



The entire patch looks good to me.

However, let me explain that SMSM arrays are. MSM has a different 
interrupt controller that monitors few of the lines that the VIC does.
This parallel interrupt controller is activated when the MSM goes to low
power modes.

For idle case, if an interrupt not monitored by the parallel interrupt 
controller is enabled, we avoid going to low power modes. It is 
unreasonable to check all the shadow registers to find if such is the 
case, so we maintain the unmask status of such interrupts in
static uint32_t msm_irq_idle_disable[VIC_NUM_REGS]. If any bit is set we 
dont go to low power mode. This code is not upstreamed yet, I can submit 
it on top of this patch.

The reason for explaining this is to ask if we should extend the generic 
chip to have a function that returns if any interrupts besides the 
wakeup ones are unmasked. It would return

mask_cache & ~wakeup_active  if mask_cache bit set means interrupt is 
unmasked
~mask_cache & ~wakeup_active if mask_cache bit set means interrupts is 
masked

or you would prefer the driver do that check?



-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
