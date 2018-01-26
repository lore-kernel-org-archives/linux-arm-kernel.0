From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Jan 2018 08:04:18 +0800
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
Message-ID: <201801260759.RyNhDZz4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.15-rc9 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Deng/dt-bindings-media-Add-Allwinner-V3s-Camera-Sensor-Interface-CSI/20180126-054511
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c: In function 'sun6i_csi_update_buf_addr':
>> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:567:31: error: 'PHYS_OFFSET' undeclared (first use in this function); did you mean 'PAGE_OFFSET'?
     dma_addr_t bus_addr = addr - PHYS_OFFSET;
                                  ^~~~~~~~~~~
                                  PAGE_OFFSET
   drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:567:31: note: each undeclared identifier is reported only once for each function it appears in

vim +567 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c

   562	
   563	void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
   564	{
   565		struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
   566		/* transform physical address to bus address */
 > 567		dma_addr_t bus_addr = addr - PHYS_OFFSET;
   568	
   569		regmap_write(sdev->regmap, CSI_CH_F0_BUFA_REG,
   570			     (bus_addr + sdev->planar_offset[0]) >> 2);
   571		if (sdev->planar_offset[1] != -1)
   572			regmap_write(sdev->regmap, CSI_CH_F1_BUFA_REG,
   573				     (bus_addr + sdev->planar_offset[1]) >> 2);
   574		if (sdev->planar_offset[2] != -1)
   575			regmap_write(sdev->regmap, CSI_CH_F2_BUFA_REG,
   576				     (bus_addr + sdev->planar_offset[2]) >> 2);
   577	}
   578	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62442 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/f839cd5c/attachment-0001.gz>
