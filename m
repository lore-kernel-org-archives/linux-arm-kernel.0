From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Jul 2017 14:15:00 +0800
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201707061303.s2NKJzDM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test ERROR on next-20170705]
[cannot apply to gpio/for-next tegra/for-next xlnx/master v4.12 v4.12-rc7 v4.12-rc6 v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/gpio-drop-unnecessary-includes-from-include-linux-gpio-driver-h/20170706-123711
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers//gpio/gpio-exar.c: In function 'gpio_exar_probe':
>> drivers//gpio/gpio-exar.c:135:2: error: implicit declaration of function 'device_property_read_u32' [-Werror=implicit-function-declaration]
     ret = device_property_read_u32(&pdev->dev, "linux,first-pin",
     ^
   cc1: some warnings being treated as errors
--
   drivers//gpio/gpio-lp87565.c: In function 'lp87565_gpio_set_config':
>> drivers//gpio/gpio-lp87565.c:116:2: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
     switch (pinconf_to_config_param(config)) {
     ^
>> drivers//gpio/gpio-lp87565.c:117:7: error: 'PIN_CONFIG_DRIVE_OPEN_DRAIN' undeclared (first use in this function)
     case PIN_CONFIG_DRIVE_OPEN_DRAIN:
          ^
   drivers//gpio/gpio-lp87565.c:117:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers//gpio/gpio-lp87565.c:124:7: error: 'PIN_CONFIG_DRIVE_PUSH_PULL' undeclared (first use in this function)
     case PIN_CONFIG_DRIVE_PUSH_PULL:
          ^
   cc1: some warnings being treated as errors

vim +/device_property_read_u32 +135 drivers//gpio/gpio-exar.c

6596e59e Sudip Mukherjee 2017-01-19  119  static int gpio_exar_probe(struct platform_device *pdev)
6596e59e Sudip Mukherjee 2017-01-19  120  {
d3936d74 Jan Kiszka      2017-06-09  121  	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
6596e59e Sudip Mukherjee 2017-01-19  122  	struct exar_gpio_chip *exar_gpio;
380b1e2f Jan Kiszka      2017-05-22  123  	u32 first_pin, ngpios;
6596e59e Sudip Mukherjee 2017-01-19  124  	void __iomem *p;
6596e59e Sudip Mukherjee 2017-01-19  125  	int index, ret;
6596e59e Sudip Mukherjee 2017-01-19  126  
6596e59e Sudip Mukherjee 2017-01-19  127  	/*
8847f5f9 Jan Kiszka      2017-05-02  128  	 * The UART driver must have mapped region 0 prior to registering this
8847f5f9 Jan Kiszka      2017-05-02  129  	 * device - use it.
6596e59e Sudip Mukherjee 2017-01-19  130  	 */
8847f5f9 Jan Kiszka      2017-05-02  131  	p = pcim_iomap_table(pcidev)[0];
6596e59e Sudip Mukherjee 2017-01-19  132  	if (!p)
6596e59e Sudip Mukherjee 2017-01-19  133  		return -ENOMEM;
6596e59e Sudip Mukherjee 2017-01-19  134  
380b1e2f Jan Kiszka      2017-05-22 @135  	ret = device_property_read_u32(&pdev->dev, "linux,first-pin",
380b1e2f Jan Kiszka      2017-05-22  136  				       &first_pin);
380b1e2f Jan Kiszka      2017-05-22  137  	if (ret)
380b1e2f Jan Kiszka      2017-05-22  138  		return ret;
380b1e2f Jan Kiszka      2017-05-22  139  
380b1e2f Jan Kiszka      2017-05-22  140  	ret = device_property_read_u32(&pdev->dev, "ngpios", &ngpios);
380b1e2f Jan Kiszka      2017-05-22  141  	if (ret)
380b1e2f Jan Kiszka      2017-05-22  142  		return ret;
380b1e2f Jan Kiszka      2017-05-22  143  

:::::: The code at line 135 was first introduced by commit
:::::: 380b1e2f3a2f32bfe9c0aa85a68629eb99b043c0 gpio-exar/8250-exar: Make set of exported GPIOs configurable

:::::: TO: Jan Kiszka <jan.kiszka@siemens.com>
:::::: CC: Jan Kiszka <jan.kiszka@siemens.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51007 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/2900b4a7/attachment-0001.gz>
