From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 11 Jan 2016 17:57:47 +0800
Subject: [PATCH 1/1] USB: core: let USB device know device node
In-Reply-To: <201601111658.gmkaFolV%fengguang.wu@intel.com>
References: <1452501535-8580-1-git-send-email-peter.chen@freescale.com>
 <201601111658.gmkaFolV%fengguang.wu@intel.com>
Message-ID: <20160111095747.GA9239@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 04:54:21PM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on v4.4 next-20160108]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Chen/USB-core-let-USB-device-know-device-node/20160111-164533
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: x86_64-randconfig-x002-201602 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/compiler.h:56:0,
>                     from include/uapi/linux/stddef.h:1,
>                     from include/linux/stddef.h:4,
>                     from include/uapi/linux/posix_types.h:4,
>                     from include/uapi/linux/types.h:13,
>                     from include/linux/types.h:5,
>                     from include/linux/list.h:4,
>                     from include/linux/module.h:9,
>                     from drivers/usb/core/usb.c:24:
> >> include/linux/compiler-gcc.h:73:17: error: expected '{' before 'inline'
>     #define inline  inline  __attribute__((always_inline)) notrace
>                     ^
> >> include/linux/usb/of.h:36:8: note: in expansion of macro 'inline'
>     struct inline device_node * usb_of_get_child_node(struct device_node *parent,
>            ^

Would anybody explain what does above mean, thanks.
I just can't reproduce it at my env.

>    drivers/usb/core/usb.c: In function 'usb_alloc_dev':
> >> drivers/usb/core/usb.c:512:22: error: implicit declaration of function 'usb_of_get_child_node' [-Werror=implicit-function-declaration]
>       dev->dev.of_node = usb_of_get_child_node
>                          ^
> >> drivers/usb/core/usb.c:512:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>       dev->dev.of_node = usb_of_get_child_node
>                        ^
>    cc1: some warnings being treated as errors
> 
> vim +/usb_of_get_child_node +512 drivers/usb/core/usb.c
> 
>    506		if (root_hub) {	/* Root hub always ok [and always wired] */
>    507			dev->authorized = 1;
>    508			dev->of_node = bus->controller->of_node;
>    509		} else {
>    510			dev->authorized = !!HCD_DEV_AUTHORIZED(usb_hcd);
>    511			dev->wusb = usb_bus_is_wusb(bus) ? 1 : 0;
>  > 512			dev->dev.of_node = usb_of_get_child_node
>    513				(parent->of_node, dev->portnum);
>    514		}
>    515		return dev;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 

Best Regards,
Peter Chen
