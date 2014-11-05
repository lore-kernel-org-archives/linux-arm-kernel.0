From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Wed, 5 Nov 2014 18:05:07 +0100
Subject: [PATCH v2 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <20141105175951.71ad792a@bbrezillon>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-6-git-send-email-boris.brezillon@free-electrons.com>
 <CACh+v5MP4XecA_fKrg=W2Xs8gkkEXaoEnFt_c8sC=wdUQg4HFw@mail.gmail.com>
 <20141105175951.71ad792a@bbrezillon>
Message-ID: <CACh+v5MiqKVQA7mt8CjMGwmwuO45P2udX5a0ctvuyCAZ1UBKAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-05 17:59 GMT+01:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> On Wed, 5 Nov 2014 17:53:42 +0100
> Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
>
>> 2014-11-05 17:01 GMT+01:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
>> > The EBI (External Bus Interface) is used to access external peripherals
>> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
>> > Each device is assigned a CS line and an address range and can have its
>> > own configuration (timings, access mode, bus width, ...).
>> > This driver provides a generic DT binding to configure a device according
>> > to its requirements.
>> > For specific device controllers (like the NAND one) the SMC timings
>> > should be configured by the controller driver through the matrix and
>> > smc syscon regmaps.
>> >
>> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> > ---
>> >  drivers/memory/Kconfig     |  11 +
>> >  drivers/memory/Makefile    |   1 +
>> >  drivers/memory/atmel-ebi.c | 615 +++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 627 insertions(+)
>> >  create mode 100644 drivers/memory/atmel-ebi.c
>> >
>> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> > index 6d91c27..dfe24a2 100644
>> > --- a/drivers/memory/Kconfig
>> > +++ b/drivers/memory/Kconfig
>> > @@ -17,6 +17,17 @@ config ATMEL_SDRAMC
>> >           Starting with the at91sam9g45, this controller supports SDR, DDR and
>> >           LP-DDR memories.
>> >
>> > +config ATMEL_EBI
>> > +       bool "Atmel EBI driver"
>> > +       default y
>> > +       depends on ARCH_AT91 && OF
>> > +       select MFD_SYSCON
>> > +       help
>> > +         Driver for Atmel EBI controller.
>> > +         Used to configure the EBI (external bus interface) when the device-
>> > +         tree is used. This bus supports NANDs, external ethernet controller,
>> > +         SRAMs, ATA devices, etc.
>> > +
>> >  config TI_AEMIF
>> >         tristate "Texas Instruments AEMIF driver"
>> >         depends on (ARCH_DAVINCI || ARCH_KEYSTONE) && OF
>> > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
>> > index c32d319..7ca2c19 100644
>> > --- a/drivers/memory/Makefile
>> > +++ b/drivers/memory/Makefile
>> > @@ -6,6 +6,7 @@ ifeq ($(CONFIG_DDR),y)
>> >  obj-$(CONFIG_OF)               += of_memory.o
>> >  endif
>> >  obj-$(CONFIG_ATMEL_SDRAMC)     += atmel-sdramc.o
>> > +obj-$(CONFIG_ATMEL_EBI)                += atmel-ebi.o
>> >  obj-$(CONFIG_TI_AEMIF)         += ti-aemif.o
>> >  obj-$(CONFIG_TI_EMIF)          += emif.o
>> >  obj-$(CONFIG_FSL_CORENET_CF)   += fsl-corenet-cf.o
>> > diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
>> > new file mode 100644
>> > index 0000000..41bc893
>> > --- /dev/null
>> > +++ b/drivers/memory/atmel-ebi.c
>> > @@ -0,0 +1,615 @@
>> > +/*
>> > + * EBI driver for Atmel SAM9 chips
>> > + * inspired by the fsl weim bus driver
>> > + *
>> > + * Copyright (C) 2013 JJ Hiblot.
>> > + *
>> > + * This file is licensed under the terms of the GNU General Public
>> > + * License version 2. This program is licensed "as is" without any
>> > + * warranty of any kind, whether express or implied.
>> > + */
>> > +
>> > +#include <linux/clk.h>
>> > +#include <linux/io.h>
>> > +#include <linux/mfd/syscon.h>
>> > +#include <linux/mfd/syscon/atmel-matrix.h>
>> > +#include <linux/mfd/syscon/atmel-smc.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/regmap.h>
>> > +
>> > +#define AT91SAM9_SMC_READ_MODE_MSK     BIT(0)
>> > +#define AT91SAM9_SMC_READ_NCS_MODE     0
>> > +#define AT91SAM9_SMC_READ_NRD_MODE     1
>> > +#define AT91SAM9_SMC_WRITE_MODE_MSK    BIT(1)
>> > +#define AT91SAM9_SMC_WRITE_NCS_MODE    (0 << 1)
>> > +#define AT91SAM9_SMC_WRITE_NWE_MODE    (1 << 1)
>> > +#define AT91SAM9_SMC_EXNW_MODE_MSK     GENMASK(5, 4)
>> > +#define AT91SAM9_SMC_EXNW_DIS          (0 << 4)
>> > +#define AT91SAM9_SMC_EXNW_FROZEN       (2 << 4)
>> > +#define AT91SAM9_SMC_EXNW_READY                (3 << 4)
>> > +#define AT91SAM9_SMC_BAT_MSK           BIT(8)
>> > +#define AT91SAM9_SMC_BAT_SELECT                (0 << 8)
>> > +#define AT91SAM9_SMC_BAT_WRITE         (1 << 8)
>> > +#define AT91SAM9_SMC_DBW_MSK           GENMASK(13, 12)
>> > +#define AT91SAM9_SMC_DBW(x)            ((((x) / 16) & 0x3) << 12)
>> > +#define AT91SAM9_SMC_TDF_CYCLES_MSK    GENMASK(19, 16)
>> > +#define AT91SAM9_SMC_TDF_CYCLES(x)     (((x) & 0xf) << 16)
>> > +#define AT91SAM9_SMC_TDF_MODE_MSK      BIT(20)
>> > +#define AT91SAM9_SMC_TDF_OPTIMIZED     (1 << 20)
>> > +#define AT91SAM9_SMC_PMEN              BIT(24)
>> > +#define AT91SAM9_SMC_PS(x)             ((((x) / 4) & 0x3) << 28)
>>
>> Those definitions are now also available in
>> linux/mfd/syscon/atmel-smc.h.For consistency sake, this driver should
>> probably use the new ones.
>
> That was my intention, I just forgot to cleanup this part...
>
>> BTW this patch should probably be applied after patch 3 "mfd: syscon:
>> Add atmel-smc registers definition" and patch 1 "mfd: syscon: Add
>> atmel-matrix registers definition"
>>
>
> And it is: patch 05/11 :-)

Damn gmail again for showing it under [Patch 00/11] ! It's definitely
not the ideal review tool :-)
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
