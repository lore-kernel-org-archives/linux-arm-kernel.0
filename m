From: lkp@intel.com (kbuild test robot)
Date: Fri, 3 Feb 2017 03:17:47 +0800
Subject: [PATCH] log2: make order_base_2() behave correctly on const
 input value zero
In-Reply-To: <1486055052-6442-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <201702030317.pRCTSSWg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.10-rc6 next-20170202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/log2-make-order_base_2-behave-correctly-on-const-input-value-zero/20170203-012201
config: x86_64-randconfig-s2-02030209 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/drm_bufs.c: In function 'drm_addmap_core':
>> drivers/gpu/drm/drm_bufs.c:239: warning: format '%d' expects type 'int', but argument 5 has type 'long unsigned int'

vim +239 drivers/gpu/drm/drm_bufs.c

^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  223  		break;
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  224  	case _DRM_SHM:
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  225  		list = drm_find_matching_map(dev, map);
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  226  		if (list != NULL) {
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  227  			if(list->map->size != map->size) {
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  228  				DRM_DEBUG("Matching maps of type %d with "
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  229  					  "mismatched sizes, (%ld vs %ld)\n",
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  230  					  map->type, map->size, list->map->size);
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  231  				list->map->size = map->size;
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  232  			}
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  233  
9a298b2ac drivers/gpu/drm/drm_bufs.c  Eric Anholt      2009-03-24  234  			kfree(map);
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  235  			*maplist = list;
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  236  			return 0;
54ba2f76e drivers/char/drm/drm_bufs.c Dave Airlie      2007-02-10  237  		}
f239b7b0c drivers/char/drm/drm_bufs.c Thomas Hellstrom 2007-01-08  238  		map->handle = vmalloc_user(map->size);
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16 @239  		DRM_DEBUG("%lu %d %p\n",
04420c9c6 drivers/gpu/drm/drm_bufs.c  Daniel Vetter    2013-07-10  240  			  map->size, order_base_2(map->size), map->handle);
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  241  		if (!map->handle) {
9a298b2ac drivers/gpu/drm/drm_bufs.c  Eric Anholt      2009-03-24  242  			kfree(map);
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  243  			return -ENOMEM;
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  244  		}
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  245  		map->offset = (unsigned long)map->handle;
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  246  		if (map->flags & _DRM_CONTAINS_LOCK) {
^1da177e4 drivers/char/drm/drm_bufs.c Linus Torvalds   2005-04-16  247  			/* Prevent a 2nd X Server from creating a 2nd lock */

:::::: The code at line 239 was first introduced by commit
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
Size: 30294 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/4da86cbc/attachment-0001.gz>
