From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Jun 2016 08:46:52 +0800
Subject: [PATCHv5] support for AD5820 camera auto-focus coil
In-Reply-To: <20160527205140.GA26767@amd>
Message-ID: <201606050830.NN5YOQm1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.7-rc1 next-20160603]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Machek/support-for-AD5820-camera-auto-focus-coil/20160528-045306
base:   git://linuxtv.org/media_tree.git master
config: sh-allyesconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers/media/i2c/ad5820.c: In function 'ad5820_set_ctrl':
>> drivers/media/i2c/ad5820.c:168:7: error: 'V4L2_CID_FOCUS_AD5820_RAMP_TIME' undeclared (first use in this function)
     case V4L2_CID_FOCUS_AD5820_RAMP_TIME:
          ^
   drivers/media/i2c/ad5820.c:168:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/i2c/ad5820.c:174:7: error: 'V4L2_CID_FOCUS_AD5820_RAMP_MODE' undeclared (first use in this function)
     case V4L2_CID_FOCUS_AD5820_RAMP_MODE:
          ^
   drivers/media/i2c/ad5820.c: At top level:
>> drivers/media/i2c/ad5820.c:194:10: error: 'V4L2_CID_FOCUS_AD5820_RAMP_TIME' undeclared here (not in a function)
      .id  = V4L2_CID_FOCUS_AD5820_RAMP_TIME,
             ^
>> drivers/media/i2c/ad5820.c:205:10: error: 'V4L2_CID_FOCUS_AD5820_RAMP_MODE' undeclared here (not in a function)
      .id  = V4L2_CID_FOCUS_AD5820_RAMP_MODE,
             ^
   drivers/media/i2c/ad5820.c:321:12: warning: 'ad5820_suspend' defined but not used [-Wunused-function]
    static int ad5820_suspend(struct device *dev)
               ^
   drivers/media/i2c/ad5820.c:333:12: warning: 'ad5820_resume' defined but not used [-Wunused-function]
    static int ad5820_resume(struct device *dev)
               ^

vim +/V4L2_CID_FOCUS_AD5820_RAMP_TIME +168 drivers/media/i2c/ad5820.c

   162	
   163		switch (ctrl->id) {
   164		case V4L2_CID_FOCUS_ABSOLUTE:
   165			coil->focus_absolute = ctrl->val;
   166			return ad5820_update_hw(coil);
   167	
 > 168		case V4L2_CID_FOCUS_AD5820_RAMP_TIME:
   169			code = RAMP_US_TO_CODE(ctrl->val);
   170			ctrl->val = CODE_TO_RAMP_US(code);
   171			coil->focus_ramp_time = ctrl->val;
   172			break;
   173	
   174		case V4L2_CID_FOCUS_AD5820_RAMP_MODE:
   175			coil->focus_ramp_mode = ctrl->val;
   176			break;
   177		}
   178	
   179		return 0;
   180	}
   181	
   182	static const struct v4l2_ctrl_ops ad5820_ctrl_ops = {
   183		.s_ctrl = ad5820_set_ctrl,
   184	};
   185	
   186	static const char * const ad5820_focus_menu[] = {
   187		"Linear ramp",
   188		"64/16 ramp",
   189	};
   190	
   191	static const struct v4l2_ctrl_config ad5820_ctrls[] = {
   192		{
   193			.ops		= &ad5820_ctrl_ops,
 > 194			.id		= V4L2_CID_FOCUS_AD5820_RAMP_TIME,
   195			.type		= V4L2_CTRL_TYPE_INTEGER,
   196			.name		= "Focus ramping time [us]",
   197			.min		= 0,
   198			.max		= 3200,
   199			.step		= 50,
   200			.def		= 0,
   201			.flags		= 0,
   202		},
   203		{
   204			.ops		= &ad5820_ctrl_ops,
 > 205			.id		= V4L2_CID_FOCUS_AD5820_RAMP_MODE,
   206			.type		= V4L2_CTRL_TYPE_MENU,
   207			.name		= "Focus ramping mode",
   208			.min		= 0,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39262 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160605/d6e47d54/attachment-0001.obj>
