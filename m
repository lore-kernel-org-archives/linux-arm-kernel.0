From: lkp@intel.com (kbuild test robot)
Date: Wed, 3 Feb 2016 19:54:21 +0800
Subject: [PATCH v3 2/4] power: reset: add reboot mode driver
In-Reply-To: <1454407325-4804-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <201602031943.IyDJj4gO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.5-rc2 next-20160203]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Andy-Yan/add-reboot-mode-driver/20160202-181909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: x86_64-randconfig-r0-02031912 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

warning: (SYSCON_REBOOT_MODE) selects REBOOT_MODE which has unmet direct dependencies (POWER_RESET && OF)
   drivers/power/reset/reboot-mode.c: In function 'reboot_mode_register':
>> drivers/power/reset/reboot-mode.c:79:2: error: implicit declaration of function 'for_each_property_of_node' [-Werror=implicit-function-declaration]
     for_each_property_of_node(dev->of_node, prop) {
     ^
>> drivers/power/reset/reboot-mode.c:79:48: error: expected ';' before '{' token
     for_each_property_of_node(dev->of_node, prop) {
                                                   ^
>> drivers/power/reset/reboot-mode.c:70:9: warning: unused variable 'len' [-Wunused-variable]
     size_t len = strlen(PREFIX);
            ^
>> drivers/power/reset/reboot-mode.c:68:20: warning: unused variable 'info' [-Wunused-variable]
     struct mode_info *info;
                       ^
   drivers/power/reset/reboot-mode.c: At top level:
   drivers/power/reset/reboot-mode.c:51:12: warning: 'reboot_mode_notify' defined but not used [-Wunused-function]
    static int reboot_mode_notify(struct notifier_block *this,
               ^
   cc1: some warnings being treated as errors

vim +/for_each_property_of_node +79 drivers/power/reset/reboot-mode.c

    62		return NOTIFY_DONE;
    63	}
    64	
    65	int reboot_mode_register(struct device *dev, int (*write)(int))
    66	{
    67		struct reboot_mode_driver *reboot;
  > 68		struct mode_info *info;
    69		struct property *prop;
  > 70		size_t len = strlen(PREFIX);
    71		int ret;
    72	
    73		reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
    74		if (!reboot)
    75			return -ENOMEM;
    76	
    77		reboot->write = write;
    78		INIT_LIST_HEAD(&reboot->head);
  > 79		for_each_property_of_node(dev->of_node, prop) {
    80			if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
    81				continue;
    82			info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24266 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/17f6916f/attachment-0001.obj>
