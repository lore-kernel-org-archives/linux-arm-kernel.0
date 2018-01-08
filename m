From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Jan 2018 07:13:29 +0800
Subject: [PATCH] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
In-Reply-To: <1515373733-3658-1-git-send-email-qi.hou@windriver.com>
References: <1515373733-3658-1-git-send-email-qi.hou@windriver.com>
Message-ID: <201801090643.8ChygjAc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Qi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on omap/for-next]
[also build test WARNING on v4.15-rc7 next-20180108]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Qi-Hou/arm-omap2-timer-fix-a-kmemleak-caused-in-omap_get_timer_dt/20180109-033316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
>> arch/arm/mach-omap2/timer.c:205:12: warning: return makes pointer from integer without a cast [-Wint-conversion]
        return -ENOMEM;
               ^

vim +205 arch/arm/mach-omap2/timer.c

   170	
   171	/**
   172	 * omap_get_timer_dt - get a timer using device-tree
   173	 * @match	- device-tree match structure for matching a device type
   174	 * @property	- optional timer property to match
   175	 *
   176	 * Helper function to get a timer during early boot using device-tree for use
   177	 * as kernel system timer. Optionally, the property argument can be used to
   178	 * select a timer with a specific property. Once a timer is found then mark
   179	 * the timer node in device-tree as disabled, to prevent the kernel from
   180	 * registering this timer as a platform device and so no one else can use it.
   181	 */
   182	static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
   183							     const char *property)
   184	{
   185		struct device_node *np;
   186	
   187		for_each_matching_node(np, match) {
   188			if (!of_device_is_available(np))
   189				continue;
   190	
   191			if (property && !of_get_property(np, property, NULL))
   192				continue;
   193	
   194			if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
   195					  of_get_property(np, "ti,timer-dsp", NULL) ||
   196					  of_get_property(np, "ti,timer-pwm", NULL) ||
   197					  of_get_property(np, "ti,timer-secure", NULL)))
   198				continue;
   199	
   200			if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
   201				struct property *prop;
   202	
   203				prop = kzalloc(sizeof(*prop), GFP_KERNEL);
   204				if (!prop)
 > 205					return -ENOMEM;
   206				prop->name = "status";
   207				prop->length = sizeof("disabled");
   208				prop->value = "disabled";
   209				of_add_property(np, prop);
   210			}
   211			return np;
   212		}
   213	
   214		return NULL;
   215	}
   216	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33066 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/116fcc7a/attachment-0001.gz>
