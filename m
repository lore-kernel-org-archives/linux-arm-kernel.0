From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Dec 2016 21:41:01 +0800
Subject: [PATCH 3/3] mm: make pagoff_t type 64-bit
In-Reply-To: <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201612112100.I0lSZeL5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc8]
[cannot apply to mmotm/master next-20161209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/mm-move-argument-checkers-of-mmap_pgoff-to-separated-routine/20161211-211314
config: i386-randconfig-x003-201650 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   fs/ext2/dir.c: In function 'ext2_check_page':
>> fs/ext2/dir.c:177:56: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
      ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
                                                           ^
>> fs/ext2/dir.c:177:28: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'long long unsigned int' [-Wformat=]
      ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
                               ^
   fs/ext2/dir.c:187:28: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
       "entry in directory #%llu spans the page boundary"
                               ^
   fs/ext2/dir.c:187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
       "entry in directory #%llu spans the page boundary"
       ^

vim +177 fs/ext2/dir.c

   161	Eshort:
   162		error = "rec_len is smaller than minimal";
   163		goto bad_entry;
   164	Ealign:
   165		error = "unaligned directory entry";
   166		goto bad_entry;
   167	Enamelen:
   168		error = "rec_len is too small for name_len";
   169		goto bad_entry;
   170	Espan:
   171		error = "directory entry across blocks";
   172		goto bad_entry;
   173	Einumber:
   174		error = "inode out of bounds";
   175	bad_entry:
   176		if (!quiet)
 > 177			ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
   178				"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
   179				dir->i_ino, error, (page->index<<PAGE_SHIFT)+offs,
   180				(unsigned long) le32_to_cpu(p->inode),
   181				rec_len, p->name_len);
   182		goto fail;
   183	Eend:
   184		if (!quiet) {
   185			p = (ext2_dirent *)(kaddr + offs);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26862 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161211/8b3995f2/attachment-0001.gz>
