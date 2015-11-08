From: lkp@intel.com (kbuild test robot)
Date: Sun, 8 Nov 2015 17:42:10 +0800
Subject: [PATCH v3 05/10] thermal: rockchip: Add the sort flag for adc
 value increment or decrement
In-Reply-To: <1446974768-25795-6-git-send-email-wxt@rock-chips.com>
Message-ID: <201511081727.aYHG5C5A%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test WARNING on: soc-thermal/next]
[also build test WARNING on: next-20151106]
[cannot apply to: rockchip/for-next v4.3]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/Better-compatible-for-the-rockchip-thermal-and-support-RK3368-SoCs/20151108-173308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal next
config: x86_64-randconfig-x014-201545 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/thermal/rockchip_thermal.c: In function 'rk_tsadcv2_code_to_temp':
>> drivers/thermal/rockchip_thermal.c:239:10: warning: switch condition has boolean value [-Wswitch-bool]
     switch (table.sort_flag) {
             ^
   drivers/thermal/rockchip_thermal.c: In function 'rockchip_thermal_suspend':
   drivers/thermal/rockchip_thermal.c:720:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
     pinctrl_pm_select_sleep_state(dev);
     ^
   drivers/thermal/rockchip_thermal.c: In function 'rockchip_thermal_resume':
   drivers/thermal/rockchip_thermal.c:759:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
     pinctrl_pm_select_default_state(dev);
     ^
   cc1: some warnings being treated as errors

vim +239 drivers/thermal/rockchip_thermal.c

   223		}
   224	
   225		return 0;
   226	}
   227	
   228	static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
   229					   int *temp)
   230	{
   231		unsigned int low = 1;
   232		unsigned int high = table.length - 1;
   233		unsigned int mid = (low + high) / 2;
   234		unsigned int num;
   235		unsigned long denom;
   236	
   237		WARN_ON(table.length < 2);
   238	
 > 239		switch (table.sort_flag) {
   240		case ADC_DECREMENT:
   241			code &= table.data_mask;
   242			if (code < table.id[high].code)
   243				return -EAGAIN;		/* Incorrect reading */
   244	
   245			while (low <= high) {
   246				if (code >= table.id[mid].code &&
   247				    code < table.id[mid - 1].code)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25156 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/4fab5161/attachment-0001.obj>
