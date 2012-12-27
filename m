From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 27 Dec 2012 07:43:28 +0000
Subject: [imx:work/efikasb 5/29] drivers/usb/chipidea/core.c:323:4:
 warning: large integer implicitly truncated to unsigned type
In-Reply-To: <50ce2697.0463bOWc8yxBEQL0%fengguang.wu@intel.com>
References: <50ce2697.0463bOWc8yxBEQL0%fengguang.wu@intel.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803D58AAD@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixed at my tree: https://github.com/hzpeterchen/linux-usb.git

 
> 
> tree:   git://git.pengutronix.de/git/imx/linux-2.6.git work/efikasb
> head:   4de30514cbd7126ba06062e39ba4701f2bca1a37
> commit: 012289b901c5e60b6f0d215cef44697dc71b5d76 [5/29] usb: chipidea:
> add otg id switch and vbus connect/disconnect detect
> config: make ARCH=x86_64 allyesconfig
> 
> All warnings:
> 
> drivers/usb/chipidea/core.c: In function 'ci_handle_id_switch':
> drivers/usb/chipidea/core.c:323:4: warning: large integer implicitly
> truncated to unsigned type [-Woverflow]
> 
> vim +323 drivers/usb/chipidea/core.c
> 
> 012289b9 Peter Chen         2012-11-19  307
> 012289b9 Peter Chen         2012-11-19  308  	}
> 012289b9 Peter Chen         2012-11-19  309  }
> 012289b9 Peter Chen         2012-11-19  310
> 012289b9 Peter Chen         2012-11-19  311  static void
> ci_handle_id_switch(struct ci13xxx *ci)
> 5f36e231 Alexander Shishkin 2012-05-11  312  {
> 5f36e231 Alexander Shishkin 2012-05-11  313  	enum ci_role role =
> ci_otg_role(ci);
> 5f36e231 Alexander Shishkin 2012-05-11  314
> 5f36e231 Alexander Shishkin 2012-05-11  315  	if (role != ci->role) {
> 5f36e231 Alexander Shishkin 2012-05-11  316  		dev_dbg(ci->dev,
> "switching from %s to %s\n",
> 5f36e231 Alexander Shishkin 2012-05-11  317  			ci_role(ci)-
> >name, ci->roles[role]->name);
> 5f36e231 Alexander Shishkin 2012-05-11  318
> 012289b9 Peter Chen         2012-11-19  319  		/* 1. Finish the
> current role */
> 012289b9 Peter Chen         2012-11-19  320  		if (ci->role ==
> CI_ROLE_GADGET) {
> 012289b9 Peter Chen         2012-11-19  321
> 	usb_gadget_vbus_disconnect(&ci->gadget);
> 012289b9 Peter Chen         2012-11-19  322  			/* host
> doesn't care B_SESSION_VALID event */
> 012289b9 Peter Chen         2012-11-19 @323  			hw_write(ci,
> OP_OTGSC, OTGSC_BSVIE, ~OTGSC_BSVIE);
> 012289b9 Peter Chen         2012-11-19  324  			hw_write(ci,
> OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
> 012289b9 Peter Chen         2012-11-19  325  			ci->role =
> CI_ROLE_END;
> 012289b9 Peter Chen         2012-11-19  326  			/* reset
> controller */
> 012289b9 Peter Chen         2012-11-19  327
> 	hw_device_reset(ci, USBMODE_CM_IDLE);
> 012289b9 Peter Chen         2012-11-19  328  		} else if (ci->role
> == CI_ROLE_HOST) {
> 012289b9 Peter Chen         2012-11-19  329
> 	ci_role_stop(ci);
> 012289b9 Peter Chen         2012-11-19  330  			/* reset
> controller */
> 012289b9 Peter Chen         2012-11-19  331
> 	hw_device_reset(ci, USBMODE_CM_IDLE);
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation
