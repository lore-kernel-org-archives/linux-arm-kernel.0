From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jan 2016 20:52:17 +0800
Subject: [PATCH V13 09/10] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <1454106914-15857-10-git-send-email-okaya@codeaurora.org>
Message-ID: <201601302013.VQW0NZ88%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on vfio/next]
[also build test ERROR on v4.5-rc1 next-20160129]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/dma-add-Qualcomm-Technologies-HIDMA-driver/20160130-064551
base:   https://github.com/awilliam/linux-vfio.git next
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/vfio/platform/vfio_platform_common.c: In function 'vfio_platform_probe_acpi':
>> drivers/vfio/platform/vfio_platform_common.c:558:9: error: invalid initializer
     struct acpi_device adev = ACPI_COMPANION(dev);
            ^
>> drivers/vfio/platform/vfio_platform_common.c:560:6: error: wrong type argument to unary exclamation mark
     if (!adev)
         ^
>> drivers/vfio/platform/vfio_platform_common.c:563:18: error: incompatible type for argument 1 of 'acpi_device_hid'
     vdev->acpihid = acpi_device_hid(adev);
                     ^
   In file included from include/linux/acpi.h:41:0,
                    from drivers/vfio/platform/vfio_platform_common.c:16:
   include/acpi/acpi_bus.h:253:13: note: expected 'struct acpi_device *' but argument is of type 'struct acpi_device'
    const char *acpi_device_hid(struct acpi_device *device);
                ^

vim +558 drivers/vfio/platform/vfio_platform_common.c

   552	};
   553	
   554	#ifdef CONFIG_ACPI
   555	int vfio_platform_probe_acpi(struct vfio_platform_device *vdev,
   556				     struct device *dev)
   557	{
 > 558		struct acpi_device adev = ACPI_COMPANION(dev);
   559	
 > 560		if (!adev)
   561			return -EINVAL;
   562	
 > 563		vdev->acpihid = acpi_device_hid(adev);
   564		if (!vdev->acpihid) {
   565			pr_err("VFIO: cannot find ACPI HID for %s\n",
   566			       vdev->name);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46685 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160130/b58da2c8/attachment-0001.obj>
