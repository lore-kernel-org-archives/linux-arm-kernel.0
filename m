From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 May 2017 16:37:12 +0200
Subject: [PATCH 7/9] pinctrl: mvebu: add driver for Armada AP806 pinctrl
In-Reply-To: <CAP=VYLrpQJ+C+KaEVcv8Rjmp470UH9-+MKAsjErXYoh=AME-Qw@mail.gmail.com>
 (Paul Gortmaker's message of "Sat, 20 May 2017 15:04:22 -0400")
References: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
 <5a190d4d71cb8626315b832c6f987e9e03da2fa9.1495209664.git-series.gregory.clement@free-electrons.com>
 <CAP=VYLrpQJ+C+KaEVcv8Rjmp470UH9-+MKAsjErXYoh=AME-Qw@mail.gmail.com>
Message-ID: <87k2590xgn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
 
 On sam., mai 20 2017, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Fri, May 19, 2017 at 12:04 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hanna Hawa <hannah@marvell.com>
>>
>> This commit adds a pinctrl driver for the pin-muxing controller found in
>> the AP806 part of the Marvell Armada 7K and 8K SoCs. Its register
>> interface is compatible with the one used by previous mvebu pin
>> controllers, so the common logic in drivers/pinctrl/mvebu/pinctrl-mvebu.c
>> is used.
>>
>> Signed-off-by: Hanna Hawa <hannah@marvell.com>
>> Reviewed-by: Shadi Ammouri <shadi@marvell.com>
>> [updated for mvebu pinctrl changes
>>  - converted to simple_mmio
>>  - removed unimplemented .remove function
>>  - removed DTS description
>>   - converted  to use syscon/regmap
>>  --rmk]
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/pinctrl/mvebu/Kconfig                |   4 +-
>>  drivers/pinctrl/mvebu/Makefile               |   1 +-
>>  drivers/pinctrl/mvebu/pinctrl-armada-ap806.c | 145 ++++++++++++++++++++-
>>  3 files changed, 150 insertions(+)
>>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
>>
>> diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
>> index 8cb444b60ae9..0e0b009f2b71 100644
>> --- a/drivers/pinctrl/mvebu/Kconfig
>> +++ b/drivers/pinctrl/mvebu/Kconfig
>> @@ -28,6 +28,10 @@ config PINCTRL_ARMADA_39X
>>         bool
>>         select PINCTRL_MVEBU
>>
>> +config PINCTRL_ARMADA_AP806
>> +       bool
>> +       select PINCTRL_MVEBU
>
> If this isn't going to be modular, can we remove all the uses
> of module.h and MODULE_ etc.   I've nearly got all of these
> cleaned up in pinctrl and it would be nice to not have new
> ones creep back in.

Indeed it won't be modular, so I will remove it in this driver and the
next one.

Thanks,

Gregory

>
> Thanks,
> Paul.
> --
>
>> +
>>  config PINCTRL_ARMADA_XP
>>         bool
>>         select PINCTRL_MVEBU
>> diff --git a/drivers/pinctrl/mvebu/Makefile b/drivers/pinctrl/mvebu/Makefile
>> index 60c245a60f39..455db274b53d 100644
>> --- a/drivers/pinctrl/mvebu/Makefile
>> +++ b/drivers/pinctrl/mvebu/Makefile
>> @@ -5,6 +5,7 @@ obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
>>  obj-$(CONFIG_PINCTRL_ARMADA_375) += pinctrl-armada-375.o
>>  obj-$(CONFIG_PINCTRL_ARMADA_38X) += pinctrl-armada-38x.o
>>  obj-$(CONFIG_PINCTRL_ARMADA_39X) += pinctrl-armada-39x.o
>> +obj-$(CONFIG_PINCTRL_ARMADA_AP806) += pinctrl-armada-ap806.o
>>  obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
>>  obj-$(CONFIG_PINCTRL_ARMADA_37XX)  += pinctrl-armada-37xx.o
>>  obj-$(CONFIG_PINCTRL_ORION)  += pinctrl-orion.o
>> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c b/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
>> new file mode 100644
>> index 000000000000..269b1c1f53b1
>> --- /dev/null
>> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
>> @@ -0,0 +1,145 @@
>> +/*
>> + * Marvell Armada ap806 pinctrl driver based on mvebu pinctrl core
>> + *
>> + * Copyright (C) 2017 Marvell
>> + *
>> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> + * Hanna Hawa <hannah@marvell.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>
> [...]
>
>> +module_platform_driver(armada_ap806_pinctrl_driver);
>> +
>> +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
>> +MODULE_DESCRIPTION("Marvell Armada ap806 pinctrl driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
