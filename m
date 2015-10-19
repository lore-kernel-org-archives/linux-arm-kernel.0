From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Oct 2015 06:07:01 +0800
Subject: [RFC PATCH v3 4/4] drm/armada: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1445267270-23126-5-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201510200618.NEUoP2ho%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

[auto build test WARNING on drm/drm-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Liviu-Dudau/drm-Introduce-generic-probe-function-for-component-based-masters/20151019-231229
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/armada/armada_drv.c: In function 'armada_drm_probe':
>> drivers/gpu/drm/armada/armada_drv.c:291:4: warning: passing argument 2 of 'component_match_add' from incompatible pointer type
       component_match_add(&pdev->dev, match, compare_dev_name,
       ^
   In file included from drivers/gpu/drm/armada/armada_drv.c:9:0:
   include/linux/component.h:36:6: note: expected 'struct component_match **' but argument is of type 'struct component_match *'
    void component_match_add(struct device *, struct component_match **,
         ^
>> drivers/gpu/drm/armada/armada_drv.c:304:6: warning: passing argument 2 of 'armada_add_endpoints' from incompatible pointer type
         armada_add_endpoints(&pdev->dev, match,
         ^
   drivers/gpu/drm/armada/armada_drv.c:247:13: note: expected 'struct component_match **' but argument is of type 'struct component_match *'
    static void armada_add_endpoints(struct device *dev,
                ^

vim +/component_match_add +291 drivers/gpu/drm/armada/armada_drv.c

   285			char **devices = pdev->dev.platform_data;
   286			struct device_node *port;
   287			struct device *d;
   288			int i;
   289	
   290			for (i = 0; devices[i]; i++)
 > 291				component_match_add(&pdev->dev, match, compare_dev_name,
   292						    devices[i]);
   293	
   294			if (i == 0) {
   295				dev_err(&pdev->dev, "missing 'ports' property\n");
   296				return -ENODEV;
   297			}
   298	
   299			for (i = 0; devices[i]; i++) {
   300				d = bus_find_device_by_name(&platform_bus_type, NULL,
   301							    devices[i]);
   302				if (d && d->of_node) {
   303					for_each_child_of_node(d->of_node, port)
 > 304						armada_add_endpoints(&pdev->dev, match,
   305								     port);
   306				}
   307				put_device(d);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53739 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/28920948/attachment-0001.obj>
