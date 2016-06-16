From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 16 Jun 2016 18:28:16 +0800
Subject: [nomadik:pl08x-dma-mmc-sync-callback 5/5]
 drivers/mmc/host/mmci.c:235:4: note: in expansion of macro 'pr_info'
Message-ID: <201606161814.7XFbMAhu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git pl08x-dma-mmc-sync-callback
head:   42839b1b23fb2248fb6d305bfe956a1da8775392
commit: 42839b1b23fb2248fb6d305bfe956a1da8775392 [5/5] MMC uglyhack
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 42839b1b23fb2248fb6d305bfe956a1da8775392
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/mmc/host/mmci.c:11:
   drivers/mmc/host/mmci.c: In function 'mmci_dump_sg':
>> include/linux/kern_levels.h:4:18: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:13:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^
   include/linux/printk.h:271:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^
>> drivers/mmc/host/mmci.c:235:4: note: in expansion of macro 'pr_info'
       pr_info("addr: %p, length: %08x\n",
       ^
   drivers/mmc/host/mmci.c: At top level:
   drivers/mmc/host/mmci.c:226:13: warning: 'mmci_dump_sg' defined but not used [-Wunused-function]
    static void mmci_dump_sg(struct mmc_data *data)
                ^

vim +/pr_info +235 drivers/mmc/host/mmci.c

   219		.pwrreg_powerup		= MCI_PWR_UP,
   220		.f_max			= 208000000,
   221		.explicit_mclk_control	= true,
   222		.qcom_fifo		= true,
   223		.qcom_dml		= true,
   224	};
   225	
   226	static void mmci_dump_sg(struct mmc_data *data)
   227	{
   228	
   229		unsigned int flags = SG_MITER_ATOMIC | SG_MITER_FROM_SG;
   230		struct sg_mapping_iter miter;
   231	
   232		sg_miter_start(&miter, data->sg, data->sg_len, flags);
   233		do {
   234			if (miter.length > 0) {
 > 235				pr_info("addr: %p, length: %08x\n",
   236					miter.addr,
   237					miter.length);
   238				print_hex_dump(KERN_INFO, "data: ",
   239					DUMP_PREFIX_OFFSET, 16, 1,
   240					miter.addr, miter.length, true);
   241			}
   242		} while (sg_miter_next(&miter));
   243		sg_miter_stop(&miter);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25987 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/92cb84fb/attachment-0001.obj>
