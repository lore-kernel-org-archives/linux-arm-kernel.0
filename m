From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 3 Feb 2017 05:43:08 +0800
Subject: [arm-soc:to-build 8/8] mm/nommu.c:1647:8: error: too few arguments
 to function 'do_munmap'
Message-ID: <201702030547.w7eixv2M%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   1bc74cf06c1d41d646677d9b50b60cb5c9d7eb18
commit: 1bc74cf06c1d41d646677d9b50b60cb5c9d7eb18 [8/8] fixup do_mmap/do_munmap prototype
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1bc74cf06c1d41d646677d9b50b60cb5c9d7eb18
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   mm/nommu.c: In function 'vm_munmap':
>> mm/nommu.c:1647:8: error: too few arguments to function 'do_munmap'
     ret = do_munmap(mm, addr, len);
           ^~~~~~~~~
   mm/nommu.c:1581:5: note: declared here
    int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list_head *uf)
        ^~~~~~~~~

vim +/do_munmap +1647 mm/nommu.c

bfce281c Al Viro       2012-04-20  1641  int vm_munmap(unsigned long addr, size_t len)
3034097a David Howells 2006-09-27  1642  {
bfce281c Al Viro       2012-04-20  1643  	struct mm_struct *mm = current->mm;
3034097a David Howells 2006-09-27  1644  	int ret;
3034097a David Howells 2006-09-27  1645  
3034097a David Howells 2006-09-27  1646  	down_write(&mm->mmap_sem);
3034097a David Howells 2006-09-27 @1647  	ret = do_munmap(mm, addr, len);
3034097a David Howells 2006-09-27  1648  	up_write(&mm->mmap_sem);
3034097a David Howells 2006-09-27  1649  	return ret;
3034097a David Howells 2006-09-27  1650  }

:::::: The code at line 1647 was first introduced by commit
:::::: 3034097a5017dd9281b1f795e80af9859627850e [PATCH] NOMMU: Order the per-mm_struct VMA list

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/dc4a4e6f/attachment-0001.gz>
