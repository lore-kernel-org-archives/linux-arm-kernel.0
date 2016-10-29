From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 30 Oct 2016 00:27:08 +0800
Subject: [rjarzmik:pxa/for-next 8/8] arch/arm/mach-pxa/em-x270.c:987:15:
 error: variable 'camera_dummy_config' has initializer but incomplete type
Message-ID: <201610300005.Wr8vvIuS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux pxa/for-next
head:   f27d52aafe46f2cdce6a075970861dab30ff715d
commit: f27d52aafe46f2cdce6a075970861dab30ff715d [8/8] ARM: pxa: em-x270: use the new pxa_camera platform_data
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f27d52aafe46f2cdce6a075970861dab30ff715d
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> arch/arm/mach-pxa/em-x270.c:987:15: error: variable 'camera_dummy_config' has initializer but incomplete type
    static struct fixed_voltage_config camera_dummy_config = {
                  ^~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/em-x270.c:988:2: error: unknown field 'supply_name' specified in initializer
     .supply_name  = "camera_vdd",
     ^
>> arch/arm/mach-pxa/em-x270.c:988:18: warning: excess elements in struct initializer
     .supply_name  = "camera_vdd",
                     ^~~~~~~~~~~~
   arch/arm/mach-pxa/em-x270.c:988:18: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:989:2: error: unknown field 'input_supply' specified in initializer
     .input_supply  = "vcc cam",
     ^
   arch/arm/mach-pxa/em-x270.c:989:19: warning: excess elements in struct initializer
     .input_supply  = "vcc cam",
                      ^~~~~~~~~
   arch/arm/mach-pxa/em-x270.c:989:19: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:990:2: error: unknown field 'microvolts' specified in initializer
     .microvolts  = 2800000,
     ^
   arch/arm/mach-pxa/em-x270.c:990:17: warning: excess elements in struct initializer
     .microvolts  = 2800000,
                    ^~~~~~~
   arch/arm/mach-pxa/em-x270.c:990:17: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:991:2: error: unknown field 'gpio' specified in initializer
     .gpio   = GPIO56_MT9M111_nOE,
     ^
>> arch/arm/mach-pxa/em-x270.c:991:12: error: 'GPIO56_MT9M111_nOE' undeclared here (not in a function)
     .gpio   = GPIO56_MT9M111_nOE,
               ^~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/em-x270.c:991:12: warning: excess elements in struct initializer
   arch/arm/mach-pxa/em-x270.c:991:12: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:992:2: error: unknown field 'enable_high' specified in initializer
     .enable_high  = 0,
     ^
   arch/arm/mach-pxa/em-x270.c:992:18: warning: excess elements in struct initializer
     .enable_high  = 0,
                     ^
   arch/arm/mach-pxa/em-x270.c:992:18: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:993:2: error: unknown field 'init_data' specified in initializer
     .init_data  = &camera_dummy_initdata,
     ^
   arch/arm/mach-pxa/em-x270.c:993:16: warning: excess elements in struct initializer
     .init_data  = &camera_dummy_initdata,
                   ^
   arch/arm/mach-pxa/em-x270.c:993:16: note: (near initialization for 'camera_dummy_config')
>> arch/arm/mach-pxa/em-x270.c:987:36: error: storage size of 'camera_dummy_config' isn't known
    static struct fixed_voltage_config camera_dummy_config = {
                                       ^~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/em-x270.c:996:31: warning: 'camera_supply_dummy_device' defined but not used [-Wunused-variable]
    static struct platform_device camera_supply_dummy_device = {
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/em-x270.c:959:26: warning: 'em_x270_camera_ldo' defined but not used [-Wunused-variable]
    static struct regulator *em_x270_camera_ldo;
                             ^~~~~~~~~~~~~~~~~~

vim +/camera_dummy_config +987 arch/arm/mach-pxa/em-x270.c

   953	#else
   954	static inline void em_x270_init_gpio_keys(void) {}
   955	#endif
   956	
   957	/* Quick Capture Interface and sensor setup */
   958	#if defined(CONFIG_VIDEO_PXA27x) || defined(CONFIG_VIDEO_PXA27x_MODULE)
 > 959	static struct regulator *em_x270_camera_ldo;
   960	
   961	static int em_x270_sensor_init(void)
   962	{
   963		int ret;
   964	
   965		ret = gpio_request(cam_reset, "camera reset");
   966		if (ret)
   967			return ret;
   968	
   969		gpio_direction_output(cam_reset, 0);
   970		gpio_set_value(cam_reset, 1);
   971	
   972		return 0;
   973	}
   974	
   975	static struct regulator_consumer_supply camera_dummy_supplies[] = {
   976		REGULATOR_SUPPLY("vdd", "0-005d"),
   977	};
   978	
   979	static struct regulator_init_data camera_dummy_initdata = {
   980		.consumer_supplies = camera_dummy_supplies,
   981		.num_consumer_supplies = ARRAY_SIZE(camera_dummy_supplies),
   982		.constraints = {
   983			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
   984		},
   985	};
   986	
 > 987	static struct fixed_voltage_config camera_dummy_config = {
 > 988		.supply_name		= "camera_vdd",
 > 989		.input_supply		= "vcc cam",
 > 990		.microvolts		= 2800000,
 > 991		.gpio			= GPIO56_MT9M111_nOE,
 > 992		.enable_high		= 0,
 > 993		.init_data		= &camera_dummy_initdata,
   994	};
   995	
 > 996	static struct platform_device camera_supply_dummy_device = {
   997		.name	= "reg-fixed-voltage",
   998		.id	= 1,
   999		.dev	= {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30095 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161030/40070bab/attachment-0001.gz>
