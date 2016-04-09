From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Apr 2016 06:42:17 +0800
Subject: [PATCH v5 2/2] ohci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <1460211315-17915-3-git-send-email-hdegoede@redhat.com>
Message-ID: <201604100613.ZjXMnHgp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.6-rc2 next-20160408]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/hci-platform-Add-support-for-controllers-with-more-then-one-reset-line/20160409-221746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: x86_64-randconfig-s5-04100613 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/usb/host/ohci-platform.c: In function 'ohci_platform_probe':
>> drivers/usb/host/ohci-platform.c:201:5: error: implicit declaration of function 'devm_reset_control_get_shared_by_index' [-Werror=implicit-function-declaration]
        devm_reset_control_get_shared_by_index(
        ^
   drivers/usb/host/ohci-platform.c:200:22: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       priv->resets[rst] =
                         ^
   cc1: some warnings being treated as errors

vim +/devm_reset_control_get_shared_by_index +201 drivers/usb/host/ohci-platform.c

   195					priv->clks[clk] = NULL;
   196					break;
   197				}
   198			}
   199			for (rst = 0; rst < OHCI_MAX_RESETS; rst++) {
   200				priv->resets[rst] =
 > 201					devm_reset_control_get_shared_by_index(
   202									&dev->dev, rst);
   203				if (IS_ERR(priv->resets[rst])) {
   204					err = PTR_ERR(priv->resets[rst]);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25550 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/af0aa259/attachment-0001.obj>
