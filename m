From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Sep 2016 01:17:41 +0200
Subject: [PATCH 4/5] PM / devfreq: rockchip: add devfreq driver for rk3399
 dmc
In-Reply-To: <1472769085-20715-5-git-send-email-hl@rock-chips.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
 <1472769085-20715-5-git-send-email-hl@rock-chips.com>
Message-ID: <8339852.vAWNvCSMju@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. September 2016, 06:31:24 schrieb Lin Huang:
> base on dfi result, we do ddr frequency scaling, register
> dmc driver to devfreq framework, and use simple-ondemand
> policy.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: MyngJoo Ham <myngjoo.ham@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

[...]

> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> new file mode 100644
> index 0000000..54d65f2
> --- /dev/null
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -0,0 +1,480 @@
> +/*
> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd.
> + * Author: Lin Huang <hl@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for + * more details.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/devfreq.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/rwsem.h>
> +#include <linux/suspend.h>
> +
> +#include <soc/rockchip/rockchip_sip.h>

(Repeated from previous version)
For the shared sip-interface header I've prepared a signed, stable tag
which can be pulled from

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/rockchip-ddr-sip

for you to fetch changes up to 97dd82682f1a6174698fbea149a04b4cabc58c4f:

  soc: rockchip: add header for ddr rate SIP interface (2016-08-31 18:53:24 +0200)

----------------------------------------------------------------
Header file defining the SIP-interface to the ATF for DDR frequency changes

----------------------------------------------------------------
Lin Huang (1):
      soc: rockchip: add header for ddr rate SIP interface

 include/soc/rockchip/rockchip_sip.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/soc/rockchip/rockchip_sip.h
