From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Mar 2016 06:45:54 +0800
Subject: [PATCH v4 1/2] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <1456592339-31767-2-git-send-email-hdegoede@redhat.com>
Message-ID: <201603060656.JPQ60k7d%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Reinder,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc6 next-20160304]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/hci-platform-Add-support-for-controllers-with-more-then-one-reset-line/20160228-010130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: x86_64-randconfig-s5-03060621 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/usb/host/ehci-platform.c: In function 'ehci_platform_probe':
>> drivers/usb/host/ehci-platform.c:239:5: error: implicit declaration of function 'devm_reset_control_get_shared_by_index' [-Werror=implicit-function-declaration]
        devm_reset_control_get_shared_by_index(
        ^
   drivers/usb/host/ehci-platform.c:238:22: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       priv->resets[rst] =
                         ^
   cc1: some warnings being treated as errors

vim +/devm_reset_control_get_shared_by_index +239 drivers/usb/host/ehci-platform.c

   233					break;
   234				}
   235			}
   236	
   237			for (rst = 0; rst < EHCI_MAX_RESETS; rst++) {
   238				priv->resets[rst] =
 > 239					devm_reset_control_get_shared_by_index(
   240							&dev->dev, rst);
   241				if (IS_ERR(priv->resets[rst])) {
   242					err = PTR_ERR(priv->resets[rst]);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160306/36c64f75/attachment-0001.obj>
