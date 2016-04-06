From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Apr 2016 08:05:56 +0800
Subject: [PATCH v2] arm: omap2: remove redundant multiplatform checks
In-Reply-To: <1459895738-6546-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <201604060800.bQaPgVZ1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.6-rc2 next-20160405]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jonas-Rabenstein/arm-omap2-remove-redundant-multiplatform-checks/20160406-064050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-omap2/io.c: In function 'omap_sdrc_init':
>> arch/arm/mach-omap2/io.c:766:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx() || omap3_has_sdrc()) {
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/control.c: In function 'omap_ctrl_write_dsp_boot_addr':
>> arch/arm/mach-omap2/control.c:245:2: error: implicit declaration of function 'soc_is_omap243x' [-Werror=implicit-function-declaration]
     u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/timer.c: In function 'omap_dm_timer_get_errata':
>> arch/arm/mach-omap2/timer.c:223:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx())
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/display.c: In function 'omap_display_get_version':
>> arch/arm/mach-omap2/display.c:265:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx())
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/i2c.c: In function 'omap_i2c_nr_ports':
>> arch/arm/mach-omap2/i2c.c:115:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx())
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/omap_hwmod.c: In function 'omap_hwmod_init':
>> arch/arm/mach-omap2/omap_hwmod.c:3895:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx()) {
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/sram.c: In function 'is_sram_locked':
>> arch/arm/mach-omap2/sram.c:66:3: error: implicit declaration of function 'soc_is_omap242x' [-Werror=implicit-function-declaration]
      if (cpu_is_omap242x()) {
      ^
   arch/arm/mach-omap2/sram.c: In function 'omap_detect_sram':
>> arch/arm/mach-omap2/sram.c:114:4: error: implicit declaration of function 'soc_is_omap243x' [-Werror=implicit-function-declaration]
       else if (cpu_is_omap243x())
       ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/clockdomain.c: In function 'clkdm_hwmod_enable':
>> arch/arm/mach-omap2/clockdomain.c:1233:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx() || cpu_is_omap34xx())
     ^
   cc1: some warnings being treated as errors
--
   arch/arm/mach-omap2/clock.c: In function 'ti_clk_init_features':
>> arch/arm/mach-omap2/clock.c:194:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx()) {
     ^
   cc1: some warnings being treated as errors

vim +/soc_is_omap24xx +766 arch/arm/mach-omap2/io.c

a3a9384a R Sricharan      2013-07-03  760  
a4ca9dbe Tony Lindgren    2011-08-22  761  void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
4805734b Paul Walmsley    2010-12-21  762  				      struct omap_sdrc_params *sdrc_cs1)
4805734b Paul Walmsley    2010-12-21  763  {
a66cb345 Tony Lindgren    2011-10-04  764  	omap_sram_init();
a66cb345 Tony Lindgren    2011-10-04  765  
01001712 Hemant Pedanekar 2011-02-16 @766  	if (cpu_is_omap24xx() || omap3_has_sdrc()) {
58cda884 Jean Pihet       2009-07-24  767  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
2f135eaf Paul Walmsley    2009-06-19  768  		_omap2_init_reprogram_sdrc();
aa4b1f6e Kevin Hilman     2010-03-10  769  	}

:::::: The code at line 766 was first introduced by commit
:::::: 01001712c96f82e6317b1e09729d8fc4bcc66957 TI816X: Update common OMAP machine specific sources

:::::: TO: Hemant Pedanekar <hemantp@ti.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36970 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160406/553231e4/attachment-0001.obj>
