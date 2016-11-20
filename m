From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 20 Nov 2016 14:28:50 +0100 (CET)
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <1479644869.2653.3.camel@embedded.rocks>
References: <1479644869.2653.3.camel@embedded.rocks>
Message-ID: <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

> J?rg Krause <joerg.krause@embedded.rocks> hat am 20. November 2016 um 13:27
> geschrieben:
> 
> 
> Hi,
> 
> I started the discussion on this mailing list in another thread [1],
> but I'd like to move it to a new thread, because it might be mmc
> specific.
> 
> The issue is that I am noticed low wifi network throughput on an i.MX28
> board with the mainline kernel (v4.7.10, about 6 Mbps) compared to the
> vendor kernel (Freescale v2.6.35.3, about 20 Mbps). The wifi chip is
> attached using the SDIO interface.
> 
> I started investigation where the bottleneck in the mainline
> kernel?might come from. Therefore I checked that the configs and
> settings for the interfaces and drivers are the same. They are.

so you're not using the mxs_defconfig settings anymore? Better provide your
settings because there are differences between the vendor defconfig and mainline
defconfig.

Examples:

Vendor updater defconfig (2.6.35) - [1]

CONFIG_PREEMPTY_NONE=y
CONFIG_DEFAULT_IOSCHED="noop"

Vendor defconfig (2.6.35) - [2]

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_DEFAULT_IOSCHED="cfq"

Mainline defconfig (4.8) - [3]

CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_DEFAULT_IOSCHED="noop"

[1] -
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/configs/imx28evk_updater_defconfig?h=imx_2.6.35_maintain
[2] -
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/configs/imx28evk_defconfig?h=imx_2.6.35_maintain
[3] - http://lxr.free-electrons.com/source/arch/arm/configs/mxs_defconfig?v=4.8
