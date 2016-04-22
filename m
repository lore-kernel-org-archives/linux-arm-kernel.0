From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Apr 2016 15:37:09 +0800
Subject: [PATCH v7 5/8] [media] vcodec: mediatek: Add Mediatek V4L2 Video
 Encoder Driver
In-Reply-To: <1461299131-57851-6-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <201604221515.RY9dD5v0%fengguang.wu@intel.com>
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

   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c: In function 'mtk_venc_encode_header':
>> drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:896:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 9 has type 'size_t {aka unsigned int}' [-Wformat=]
   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c: In function 'mtk_venc_worker':
   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]
   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 10 has type 'size_t {aka unsigned int}' [-Wformat=]
   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 13 has type 'size_t {aka unsigned int}' [-Wformat=]

vim +896 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c

   880		struct mtk_vcodec_ctx *ctx = priv;
   881		int ret;
   882		struct vb2_buffer *dst_buf;
   883		struct mtk_vcodec_mem bs_buf;
   884		struct venc_done_result enc_result;
   885	
   886		dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
   887		if (!dst_buf) {
   888			mtk_v4l2_debug(1, "No dst buffer");
   889			return -EINVAL;
   890		}
   891	
   892		bs_buf.va = vb2_plane_vaddr(dst_buf, 0);
   893		bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
   894		bs_buf.size = (size_t)dst_buf->planes[0].length;
   895	
 > 896		mtk_v4l2_debug(1,
   897				"[%d] buf idx=%d va=0x%p dma_addr=0x%llx size=0x%lx",
   898				ctx->idx,
   899				dst_buf->index, bs_buf.va,
   900				(u64)bs_buf.dma_addr,
   901				bs_buf.size);
   902	
   903		ret = venc_if_encode(ctx,
   904				VENC_START_OPT_ENCODE_SEQUENCE_HEADER,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53783 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/6f18a246/attachment-0001.obj>
