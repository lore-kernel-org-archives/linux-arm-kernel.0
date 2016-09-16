From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Sep 2016 19:56:13 +0800
Subject: [PATCH] dmaengine: mv_xor: Add support for scatter-gather DMA mode
In-Reply-To: <20160916093518.14889-1-sr@denx.de>
Message-ID: <201609161945.4zey9JGT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc6 next-20160916]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Stefan-Roese/dmaengine-mv_xor-Add-support-for-scatter-gather-DMA-mode/20160916-175703
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/dma/mv_xor.c: In function 'mv_xor_prep_dma_sg':
>> drivers/dma/mv_xor.c:631:24: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
        "Transfer size of %d too small!\n", len);
                           ^
>> drivers/dma/mv_xor.c:641:9: error: implicit declaration of function 'mv_xor_add_io_win' [-Werror=implicit-function-declaration]
      ret = mv_xor_add_io_win(mv_chan, dma_dst);
            ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/mv_xor_add_io_win +641 drivers/dma/mv_xor.c

   625			len = min_t(size_t, len, MV_XOR_MAX_BYTE_COUNT);
   626			if (len == 0)
   627				goto fetch;
   628	
   629			if (len < MV_XOR_MIN_BYTE_COUNT) {
   630				dev_err(mv_chan_to_devp(mv_chan),
 > 631					"Transfer size of %d too small!\n", len);
   632				goto err;
   633			}
   634	
   635			dma_dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
   636				dst_avail;
   637			dma_src = sg_dma_address(src_sg) + sg_dma_len(src_sg) -
   638				src_avail;
   639	
   640			/* Check if a new window needs to get added for 'dst' */
 > 641			ret = mv_xor_add_io_win(mv_chan, dma_dst);
   642			if (ret)
   643				goto err;
   644	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55517 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/4e701470/attachment-0001.obj>
