From: lkp@intel.com (kbuild test robot)
Date: Sun, 30 Jul 2017 12:26:55 +0800
Subject: [PATCH v1 5/5] [media] stm32-dcmi: g_/s_selection crop support
In-Reply-To: <1501236302-18097-6-git-send-email-hugues.fruchet@st.com>
Message-ID: <201707301258.09yjhNRw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.13-rc2 next-20170728]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/STM32-DCMI-camera-interface-crop-support/20170730-114803
base:   git://linuxtv.org/media_tree.git master
config: powerpc-allmodconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/media//platform/stm32/stm32-dcmi.c: In function 'dcmi_graph_notify_complete':
>> drivers/media//platform/stm32/stm32-dcmi.c:1445:5: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (ret) {
        ^

vim +/ret +1445 drivers/media//platform/stm32/stm32-dcmi.c

  1431	
  1432	static int dcmi_graph_notify_complete(struct v4l2_async_notifier *notifier)
  1433	{
  1434		struct stm32_dcmi *dcmi = notifier_to_dcmi(notifier);
  1435		int ret;
  1436	
  1437		dcmi->vdev->ctrl_handler = dcmi->entity.subdev->ctrl_handler;
  1438		ret = dcmi_formats_init(dcmi);
  1439		if (ret) {
  1440			dev_err(dcmi->dev, "No supported mediabus format found\n");
  1441			return ret;
  1442		}
  1443	
  1444		ret = dcmi_framesizes_init(dcmi);
> 1445		if (ret) {
  1446			dev_err(dcmi->dev, "Could not initialize framesizes\n");
  1447			return ret;
  1448		}
  1449	
  1450		ret = dcmi_get_sensor_bounds(dcmi, &dcmi->sd_bounds);
  1451		if (ret) {
  1452			dev_err(dcmi->dev, "Could not get sensor bounds\n");
  1453			return ret;
  1454		}
  1455	
  1456		ret = dcmi_set_default_fmt(dcmi);
  1457		if (ret) {
  1458			dev_err(dcmi->dev, "Could not set default format\n");
  1459			return ret;
  1460		}
  1461	
  1462		ret = video_register_device(dcmi->vdev, VFL_TYPE_GRABBER, -1);
  1463		if (ret) {
  1464			dev_err(dcmi->dev, "Failed to register video device\n");
  1465			return ret;
  1466		}
  1467	
  1468		dev_dbg(dcmi->dev, "Device registered as %s\n",
  1469			video_device_node_name(dcmi->vdev));
  1470		return 0;
  1471	}
  1472	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54615 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170730/939a55ad/attachment-0001.gz>
