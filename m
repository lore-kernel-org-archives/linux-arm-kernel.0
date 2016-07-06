From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Jul 2016 18:22:10 +0800
Subject: [PATCH v6 01/18] remoteproc: st_slim_rproc: add a slimcore rproc
 driver
In-Reply-To: <1467795276-21725-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <201607061839.LWqagDPP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.7-rc6 next-20160706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160706-170304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-allyesconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   drivers/remoteproc/st_slim_rproc.c: In function 'slim_rproc_alloc':
>> drivers/remoteproc/st_slim_rproc.c:288:10: warning: assignment discards 'const' qualifier from pointer target type
     elf_ops = rproc->fw_ops;
             ^

vim +/const +288 drivers/remoteproc/st_slim_rproc.c

   272		if (WARN_ON(!np || !fw_name))
   273			return ERR_PTR(-EINVAL);
   274	
   275		if (!of_device_is_compatible(np, "st,slim-rproc"))
   276			return ERR_PTR(-EINVAL);
   277	
   278		rproc = rproc_alloc(dev, np->name, &slim_rproc_ops,
   279				fw_name, sizeof(*slim_rproc));
   280		if (!rproc)
   281			return ERR_PTR(-ENOMEM);
   282	
   283		rproc->has_iommu = false;
   284	
   285		slim_rproc = rproc->priv;
   286		slim_rproc->rproc = rproc;
   287	
 > 288		elf_ops = rproc->fw_ops;
   289		/* Use some generic elf ops */
   290		slim_rproc_fw_ops.load = elf_ops->load;
   291		slim_rproc_fw_ops.sanity_check = elf_ops->sanity_check;
   292	
   293		rproc->fw_ops = &slim_rproc_fw_ops;
   294	
   295		/* get imem and dmem */
   296		for (i = 0; i < ARRAY_SIZE(mem_names); i++) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37201 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160706/0d1cf197/attachment-0001.obj>
