From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Nov 2015 02:17:21 +0800
Subject: [PATCH v3] crypto: atmel: fix bogus select
In-Reply-To: <12173927.U7ILfy5BBh@wuerfel>
Message-ID: <201511190227.fHF3LVfw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on: cryptodev/master]
[also build test WARNING on: v4.4-rc1 next-20151118]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/crypto-atmel-fix-bogus-select/20151118-233706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: tile-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All warnings (new ones prefixed by >>):

   drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
>> drivers/crypto/atmel-aes.c:191:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_start':
   drivers/crypto/atmel-aes.c:447:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   drivers/crypto/atmel-aes.c:448:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
>> drivers/crypto/atmel-aes.c:642:5: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t' [-Wformat]
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_buff_init':
>> drivers/crypto/atmel-aes.c:669:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' [-Wformat]
   drivers/crypto/atmel-aes.c:677:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' [-Wformat]

vim +191 drivers/crypto/atmel-aes.c

bd3c7b5c Nicolas Royer 2012-07-01  175  
bd3c7b5c Nicolas Royer 2012-07-01  176  		sg_list = sg_next(sg_list);
bd3c7b5c Nicolas Royer 2012-07-01  177  		if (!sg_list)
bd3c7b5c Nicolas Royer 2012-07-01  178  			total = 0;
bd3c7b5c Nicolas Royer 2012-07-01  179  	}
bd3c7b5c Nicolas Royer 2012-07-01  180  
bd3c7b5c Nicolas Royer 2012-07-01  181  	return sg_nb;
bd3c7b5c Nicolas Royer 2012-07-01  182  }
bd3c7b5c Nicolas Royer 2012-07-01  183  
cadc4ab8 Nicolas Royer 2013-02-20  184  static int atmel_aes_sg_copy(struct scatterlist **sg, size_t *offset,
cadc4ab8 Nicolas Royer 2013-02-20  185  			void *buf, size_t buflen, size_t total, int out)
cadc4ab8 Nicolas Royer 2013-02-20  186  {
cadc4ab8 Nicolas Royer 2013-02-20  187  	unsigned int count, off = 0;
cadc4ab8 Nicolas Royer 2013-02-20  188  
cadc4ab8 Nicolas Royer 2013-02-20  189  	while (buflen && total) {
cadc4ab8 Nicolas Royer 2013-02-20  190  		count = min((*sg)->length - *offset, total);
cadc4ab8 Nicolas Royer 2013-02-20 @191  		count = min(count, buflen);
cadc4ab8 Nicolas Royer 2013-02-20  192  
cadc4ab8 Nicolas Royer 2013-02-20  193  		if (!count)
cadc4ab8 Nicolas Royer 2013-02-20  194  			return off;
cadc4ab8 Nicolas Royer 2013-02-20  195  
cadc4ab8 Nicolas Royer 2013-02-20  196  		scatterwalk_map_and_copy(buf + off, *sg, *offset, count, out);
cadc4ab8 Nicolas Royer 2013-02-20  197  
cadc4ab8 Nicolas Royer 2013-02-20  198  		off += count;
cadc4ab8 Nicolas Royer 2013-02-20  199  		buflen -= count;

:::::: The code at line 191 was first introduced by commit
:::::: cadc4ab8f6f73719ef0e124320cdd210d1c9ff3e crypto: atmel-aes - add support for latest release of the IP (0x130)

:::::: TO: Nicolas Royer <nicolas@eukrea.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42162 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/8f974c02/attachment-0001.obj>
