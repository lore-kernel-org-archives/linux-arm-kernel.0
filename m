From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 02:58:49 +0800
Subject: [stericsson:mmc-no-NULL 30/34] drivers/mmc/core/mmc_test.c:856:43:
 sparse: too many arguments for function mmc_start_areq
Message-ID: <201702100242.aQMdcviN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   1bec9a625b256f78d00c38b58caad7ccdae8aaf5
commit: b46e8edc13f163392fd8f5ae2b27ef2f349fe457 [30/34] mmc: queue: stop flushing the pipeline with NULL
reproduce:
        # apt-get install sparse
        git checkout b46e8edc13f163392fd8f5ae2b27ef2f349fe457
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/mmc/core/mmc_test.c:856:43: sparse: too many arguments for function mmc_start_areq
   drivers/mmc/core/mmc_test.c:875:35: sparse: too many arguments for function mmc_start_areq
   drivers/mmc/core/mmc_test.c:2405:31: sparse: too many arguments for function mmc_start_areq
   drivers/mmc/core/mmc_test.c:2443:31: sparse: too many arguments for function mmc_start_areq
   drivers/mmc/core/mmc_test.c: In function 'mmc_test_nonblock_transfer':
   drivers/mmc/core/mmc_test.c:856:15: error: too many arguments to function 'mmc_start_areq'
      done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
                  ^~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc_test.c:10:0:
   include/linux/mmc/core.h:163:5: note: declared here
    int mmc_start_areq(struct mmc_host *host,
        ^~~~~~~~~~~~~~
   drivers/mmc/core/mmc_test.c:856:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
                ^
   drivers/mmc/core/mmc_test.c:875:14: error: too many arguments to function 'mmc_start_areq'
     done_areq = mmc_start_areq(test->card->host, NULL, &status);
                 ^~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc_test.c:10:0:
   include/linux/mmc/core.h:163:5: note: declared here
    int mmc_start_areq(struct mmc_host *host,
        ^~~~~~~~~~~~~~
   drivers/mmc/core/mmc_test.c:875:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     done_areq = mmc_start_areq(test->card->host, NULL, &status);
               ^
   drivers/mmc/core/mmc_test.c: In function 'mmc_test_ongoing_transfer':
   drivers/mmc/core/mmc_test.c:2405:3: error: too many arguments to function 'mmc_start_areq'
      mmc_start_areq(host, &test_areq.areq, &blkstat);
      ^~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc_test.c:10:0:
   include/linux/mmc/core.h:163:5: note: declared here
    int mmc_start_areq(struct mmc_host *host,
        ^~~~~~~~~~~~~~
   drivers/mmc/core/mmc_test.c:2443:3: error: too many arguments to function 'mmc_start_areq'
      mmc_start_areq(host, NULL, &blkstat);
      ^~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc_test.c:10:0:
   include/linux/mmc/core.h:163:5: note: declared here
    int mmc_start_areq(struct mmc_host *host,
        ^~~~~~~~~~~~~~

vim +856 drivers/mmc/core/mmc_test.c

16652a93 drivers/mmc/card/mmc_test.c Dan Carpenter 2016-11-14  840  	int ret = RESULT_OK;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  841  
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  842  	test_areq[0].test = test;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  843  	test_areq[1].test = test;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  844  
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  845  	mmc_test_nonblock_reset(&mrq1, &cmd1, &stop1, &data1);
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  846  	mmc_test_nonblock_reset(&mrq2, &cmd2, &stop2, &data2);
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  847  
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  848  	cur_areq->mrq = &mrq1;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  849  	cur_areq->err_check = mmc_test_check_result_async;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  850  	other_areq->mrq = &mrq2;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  851  	other_areq->err_check = mmc_test_check_result_async;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  852  
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  853  	for (i = 0; i < count; i++) {
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  854  		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  855  				     blocks, blksz, write);
03259cfb drivers/mmc/core/mmc_test.c Linus Walleij 2017-01-24 @856  		done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  857  
8e8b3f51 drivers/mmc/card/mmc_test.c Linus Walleij 2016-11-04  858  		if (status != MMC_BLK_SUCCESS || (!done_areq && i > 0)) {
8e8b3f51 drivers/mmc/card/mmc_test.c Linus Walleij 2016-11-04  859  			ret = RESULT_FAIL;
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  860  			goto err;
8e8b3f51 drivers/mmc/card/mmc_test.c Linus Walleij 2016-11-04  861  		}
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  862  
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  863  		if (done_areq) {
9f9c4180 drivers/mmc/card/mmc_test.c Per Forlin    2011-07-01  864  			if (done_areq->mrq == &mrq2)

:::::: The code at line 856 was first introduced by commit
:::::: 03259cfbc000b12e92ab10a8d6815d887cb2d8ae mmc: core: rename mmc_start_req() to *areq()

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
