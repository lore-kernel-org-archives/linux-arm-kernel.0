From: helmut.raiger@hale.at (Helmut Raiger)
Date: Mon, 21 Mar 2011 13:54:01 +0100
Subject: i.MX31 suspend and VSTBY question
Message-ID: <4D874A69.9010209@hale.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
     I'm currently testing 'suspend to memory' on our i.MX31 platform, 
therefore I created a file named pm-imx31.c in arch/arm/plat-mxc. It 
contains some debugging code for the PMIC registers, that was hacked 
into mc13xxx_core.c.

------------------- snip: pm-imx31.c --------------------------

#include <linux/kernel.h>
#include <linux/err.h>
#include <linux/suspend.h>
#include <linux/regulator/machine.h>

#include <mach/system.h>
// HACK
#include "../mach-mx3/crm_regs.h"

extern void mc13xxx_dump_registers(void);

static void mxc_modify_reg(void *reg_offset, unsigned int mask,
                         unsigned int data)
{
     u32 reg;

     reg = __raw_readl(reg_offset);
     reg = (reg & (~mask)) | data;
     __raw_writel(reg, reg_offset);
}

static int mx31_suspend_prepare(void)
{
#ifdef CONFIG_PM_DEBUG
     mc13xxx_dump_registers();
#endif
     return 0;
}

static int mx31_suspend_enter(suspend_state_t state)
{
     unsigned long *reg;

     switch (state) {
     case PM_SUSPEND_MEM:
         /* TODO: Enable Well Bias, disable core clock in standby */
         mxc_modify_reg(MXC_CCM_CCMR,
                 MXC_CCM_CCMR_WBEN | MXC_CCM_CCMR_SBYCS,
                 MXC_CCM_CCMR_SBYCS);

         mxc_modify_reg(MXC_CCM_CCMR,
                 MXC_CCM_CCMR_LPM_MASK,
                 2 << MXC_CCM_CCMR_LPM_OFFSET);

         /* enable VSTBY signalling */
         mxc_modify_reg(MXC_CCM_CCMR, MXC_CCM_CCMR_VSTBY, 
MXC_CCM_CCMR_VSTBY);

         printk(KERN_INFO "Now supsending! CCMR=0x%x\n", 
__raw_readl(MXC_CCM_CCMR));

         for (reg = MXC_CCM_CCMR; reg <= MXC_CCM_PDR2; reg++)
             printk(KERN_INFO "0x%p: 0x%08lx\n", reg, *reg);

         arch_idle();

         printk(KERN_INFO "Now resuming\n");
         break;
     default:
         return -EINVAL;
     }
     return 0;
}

static void mx31_resume_done(void)
{
#ifdef CONFIG_PM_DEBUG
     mc13xxx_dump_registers();
#endif

}

struct platform_suspend_ops mx31_suspend_ops = {
       .valid = suspend_valid_only_mem,
       .prepare = mx31_suspend_prepare,
       .enter = mx31_suspend_enter,
       .end = mx31_resume_done,
};

static int __init mx31_pm_init(void)
{
       printk(KERN_INFO "Power Management for Freescale MX31\n");
       suspend_set_ops(&mx31_suspend_ops);

       return 0;
}

------------------- snip --------------------------

'echo mem >/sys/power/state' does what is expected, however the VSTBY 
line is not asserted.

We had this platform running with a 2.6.21 LTIB based kernel. When I use 
this image (hardly comparable)  the signal appears as expected. I'm 
running out of ideas, so any pointers would be very much appreciated.

Helmut



--
Scanned by MailScanner.
