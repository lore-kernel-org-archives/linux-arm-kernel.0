From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 1 Sep 2011 09:37:53 +0800
Subject: [PATCH v3 1/2] mmc: sdio add regulator vsdio
In-Reply-To: <CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
References: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
	<1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
	<CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
Message-ID: <CAMj5Bkh99bkQPX01h_WLnyOP_whdZx=WS-wfG1DB2b32STcTeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 10:06 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Zhangfei,
>
> My understanding is that the card in the slot would be either MMC _or_
> SDIO and why do we need another regulator for the power on/off?
>
Hi, Eric

vsdio is used for dynamically power control to sdio, for example
application dynamically disable/enable wifi.
Then mmc_start/stop_host and mmc_power_up/down could directly power
on/off sdio via mmc_set_ios.
This also workable with runtime PM, which already introduced into mmc by Ohad.

vmmc is used to statically provided power to sd or vmmc.

Daniel once suggested reusing vmmc, however we found CD pin requires
vmmc to be alwayes on.
If vmmc is dynamically power off, CD pin will be low, which indicating
card is inserted by mistake.
For example when no card inserted, CD pin will high -> host fail to
detect sd card -> vmmc disabled in set_ios -> host thought card
inserted -> irq happen -> host redetect card ->

If there is concern of vsdio in sdhci.c, how about moving vsdio to
specific driver via call back.

Thanks
