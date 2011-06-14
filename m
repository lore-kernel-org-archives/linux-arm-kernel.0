From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 14 Jun 2011 18:59:48 +0800
Subject: OMPA4: 3.0-rc1: Unhandled fault during insmod 'ohci-hcd.ko'
In-Reply-To: <BANLkTin=7aEaPDf=2Aa9SApdGetyvdz50g@mail.gmail.com>
References: <BANLkTinYcxJqUM4G2ERew3okUTdf0LOLGA@mail.gmail.com>
	<BANLkTin=7aEaPDf=2Aa9SApdGetyvdz50g@mail.gmail.com>
Message-ID: <BANLkTi=TPNWMe9_gb7SY2J62SC0L8EoRcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/6/5 Todd Poynor <toddpoynor@google.com>:
> In general, the imprecise external abort usually means an access was made to
> registers of a module whose clock is gated. ?The calls to clk_enable()
> within?usbhs_enable() probably aren't following the proper sequence of
> ensuring the CD_L3_INIT clock domain is on (CM_L3INIT_CLKSTCTRL.CLKTRCTRL =
> 0x2 SW_WKUP) and then the associated module slaves woken up
> (CM_L3INIT_HSUSBHOST_CLKCTRL.MODULEMODE = 0x2 Enabled, similar
> for?CM_L3INIT_HSUSBTLL_CLKCTRL). ?Probably needs calls to the OMAP device
> layer to set those up, but I dunno the details of this device or why it
> broke.
>

No doubt, it is caused by gated clock, ehci will be OK if revert the
commit below:

commit 7e6502d577106fb5b202bbaac64c5f1b065e6daa
Author: Keshava Munegowda <Keshava_mgowda@ti.com>
Date:   Sun May 22 22:51:26 2011 +0200

    mfd: Add omap-usbhs runtime PM support

    The usbhs core driver does not enable/disable the interface and
    functional clocks; These clocks are handled by hwmod and runtime pm,
    hence insted of the clock enable/disable, the runtime pm APIS are
    used. however,the port clocks and tll clocks are handled
    by the usbhs core.

    Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>


-- 
Ming Lei
