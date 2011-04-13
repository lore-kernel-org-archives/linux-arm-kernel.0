From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 13 Apr 2011 09:25:26 -0400
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <20110413114304.GA1897@S2100-06.ap.freescale.net>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-2-git-send-email-b32955@freescale.com>
	<20110413114304.GA1897@S2100-06.ap.freescale.net>
Message-ID: <BANLkTi=xHoT_=pwy3y7q0FSXRWNQ3Pe21A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/13 Shawn Guo <shawn.guo@freescale.com>:
> On Wed, Apr 13, 2011 at 02:24:38PM +0800, Huang Shijie wrote:
>> add the clock and iomux initialization for GPMI in the imx23 and imx28.
>> and register the gpmi driver.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>> ---
>> ?arch/arm/mach-mxs/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-mxs/clock-mx23.c ? ? ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-mxs/clock-mx28.c ? ? ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-mxs/devices-mx23.h ? ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-mxs/devices-mx28.h ? ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-mxs/devices/Kconfig ? ? ? ? ? ? ? | ? ?3 +
>> ?arch/arm/mach-mxs/devices/Makefile ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-mxs/devices/platform-gpmi.c ? ? ? | ?134 +++++++++++++++++++++++
>> ?arch/arm/mach-mxs/include/mach/devices-common.h | ? ?4 +
>> ?arch/arm/mach-mxs/include/mach/gpmi-nfc.h ? ? ? | ? 65 +++++++++++
>> ?arch/arm/mach-mxs/mach-mx23evk.c ? ? ? ? ? ? ? ?| ? 37 ++++++
>> ?arch/arm/mach-mxs/mach-mx28evk.c ? ? ? ? ? ? ? ?| ? 37 ++++++
>> ?12 files changed, 295 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
>> ?create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
>>
> [...]
>> diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
>> new file mode 100644
>> index 0000000..74ebe22
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
>> @@ -0,0 +1,134 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +#include <asm/sizes.h>
>> +#include <mach/mx23.h>
>> +#include <mach/mx28.h>
>> +#include <mach/gpmi-nfc.h>
>> +#include <mach/devices-common.h>
>
> devices-common.h already includes gpmi-nfc.h

ok. thanks
>
> [...]
>> diff --git a/arch/arm/mach-mxs/include/mach/gpmi-nfc.h b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
>> new file mode 100644
>> index 0000000..cf8e8c3
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
>> @@ -0,0 +1,65 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#ifndef __INCLUDE_LINUX_DEVICE_H
>> +#define __INCLUDE_LINUX_DEVICE_H
>
> __INCLUDE_LINUX_DEVICE_H is too generic to protect the inclusion of
> gpmi-nfc.h

ok, thanks
>
> [...]
>> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
>> index a66994f..db715f9 100644
>> --- a/arch/arm/mach-mxs/mach-mx23evk.c
>> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
>> @@ -34,6 +34,42 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
>> ? ? ? MX23_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
>> ? ? ? MX23_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
>>
>> + ? ? /* gpmi */
>> + ? ? MX23_PAD_GPMI_D00__GPMI_D00 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>
> You can use MXS_PAD_CTRL here.
>
>> + ? ? MX23_PAD_GPMI_D01__GPMI_D01 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D02__GPMI_D02 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D03__GPMI_D03 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D04__GPMI_D04 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D05__GPMI_D05 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D06__GPMI_D06 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_D07__GPMI_D07 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_CLE__GPMI_CLE |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_ALE__GPMI_ALE |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_WPN__GPMI_WPN |
>> + ? ? ? ? ? ? (MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_WRN__GPMI_WRN |
>> + ? ? ? ? ? ? (MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_RDN__GPMI_RDN |
>> + ? ? ? ? ? ? (MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_RDY0__GPMI_RDY0 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_RDY1__GPMI_RDY1 |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_CE0N__GPMI_CE0N |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> + ? ? MX23_PAD_GPMI_CE1N__GPMI_CE1N |
>> + ? ? ? ? ? ? (MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>> +
>
> mmc (ssp) has pin conflict with gpmi on both mx23evk and mx28evk.
>
> Uwe,
>
> How do you usually handle such pin conflicts on board?
In the our imx508 code, we add a initialization  hook in the platform
data , and calls the
hook in the driver's probe().

Does this a good solution?


>
>> ? ? ? /* auart */
>> ? ? ? MX23_PAD_AUART1_RX__AUART1_RX | MXS_PAD_CTRL,
>> ? ? ? MX23_PAD_AUART1_TX__AUART1_TX | MXS_PAD_CTRL,
>> @@ -108,6 +144,7 @@ static void __init mx23evk_init(void)
>> ? ? ? mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
>>
>> ? ? ? mx23_add_duart();
>> + ? ? mx23_add_gpmi();
>> ? ? ? mx23_add_auart0();
>>
> Can you please add gpmi stuff like this and pad configuration at the
> end to reflect the order that devices get supported?
ok.

Best Regards
Huang Shijie

>
>> ? ? ? ret = gpio_request_one(MX23EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
>> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
>> index 08002d0..cf8ddcb 100644
>> --- a/arch/arm/mach-mxs/mach-mx28evk.c
>> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> Ditto
>
> --
> Regards,
> Shawn
>
>
