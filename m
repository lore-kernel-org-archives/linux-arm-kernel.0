From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Aug 2017 21:01:50 +0800
Subject: [PATCH v6 04/19] crypto: marvell/cesa: remove redundant backlog
 checks on EBUSY
In-Reply-To: <1503324309-13673-5-git-send-email-gilad@benyossef.com>
Message-ID: <201708242036.ODpqdw7q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilad,

[auto build test ERROR on cryptodev/master]
[also build test ERROR on v4.13-rc6 next-20170823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gilad-Ben-Yossef/crypto-change-transient-busy-return-code-to-EAGAIN/20170824-180606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/crypto/marvell/cesa.c: In function 'mv_cesa_queue_req':
>> drivers/crypto/marvell/cesa.c:187:3: error: expected ')' before 'mv_cesa_tdma_chain'
      mv_cesa_tdma_chain(engine, creq);
      ^~~~~~~~~~~~~~~~~~
>> drivers/crypto/marvell/cesa.c:196:1: error: expected expression before '}' token
    }
    ^
>> drivers/crypto/marvell/cesa.c:196:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +187 drivers/crypto/marvell/cesa.c

f63601fd6 Boris Brezillon  2015-06-18  176  
53da740fe Romain Perier    2016-06-21  177  int mv_cesa_queue_req(struct crypto_async_request *req,
53da740fe Romain Perier    2016-06-21  178  		      struct mv_cesa_req *creq)
f63601fd6 Boris Brezillon  2015-06-18  179  {
f63601fd6 Boris Brezillon  2015-06-18  180  	int ret;
bf8f91e71 Romain Perier    2016-06-21  181  	struct mv_cesa_engine *engine = creq->engine;
f63601fd6 Boris Brezillon  2015-06-18  182  
bf8f91e71 Romain Perier    2016-06-21  183  	spin_lock_bh(&engine->lock);
bf8f91e71 Romain Perier    2016-06-21  184  	ret = crypto_enqueue_request(&engine->queue, req);
603e989eb Romain Perier    2016-07-22  185  	if ((mv_cesa_req_get_type(creq) == CESA_DMA_REQ) &&
3a1c7473a Gilad Ben-Yossef 2017-08-21  186  	    (ret == -EINPROGRESS || ret == -EBUSY)
603e989eb Romain Perier    2016-07-22 @187  		mv_cesa_tdma_chain(engine, creq);
bf8f91e71 Romain Perier    2016-06-21  188  	spin_unlock_bh(&engine->lock);
f63601fd6 Boris Brezillon  2015-06-18  189  
f63601fd6 Boris Brezillon  2015-06-18  190  	if (ret != -EINPROGRESS)
f63601fd6 Boris Brezillon  2015-06-18  191  		return ret;
f63601fd6 Boris Brezillon  2015-06-18  192  
85030c516 Romain Perier    2016-06-21  193  	mv_cesa_rearm_engine(engine);
f63601fd6 Boris Brezillon  2015-06-18  194  
f63601fd6 Boris Brezillon  2015-06-18  195  	return -EINPROGRESS;
f63601fd6 Boris Brezillon  2015-06-18 @196  }
f63601fd6 Boris Brezillon  2015-06-18  197  

:::::: The code at line 187 was first introduced by commit
:::::: 603e989ebee21bfa9cddf8390d0515a07324edc8 crypto: marvell - Don't chain at DMA level when backlog is disabled

:::::: TO: Romain Perier <romain.perier@free-electrons.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63446 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/da621504/attachment-0001.gz>
