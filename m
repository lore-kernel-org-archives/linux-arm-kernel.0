From: lkp@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 16:38:23 +0800
Subject: [PATCH 4/4] [media] s5p-mfc: Always check and set
 'v4l2_pix_format:field' field
In-Reply-To: <20170209194314.5908-5-thibault.saunier@osg.samsung.com>
Message-ID: <201702101610.pswKdr2D%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thibault,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.10-rc7 next-20170210]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thibault-Saunier/exynos-gsc-Use-576p-instead-720p-as-a-threshold-for-colorspaces/20170210-113658
base:   git://linuxtv.org/media_tree.git master
config: openrisc-allmodconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

   drivers/media/platform/s5p-mfc/s5p_mfc_dec.c: In function 'vidioc_try_fmt':
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: warning: comparison between pointer and integer
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: warning: comparison with string literal results in unspecified behavior
   drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: error: expected ')' before 'pix_mp'
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: warning: too few arguments for format

vim +404 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c

   388		mfc_debug_leave();
   389		return 0;
   390	}
   391	
   392	/* Try format */
   393	static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
   394	{
   395		struct s5p_mfc_dev *dev = video_drvdata(file);
   396		struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
   397		struct s5p_mfc_fmt *fmt;
   398		enum v4l2_field field;
   399	
   400		field = f->fmt.pix.field;
   401		if (field == V4L2_FIELD_ANY) {
   402			field = V4L2_FIELD_NONE;
   403		} else if (V4L2_FIELD_NONE != field) {
 > 404			mfc_debug("Not supported field order(%d)\n", pix_mp->field);
   405			return -EINVAL;
   406		}
   407	
   408		/* V4L2 specification suggests the driver corrects the format struct
   409		 * if any of the dimensions is unsupported */
   410		f->fmt.pix.field = field;
   411	
   412		mfc_debug(2, "Type is %d\n", f->type);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40023 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/eac3a32b/attachment-0001.gz>
