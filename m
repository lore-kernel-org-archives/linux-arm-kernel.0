From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 29 Apr 2016 13:14:54 +0200
Subject: [PATCH v9 0/8] Add MT8173 Video Encoder Driver and VPU Driver
In-Reply-To: <1461661117-4657-1-git-send-email-tiffany.lin@mediatek.com>
References: <1461661117-4657-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <5723422E.4030109@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tiffany,

On 04/26/2016 10:58 AM, Tiffany Lin wrote:
> ==============
>  Introduction
> ==============
> 
> The purpose of this series is to add the driver for video codec hw embedded in the Mediatek's MT8173 SoCs.
> Mediatek Video Codec is able to handle video encoding of in a range of formats.
> 
> This patch series also include VPU driver. Mediatek Video Codec driver rely on VPU driver to load,
> communicate with VPU.
> 
> Internally the driver uses videobuf2 framework and MTK IOMMU and MTK SMI both have been merged in v4.6-rc1.
> 
> ==================
>  Device interface
> ==================
> 
> In principle the driver bases on v4l2 memory-to-memory framework:
> it provides a single video node and each opened file handle gets its own private context with separate
> buffer queues. Each context consist of 2 buffer queues: OUTPUT (for source buffers, i.e. raw video
> frames) and CAPTURE (for destination buffers, i.e. encoded video frames).
> 
> ==============================
>  VPU (Video Processor Unit)
> ==============================
> The VPU driver for hw video codec embedded in Mediatek's MT8173 SOCs.
> It is able to handle video decoding/encoding in a range of formats.
> The driver provides with VPU firmware download, memory management and the communication interface between CPU and VPU.
> For VPU initialization, it will create virtual memory for CPU access and physical address for VPU hw device access. 
> When a decode/encode instance opens a device node, vpu driver will download vpu firmware to the device.
> A decode/encode instant will decode/encode a frame using VPU interface to interrupt vpu to handle decoding/encoding jobs.
> 
> Please have a look at the code and comments will be very much appreciated.

I build this using my daily build setup and got a bunch of errors and warnings
from both the compiler (when this driver is compile-tested on a 32 bit arch)
and from sparse/smatch.

Can you fix these?

linux-git-i686: WARNINGS

/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c: In function 'load_requested_vpu':
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:498:117: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:498:117: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t {aka unsigned int}' [-Wformat=]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:501:410: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/venc_vpu_if.c: In function 'vpu_enc_ipi_handler':
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/venc_vpu_if.c:40:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  struct venc_vpu_inst *vpu = (struct venc_vpu_inst *)msg->venc_inst;
                              ^
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c: In function 'mtk_venc_worker':
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 10 has type 'size_t {aka unsigned int}' [-Wformat=]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:1046:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 13 has type 'size_t {aka unsigned int}' [-Wformat=]

Tip: use %zu or %zx for size_t.

sparse: ERRORS
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:261:24: warning: incorrect type in assignment (different base types)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:476:23: warning: symbol 'get_vp8_enc_comm_if' was not declared. Should it be static?
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:237:6: warning: symbol 'vpu_clock_disable' was not declared. Should it be static?
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:250:5: warning: symbol 'vpu_clock_enable' was not declared. Should it be static?
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:436:54: warning: incorrect type in return expression (different address spaces)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:504:14: warning: incorrect type in assignment (different address spaces)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:710:26: warning: cast removes address space of expression
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:674:23: warning: symbol 'get_h264_enc_comm_if' was not declared. Should it be static?
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:804:41: warning: Using plain integer as NULL pointer
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:905:25: warning: Using plain integer as NULL pointer
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:989:50: warning: Using plain integer as NULL pointer
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:133:15: error: undefined identifier 'kzalloc'
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:206:9: error: undefined identifier 'kfree'
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:228:9: error: undefined identifier 'kfree'
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:548:6: warning: 'vpu_fw' may be used uninitialized in this function [-Wmaybe-uninitialized]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:133:8: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:133:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:206:2: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]

smatch: ERRORS
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:921 mtk_venc_encode_header() warn: inconsistent indenting
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:397 vpu_wdt_reg_handler() warn: variable dereferenced before check 'vpu' (see line 395)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vpu/mtk_vpu.c:398 vpu_wdt_reg_handler() error: we previously assumed 'vpu' could be null (see line 397)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:142 fops_vcodec_open() error: we previously assumed 'ctx' could be null (see line 134)
/home/hans/work/build/media-git/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:363 mtk_vcodec_probe() warn: passing zero to 'PTR_ERR'

Thanks!

	Hans
