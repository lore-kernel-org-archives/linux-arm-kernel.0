From: lkp@intel.com (kbuild test robot)
Date: Mon, 3 Apr 2017 15:22:27 +0800
Subject: [PATCH 8/9] drm/rockchip: gem: Don't alloc/free gem buf before
 drm dev registered
In-Reply-To: <1491043442-20626-9-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <201704031501.g1FZRbBJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on v4.11-rc5 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jeffy-Chen/drm-rockchip-Fix-rockchip-drm-unbind-crash-error/20170403-094428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/rockchip/rockchip_drm_gem.c: In function 'rockchip_gem_alloc_buf':
>> drivers/gpu/drm/rockchip/rockchip_drm_gem.c:188:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
      return;
      ^~~~~~
   drivers/gpu/drm/rockchip/rockchip_drm_gem.c:180:12: note: declared here
    static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
               ^~~~~~~~~~~~~~~~~~~~~~

vim +/return +188 drivers/gpu/drm/rockchip/rockchip_drm_gem.c

   172		if (!rk_obj->kvaddr) {
   173			DRM_ERROR("failed to allocate %zu byte dma buffer", obj->size);
   174			return -ENOMEM;
   175		}
   176	
   177		return 0;
   178	}
   179	
   180	static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
   181					  bool alloc_kmap)
   182	{
   183		struct drm_gem_object *obj = &rk_obj->base;
   184		struct drm_device *drm = obj->dev;
   185		struct rockchip_drm_private *private = drm->dev_private;
   186	
   187		if (!drm->registered)
 > 188			return;
   189	
   190		if (private->domain)
   191			return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
   192		else
   193			return rockchip_gem_alloc_dma(rk_obj, alloc_kmap);
   194	}
   195	
   196	static void rockchip_gem_free_iommu(struct rockchip_gem_object *rk_obj)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61325 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/a92b2785/attachment-0001.gz>
