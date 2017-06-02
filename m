From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 2 Jun 2017 08:31:21 +0200
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <b8bcdc78-12a1-9c3d-58ac-b53fe829dd80@baylibre.com>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <b8bcdc78-12a1-9c3d-58ac-b53fe829dd80@baylibre.com>
Message-ID: <a1aef75d-74f2-d45a-c5ac-57fc13c6be9e@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2017 03:47 PM, Neil Armstrong wrote:
> On 05/30/2017 04:23 PM, Russell King wrote:
>> Add a CEC driver for the dw-hdmi hardware.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/Kconfig       |   8 +
>>   drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 320 ++++++++++++++++++++++++++
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  19 ++
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  40 +++-
>>   5 files changed, 387 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>>   create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
>> index 40d2827a6d19..bd30a0a07272 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
>> +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
>> @@ -21,3 +21,11 @@ config DRM_DW_HDMI_I2S_AUDIO
>>   	help
>>   	  Support the I2S Audio interface which is part of the Synopsys
>>   	  Designware HDMI block.
>> +
>> +config DRM_DW_HDMI_CEC
>> +	tristate "Synopsis Designware CEC interface"
>> +	depends on DRM_DW_HDMI && MEDIA_CEC_SUPPORT
>> +	select MEDIA_CEC_NOTIFIER
>> +	help
>> +	  Support the CE interface which is part of the Synopsis
>> +	  Designware HDMI block.
>> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
>> index 17aa7a65b57e..6fe415903668 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
>> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
>> @@ -3,3 +3,4 @@
>>   obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>>   obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>>   obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o
>> +obj-$(CONFIG_DRM_DW_HDMI_CEC) += dw-hdmi-cec.o
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>> new file mode 100644
>> index 000000000000..761ef5ae687d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>> @@ -0,0 +1,320 @@
>> +/*
>> + * Designware HDMI CEC driver
>> + *
>> + * Copyright (C) 2015-2017 Russell King.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +
>> +#include <drm/drm_edid.h>
>> +
>> +#include <media/cec.h>
>> +#include <media/cec-notifier.h>
>> +
>> +#include "dw-hdmi-cec.h"
>> +
>> +enum {
>> +	HDMI_IH_CEC_STAT0	= 0x0106,
>> +	HDMI_IH_MUTE_CEC_STAT0	= 0x0186,
>> +
>> +	HDMI_CEC_CTRL		= 0x7d00,
>> +	CEC_CTRL_START		= BIT(0),
>> +	CEC_CTRL_NORMAL		= 1 << 1,
>> +
>> +	HDMI_CEC_STAT		= 0x7d01,
>> +	CEC_STAT_DONE		= BIT(0),
>> +	CEC_STAT_EOM		= BIT(1),
>> +	CEC_STAT_NACK		= BIT(2),
>> +	CEC_STAT_ARBLOST	= BIT(3),
>> +	CEC_STAT_ERROR_INIT	= BIT(4),
>> +	CEC_STAT_ERROR_FOLL	= BIT(5),
>> +	CEC_STAT_WAKEUP		= BIT(6),

I hadn't realized until Jose Abreu's latest reply, but you need to check the
ARBLOST status and set the TX state to CEC_TX_STATUS_ARB_LOST.

I think CEC_STAT_ERROR_FOLL might equal CEC_TX_STATUS_LOW_DRIVE, but without
documentation I can't be sure.

My experience is that this low drive condition tends to be poorly reported by
hardware. Either that or poorly documented. This is why I added a
CEC_TX_STATUS_ERROR status as a catch-all error status when it is unclear from
the hardware/documentation what error occurred.

Jose, do you know which status bit is used to report a follower pulling the
CEC line low for a long time (approx. 3.6 ms) to signal a CEC error?

Regards,

	Hans
