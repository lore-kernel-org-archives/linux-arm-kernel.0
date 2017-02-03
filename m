From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 3 Feb 2017 23:00:29 +0800
Subject: [xlnx:master 2262/2699]
 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c:36:26:
 error: implicit declaration of function 'ioremap_nocache'
Message-ID: <201702032314.rBHXkUMl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

First bad commit (maybe != root cause):

tree:   https://github.com/Xilinx/linux-xlnx master
head:   629041605b93343ad2e8971ceaac3edcef0b043b
commit: 2ab6f2613b2c23f3d79821331f709d17219c6ec1 [2262/2699] Merge tag 'v4.2' into master
config: um-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 2ab6f2613b2c23f3d79821331f709d17219c6ec1
        # save the attached .config to linux build tree
        make ARCH=um 

All error/warnings (new ones prefixed by >>):

   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c: In function '_mali_osk_mem_mapioregion':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c:36:26: error: implicit declaration of function 'ioremap_nocache' [-Werror=implicit-function-declaration]
     return (mali_io_address)ioremap_nocache(phys, size);
                             ^~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c:36:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     return (mali_io_address)ioremap_nocache(phys, size);
            ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c: In function '_mali_osk_mem_unmapioregion':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c:41:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
     iounmap((void *)virt);
     ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c: In function 'mali_read_phys':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:330:21: error: implicit declaration of function 'ioremap_nocache' [-Werror=implicit-function-declaration]
     void *mem_mapped = ioremap_nocache(phys_addr_page, map_size);
                        ^~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:330:21: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:333:3: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
      iounmap(mem_mapped);
      ^~~~~~~
   At top level:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:324:12: warning: 'mali_read_phys' defined but not used [-Wunused-function]
    static u32 mali_read_phys(u32 phys_addr)
               ^~~~~~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:25:0:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c: In function 'mali_platform_device_init':
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_kernel_common.h:156:45: warning: 'num_pp_cores' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define MALI_DEBUG_ASSERT(condition) do  {if( !(condition)) {MALI_PRINT_ERROR(("ASSERT failed: " #condition )); _mali_osk_break();} } while(0)
                                                ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/platform/arm/arm.c:238:6: note: 'num_pp_cores' was declared here
     int num_pp_cores;
         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ioremap_nocache +36 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_osk_low_level_mem.c

8e905b3b Michal Simek 2015-06-10  30  {
8e905b3b Michal Simek 2015-06-10  31  	wmb();
8e905b3b Michal Simek 2015-06-10  32  }
8e905b3b Michal Simek 2015-06-10  33  
8e905b3b Michal Simek 2015-06-10  34  mali_io_address _mali_osk_mem_mapioregion(uintptr_t phys, u32 size, const char *description)
8e905b3b Michal Simek 2015-06-10  35  {
8e905b3b Michal Simek 2015-06-10 @36  	return (mali_io_address)ioremap_nocache(phys, size);
8e905b3b Michal Simek 2015-06-10  37  }
8e905b3b Michal Simek 2015-06-10  38  
8e905b3b Michal Simek 2015-06-10  39  void _mali_osk_mem_unmapioregion(uintptr_t phys, u32 size, mali_io_address virt)
8e905b3b Michal Simek 2015-06-10  40  {
8e905b3b Michal Simek 2015-06-10 @41  	iounmap((void *)virt);
8e905b3b Michal Simek 2015-06-10  42  }
8e905b3b Michal Simek 2015-06-10  43  
8e905b3b Michal Simek 2015-06-10  44  _mali_osk_errcode_t inline _mali_osk_mem_reqregion(uintptr_t phys, u32 size, const char *description)

:::::: The code at line 36 was first introduced by commit
:::::: 8e905b3b33fa6f3f2f97591500b53d8a8245df29 staging: mali: Add r5p1-01rel0 and r5p2-00rel0 drivers

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16422 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/da41b26f/attachment-0001.gz>
