From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Tue, 06 Sep 2016 04:37:54 +0000
Subject: =?UTF-8?B?UkU6IFtQQVRDSCB2MTAgNS81XSBkcm0vcm9ja2NoaXA6IEFk?=
 =?UTF-8?B?ZCBkbWMgbm90aWZpZXIgaW4gdm9wIGRyaXZlcg==?=
References: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
 <CGME20160905050631epcas1p4ebe75a5f119132f583a5020187382026@epcas1p4.samsung.com>
Message-ID: <705204681.416743.1473136674125.JavaMail.weblogic@ep1ml102b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> when in ddr frequency scaling process, vop can not do enable or
> disable operation, since in dcf we check vop clock to see whether
> vop work. If vop work, dcf do ddr frequency scaling when vop
> in vblank status, and we need to read vop register to check whether
> vop go into vblank status. If vop not work, dcf can do ddr frequency
> any time. So when do ddr frequency scaling, you disabled or enable
> vop, there may two bad thing happen: 1, the panel flicker(when vop from
> disable status change to enable). 2, kernel hang (when vop from enable
> status change to disable, dcf need to read vblank status, but if you disable
> vop clock, it can not get the status, it will lead soc dead) So we need
> register to devfreq notifier, and we can get the dmc status. Also, when
> there have two vop enabled, we need to disable dmc, since dcf only base
> on one vop vblank time, so the other panel will flicker when do ddr
> frequency scaling.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


The code looks fine, but I've just found that I cannot merge this
code as I am not handling drivers/gpu/drm.

Please try to merge this piece into drivers/gpu/drm tree.

For the other 4 piecies (1/5 to 4/5) I'm ok with them. I'm merging them now.


> ---
> Changes in v10:
> - None
> 
> Changes in v9:
> - None
> 
> Changes in v8:
> - None
> 
> Changes in v7:
> - None
> 
> Changes in v6:
> - fix a build error
> 
> Changes in v5:
> - improve some nits
> 
> Changes in v4:
> - register notifier to devfreq_register_notifier
> - use DEVFREQ_PRECHANGE and DEVFREQ_POSTCHANGE to get dmc status
> - when two vop enable, disable dmc
> - when two vop back to one vop, enable dmc
> 
> Changes in v3:
> - when do vop eanble/disable, dmc will wait until it finish
> 
> Changes in v2:
> - None
> 
> Changes in v1:
> - use wait_event instead usleep
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 116 ++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
