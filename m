From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 00:42:08 +0800
Subject: [stericsson:mmc-no-NULL 30/34] drivers/mmc/core/mmc_test.c:856:15:
 error: too many arguments to function 'mmc_start_areq'
Message-ID: <201702100059.4feyW6tA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   1bec9a625b256f78d00c38b58caad7ccdae8aaf5
commit: b46e8edc13f163392fd8f5ae2b27ef2f349fe457 [30/34] mmc: queue: stop flushing the pipeline with NULL
config: x86_64-randconfig-x014-201706 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout b46e8edc13f163392fd8f5ae2b27ef2f349fe457
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/mmc/core/mmc_test.c: In function 'mmc_test_nonblock_transfer':
>> drivers/mmc/core/mmc_test.c:856:15: error: too many arguments to function 'mmc_start_areq'
      done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
                  ^~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc_test.c:10:0:
   include/linux/mmc/core.h:163:5: note: declared here
    int mmc_start_areq(struct mmc_host *host,
        ^~~~~~~~~~~~~~
>> drivers/mmc/core/mmc_test.c:856:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
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

vim +/mmc_start_areq +856 drivers/mmc/core/mmc_test.c

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

:::::: The code at line 856 was first introduced by commit
:::::: 03259cfbc000b12e92ab10a8d6815d887cb2d8ae mmc: core: rename mmc_start_req() to *areq()

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21694 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/2c37302b/attachment-0001.gz>
