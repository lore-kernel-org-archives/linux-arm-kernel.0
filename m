From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Apr 2016 15:50:38 +0800
Subject: [PATCH v7 6/8] [media] vcodec: mediatek: Add Mediatek VP8 Video
 Encoder Driver
In-Reply-To: <1461299131-57851-7-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <201604221555.2coNqrLX%fengguang.wu@intel.com>
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

   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c: In function 'vp8_enc_alloc_work_buf':
>> drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:214:35: warning: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]
   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c: In function 'vp8_enc_compose_one_frame':
>> drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:279:10: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
      mtk_vcodec_err(inst, "bitstream buf size is too small(%ld)",
             ^

vim +214 drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c

   208				tmp_va = vpu_mapping_dm_addr(inst->vpu_inst.dev,
   209							     wb[i].vpua);
   210				memcpy(inst->work_bufs[i].va, tmp_va, wb[i].size);
   211			}
   212			wb[i].iova = inst->work_bufs[i].dma_addr;
   213	
 > 214			mtk_vcodec_debug(inst,
   215					 "work_bufs[%d] va=0x%p,iova=0x%p,size=0x%lx",
   216					 i, inst->work_bufs[i].va,
   217					 (void *)inst->work_bufs[i].dma_addr,
   218					 inst->work_bufs[i].size);
   219		}
   220	
   221		mtk_vcodec_debug_leave(inst);
   222	
   223		return ret;
   224	
   225	err_alloc:
   226		vp8_enc_free_work_buf(inst);
   227	
   228		return ret;
   229	}
   230	
   231	static unsigned int vp8_enc_wait_venc_done(struct venc_vp8_inst *inst)
   232	{
   233		unsigned int irq_status = 0;
   234		struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)inst->ctx;
   235	
   236		if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
   237						  WAIT_INTR_TIMEOUT_MS)) {
   238			irq_status = ctx->irq_status;
   239			mtk_vcodec_debug(inst, "isr return %x", irq_status);
   240		}
   241		return irq_status;
   242	}
   243	
   244	/*
   245	 * Compose ac_tag, bitstream header and bitstream payload into
   246	 * one bitstream buffer.
   247	 */
   248	static int vp8_enc_compose_one_frame(struct venc_vp8_inst *inst,
   249					     struct mtk_vcodec_mem *bs_buf,
   250					     unsigned int *bs_size)
   251	{
   252		unsigned int not_key;
   253		u32 bs_frm_size;
   254		u32 bs_hdr_len;
   255		unsigned int ac_tag_size;
   256		u8 ac_tag[MAX_AC_TAG_SIZE];
   257	
   258		bs_frm_size = vp8_enc_read_reg(inst, VENC_BITSTREAM_FRAME_SIZE);
   259		bs_hdr_len = vp8_enc_read_reg(inst, VENC_BITSTREAM_HEADER_LEN);
   260	
   261		/* if a frame is key frame, not_key is 0 */
   262		not_key = !inst->vpu_inst.is_key_frm;
   263		*(u32 *)ac_tag = __cpu_to_le32((bs_hdr_len << 5) | 0x10 | not_key);
   264		/* key frame */
   265		if (not_key == 0) {
   266			ac_tag_size = MAX_AC_TAG_SIZE;
   267			ac_tag[3] = 0x9d;
   268			ac_tag[4] = 0x01;
   269			ac_tag[5] = 0x2a;
   270			ac_tag[6] = inst->vsi->config.pic_w;
   271			ac_tag[7] = inst->vsi->config.pic_w >> 8;
   272			ac_tag[8] = inst->vsi->config.pic_h;
   273			ac_tag[9] = inst->vsi->config.pic_h >> 8;
   274		} else {
   275			ac_tag_size = 3;
   276		}
   277	
   278		if (bs_buf->size < bs_hdr_len + bs_frm_size + ac_tag_size) {
 > 279			mtk_vcodec_err(inst, "bitstream buf size is too small(%ld)",
   280				       bs_buf->size);
   281			return -EINVAL;
   282		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53783 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/3257aecd/attachment-0001.obj>
