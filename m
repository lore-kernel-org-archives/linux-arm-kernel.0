From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 03:59:46 +0800
Subject: [xlnx:master 120/172] drivers/media/i2c/ad9389b.c:950:28: error:
 'struct ad9389b_state' has no member named 'work_queue'
Message-ID: <201702070328.DEd33YPS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   b11f1d3fcb6195933acc39b8d26891847a5ea24d
commit: 1e7078305158539e8432fc62e62d547a59d98f2b [120/172] Merge tag 'v4.9' into master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1e7078305158539e8432fc62e62d547a59d98f2b
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/media/i2c/ad9389b.c: In function 'ad9389b_check_monitor_present_status':
>> drivers/media/i2c/ad9389b.c:950:28: error: 'struct ad9389b_state' has no member named 'work_queue'
       queue_delayed_work(state->work_queue,
                               ^~

vim +950 drivers/media/i2c/ad9389b.c

117a55b6 Hans Verkuil         2012-07-18  934  	if ((status & MASK_AD9389B_HPD_DETECT) &&
117a55b6 Hans Verkuil         2012-07-18  935  	    ((status & MASK_AD9389B_MSEN_DETECT) || state->edid.segments)) {
117a55b6 Hans Verkuil         2012-07-18  936  		v4l2_dbg(1, debug, sd,
117a55b6 Hans Verkuil         2012-07-18  937  				"%s: hotplug and (rx-sense or edid)\n", __func__);
117a55b6 Hans Verkuil         2012-07-18  938  		if (!state->have_monitor) {
117a55b6 Hans Verkuil         2012-07-18  939  			v4l2_dbg(1, debug, sd, "%s: monitor detected\n", __func__);
117a55b6 Hans Verkuil         2012-07-18  940  			state->have_monitor = true;
117a55b6 Hans Verkuil         2012-07-18  941  			ad9389b_set_isr(sd, true);
117a55b6 Hans Verkuil         2012-07-18  942  			if (!ad9389b_s_power(sd, true)) {
117a55b6 Hans Verkuil         2012-07-18  943  				v4l2_dbg(1, debug, sd,
117a55b6 Hans Verkuil         2012-07-18  944  					"%s: monitor detected, powerup failed\n", __func__);
117a55b6 Hans Verkuil         2012-07-18  945  				return;
117a55b6 Hans Verkuil         2012-07-18  946  			}
117a55b6 Hans Verkuil         2012-07-18  947  			ad9389b_setup(sd);
117a55b6 Hans Verkuil         2012-07-18  948  			ad9389b_notify_monitor_detect(sd);
117a55b6 Hans Verkuil         2012-07-18  949  			state->edid.read_retries = EDID_MAX_RETRIES;
117a55b6 Hans Verkuil         2012-07-18 @950  			queue_delayed_work(state->work_queue,
117a55b6 Hans Verkuil         2012-07-18  951  					&state->edid_handler, EDID_DELAY);
117a55b6 Hans Verkuil         2012-07-18  952  		}
117a55b6 Hans Verkuil         2012-07-18  953  	} else if (status & MASK_AD9389B_HPD_DETECT) {
117a55b6 Hans Verkuil         2012-07-18  954  		v4l2_dbg(1, debug, sd, "%s: hotplug detected\n", __func__);
117a55b6 Hans Verkuil         2012-07-18  955  		state->edid.read_retries = EDID_MAX_RETRIES;
969ac39e Bhaktipriya Shridhar 2016-07-16  956  		schedule_delayed_work(&state->edid_handler, EDID_DELAY);
117a55b6 Hans Verkuil         2012-07-18  957  	} else if (!(status & MASK_AD9389B_HPD_DETECT)) {
117a55b6 Hans Verkuil         2012-07-18  958  		v4l2_dbg(1, debug, sd, "%s: hotplug not detected\n", __func__);

:::::: The code at line 950 was first introduced by commit
:::::: 117a55b69d36a19028d1c59a737ad1246a0a75ad [media] ad9389b: driver for the Analog Devices AD9389B video encoder

:::::: TO: Hans Verkuil <hans.verkuil@cisco.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45372 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/0275ed43/attachment-0001.gz>
