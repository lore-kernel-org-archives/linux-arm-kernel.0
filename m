From: zhongjiang@huawei.com (zhong jiang)
Date: Sat, 15 Sep 2018 14:46:42 +0800
Subject: [PATCH] arm: common: use match_string() helper to simplify the
 code
In-Reply-To: <201809150710.kyiQ0EXh%fengguang.wu@intel.com>
References: <1536937519-31611-1-git-send-email-zhongjiang@huawei.com>
 <201809150710.kyiQ0EXh%fengguang.wu@intel.com>
Message-ID: <5B9CAAD2.70501@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/9/15 7:52, kbuild test robot wrote:
> Hi zhong,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on arm-soc/for-next]
> [also build test ERROR on v4.19-rc3 next-20180913]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/zhong-jiang/arm-common-use-match_string-helper-to-simplify-the-code/20180915-035510
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
> config: arm-multi_v5_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
>
> All errors (new ones prefixed by >>):
>
>    arch/arm/plat-orion/common.c: In function 'orion_ge00_switch_init':
>>> arch/arm/plat-orion/common.c:487:23: error: passing argument 1 of 'match_string' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
>                           ^
>    In file included from include/linux/bitmap.h:9:0,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/rcupdate.h:44,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from include/linux/platform_device.h:14,
>                     from arch/arm/plat-orion/common.c:13:
>    include/linux/string.h:184:5: note: expected 'const char * const*' but argument is of type 'char **'
>     int match_string(const char * const *array, size_t n, const char *string);
>         ^~~~~~~~~~~~
>    cc1: some warnings being treated as errors
I am sorry for that. :-[    Will repost in v2.

Thanks,
zhong jiang
> vim +/match_string +487 arch/arm/plat-orion/common.c
>
>    479	
>    480	void __init orion_ge00_switch_init(struct dsa_chip_data *d)
>    481	{
>    482		int index;
>    483	
>    484		if (!IS_BUILTIN(CONFIG_PHYLIB))
>    485			return;
>    486	
>  > 487		index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
>    488		if (index >= 0)
>    489			d->netdev[index] = &orion_ge00.dev;
>    490	
>    491		orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
>    492		orion_ge00_switch_board_info.platform_data = d;
>    493	
>    494		mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
>    495	}
>    496	#endif
>    497	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
