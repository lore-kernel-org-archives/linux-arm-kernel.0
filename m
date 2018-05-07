From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 May 2018 02:03:04 +0800
Subject: [PATCH v3 11/14] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
Message-ID: <201805080144.xOWDay7o%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.17-rc4 next-20180507]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Kocialkowski/Sunxi-Cedrus-driver-for-the-Allwinner-Video-Engine-using-media-requests/20180508-004955
base:   git://linuxtv.org/media_tree.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:205:3: error: 'const struct media_device_ops' has no member named 'req_validate'
     .req_validate = vb2_request_validate,
      ^~~~~~~~~~~~
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:205:18: error: 'vb2_request_validate' undeclared here (not in a function); did you mean 'vb2_queue_release'?
     .req_validate = vb2_request_validate,
                     ^~~~~~~~~~~~~~~~~~~~
                     vb2_queue_release
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:206:3: error: 'const struct media_device_ops' has no member named 'req_queue'
     .req_queue = vb2_m2m_request_queue,
      ^~~~~~~~~
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:206:15: error: 'vb2_m2m_request_queue' undeclared here (not in a function); did you mean 'v4l2_m2m_buf_queue'?
     .req_queue = vb2_m2m_request_queue,
                  ^~~~~~~~~~~~~~~~~~~~~
                  v4l2_m2m_buf_queue
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:206:15: warning: excess elements in struct initializer
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c:206:15: note: (near initialization for 'sunxi_cedrus_m2m_media_ops')
--
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c: In function 'sunxi_cedrus_stop_streaming':
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:437:3: error: implicit declaration of function 'v4l2_ctrl_request_complete'; did you mean 'v4l2_ctrl_replace'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_replace
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:437:43: error: 'struct vb2_buffer' has no member named 'req_obj'
      v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
                                              ^
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c: In function 'sunxi_cedrus_buf_request_complete':
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:455:31: error: 'struct vb2_buffer' has no member named 'req_obj'
     v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
                                  ^~
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c: At top level:
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:464:3: error: 'struct vb2_ops' has no member named 'buf_request_complete'
     .buf_request_complete = sunxi_cedrus_buf_request_complete,
      ^~~~~~~~~~~~~~~~~~~~
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:464:26: warning: excess elements in struct initializer
     .buf_request_complete = sunxi_cedrus_buf_request_complete,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_video.c:464:26: note: (near initialization for 'sunxi_cedrus_qops')
   cc1: some warnings being treated as errors
--
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_dec.c: In function 'sunxi_cedrus_device_run':
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_dec.c:100:28: error: 'struct vb2_buffer' has no member named 'req_obj'
     src_req = run.src->vb2_buf.req_obj.req;
                               ^
   drivers/media//platform/sunxi/cedrus/sunxi_cedrus_dec.c:101:28: error: 'struct vb2_buffer' has no member named 'req_obj'
     dst_req = run.dst->vb2_buf.req_obj.req;
                               ^
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_dec.c:104:3: error: implicit declaration of function 'v4l2_ctrl_request_setup'; did you mean 'v4l2_ctrl_handler_setup'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_setup(src_req, &ctx->hdl);
      ^~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_handler_setup
>> drivers/media//platform/sunxi/cedrus/sunxi_cedrus_dec.c:138:3: error: implicit declaration of function 'v4l2_ctrl_request_complete'; did you mean 'v4l2_ctrl_replace'? [-Werror=implicit-function-declaration]
      v4l2_ctrl_request_complete(src_req, &ctx->hdl);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      v4l2_ctrl_replace
   cc1: some warnings being treated as errors

vim +205 drivers/media//platform/sunxi/cedrus/sunxi_cedrus.c

   203	
   204	static const struct media_device_ops sunxi_cedrus_m2m_media_ops = {
 > 205		.req_validate = vb2_request_validate,
 > 206		.req_queue = vb2_m2m_request_queue,
   207	};
   208	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65363 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180508/495792c1/attachment-0001.gz>
