From: lkp@intel.com (kbuild test robot)
Date: Tue, 14 Mar 2017 13:11:12 +0800
Subject: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
In-Reply-To: <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201703141348.KMI1COZC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LPC-legacy-ISA-I-O-support/20170314-114635
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   drivers/bus/hisi_lpc.c: In function 'hisilpc_probe':
>> drivers/bus/hisi_lpc.c:529:4: error: implicit declaration of function 'acpi_walk_dep_device_list' [-Werror=implicit-function-declaration]
       acpi_walk_dep_device_list(adev->handle);
       ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:529:34: error: dereferencing pointer to incomplete type 'struct acpi_device'
       acpi_walk_dep_device_list(adev->handle);
                                     ^~
   cc1: some warnings being treated as errors

vim +/acpi_walk_dep_device_list +529 drivers/bus/hisi_lpc.c

   523			struct acpi_device *adev;
   524	
   525			adev = to_acpi_device_node(dev->fwnode);
   526			if (!adev)
   527				ret = -ENODEV;
   528			else
 > 529				acpi_walk_dep_device_list(adev->handle);
   530		} else {
   531			ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
   532			if (ret)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49586 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/11d671f9/attachment-0001.gz>
