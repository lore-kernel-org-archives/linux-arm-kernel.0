From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 00:43:32 +0800
Subject: [PATCH v2 3/3] mfd: lm3533: Support initialization from Device
 Tree
In-Reply-To: <1445963373-27790-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <201510280043.8F7y835w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

[auto build test WARNING on ljones-mfd/for-mfd-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Andersson/devicetree-mfd-Add-binding-for-the-TI-LM3533/20151028-003248
config: x86_64-randconfig-x012-201543 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/mfd/lm3533-core.c:14:
   drivers/mfd/lm3533-core.c: In function 'lm3533_pdata_from_of_node':
   drivers/mfd/lm3533-core.c:830:8: error: implicit declaration of function 'of_node_cmp' [-Werror=implicit-function-declaration]
      if (!of_node_cmp(node->name, "als"))
           ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> drivers/mfd/lm3533-core.c:830:3: note: in expansion of macro 'if'
      if (!of_node_cmp(node->name, "als"))
      ^
   cc1: some warnings being treated as errors

vim +/if +830 drivers/mfd/lm3533-core.c

   814	
   815		ret = lm3533_of_parse_enum(dev->of_node, "ti,boost-freq-khz", freqs, 2);
   816		if (ret < 0) {
   817			dev_err(dev, "failed to parse ti,boost-freq-khz\n");
   818			return ret;
   819		}
   820		pdata->boost_freq = ret;
   821	
   822		ret = lm3533_of_parse_enum(dev->of_node, "ti,boost-ovp", ovps, 4);
   823		if (ret < 0) {
   824			dev_err(dev, "failed to parse ti,boost-ovp\n");
   825			return ret;
   826		}
   827		pdata->boost_ovp = ret;
   828	
   829		for_each_child_of_node(dev->of_node, node) {
 > 830			if (!of_node_cmp(node->name, "als"))
   831				ret = lm3533_of_parse_als_node(dev, node, pdata);
   832			else if (!of_node_cmp(node->name, "backlight"))
   833				ret = lm3533_of_parse_bl_node(dev, node, pdata);
   834			else if (!of_node_cmp(node->name, "led"))
   835				ret = lm3533_of_parse_led_node(dev, node, pdata);
   836	
   837			if (ret < 0) {
   838				of_node_put(node);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19618 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/4f7358ac/attachment-0001.obj>
