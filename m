From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 20 Nov 2015 23:52:22 +0800
Subject: [arm:drm-etnaviv-devel 69/149]
 drivers/staging/etnaviv/etnaviv_gpu.c:1063:12: error:
 'etnaviv_gpu_hw_resume' defined but not used
Message-ID: <201511202321.dgWwfHFS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
commit: 6cfaea6c08d9d915ae44b70427db5f32a454e1ba [69/149] staging: etnaviv: add runtime PM support
config: i386-randconfig-r0-201546 (attached as .config)
reproduce:
        git checkout 6cfaea6c08d9d915ae44b70427db5f32a454e1ba
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm/drm-etnaviv-devel HEAD a0252118653cb935f209bd8baf048195c77d3292 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/staging/etnaviv/etnaviv_gpu.c: In function 'etnaviv_gpu_hw_resume':
   drivers/staging/etnaviv/etnaviv_gpu.c:1079:5: error: 'struct etnaviv_gpu' has no member named 'switch_context'
     gpu->switch_context = true;
        ^
   drivers/staging/etnaviv/etnaviv_gpu.c: At top level:
>> drivers/staging/etnaviv/etnaviv_gpu.c:1063:12: error: 'etnaviv_gpu_hw_resume' defined but not used [-Werror=unused-function]
    static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
               ^
   cc1: all warnings being treated as errors

vim +/etnaviv_gpu_hw_resume +1063 drivers/staging/etnaviv/etnaviv_gpu.c

  1057			} while (1);
  1058		}
  1059	
  1060		return etnaviv_gpu_clk_disable(gpu);
  1061	}
  1062	
> 1063	static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
  1064	{
  1065		struct drm_device *drm = gpu->drm;
  1066		uint32_t clock;
  1067		int ret;
  1068	
  1069		ret = mutex_lock_killable(&drm->struct_mutex);
  1070		if (ret)
  1071			return ret;
  1072	
  1073		clock = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
  1074			VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(0x40);
  1075	
  1076		etnaviv_gpu_load_clock(gpu, clock);
  1077		etnaviv_gpu_hw_init(gpu);
  1078	
> 1079		gpu->switch_context = true;
  1080	
  1081		mutex_unlock(&drm->struct_mutex);
  1082	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22037 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/e06f28e3/attachment-0001.obj>
