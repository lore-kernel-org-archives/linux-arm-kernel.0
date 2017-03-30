From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Mar 2017 16:55:44 +0800
Subject: [PATCH v1 2/8] [media] stm32-dcmi: STM32 DCMI camera interface
 driver
In-Reply-To: <1490793926-6477-3-git-send-email-hugues.fruchet@st.com>
Message-ID: <201703301611.nzJboriI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.11-rc4 next-20170329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/Add-support-for-DCMI-camera-interface-of-STMicroelectronics-STM32-SoC-series/20170330-140726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/media/platform/stm32/stm32-dcmi.c: In function 'dcmi_probe':
>> drivers/media/platform/stm32/stm32-dcmi.c:1386:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return ret;
            ^~~

vim +/ret +1386 drivers/media/platform/stm32/stm32-dcmi.c

  1370		dev_info(&pdev->dev, "Probe done\n");
  1371	
  1372		platform_set_drvdata(pdev, dcmi);
  1373		return 0;
  1374	
  1375	err_reset_control_put:
  1376		reset_control_put(dcmi->rstc);
  1377	err_device_release:
  1378		video_device_release(dcmi->vdev);
  1379	err_device_unregister:
  1380		v4l2_device_unregister(&dcmi->v4l2_dev);
  1381	err_clk_unprepare:
  1382		clk_unprepare(dcmi->mclk);
  1383	err_dma_release:
  1384		dma_release_channel(dcmi->dma_chan);
  1385	
> 1386		return ret;
  1387	}
  1388	
  1389	static int dcmi_remove(struct platform_device *pdev)
  1390	{
  1391		struct stm32_dcmi *dcmi = platform_get_drvdata(pdev);
  1392	
  1393		v4l2_async_notifier_unregister(&dcmi->notifier);
  1394		v4l2_device_unregister(&dcmi->v4l2_dev);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58859 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/3c1c9da2/attachment-0001.gz>
