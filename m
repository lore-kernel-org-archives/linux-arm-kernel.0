From: lkp@intel.com (kbuild test robot)
Date: Tue, 19 Jun 2018 03:37:28 +0800
Subject: [PATCH v4 16/19] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180618145843.14631-17-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-17-paul.kocialkowski@bootlin.com>
Message-ID: <201806190344.YMXaZvnZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.18-rc1 next-20180618]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Kocialkowski/Sunxi-Cedrus-driver-for-the-Allwinner-Video-Engine-using-media-requests/20180619-020757
base:   git://linuxtv.org/media_tree.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/media/platform/sunxi/cedrus/cedrus_video.c: In function 'cedrus_stop_streaming':
>> drivers/media/platform/sunxi/cedrus/cedrus_video.c:434:3: error: implicit declaration of function 'v4l2_ctrl_request_complete'; did you mean 'v4l2_ctrl_replace'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_replace
>> drivers/media/platform/sunxi/cedrus/cedrus_video.c:434:43: error: 'struct vb2_buffer' has no member named 'req_obj'
      v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
                                              ^
   drivers/media/platform/sunxi/cedrus/cedrus_video.c: In function 'cedrus_buf_request_complete':
   drivers/media/platform/sunxi/cedrus/cedrus_video.c:452:31: error: 'struct vb2_buffer' has no member named 'req_obj'
     v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
                                  ^~
   drivers/media/platform/sunxi/cedrus/cedrus_video.c: At top level:
>> drivers/media/platform/sunxi/cedrus/cedrus_video.c:461:3: error: 'struct vb2_ops' has no member named 'buf_request_complete'
     .buf_request_complete = cedrus_buf_request_complete,
      ^~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/sunxi/cedrus/cedrus_video.c:461:26: warning: excess elements in struct initializer
     .buf_request_complete = cedrus_buf_request_complete,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/sunxi/cedrus/cedrus_video.c:461:26: note: (near initialization for 'cedrus_qops')
   cc1: some warnings being treated as errors
--
   drivers/media/platform/sunxi/cedrus/cedrus_dec.c: In function 'cedrus_device_run':
>> drivers/media/platform/sunxi/cedrus/cedrus_dec.c:91:28: error: 'struct vb2_buffer' has no member named 'req_obj'
     src_req = run.src->vb2_buf.req_obj.req;
                               ^
>> drivers/media/platform/sunxi/cedrus/cedrus_dec.c:94:3: error: implicit declaration of function 'v4l2_ctrl_request_setup'; did you mean 'v4l2_ctrl_handler_setup'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_setup(src_req, &ctx->hdl);
      ^~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_handler_setup
>> drivers/media/platform/sunxi/cedrus/cedrus_dec.c:123:3: error: implicit declaration of function 'v4l2_ctrl_request_complete'; did you mean 'v4l2_ctrl_replace'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_complete(src_req, &ctx->hdl);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_replace
   cc1: some warnings being treated as errors

vim +434 drivers/media/platform/sunxi/cedrus/cedrus_video.c

   413	
   414	static void cedrus_stop_streaming(struct vb2_queue *q)
   415	{
   416		struct cedrus_ctx *ctx = vb2_get_drv_priv(q);
   417		struct vb2_v4l2_buffer *vbuf;
   418		unsigned long flags;
   419	
   420		flush_scheduled_work();
   421		for (;;) {
   422			spin_lock_irqsave(&ctx->dev->irq_lock, flags);
   423	
   424			if (V4L2_TYPE_IS_OUTPUT(q->type))
   425				vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
   426			else
   427				vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
   428	
   429			spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
   430	
   431			if (vbuf == NULL)
   432				return;
   433	
 > 434			v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
   435						   &ctx->hdl);
   436			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
   437		}
   438	}
   439	
   440	static void cedrus_buf_queue(struct vb2_buffer *vb)
   441	{
   442		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
   443		struct cedrus_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
   444	
   445		v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
   446	}
   447	
   448	static void cedrus_buf_request_complete(struct vb2_buffer *vb)
   449	{
   450		struct cedrus_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
   451	
 > 452		v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
   453	}
   454	
   455	static struct vb2_ops cedrus_qops = {
   456		.queue_setup		= cedrus_queue_setup,
   457		.buf_prepare		= cedrus_buf_prepare,
   458		.buf_init		= cedrus_buf_init,
   459		.buf_cleanup		= cedrus_buf_cleanup,
   460		.buf_queue		= cedrus_buf_queue,
 > 461		.buf_request_complete	= cedrus_buf_request_complete,
   462		.stop_streaming		= cedrus_stop_streaming,
   463		.wait_prepare		= vb2_ops_wait_prepare,
   464		.wait_finish		= vb2_ops_wait_finish,
   465	};
   466	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65280 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/c08b77c7/attachment-0001.gz>
