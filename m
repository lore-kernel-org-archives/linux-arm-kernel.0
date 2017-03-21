From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 21 Mar 2017 20:52:09 +0800
Subject: [arm-platforms:timers/errata-rework 10/18]
 drivers/clocksource/arm_arch_timer.c:483:6: error: implicit declaration of
 function 'needs_unstable_timer_counter_workaround'
Message-ID: <201703212006.FklvpAFk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git timers/errata-rework
head:   317327df79aeca1621758debe2c4c07f97f43f68
commit: ffc9559fe76cd5bbd6562cf3a68f87b8c38e8176 [10/18] arm64: arch_timer: Get rid of erratum_workaround_set_sne
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ffc9559fe76cd5bbd6562cf3a68f87b8c38e8176
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-platforms/timers/errata-rework HEAD 317327df79aeca1621758debe2c4c07f97f43f68 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_set_next_event_virt':
>> drivers/clocksource/arm_arch_timer.c:483:6: error: implicit declaration of function 'needs_unstable_timer_counter_workaround' [-Werror=implicit-function-declaration]
     if (needs_unstable_timer_counter_workaround())
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/needs_unstable_timer_counter_workaround +483 drivers/clocksource/arm_arch_timer.c

   477		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
   478	}
   479	
   480	static int arch_timer_set_next_event_virt(unsigned long evt,
   481						  struct clock_event_device *clk)
   482	{
 > 483		if (needs_unstable_timer_counter_workaround())
   484			return erratum_set_next_event_tval_virt(evt, clk);
   485	
   486		set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20777 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/09721aab/attachment-0001.gz>
