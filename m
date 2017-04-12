From: lkp@intel.com (kbuild test robot)
Date: Wed, 12 Apr 2017 08:20:11 +0800
Subject: [PATCH 1/5] arm64: memory-hotplug: Add MEMORY_HOTPLUG,
 MEMORY_HOTREMOVE, MEMORY_PROBE
In-Reply-To: <2edd1a6b64ea9b4c9b8126d840844d624fe8e0d4.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <201704120813.8PdAklR2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc6]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrea-Reale/Memory-hotplug-support-for-arm64-complete-patchset/20170412-022242
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Andrea-Reale/Memory-hotplug-support-for-arm64-complete-patchset/20170412-022242 HEAD bffdda51b562ca7bb9baf7642e14c8d03d44602d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `memory_probe_store':
>> drivers/base/memory.c:501: undefined reference to `memory_add_physaddr_to_nid'
   drivers/base/memory.c:501:(.text+0x1a5ef8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `memory_add_physaddr_to_nid'

vim +501 drivers/base/memory.c

3947be19 Dave Hansen         2005-10-29  485  #ifdef CONFIG_ARCH_MEMORY_PROBE
3947be19 Dave Hansen         2005-10-29  486  static ssize_t
10fbcf4c Kay Sievers         2011-12-21  487  memory_probe_store(struct device *dev, struct device_attribute *attr,
28812fe1 Andi Kleen          2010-01-05  488  		   const char *buf, size_t count)
3947be19 Dave Hansen         2005-10-29  489  {
3947be19 Dave Hansen         2005-10-29  490  	u64 phys_addr;
cb5490a5 John Allen          2016-01-14  491  	int nid, ret;
61b94fea Anton Blanchard     2011-09-15  492  	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
3947be19 Dave Hansen         2005-10-29  493  
b69deb2b Zhang Zhen          2014-08-06  494  	ret = kstrtoull(buf, 0, &phys_addr);
b69deb2b Zhang Zhen          2014-08-06  495  	if (ret)
b69deb2b Zhang Zhen          2014-08-06  496  		return ret;
3947be19 Dave Hansen         2005-10-29  497  
61b94fea Anton Blanchard     2011-09-15  498  	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
61b94fea Anton Blanchard     2011-09-15  499  		return -EINVAL;
61b94fea Anton Blanchard     2011-09-15  500  
bc02af93 Yasunori Goto       2006-06-27 @501  	nid = memory_add_physaddr_to_nid(phys_addr);
6add7cd6 Nathan Fontenot     2011-01-31  502  	ret = add_memory(nid, phys_addr,
cb5490a5 John Allen          2016-01-14  503  			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
cb5490a5 John Allen          2016-01-14  504  
6add7cd6 Nathan Fontenot     2011-01-31  505  	if (ret)
9f0af69b Nikanth Karthikesan 2011-03-24  506  		goto out;
6add7cd6 Nathan Fontenot     2011-01-31  507  
9f0af69b Nikanth Karthikesan 2011-03-24  508  	ret = count;
9f0af69b Nikanth Karthikesan 2011-03-24  509  out:

:::::: The code at line 501 was first introduced by commit
:::::: bc02af93dd2bbddce1b55e0a493f833a1b7cf140 [PATCH] pgdat allocation for new node add (specify node id)

:::::: TO: Yasunori Goto <y-goto@jp.fujitsu.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34552 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/736f7a6b/attachment-0001.gz>
