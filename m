From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Apr 2016 16:05:48 +0800
Subject: [PATCH v7 7/8] [media] vcodec: mediatek: Add Mediatek H264 Video
 Encoder Driver
In-Reply-To: <1461299131-57851-8-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <201604221647.1smOH44j%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.6-rc4 next-20160421]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tiffany-Lin/Add-MT8173-Video-Encoder-Driver-and-VPU-Driver/20160422-123111
base:   git://linuxtv.org/media_tree.git master
config: i386-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c: In function 'h264_enc_alloc_work_buf':
>> drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:299:35: warning: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]

vim +299 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c

   283				 * This RC_CODE is pre-allocated by VPU and saved in VPU
   284				 * addr. So we need use memcpy to copy RC_CODE from VPU
   285				 * addr into IO virtual addr in 'iova' field for reg
   286				 * setting in VPU side.
   287				 */
   288				if (i == VENC_H264_VPU_WORK_BUF_RC_CODE) {
   289					void *tmp_va;
   290	
   291					tmp_va = vpu_mapping_dm_addr(inst->vpu_inst.dev,
   292								     wb[i].vpua);
   293					memcpy(inst->work_bufs[i].va, tmp_va,
   294					       wb[i].size);
   295				}
   296			}
   297			wb[i].iova = inst->work_bufs[i].dma_addr;
   298	
 > 299			mtk_vcodec_debug(inst,
   300					 "work_buf[%d] va=0x%p iova=0x%p size=0x%lx",
   301					 i, inst->work_bufs[i].va,
   302					 (void *)inst->work_bufs[i].dma_addr,
   303					 inst->work_bufs[i].size);
   304		}
   305	
   306		/* the pps_buf is used by AP side only */
   307		inst->pps_buf.size = 128;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53783 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/a978aaf8/attachment-0001.obj>
