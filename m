From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 Mar 2016 04:18:48 +0800
Subject: [PATCH 1/3] crypto: marvell/cesa - replace dma_to_phys with
 dma_map_single
In-Reply-To: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
Message-ID: <201603190432.0uju3pvU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.5 next-20160318]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/crypto-marvell-cesa-replace-dma_to_phys-with-dma_map_single/20160318-060640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/crypto/marvell/cesa.c: In function 'mv_cesa_get_sram':
>> drivers/crypto/marvell/cesa.c:354:21: error: macro "dma_map_single" requires 4 arguments, but only 3 given
           DMA_TO_DEVICE);
                        ^
>> drivers/crypto/marvell/cesa.c:353:21: error: 'dma_map_single' undeclared (first use in this function)
     engine->sram_dma = dma_map_single(cesa->dev, engine->sram,
                        ^
   drivers/crypto/marvell/cesa.c:353:21: note: each undeclared identifier is reported only once for each function it appears in

vim +/dma_map_single +354 drivers/crypto/marvell/cesa.c

   347			return -EINVAL;
   348	
   349		engine->sram = devm_ioremap_resource(cesa->dev, res);
   350		if (IS_ERR(engine->sram))
   351			return PTR_ERR(engine->sram);
   352	
 > 353		engine->sram_dma = dma_map_single(cesa->dev, engine->sram,
 > 354						  DMA_TO_DEVICE);
   355	
   356		return 0;
   357	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56216 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160319/21814c68/attachment-0001.obj>
