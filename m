From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Sep 2017 18:04:31 +0800
Subject: [PATCH v8 1/4] rockchip/rga: v4l2 m2m support
In-Reply-To: <1505126644-18396-2-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <201709131735.8RjddCdq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.13 next-20170913]
[cannot apply to rockchip/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/Add-Rockchip-RGA-V4l2-support/20170913-171106
base:   git://linuxtv.org/media_tree.git master
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/media/platform/rockchip-rga/rga.c: In function 'rga_setup_ctrls':
>> drivers/media/platform/rockchip-rga/rga.c:190:11: error: 'V4L2_CID_PORTER_DUFF_MODE' undeclared (first use in this function)
              V4L2_CID_PORTER_DUFF_MODE,
              ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga.c:190:11: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/media/platform/rockchip-rga/rga.c:191:11: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
              V4L2_PORTER_DUFF_CLEAR, 0,
              ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/rockchip-rga/rga.c:192:11: error: 'V4L2_PORTER_DUFF_SRC' undeclared (first use in this function)
              V4L2_PORTER_DUFF_SRC);
              ^~~~~~~~~~~~~~~~~~~~

vim +/V4L2_CID_PORTER_DUFF_MODE +190 drivers/media/platform/rockchip-rga/rga.c

   182	
   183	static int rga_setup_ctrls(struct rga_ctx *ctx)
   184	{
   185		struct rockchip_rga *rga = ctx->rga;
   186	
   187		v4l2_ctrl_handler_init(&ctx->ctrl_handler, 5);
   188	
   189		v4l2_ctrl_new_std_menu(&ctx->ctrl_handler, &rga_ctrl_ops,
 > 190				       V4L2_CID_PORTER_DUFF_MODE,
 > 191				       V4L2_PORTER_DUFF_CLEAR, 0,
 > 192				       V4L2_PORTER_DUFF_SRC);
   193	
   194		v4l2_ctrl_new_std(&ctx->ctrl_handler, &rga_ctrl_ops,
   195				  V4L2_CID_HFLIP, 0, 1, 1, 0);
   196	
   197		v4l2_ctrl_new_std(&ctx->ctrl_handler, &rga_ctrl_ops,
   198				  V4L2_CID_VFLIP, 0, 1, 1, 0);
   199	
   200		v4l2_ctrl_new_std(&ctx->ctrl_handler, &rga_ctrl_ops,
   201				  V4L2_CID_ROTATE, 0, 270, 90, 0);
   202	
   203		v4l2_ctrl_new_std(&ctx->ctrl_handler, &rga_ctrl_ops,
   204				  V4L2_CID_BG_COLOR, 0, 0xffffffff, 1, 0);
   205	
   206		if (ctx->ctrl_handler.error) {
   207			int err = ctx->ctrl_handler.error;
   208	
   209			v4l2_err(&rga->v4l2_dev, "%s failed\n", __func__);
   210			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
   211			return err;
   212		}
   213	
   214		return 0;
   215	}
   216	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51534 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/5180f18c/attachment-0001.gz>
