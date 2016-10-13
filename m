From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Oct 2016 21:26:03 +0800
Subject: [arm-soc:to-build 4/4] include/linux/buffer_head.h:340:16: warning:
 'bno' may be used uninitialized in this function
Message-ID: <201610132148.TWDi70Ia%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   346c22ea9cb8d0ee331c73529b205414e43a4655
commit: 346c22ea9cb8d0ee331c73529b205414e43a4655 [4/4] Revert "Disable "maybe-uninitialized" warning globally"
config: blackfin-BF526-EZBRD_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 346c22ea9cb8d0ee331c73529b205414e43a4655
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from fs/ext2/inode.c:32:0:
   fs/ext2/inode.c: In function 'ext2_get_block':
>> include/linux/buffer_head.h:340:16: warning: 'bno' may be used uninitialized in this function [-Wmaybe-uninitialized]
     bh->b_blocknr = block;
     ~~~~~~~~~~~~~~^~~~~~~
   fs/ext2/inode.c:783:6: note: 'bno' was declared here
     u32 bno;
         ^~~

vim +/bno +340 include/linux/buffer_head.h

bd7ade3c Nikolay Borisov  2015-07-02  324  sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
bd7ade3c Nikolay Borisov  2015-07-02  325  {
bd7ade3c Nikolay Borisov  2015-07-02  326  	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, gfp);
bd7ade3c Nikolay Borisov  2015-07-02  327  }
bd7ade3c Nikolay Borisov  2015-07-02  328  
^1da177e Linus Torvalds   2005-04-16  329  static inline struct buffer_head *
^1da177e Linus Torvalds   2005-04-16  330  sb_find_get_block(struct super_block *sb, sector_t block)
^1da177e Linus Torvalds   2005-04-16  331  {
^1da177e Linus Torvalds   2005-04-16  332  	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
^1da177e Linus Torvalds   2005-04-16  333  }
^1da177e Linus Torvalds   2005-04-16  334  
^1da177e Linus Torvalds   2005-04-16  335  static inline void
^1da177e Linus Torvalds   2005-04-16  336  map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
^1da177e Linus Torvalds   2005-04-16  337  {
^1da177e Linus Torvalds   2005-04-16  338  	set_buffer_mapped(bh);
^1da177e Linus Torvalds   2005-04-16  339  	bh->b_bdev = sb->s_bdev;
^1da177e Linus Torvalds   2005-04-16 @340  	bh->b_blocknr = block;
b0cf2321 Badari Pulavarty 2006-03-26  341  	bh->b_size = sb->s_blocksize;
^1da177e Linus Torvalds   2005-04-16  342  }
^1da177e Linus Torvalds   2005-04-16  343  
^1da177e Linus Torvalds   2005-04-16  344  static inline void wait_on_buffer(struct buffer_head *bh)
^1da177e Linus Torvalds   2005-04-16  345  {
^1da177e Linus Torvalds   2005-04-16  346  	might_sleep();
a9877cc2 Richard Kennedy  2010-08-09  347  	if (buffer_locked(bh))
^1da177e Linus Torvalds   2005-04-16  348  		__wait_on_buffer(bh);

:::::: The code at line 340 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14504 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161013/085a2c6b/attachment-0001.gz>
