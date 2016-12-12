From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Dec 2016 08:27:32 -0800
Subject: [PATCH 2/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
References: <20161211221750.27743-1-f.fainelli@gmail.com>
 <20161211221750.27743-3-f.fainelli@gmail.com>
 <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
Message-ID: <39bc0569-81e1-8c35-0280-4ba1824b2710@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 08:01 AM, Alan Tull wrote:
> On Sun, 11 Dec 2016, Florian Fainelli wrote:
> 
>> Add support for loading bitstreams on the Altera Cyclone II FPGA
>> populated on the TS-7300 board. This is done through the configuration
>> and data registers offered through a memory interface between the EP93xx
>> SoC and the FPGA.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Hi Florain,
> 
> Thanks for submitting!
> 
> How specific is this to the tx7300 board?
> 
> I'm unclear about the programming method here.  Are these registers
> exposed by the EP93xx?  Is it possible that another cpu could access
> these two registers to configure the cyclone ii?  Is this passive
> serial?

So here is my understanding, from glancing at the TS-7300 board manual:

- there is an on-board CPLD which does a variety of services and I/O for
the EP9302 SoC, one of these services is the configuration of the
on-board FPGA

- the programming interface here is some kind of abstraction around a
Cyclone II FPGA, and is by no means standard, nor directly exposed to
the CPU

- unless you go through the CPLD, there is no other way that you could
configure the FPGA

Does that help answer your questions?

> 
> Please cc linux-fpga at vger.kernel.org for the next version.
> 
> Other comments below...

OK, I will fix those,

> 
>> ---
>>  drivers/fpga/Kconfig       |   7 ++
>>  drivers/fpga/Makefile      |   1 +
>>  drivers/fpga/ts73xx-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 173 insertions(+)
>>  create mode 100644 drivers/fpga/ts73xx-fpga.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index cd84934774cc..109625707ef0 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -26,6 +26,13 @@ config FPGA_MGR_ZYNQ_FPGA
>>  	help
>>  	  FPGA manager driver support for Xilinx Zynq FPGAs.
>>  
>> +config FPGA_MGR_TS73XX
>> +	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
>> +	depends on ARCH_EP93XX && MACH_TS72XX
>> +	help
>> +	  FPGA manager driver support for the Altera Cyclone II FPGA
>> +	  present on the TS-73xx SBC boards.
>> +
>>  endif # FPGA
>>  
>>  endmenu
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 8d83fc6b1613..5d51265cc1b4 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_FPGA)			+= fpga-mgr.o
>>  # FPGA Manager Drivers
>>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>> +obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
>> new file mode 100644
>> index 000000000000..2b3d5d668dfc
>> --- /dev/null
>> +++ b/drivers/fpga/ts73xx-fpga.c
>> @@ -0,0 +1,165 @@
>> +/*
>> + * Technologic Systems TS-73xx SBC FPGA loader
>> + *
>> + * Copyright (C) 2016 Florian Fainelli <f.fainelli@gmail.com>
>> + *
>> + * FPGA Manager Driver for the on-board Altera Cyclone II FPGA found on
>> + * TS-7300, heavily based on load_fpga.c in their vendor tree.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +#include <linux/bitrev.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +
>> +#define TS73XX_FPGA_DATA_REG	0
>> +#define TS73XX_FPGA_CONFIG_REG	1
>> +
>> +struct ts73xx_fpga_priv {
>> +	void __iomem	*io_base;
>> +	struct device	*dev;
>> +};
>> +
>> +static enum fpga_mgr_states ts73xx_fpga_state(struct fpga_manager *mgr)
>> +{
>> +	return FPGA_MGR_STATE_UNKNOWN;
>> +}
>> +
>> +static int ts73xx_fpga_write_init(struct fpga_manager *mgr, u32 flags,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct ts73xx_fpga_priv *priv = mgr->priv;
>> +
>> +	/* Reset the FPGA */
>> +	writeb(0, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +	udelay(30);
>> +	writeb(0x2, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +	udelay(80);
> 
> Could these udelay values be macros?

The bit definitions could be defined, but the delays, why would that be
useful?

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int ts73xx_fpga_can_write(struct ts73xx_fpga_priv *priv)
>> +{
>> +	unsigned int timeout = 1000;
> 
> Another macro?

The delay is just an arbitrary good timeout.
-- 
Florian
