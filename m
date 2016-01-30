From: lkp@intel.com (kbuild test robot)
Date: Sun, 31 Jan 2016 03:27:07 +0800
Subject: [PATCH 1/4] [media] s5p-mfc: Add handling of buffer freeing
 reqbufs request
In-Reply-To: <1454180017-29071-2-git-send-email-ayaka@soulik.info>
Message-ID: <201601310345.Cap6NnJl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ayaka,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.5-rc1 next-20160129]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/ayaka/s5p-mfc-Add-handling-of-buffer-freeing-reqbufs-request/20160131-030651
base:   git://linuxtv.org/media_tree.git master
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/media/platform/s5p-mfc/s5p_mfc_enc.c: In function 'vidioc_reqbufs':
>> drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1141:4: error: implicit declaration of function 's5p_mfc_hw_call_void' [-Werror=implicit-function-declaration]
       s5p_mfc_hw_call_void(dev->mfc_ops, release_codec_buffers,
       ^
>> drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1141:39: error: 'release_codec_buffers' undeclared (first use in this function)
       s5p_mfc_hw_call_void(dev->mfc_ops, release_codec_buffers,
                                          ^
   drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1141:39: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/s5p_mfc_hw_call_void +1141 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c

  1135			(reqbufs->memory != V4L2_MEMORY_USERPTR))
  1136			return -EINVAL;
  1137		if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
  1138			if (reqbufs->count == 0) {
  1139				mfc_debug(2, "Freeing buffers\n");
  1140				ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
> 1141				s5p_mfc_hw_call_void(dev->mfc_ops, release_codec_buffers,
  1142						ctx);
  1143				ctx->capture_state = QUEUE_FREE;
  1144				return ret;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44066 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160131/7271d1c6/attachment-0001.obj>
