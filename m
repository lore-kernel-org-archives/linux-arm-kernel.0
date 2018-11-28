From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Nov 2018 11:28:56 +0800
Subject: [PATCH v2 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
In-Reply-To: <1543335937-12689-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1543335937-12689-4-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <201811281107.R2ycG2WQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei.Stefanescu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on regulator/for-next]
[also build test ERROR on v4.20-rc4 next-20181127]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrei-Stefanescu-microchip-com/add-support-for-MCP16502-PMIC/20181128-041809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: sh-allyesconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All error/warnings (new ones prefixed by >>):

   drivers//regulator/mcp16502.c: In function 'mcp16502_suspend_get_target_reg':
>> drivers//regulator/mcp16502.c:273:10: error: 'pm_suspend_target_state' undeclared (first use in this function); did you mean 'pm_suspended_storage'?
     switch (pm_suspend_target_state) {
             ^~~~~~~~~~~~~~~~~~~~~~~
             pm_suspended_storage
   drivers//regulator/mcp16502.c:273:10: note: each undeclared identifier is reported only once for each function it appears in
   drivers//regulator/mcp16502.c: In function 'mcp16502_set_suspend_mode':
   drivers//regulator/mcp16502.c:310:10: error: 'pm_suspend_target_state' undeclared (first use in this function); did you mean 'pm_suspended_storage'?
     switch (pm_suspend_target_state) {
             ^~~~~~~~~~~~~~~~~~~~~~~
             pm_suspended_storage
   drivers//regulator/mcp16502.c: In function 'mcp16502_suspend_get_target_reg':
>> drivers//regulator/mcp16502.c:284:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers//regulator/mcp16502.c: In function 'mcp16502_set_suspend_mode':
   drivers//regulator/mcp16502.c:321:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +273 drivers//regulator/mcp16502.c

   266	
   267	/*
   268	 * mcp16502_suspend_get_target_reg() - get the reg of the target suspend PMIC
   269	 *				       mode
   270	 */
   271	static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
   272	{
 > 273		switch (pm_suspend_target_state) {
   274		case PM_SUSPEND_STANDBY:
   275			return mcp16502_get_reg(rdev, MCP16502_OPMODE_LPM);
   276		case PM_SUSPEND_ON:
   277		case PM_SUSPEND_MEM:
   278			return mcp16502_get_reg(rdev, MCP16502_OPMODE_HIB);
   279		default:
   280			dev_err(&rdev->dev, "invalid suspend target: %d\n",
   281				pm_suspend_target_state);
   282			return -EINVAL;
   283		}
 > 284	}
   285	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50575 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/5945d017/attachment-0001.gz>
