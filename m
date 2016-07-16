From: lkp@intel.com (kbuild test robot)
Date: Sun, 17 Jul 2016 04:55:44 +0800
Subject: [PATCH] ARM: pxa: fix GPIO double shifts
In-Reply-To: <1468657429-13117-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <201607170446.lleGc7QU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on arm-soc/for-next]
[also build test WARNING on v4.7-rc7 next-20160715]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/ARM-pxa-fix-GPIO-double-shifts/20160716-163032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-spitz_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/mach-pxa/spitz_pm.c: In function 'spitz_charger_wakeup':
>> arch/arm/mach-pxa/spitz_pm.c:171:8: warning: suggest parentheses around operand of '!' or change '|' to '||' or '!' to '~' [-Wparentheses]
     ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
           ^

vim +171 arch/arm/mach-pxa/spitz_pm.c

   155		if (PEDR & GPIO_bit(SPITZ_GPIO_KEY_INT))
   156			is_resume |= GPIO_bit(SPITZ_GPIO_KEY_INT);
   157	
   158		if (PKSR & GPIO_bit(SPITZ_GPIO_SYNC))
   159			is_resume |= GPIO_bit(SPITZ_GPIO_SYNC);
   160	
   161		if (resume_on_alarm && (PEDR & PWER_RTC))
   162			is_resume |= PWER_RTC;
   163	
   164		dev_dbg(sharpsl_pm.dev, "is_resume: %x\n", is_resume);
   165		return is_resume;
   166	}
   167	
   168	static unsigned long spitz_charger_wakeup(void)
   169	{
   170		unsigned long ret;
 > 171		ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
   172			| gpio_get_value(SPITZ_GPIO_SYNC);
   173		return ret;
   174	}
   175	
   176	unsigned long spitzpm_read_devdata(int type)
   177	{
   178		switch (type) {
   179		case SHARPSL_STATUS_ACIN:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19249 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160717/e9c0ba4e/attachment-0001.obj>
