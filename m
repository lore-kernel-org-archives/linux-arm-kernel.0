From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 9 Aug 2016 23:54:38 +0800
Subject: [rjarzmik:work/v4l2 5/14]
 drivers/media/platform/soc_camera/pxa_camera.c:742:18: error: initialization
 from incompatible pointer type
Message-ID: <201608092336.xjDWSTeR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/v4l2
head:   1646e167bd7bc014ad5c385e6a3be70d6670bbf9
commit: cce767df8b5328262c87e23ca7a5d74c17bcdad0 [5/14] media: platform: pxa_camera: convert to vb2
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cce767df8b5328262c87e23ca7a5d74c17bcdad0
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the rjarzmik/work/v4l2 HEAD 1646e167bd7bc014ad5c385e6a3be70d6670bbf9 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

>> drivers/media/platform/soc_camera/pxa_camera.c:742:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .queue_setup  = pxac_vb2_queue_setup,
                     ^
   drivers/media/platform/soc_camera/pxa_camera.c:742:18: note: (near initialization for 'pxac_vb2_ops.queue_setup')
   drivers/media/platform/soc_camera/pxa_camera.c: In function 'pxa_camera_probe':
>> drivers/media/platform/soc_camera/pxa_camera.c:1653:21: error: implicit declaration of function 'vb2_dma_sg_init_ctx' [-Werror=implicit-function-declaration]
     pcdev->alloc_ctx = vb2_dma_sg_init_ctx(&pdev->dev);
                        ^
>> drivers/media/platform/soc_camera/pxa_camera.c:1653:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     pcdev->alloc_ctx = vb2_dma_sg_init_ctx(&pdev->dev);
                      ^
   drivers/media/platform/soc_camera/pxa_camera.c: In function 'pxa_camera_remove':
>> drivers/media/platform/soc_camera/pxa_camera.c:1793:2: error: implicit declaration of function 'vb2_dma_sg_cleanup_ctx' [-Werror=implicit-function-declaration]
     vb2_dma_sg_cleanup_ctx(pcdev->alloc_ctx);
     ^
   cc1: some warnings being treated as errors

vim +742 drivers/media/platform/soc_camera/pxa_camera.c

   736	static void pxac_vb2_stop_streaming(struct vb2_queue *vq)
   737	{
   738		vb2_wait_for_all_buffers(vq);
   739	}
   740	
   741	static struct vb2_ops pxac_vb2_ops = {
 > 742		.queue_setup		= pxac_vb2_queue_setup,
   743		.buf_init		= pxac_vb2_init,
   744		.buf_prepare		= pxac_vb2_prepare,
   745		.buf_queue		= pxac_vb2_queue,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29839 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160809/06f49dc8/attachment-0001.obj>
