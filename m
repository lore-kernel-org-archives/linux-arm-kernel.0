From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Nov 2016 10:44:27 +0800
Subject: [arm-soc:to-build 12/13] drivers/block/rbd.c:3690:5: warning:
 'struct_v' may be used uninitialized in this function
Message-ID: <201611101012.DLJRSQBL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   694200c14d09069de036d1b4269b582b3118f575
commit: 3becf66c6faa12e51bd6d97df3706c8bef1b65d6 [12/13] Kbuild: enable -Wmaybe-uninitialized warnings by default
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3becf66c6faa12e51bd6d97df3706c8bef1b65d6
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/block/rbd.c: In function 'rbd_watch_cb':
>> drivers/block/rbd.c:3690:5: warning: 'struct_v' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (struct_v >= 2) {
        ^
   drivers/block/rbd.c:3759:5: note: 'struct_v' was declared here
     u8 struct_v;
        ^

vim +/struct_v +3690 drivers/block/rbd.c

ed95b21a Ilya Dryomov 2016-08-12  3674  	} else {
ed95b21a Ilya Dryomov 2016-08-12  3675  		down_read(&rbd_dev->lock_rwsem);
ed95b21a Ilya Dryomov 2016-08-12  3676  	}
ed95b21a Ilya Dryomov 2016-08-12  3677  
ed95b21a Ilya Dryomov 2016-08-12  3678  	if (!__rbd_is_lock_owner(rbd_dev))
ed95b21a Ilya Dryomov 2016-08-12  3679  		wake_requests(rbd_dev, false);
ed95b21a Ilya Dryomov 2016-08-12  3680  	up_read(&rbd_dev->lock_rwsem);
ed95b21a Ilya Dryomov 2016-08-12  3681  }
ed95b21a Ilya Dryomov 2016-08-12  3682  
ed95b21a Ilya Dryomov 2016-08-12  3683  static bool rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
ed95b21a Ilya Dryomov 2016-08-12  3684  				    void **p)
ed95b21a Ilya Dryomov 2016-08-12  3685  {
ed95b21a Ilya Dryomov 2016-08-12  3686  	struct rbd_client_id my_cid = rbd_get_cid(rbd_dev);
ed95b21a Ilya Dryomov 2016-08-12  3687  	struct rbd_client_id cid = { 0 };
ed95b21a Ilya Dryomov 2016-08-12  3688  	bool need_to_send;
ed95b21a Ilya Dryomov 2016-08-12  3689  
ed95b21a Ilya Dryomov 2016-08-12 @3690  	if (struct_v >= 2) {
ed95b21a Ilya Dryomov 2016-08-12  3691  		cid.gid = ceph_decode_64(p);
ed95b21a Ilya Dryomov 2016-08-12  3692  		cid.handle = ceph_decode_64(p);
ed95b21a Ilya Dryomov 2016-08-12  3693  	}
ed95b21a Ilya Dryomov 2016-08-12  3694  
ed95b21a Ilya Dryomov 2016-08-12  3695  	dout("%s rbd_dev %p cid %llu-%llu\n", __func__, rbd_dev, cid.gid,
ed95b21a Ilya Dryomov 2016-08-12  3696  	     cid.handle);
ed95b21a Ilya Dryomov 2016-08-12  3697  	if (rbd_cid_equal(&cid, &my_cid))
ed95b21a Ilya Dryomov 2016-08-12  3698  		return false;

:::::: The code at line 3690 was first introduced by commit
:::::: ed95b21a4b0a71ef89306cdeb427d53cc9cb343f rbd: support for exclusive-lock feature

:::::: TO: Ilya Dryomov <idryomov@gmail.com>
:::::: CC: Ilya Dryomov <idryomov@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47027 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/0247dbdf/attachment-0001.gz>
