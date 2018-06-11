From: lkp@intel.com (kbuild test robot)
Date: Mon, 11 Jun 2018 20:36:19 +0800
Subject: [PATCH] media: stm32-dcmi: add power saving support
In-Reply-To: <1528709597-7734-1-git-send-email-hugues.fruchet@st.com>
References: <1528709597-7734-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <201806111813.xzu3WBjk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/media-stm32-dcmi-add-power-saving-support/20180611-174016
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/media/platform/stm32/stm32-dcmi.c: In function 'dcmi_suspend':
>> drivers/media/platform/stm32/stm32-dcmi.c:1886:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
     pinctrl_pm_select_sleep_state(dev);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/stm32/stm32-dcmi.c: In function 'dcmi_resume':
>> drivers/media/platform/stm32/stm32-dcmi.c:1894:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
     pinctrl_pm_select_default_state(dev);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pinctrl_pm_select_sleep_state +1886 drivers/media/platform/stm32/stm32-dcmi.c

  1879	
  1880	static __maybe_unused int dcmi_suspend(struct device *dev)
  1881	{
  1882		/* disable clock */
  1883		pm_runtime_force_suspend(dev);
  1884	
  1885		/* change pinctrl state */
> 1886		pinctrl_pm_select_sleep_state(dev);
  1887	
  1888		return 0;
  1889	}
  1890	
  1891	static __maybe_unused int dcmi_resume(struct device *dev)
  1892	{
  1893		/* restore pinctl default state */
> 1894		pinctrl_pm_select_default_state(dev);
  1895	
  1896		/* clock enable */
  1897		pm_runtime_force_resume(dev);
  1898	
  1899		return 0;
  1900	}
  1901	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63188 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180611/381983f9/attachment-0001.gz>
