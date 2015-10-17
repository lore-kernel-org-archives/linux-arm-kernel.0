From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 18 Oct 2015 04:01:48 +0800
Subject: [arm-platforms:irq/gic-active-clear 1/4]
 arch/arm/kernel/machine_kexec.c:111:3: error: implicit declaration of
 function 'irq_set_irqchip_state'
Message-ID: <201510180446.LWq5dol1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-active-clear
head:   8fe60d99a755ef0ba00950a3062350c4fafdc7db
commit: 4880f734c451e7c702b0bf528d392d07ba781d6d [1/4] arm: kexec: Deactivate in-flight interrupts
config: arm-sa1100 (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4880f734c451e7c702b0bf528d392d07ba781d6d
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/machine_kexec.c: In function 'machine_kexec_mask_interrupts':
>> arch/arm/kernel/machine_kexec.c:111:3: error: implicit declaration of function 'irq_set_irqchip_state' [-Werror=implicit-function-declaration]
      ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
      ^
>> arch/arm/kernel/machine_kexec.c:111:34: error: 'IRQCHIP_STATE_ACTIVE' undeclared (first use in this function)
      ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
                                     ^
   arch/arm/kernel/machine_kexec.c:111:34: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/irq_set_irqchip_state +111 arch/arm/kernel/machine_kexec.c

   105				continue;
   106	
   107			/*
   108			 * First try to remove the active state. If this
   109			 * fails, try to EOI the interrupt.
   110			 */
 > 111			ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
   112	
   113			if (ret && irqd_irq_inprogress(&desc->irq_data) &&
   114			    chip->irq_eoi)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21715 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151018/01caba6a/attachment-0001.obj>
