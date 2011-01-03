From: jaume@fqingenieria.es (Jaume Ribot)
Date: Mon, 03 Jan 2011 16:03:26 +0100
Subject: [PATCH 02/04] ARM i.MX25 Add SIM driver
In-Reply-To: <20110103130551.GA24408@pengutronix.de>
References: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
	<20110103130551.GA24408@pengutronix.de>
Message-ID: <4D21E53E.2050809@fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sascha,


On 03/01/2011 14:05, Sascha Hauer wrote:
> Hello Iban,
>
> On Mon, Jan 03, 2011 at 10:07:19AM +0100, FQ | Iban Cerro wrote:
>> This driver is slightly based on the Freescale original one, with several
>> code simplifications. We made specially emphasis in avoiding any ISO7816
>> code into the driver, which is not the right place to be. Driver mainly
>> works via ioctl to configure and then using read/write functions to
>> read/write smart cards.
>>
>> One important consideration (not clear in the User Manual from our point
>> of view) is that there exist two SIM modules into the MX25 core, both of
>> them in different memory position. This causes all accesses to SIM modules
>> must be done via SIM0. This differs from the way the User Manual explains
>> how to access the two different SIM modules, which seems is inherited from
>> the MX51 core.
> The following comments are mostly coding style related, running Lindent
> and checkpatch.pl on this patch seems to be a good start for improving
> this driver.
Thanks for comments and reviews. We will apply all recommendations and 
we will resubmit patches, also with all identation issues solved.
> The main problem for pushing this driver to mainline is that you invent
> a i.MX specific smartcard API. This is not a good idea and probably not
> acceptable in mainline.
Regarding if this driver can fit into mainline, I agree that the kernel 
is not the right place to contain a smartcard API. There are other 
projects doing that quite well (muscle, opensc, ...). But in fact, the 
idea of this driver is not to give a smartcard API but support the 
I.MX25 SIM core, which is explicitly hardware dependant. IMHO, there is 
no conceptual difference between this driver and any of the others 
contained into plat-mxc/ directory. That's also why this driver has not 
been placed into drivers/ directory. Maybe we can study to perform a 
higher simplification of the driver, in order to remove any reminiscence 
of smartcard API functions and only performing hardware (MX25) dependent 
jobs .
>> Signed-off-by: Iban Cerro Galvez<iban@fqingenieria.es>
>> ---
>>   arch/arm/plat-mxc/Kconfig                |    7 +
>>   arch/arm/plat-mxc/Makefile               |    1 +
>>   arch/arm/plat-mxc/include/mach/mxc_sim.h |  319 +++++++++++
>>   arch/arm/plat-mxc/sim.c                  |  874
>> ++++++++++++++++++++++++++++++
> Your mailer breaks lines which means that other people can't apply this
> patch.
>
>>   4 files changed, 1201 insertions(+), 0 deletions(-)
>>   create mode 100644 arch/arm/plat-mxc/include/mach/mxc_sim.h
>>   create mode 100644 arch/arm/plat-mxc/sim.c
>>
>> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
>> index 389f217..7b16d0d 100644
>> --- a/arch/arm/plat-mxc/Kconfig
>> +++ b/arch/arm/plat-mxc/Kconfig
>> @@ -74,6 +74,13 @@ config MXC_PWM
>>   	help
>>   	  Enable support for the i.MX PWM controller(s).
>>
>> +config MXC_SIM
>> + 	tristate "Enable SIM driver"
>> + 	select HAVE_SIM
>> + 	help
>> + 	  Enable support for the i.MX SIM controller(s).
>> +
>> +
>>   config MXC_DEBUG_BOARD
>>   	bool "Enable MXC debug board(for 3-stack)"
>>   	help
>> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
>> index 5fd20e9..73073fb 100644
>> --- a/arch/arm/plat-mxc/Makefile
>> +++ b/arch/arm/plat-mxc/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_MXC_AVIC) += avic.o
>>   obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
>>   obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
>>   obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
>> +obj-$(CONFIG_MXC_SIM) += sim.o
>>   obj-$(CONFIG_MXC_PWM)  += pwm.o
>>   obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
>>   obj-$(CONFIG_MXC_ULPI) += ulpi.o
>> diff --git a/arch/arm/plat-mxc/include/mach/mxc_sim.h
>> b/arch/arm/plat-mxc/include/mach/mxc_sim.h
>> new file mode 100644
>> index 0000000..74ff008
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/include/mach/mxc_sim.h
>> @@ -0,0 +1,319 @@
>> +/*
>> + * Copyright 2010-2011 FQ Ingenieria Electronica S.A.
>> + *
>> + *  Adapted and simplify this driver to kernel mainline code style using
>> + *  other drivers from Freescale
>> + *  Jaume Ribot (jaume at fqingenieria.es)
>> + *  Iban Cerro Galvez (iban at fqingenieria.es)
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*!
>> + * @file mxc_sim.h
>> + *
>> + * @brief Driver for Freescale IMX SIM interface
>> + *
>> + */
>> +
>> +#ifndef MXC_SIM_INTERFACE_H
>> +#define MXC_SIM_INTERFACE_H
>> +
>> +#define SIM_DRIVER_VERSION 0x01
>> +
>> +/* Transmit and receive buffer sizes */
>> +#define SIM_XMT_BUFFER_SIZE 256
>> +#define SIM_RCV_BUFFER_SIZE 256
>> +
>> +/*BAUD_DIVISOR */
>> +#define SIM_DEFAULT_BAUD_DIV 372
>> +
>> +#define WRITE_TIMEOUT 1000
>> +#define READ_TIMEOUT 1000
>> +
>> +
>> +struct mxc_sim_platform_data {
>> +	unsigned int clk_rate;
>> +	char *clock_sim;
> Please do not pass clock names to drivers. Use clk_get(dev, id) instead.
>
>> +	char *power_sim;
> This seems to be unused.
>
>> +	int (*init)(struct platform_device *pdev);
>> +	void (*exit)(void);
>> +	unsigned int detect; /* 1 have detect pin, 0 not */
>> +	unsigned int sim_number; /* 0 or 1 */
>> +};
>> +
>> +typedef struct {
>> +	unsigned long addr;
>> +	unsigned long data;
>> +} sim_reg;
> Do not typedef struct types, see Documentation/CodingStyle.
>
>> +
>> +/* Main SIM driver structure */
>> +typedef struct {
>> +	/*SIM number 0, 1 */
>> +	int sim_number;
>> +	/* card inserted = 1, ATR received = 2, card removed = 0 */
>> +	int present;
>> +	/* current ATR or OPS state */
>> +	int state;
>> +	/* current power state */
>> +	int power;
>> +	/* error code occured during transfer */
>> +	int errval;
>> +	/* Clock id */
>> +	struct clk *clk;
>> +	/* on off clk*/
>> +	uint8_t clk_flag;
>> +	/* frequency of clk sim */
>> +	uint32_t clk_sim;
>> +	/* value of clk divisor*/
>> +	int uart_div;
>> +	/* IO map memory */
>> +	struct resource *res;
>> +	/* Mapped address */
>> +	void __iomem *ioaddr;	/* Mapped address */
>> +	int ipb_irq;		/* sim ipb IRQ num */
>> +	int dat_irq;		/* sim dat IRQ num */
>> +	/* async notifier for card and ATR detection */
>> +	struct fasync_struct *fasync;
>> +	/* Platform specific data */
>> +	struct mxc_sim_platform_data *plat_data;
>> +} sim_t;
> ditto
>
>> +
>> +/* ISO7816-3 protocols */
>> +#define SIM_PROTOCOL_T0  0
>> +#define SIM_PROTOCOL_T1  1
>> +
>> +/* Transfer types for SIM_IOCTL_XFER */
>> +#define SIM_XFER_TYPE_TPDU 0
>> +#define SIM_XFER_TYPE_PTS  1
>> +
>> +/* Interface power states */
>> +#define SIM_POWER_OFF 0
>> +#define SIM_POWER_ON  1
>> +
>> +/* Return values for SIM_IOCTL_GET_PRESENSE */
>> +#define SIM_PRESENT_REMOVED     0
>> +#define SIM_PRESENT_DETECTED    1
>> +#define SIM_PRESENT_OPERATIONAL 2
>> +
>> +/* Return values for SIM_IOCTL_GET_ERROR */
>> +#define SIM_OK                         0
>> +#define SIM_E_ACCESS                   1
>> +#define SIM_E_TPDUSHORT                2
>> +#define SIM_E_PTSEMPTY                 3
>> +#define SIM_E_INVALIDXFERTYPE          4
>> +#define SIM_E_INVALIDXMTLENGTH         5
>> +#define SIM_E_INVALIDRCVLENGTH         6
>> +#define SIM_E_NACK                     7
>> +#define SIM_E_TIMEOUT                  8
>> +#define SIM_E_NOCARD                   9
>> +#define SIM_E_PARAM_FI_INVALID         10
>> +#define SIM_E_PARAM_DI_INVALID         11
>> +#define SIM_E_PARAM_FBYD_WITHFRACTION  12
>> +#define SIM_E_PARAM_FBYD_NOTDIVBY8OR12 13
>> +#define SIM_E_PARAM_DIVISOR_RANGE      14
>> +#define SIM_E_MALLOC                   15
>> +#define SIM_E_IRQ                      16
>> +#define SIM_E_POWERED_ON               17
>> +#define SIM_E_POWERED_OFF              18
>> +
>> +/* ioctl encodings */
>> +#define SIM_IOCTL_BASE 0xc0
>> +#define SIM_IOCTL_VERSION        _IOR(SIM_IOCTL_BASE, 1,unsigned char)
>> +#define SIM_IOCTL_POWER_ON       _IO(SIM_IOCTL_BASE,  2)
>> +#define SIM_IOCTL_POWER_OFF      _IO(SIM_IOCTL_BASE,  3)
>> +#define SIM_IOCTL_WARM_RESET     _IO(SIM_IOCTL_BASE,  4)
>> +#define SIM_IOCTL_COLD_RESET     _IO(SIM_IOCTL_BASE,  5)
>> +#define SIM_IOCTL_CLK_PORT			 _IOW(SIM_IOCTL_BASE, 6, int)
>> +#define SIM_IOCTL_RST_PORT			 _IOW(SIM_IOCTL_BASE, 7, int)
>> +#define SIM_IOCTL_VCC_PORT			 _IOW(SIM_IOCTL_BASE, 8, int)
>> +#define SIM_IOCTL_SET_CLK_SIM    _IOW(SIM_IOCTL_BASE, 9, unsigned long)
>> +#define SIM_IOCTL_SET_CLK_DIV		 _IOW(SIM_IOCTL_BASE, 10, int)
>> +#define SIM_IOCTL_GET_REG				 _IOW(SIM_IOCTL_BASE, 11, sim_reg)
>> +#define SIM_IOCTL_SET_REG				 _IOW(SIM_IOCTL_BASE, 12, sim_reg)
>> +
>> +/* Interface character references */
>> +#define SIM_IFC_TXI(letter, number) (letter + number * 4)
>> +#define SIM_IFC_TA1   SIM_IFC_TXI(0, 0)
>> +#define SIM_IFC_TB1   SIM_IFC_TXI(0, 1)
>> +#define SIM_IFC_TC1   SIM_IFC_TXI(0, 2)
>> +#define SIM_IFC_TD1   SIM_IFC_TXI(0, 3)
>> +#define SIM_IFC_TA2   SIM_IFC_TXI(1, 0)
>> +#define SIM_IFC_TB2   SIM_IFC_TXI(1, 1)
>> +#define SIM_IFC_TC2   SIM_IFC_TXI(1, 2)
>> +#define SIM_IFC_TD2   SIM_IFC_TXI(1, 3)
>> +#define SIM_IFC_TA3   SIM_IFC_TXI(2, 0)
>> +#define SIM_IFC_TB3   SIM_IFC_TXI(2, 1)
>> +#define SIM_IFC_TC3   SIM_IFC_TXI(2, 2)
>> +#define SIM_IFC_TD3   SIM_IFC_TXI(2, 3)
>> +#define SIM_IFC_TA4   SIM_IFC_TXI(3, 0)
>> +#define SIM_IFC_TB4   SIM_IFC_TXI(3, 1)
>> +#define SIM_IFC_TC4   SIM_IFC_TXI(3, 2)
>> +#define SIM_IFC_TD4   SIM_IFC_TXI(3, 3)
>> +
>> +/* ATR and OPS states */
>> +#define SIM_STATE_REMOVED              0
>> +#define SIM_STATE_OPERATIONAL_IDLE     1
>> +#define SIM_STATE_OPERATIONAL_COMMAND  2
>> +#define SIM_STATE_OPERATIONAL_RESPONSE 3
>> +#define SIM_STATE_OPERATIONAL_STATUS1  4
>> +#define SIM_STATE_OPERATIONAL_STATUS2  5
>> +#define SIM_STATE_OPERATIONAL_PTS      6
>> +#define SIM_STATE_DETECTED_ATR_T0       7
>> +#define SIM_STATE_DETECTED_ATR_TS       8
>> +#define SIM_STATE_DETECTED_ATR_TXI      9
>> +#define SIM_STATE_DETECTED_ATR_THB      10
>> +#define SIM_STATE_DETECTED_ATR_TCK      11
>> +
>> +/* Definitions of the offset of the SIM hardware registers */
>> +#define PORT1_CNTL 	0x00	/* 00 */
>> +#define SETUP 		0x04	/* 04 */
>> +#define PORT1_DETECT 	0x08	/* 08 */
>> +#define PORT1_XMT_BUF 	0x0C	/* 0c */
>> +#define PORT1_RCV_BUF 	0x10	/* 10 */
>> +#define PORT0_CNTL 	0x14	/* 14 */
>> +#define CNTL 		0x18	/* 18 */
>> +#define CLK_PRESCALER 	0x1C	/* 1c */
>> +#define RCV_THRESHOLD 	0x20	/* 20 */
>> +#define ENABLE 		0x24	/* 24 */
>> +#define XMT_STATUS 	0x28	/* 28 */
>> +#define RCV_STATUS 	0x2C	/* 2c */
>> +#define INT_MASK 	0x30	/* 30 */
>> +#define PORTO_XMT_BUF 	0x34	/* 34 */
>> +#define PORT0_RCV_BUF 	0x38	/* 38 */
>> +#define PORT0_DETECT 	0x3C	/* 3c */
>> +#define DATA_FORMAT 	0x40	/* 40 */
>> +#define XMT_THRESHOLD 	0x44	/* 44 */
>> +#define GUARD_CNTL 	0x48	/* 48 */
>> +#define OD_CONFIG 	0x4C	/* 4c */
>> +#define RESET_CNTL 	0x50	/* 50 */
>> +#define CHAR_WAIT 	0x54	/* 54 */
>> +#define GPCNT 		0x58	/* 58 */
>> +#define DIVISOR 	0x5C	/* 5c */
>> +#define BWT 		0x60	/* 60 */
>> +#define BGT 		0x64	/* 64 */
>> +#define BWT_H 		0x68	/* 68 */
>> +#define XMT_FIFO_STAT 	0x6C	/* 6c */
>> +#define RCV_FIFO_CNT 	0x70	/* 70 */
>> +#define RCV_FIFO_WPTR 	0x74	/* 74 */
>> +#define RCV_FIFO_RPTR 	0x78	/* 78 */
> so 0x78 means 78, who would have guessed that? Please remove the comments.
>
>> +
>> +/* SIM port[0|1]_cntl register bits */
>> +#define SIM_PORT_CNTL_SFPD   (1<<7)
>> +#define SIM_PORT_CNTL_3VOLT  (1<<6)
>> +#define SIM_PORT_CNTL_SCSP   (1<<5)
>> +#define SIM_PORT_CNTL_SCEN   (1<<4)
>> +#define SIM_PORT_CNTL_SRST   (1<<3)
>> +#define SIM_PORT_CNTL_STEN   (1<<2)
>> +#define SIM_PORT_CNTL_SVEN   (1<<1)
>> +#define SIM_PORT_CNTL_SAPD   (1<<0)
>> +
>> +#define MX25_SIM_SETUP_P1_EN 		(1<<1)		// Port 1 enabled
>> +#define MX25_SIM_SETUP_AMODE_EN (1<<0)		// Alternate port enabled
> Please do not use C99 style comments.
>
>> +
>> +/* SIM od_config register bits */
>> +#define SIM_OD_CONFIG_OD_P1  (1<<1)
>> +#define SIM_OD_CONFIG_OD_P0  (1<<0)
>> +
>> +/* SIM enable register bits */
>> +#define SIM_ENABLE_XMTEN     (1<<1)
>> +#define SIM_ENABLE_RCVEN     (1<<0)
>> +
>> +/* SIM int_mask register bits */
>> +#define SIM_INT_MASK_RFEM    (1<<13)
>> +#define SIM_INT_MASK_BGTM    (1<<12)
>> +#define SIM_INT_MASK_BWTM    (1<<11)
>> +#define SIM_INT_MASK_RTM     (1<<10)
>> +#define SIM_INT_MASK_CWTM    (1<<9)
>> +#define SIM_INT_MASK_GPCM    (1<<8)
>> +#define SIM_INT_MASK_TDTFM   (1<<7)
>> +#define SIM_INT_MASK_TFOM    (1<<6)
>> +#define SIM_INT_MASK_XTM     (1<<5)
>> +#define SIM_INT_MASK_TFEIM   (1<<4)
>> +#define SIM_INT_MASK_ETCIM   (1<<3)
>> +#define SIM_INT_MASK_OIM     (1<<2)
>> +#define SIM_INT_MASK_TCIM    (1<<1)
>> +#define SIM_INT_MASK_RIM     (1<<0)
>> +
>> +/* SIM xmt_status register bits */
>> +#define SIM_XMT_STATUS_GPCNT (1<<8)
>> +#define SIM_XMT_STATUS_TDTF  (1<<7)
>> +#define SIM_XMT_STATUS_TFO   (1<<6)
>> +#define SIM_XMT_STATUS_TC    (1<<5)
>> +#define SIM_XMT_STATUS_ETC   (1<<4)
>> +#define SIM_XMT_STATUS_TFE   (1<<3)
>> +#define SIM_XMT_STATUS_XTE   (1<<0)
>> +
>> +/* SIM rcv_status register bits */
>> +#define SIM_RCV_STATUS_BGT   (1<<11)
>> +#define SIM_RCV_STATUS_BWT   (1<<10)
>> +#define SIM_RCV_STATUS_RTE   (1<<9)
>> +#define SIM_RCV_STATUS_CWT   (1<<8)
>> +#define SIM_RCV_STATUS_CRCOK (1<<7)
>> +#define SIM_RCV_STATUS_LRCOK (1<<6)
>> +#define SIM_RCV_STATUS_RDRF  (1<<5)
>> +#define SIM_RCV_STATUS_RFD   (1<<4)
>> +#define SIM_RCV_STATUS_RFE   (1<<1)
>> +#define SIM_RCV_STATUS_OEF   (1<<0)
>> +
>> +/* SIM cntl register bits */
>> +#define SIM_CNTL_BWTEN       (1<<15)
>> +#define SIM_CNTL_XMT_CRC_LRC (1<<14)
>> +#define SIM_CNTL_CRCEN       (1<<13)
>> +#define SIM_CNTL_LRCEN       (1<<12)
>> +#define SIM_CNTL_CWTEN       (1<<11)
>> +#define SIM_CNTL_SAMPLE12    (1<<4)
>> +#define SIM_CNTL_ONACK       (1<<3)
>> +#define SIM_CNTL_ANACK       (1<<2)
>> +#define SIM_CNTL_ICM         (1<<1)
>> +#define SIM_CNTL_GPCNT_CLK_SEL(x)   ((x&0x03)<<9)
> Please add some spacing here, like this: ((x&  0x3)<<  9)
> See Documentation/CodingStyle for more information.
> Also, there are braces missing around x, it should be:
>
> (((x)&  0x3)<<  9)
>
>> +#define SIM_CNTL_GPCNT_CLK_SEL_MASK     (0x03<<9)
>> +#define SIM_CNTL_BAUD_SEL(x)        ((x&0x07)<<6)
>> +#define SIM_CNTL_BAUD_SEL_MASK          (0x07<<6)
>> +
>> +/* SIM rcv_threshold register bits */
>> +#define SIM_RCV_THRESHOLD_RTH(x)    ((x&0x0f)<<9)
>> +#define SIM_RCV_THRESHOLD_RTH_MASK      (0x0f<<9)
>> +#define SIM_RCV_THRESHOLD_RDT(x)   ((x&0x1ff)<<0)
>> +#define SIM_RCV_THRESHOLD_RDT_MASK     (0x1ff<<0)
>> +
>> +/* SIM xmt_threshold register bits */
>> +#define SIM_XMT_THRESHOLD_XTH(x)    ((x&0x0f)<<4)
>> +#define SIM_XMT_THRESHOLD_XTH_MASK      (0x0f<<4)
>> +#define SIM_XMT_THRESHOLD_TDT(x)    ((x&0x0f)<<0)
>> +#define SIM_XMT_THRESHOLD_TDT_MASK      (0x0f<<0)
>> +
>> +/* SIM guard_cntl register bits */
>> +#define SIM_GUARD_CNTL_RCVR11              (1<<8)
>> +#define SIM_GIARD_CNTL_GETU(x)           (x&0xff)
>> +#define SIM_GIARD_CNTL_GETU_MASK           (0xff)
>> +
>> +/* SIM port[0|]_detect register bits */
>> +#define SIM_PORT_DETECT_SPDS  (1<<3)
>> +#define SIM_PORT_DETECT_SPDP  (1<<2)
>> +#define SIM_PORT_DETECT_SDI   (1<<1)
>> +#define SIM_PORT_DETECT_SDIM  (1<<0)
>> +
>> +/* SIM XMT_FIFO_STAT*/
>> +#define SIM_XMT_FIFO_XMT_CNT_MASK  	(0x0f<<8)
>> +#define SIM_XMT_FIFO_XMT_WPTR_MASK  (0x0f<<4)
>> +#define SIM_XMT_FIFO_XMT_RPTR_MASK  (0x0f<<0)
>> +
>> +/* SIM PORT_RCV_BUF */
>> +#define PORT_RCV_BUF_PE			(1<<8)
>> +#define PORT_RCV_BUF_FE			(1<<9)
>> +#define PORT_RCV_BUF_CWT		(1<<10)
>> +/* SIM RESET_CNTL */
>> +#define SIM_RESET_CNTL_DBUG 			(1<<6)
>> +#define SIM_RESET_CNTL_STOP 			(1<<5)
>> +#define SIM_RESET_CNTL_DOZE 			(1<<4)
>> +#define SIM_RESET_CNTL_KILL_CLOCK (1<<3)
>> +#define SIM_RESET_CNTL_SOFT_RST		(1<<2)
>> +#define SIM_RESET_CNTL_FLUSH_XMT  (1<<1)
>> +#define SIM_RESET_CNTL_FLUSH_RCV  (1<<0)
>> +/* END of REGS definitions */
>> +#endif
>> diff --git a/arch/arm/plat-mxc/sim.c b/arch/arm/plat-mxc/sim.c
>> new file mode 100644
>> index 0000000..7af073c
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/sim.c
>> @@ -0,0 +1,874 @@
>> +/*
>> + * Copyright 2010-2011 FQ Ingenieria Electronica S.A.
>> + *
>> + *  Adapted and simplify this driver to kernel mainline code style using
>> + *  other drivers from Freescale
>> + *  Jaume Ribot (jaume at fqingenieria.es)
>> + *  Iban Cerro Galvez (iban at fqingenieria.es)
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*!
>> + * @file mxc_sim.c
>> + *
>> + * @brief Driver for Freescale IMX SIM interface
>> + *
>> + */
>> +
>> +#include<linux/module.h>
>> +#include<linux/ioport.h>
>> +#include<linux/kernel.h>
>> +#include<linux/delay.h>
>> +
>> +#include<linux/sched.h>
>> +#include<linux/io.h>
>> +#include<linux/interrupt.h>
>> +#include<linux/poll.h>
>> +#include<linux/miscdevice.h>
>> +#include<linux/clk.h>
>> +#include<linux/types.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/slab.h>
>> +
>> +#include<asm/io.h>
>> +#include<mach/hardware.h>
>> +#include<mach/mxc_sim.h>
>> +
>> +#define DRIVER_NAME "mxc_sim"
>> +#define SIM1_DEV_NAME "mxc_sim_0"
>> +#define SIM2_DEV_NAME "mxc_sim_1"
>> +
>> +static struct miscdevice sim_dev;
>> +
>> +#define sim_debug(fmt, ...) \
>> +		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> Please do not define your own debug functions. dev_dbg is the weapon of
> choice here.
>
>> +
>> +
>> +/* Function: sim_clear_ports
>> + *
>> + * Description: function to unset reset, Vcc_enable or Clk_enable
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + * uint32_t value					 value to set port
>> + */
>> +static void sim_clear_ports(sim_t *sim, uint32_t value)
>> +{
>> +	uint32_t reg_data;
>> +	void __iomem *addr;
>> +
>> +#if defined(CONFIG_SOC_IMX25)
>> +			if (cpu_is_mx25()) {
>> +				addr = sim->ioaddr + PORT0_CNTL;
>> +			}
> broken indention.
>
>> +#else
>> +	if (sim->sim_number ==0)
>> +		addr = sim->ioaddr + PORT0_CNTL;
>> +	else
>> +		addr = sim->ioaddr + PORT1_CNTL;
>> +#endif
> This #ifdef looks wrong here. The idea is to make the driver independent
> of compile time options. Now with this ifdef, if i.MX25 is enabled, it
> won't be working on any other SoC.
>
>> +
>> +	reg_data = __raw_readl(addr);
>> +	reg_data&= ~value;
>> +	__raw_writel(reg_data, addr);
>> +}
>> +
>> +
>> +/* Function: sim_set_ports
>> + *
>> + * Description: function to set Reset, Vcc enable or Clk_enabble
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + * uint32_t value					 value to set port
>> + */
>> +static void sim_set_ports(sim_t *sim, uint32_t value)
>> +{
>> +	uint32_t reg_data;
>> +	void __iomem *addr;
>> +
>> +#if defined(CONFIG_SOC_IMX25)
>> +	if (cpu_is_mx25()) {
>> +		addr = sim->ioaddr + PORT0_CNTL;
>> +	}
>> +#else
>> +	if (sim->sim_number ==0)
>> +		addr = sim->ioaddr + PORT0_CNTL;
>> +	else
>> +		addr = sim->ioaddr + PORT1_CNTL;
>> +#endif
>> +
>> +	reg_data = __raw_readl(addr);
>> +	reg_data |= value;
>> +	__raw_writel(reg_data, addr);
>> +
>> +}
>> +
>> +
>> +/* Function: sim_power_on
>> + *
>> + * Description: run the power on sequence. Follow sequence explained in
>> RM 39.5
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_power_on(sim_t *sim)
>> +{
>> +	uint32_t reg_data;
>> +
>> +	// Power on sequence
> This comment is not very useful.
>
>> +	sim_debug("%s Powering on the sim port.\n", __func__);
>> +
>> +	// Enable Vcc enable port
>> +	sim_set_ports(sim, SIM_PORT_CNTL_SVEN);
>> +	msleep(10);//TODO: adjust this delay
>> +
>> +	// Enable CLK enable Port
>> +	sim_set_ports(sim, SIM_PORT_CNTL_SCEN);
>> +	msleep(10);//TODO: adjust this delay
>> +
>> +	// Configure RCV parameters
>> +	reg_data = SIM_RCV_THRESHOLD_RTH(0) | SIM_RCV_THRESHOLD_RDT(1);
>> +	__raw_writel(reg_data, sim->ioaddr + RCV_THRESHOLD);
>> +	__raw_writel(SIM_RCV_STATUS_RDRF, sim->ioaddr + RCV_STATUS);
>> +
>> +	//Configure int
>> +	reg_data = __raw_readl(sim->ioaddr + INT_MASK);
>> +	reg_data&= ~SIM_INT_MASK_RIM;
>> +	__raw_writel(reg_data, sim->ioaddr + INT_MASK);
>> +
>> +	//Duplicate in function sim_start
>> +	__raw_writel(31, sim->ioaddr + DIVISOR);
>> +	reg_data = __raw_readl(sim->ioaddr + CNTL);
>> +	reg_data |= SIM_CNTL_SAMPLE12;
>> +	__raw_writel(reg_data, sim->ioaddr + CNTL);
>> +
>> +	// Enable RCV
>> +	reg_data = __raw_readl(sim->ioaddr + ENABLE);
>> +	reg_data |= SIM_ENABLE_RCVEN;
>> +	__raw_writel(reg_data, sim->ioaddr + ENABLE);
>> +
>> +	// Enable RST
>> +	sim_set_ports(sim, SIM_PORT_CNTL_SRST);
>> +	msleep(10);//TODO: adjust this delay
>> +
>> +	sim->power = SIM_POWER_ON;
>> +
>> +};
>> +
>> +/* Function: sim_power_off
>> + *
>> + * Description: run the power off sequence
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_power_off(sim_t *sim)
>> +{
>> +	uint32_t reg_data;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +	/* sim_power_off sequence */
>> +
>> +	//disable clk
>> +	sim_clear_ports(sim, SIM_PORT_CNTL_SCEN);
>> +
>> +	reg_data = __raw_readl(sim->ioaddr + ENABLE);
>> +	reg_data&= ~SIM_ENABLE_RCVEN;
>> +	__raw_writel(reg_data, sim->ioaddr + ENABLE);
>> +
>> +	reg_data = __raw_readl(sim->ioaddr + INT_MASK);
>> +	reg_data |= SIM_INT_MASK_RIM;
>> +	__raw_writel(reg_data, sim->ioaddr + INT_MASK);
>> +
>> +	__raw_writel(0, sim->ioaddr + RCV_THRESHOLD);
>> +
>> +	//Disable RST
>> +	sim_clear_ports(sim, SIM_PORT_CNTL_SRST);
>> +	//Disable Vcc enable port
>> +	sim_clear_ports(sim, SIM_PORT_CNTL_SVEN);
>> +
>> +	sim->power = SIM_POWER_OFF;
>> +};
>> +
>> +/* Function: sim_set_clk_sim
>> + *
>> + * Description: Set CLK SIM frequency
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +uint32_t sim_set_clk_sim(sim_t *sim)
>> +{
>> +	uint32_t clk_rate, clk_div = 0;
>> +	// get ipg_clk
>> +	clk_rate = clk_get_rate(sim->clk);
>> +	// calcule divisor
>> +	clk_div = clk_rate / sim->clk_sim;
>> +	if (clk_rate % sim->clk_sim)
>> +		clk_div++;
>> +	//write divisor
>> +	__raw_writel(clk_div, sim->ioaddr + CLK_PRESCALER);
>> +	//calculate real Value
>> +	clk_rate =clk_rate/clk_div;
>> +
>> +	sim_debug("%s prescaler is 0x%x.\n", __func__, clk_div);
>> +	sim_debug("Clk = %d Hz\n", clk_rate);
>> +
>> +	return clk_rate;
>> +}
>> +
>> +/* Function: sim_set_clk_uart_divisor
>> + *
>> + * Description: Set SIM Uart divisor frequency
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +int sim_set_clk_uart_divisor(sim_t *sim)
>> +{
>> +	uint32_t reg, divisor;
>> +
>> +	//ajust baud_sel ->  divisor register
> s/ajust/adjust/
>
>> +	reg = __raw_readl(sim->ioaddr + CNTL);
>> +	//ajust sample 12
>> +	if ((sim->uart_div % 12) == 0)
>> +	{
> See Documentaion/CodingStyle for placing braces.
>
>> +		reg |= SIM_CNTL_SAMPLE12;
>> +		divisor=sim->uart_div/12;
>> +	}
>> +	else if ((sim->uart_div % 8) == 0)
>> +	{
>> +		reg&= ~SIM_CNTL_SAMPLE12;
>> +		divisor=sim->uart_div/8;
>> +	}
>> +	else
>> +	{
>> +		sim_debug("%s no valid divisor \n", __func__);
>> +		return -1;
>> +	}
>> +	// put 111 in baud_sel for use Divisor register
>> +	reg |=  SIM_CNTL_BAUD_SEL(7);
>> +	__raw_writel(reg, sim->ioaddr + CNTL);
>> +	//ajust Divisor register
>> +	__raw_writel(divisor, sim->ioaddr + DIVISOR );
>> +	sim_debug("%s divisor is %d.\n", __func__, sim->uart_div);
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +
>> +/* Function: sim_start
>> + *
>> + * Description: ramp up the SIM interface.
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +static void sim_start(sim_t *sim)
>> +{
>> +	uint32_t reg_data = 0;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +	// Configuring SIM for Operation
>> +	// Adjust XMT thresholds (no NACK and 4 bytes or less to activate TDTF bit
>> +	reg_data = SIM_XMT_THRESHOLD_XTH(0) | SIM_XMT_THRESHOLD_TDT(4);
>> +	__raw_writel(reg_data, sim->ioaddr + XMT_THRESHOLD);
>> +	// Enable SIM port N and alternate port disabled ->  Only applies to MX51
>> +	// Always eanble port 0,
>> +
>> +	// Always enable port 0 ->  Duplicated SIM core
>> +	__raw_writel(0x00, sim->ioaddr + SETUP);
>> +
>> +	// Adjust clock divider in function of platform definitions
>> +	// 66.5 / 5 ->  13.5 ->  14 (4.75MHZ initial frequency)
>> +	sim->clk_sim = sim->plat_data->clk_rate;
>> +	sim_set_clk_sim(sim);
>> +
>> +	// Adjust Control register
>> +	reg_data = __raw_readl(sim->ioaddr + CNTL);
>> +	reg_data |=  SIM_CNTL_ANACK | SIM_CNTL_ICM;
>> +	__raw_writel(reg_data, sim->ioaddr + CNTL);
>> +
>> +	// Adjust BAUD divider
>> +	sim->uart_div=SIM_DEFAULT_BAUD_DIV;
>> +	sim_set_clk_uart_divisor(sim);
>> +
>> +	// Adjust Open Drain in Port 0 XMT configuration register
>> +	reg_data = __raw_readl(sim->ioaddr + OD_CONFIG);
>> +	reg_data |= SIM_OD_CONFIG_OD_P0 | SIM_OD_CONFIG_OD_P1;
>> +	__raw_writel(reg_data, sim->ioaddr + OD_CONFIG);
>> +
>> +	// Adjust Port 0
>> +	reg_data = __raw_readl(sim->ioaddr + PORT0_CNTL);
>> +	reg_data |= SIM_PORT_CNTL_3VOLT | SIM_PORT_CNTL_STEN;
>> +	__raw_writel(reg_data, sim->ioaddr + PORT0_CNTL);
>> +
>> +	// Since there is no PD0 layout on MX51, assume that there is a SIM card
>> in slot defaulty.
>> +	if (0 == (sim->plat_data->detect)) {
>> +		reg_data = __raw_readl(sim->ioaddr + PORT0_DETECT);
>> +		reg_data |= SIM_PORT_DETECT_SPDS;
>> +		__raw_writel(reg_data, sim->ioaddr + PORT0_DETECT);
>> +		sim->present = SIM_PRESENT_DETECTED;
>> +	}
>> +
>> +	// FQ enable SIM present on the future
>> +	if (sim->present == SIM_PRESENT_DETECTED)
>> +		sim_power_on(sim);
>> +
>> +};
>> +
>> +/* Function: sim_stop
>> + *
>> + * Description: shut down the SIM interface
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_stop(sim_t *sim)
>> +{
>> +	sim_debug("%s entering.\n", __func__);
>> +	__raw_writel(0, sim->ioaddr + SETUP);
>> +	__raw_writel(0, sim->ioaddr + ENABLE);
>> +	__raw_writel(0, sim->ioaddr + PORT0_CNTL);
>> +	__raw_writel(SIM_CNTL_ANACK | SIM_CNTL_ICM, sim->ioaddr + CNTL);
>> +	__raw_writel(0, sim->ioaddr + CLK_PRESCALER);
>> +	__raw_writel(0, sim->ioaddr + SETUP);
>> +	__raw_writel(0, sim->ioaddr + OD_CONFIG);
>> +	__raw_writel(0, sim->ioaddr + XMT_THRESHOLD);
>> +	//Clear XMT_STATUS
>> +	__raw_writel( SIM_XMT_STATUS_TDTF | SIM_XMT_STATUS_TC   |
>> +								SIM_XMT_STATUS_ETC  |	SIM_XMT_STATUS_TFE   , sim->ioaddr +
>> XMT_STATUS);
>> +	//Enable SOFT_RESET
>> +	__raw_writel(SIM_RESET_CNTL_SOFT_RST , sim->ioaddr + RESET_CNTL);
>> +	mdelay(1);//TODO: adjust this delay
>> +};
>> +
>> +/* Function: sim_data_reset
>> + *
>> + * Description: reset a SIM structure to default values
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_data_reset(sim_t *sim)
>> +{
>> +	sim->present = SIM_PRESENT_REMOVED;
>> +	sim->state = SIM_STATE_REMOVED;
>> +	sim->power = SIM_POWER_OFF;
>> +	sim->errval = SIM_OK;
>> +};
>> +
>> +/* Function: sim_cold_reset
>> + *
>> + * Description: cold reset the SIM interface, including card
>> + * power down and interface hardware reset.
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_cold_reset(sim_t *sim)
>> +{
>> +	sim_debug("%s entering.\n", __func__);
>> +	if (sim->present != SIM_PRESENT_REMOVED) {
>> +		sim_power_off(sim);
>> +		sim_stop(sim);
>> +		sim_data_reset(sim);
>> +		sim->state = SIM_STATE_DETECTED_ATR_T0;
>> +		sim->present = SIM_PRESENT_DETECTED;
>> +		msleep(50);//TODO: adjust this delay
>> +		sim_start(sim);
>> +		sim_power_on(sim);
>> +	};
>> +};
>> +
>> +/* Function: sim_warm_reset
>> + *
>> + * Description: warm reset the SIM interface: just invoke the
>> + * reset signal and reset the SIM structure for the interface.
>> + *
>> + * Parameters:
>> + * sim_t* sim              pointer to SIM device handler
>> + */
>> +
>> +static void sim_warm_reset(sim_t *sim)
>> +{
>> +	sim_debug("%s entering.\n", __func__);
>> +	if (sim->present != SIM_PRESENT_REMOVED) {
>> +		sim_set_ports(sim,SIM_PORT_CNTL_SRST);
>> +		sim_data_reset(sim);
>> +		msleep(50);//TODO: adjust this delay
>> +		sim_clear_ports(sim,SIM_PORT_CNTL_SRST);
>> +
>> +	};
>> +};
>> +
>> +/* Function: sim_ioctl
>> + *
>> + * Description: handle ioctl calls
>> + *
>> + * Parameters: OS specific
>> + */
>> +
>> +static long sim_ioctl(struct file *file, unsigned int cmd, unsigned long
>> arg)
>> +{
>> +	int ret=0, value=-1;
>> +	unsigned long real_freq;
>> +	unsigned char version = SIM_DRIVER_VERSION;
>> +	sim_t *sim = (sim_t *) file->private_data;
>> +	sim_reg s_reg = {0,0};
>> +
>> +	sim_debug("%s cmd %d \n", __func__, cmd);
>> +	switch (cmd) {
>> +		sim_debug("ioctl cmd %d is issued...\n", cmd);
>> +
>> +		case SIM_IOCTL_VERSION:
>> +			sim_debug("ioctl cmd SIM_IOCTL_VERSION\n");
>> +			ret = copy_to_user((unsigned char *) arg,&version,
>> +						 sizeof(unsigned char));
>> +			break;
>> +
>> +		case SIM_IOCTL_POWER_ON:
>> +			sim_debug("ioctl cmd SIM_IOCTL_POWER_ON\n");
>> +			if (sim->power == SIM_POWER_ON) {
>> +				ret = -SIM_E_POWERED_ON;
>> +				break;
>> +			};
>> +			sim_power_on(sim);
>> +			break;
>> +
>> +		case SIM_IOCTL_POWER_OFF:
>> +			sim_debug("ioctl cmd SIM_IOCTL_POWER_OFF\n");
>> +			if (sim->power == SIM_POWER_OFF) {
>> +				ret = -SIM_E_POWERED_OFF;
>> +				break;
>> +			};
>> +			sim_power_off(sim);
>> +			break;
>> +
>> +		case SIM_IOCTL_COLD_RESET:
>> +			sim_debug("ioctl cmd SIM_IOCTL_COLD_RESET\n");
>> +			if (sim->power == SIM_POWER_OFF) {
>> +				ret = -SIM_E_POWERED_OFF;
>> +				break;
>> +			};
>> +			sim_cold_reset(sim);
>> +			break;
>> +
>> +		case SIM_IOCTL_WARM_RESET:
>> +			sim_debug("ioctl cmd SIM_IOCTL_WARM_RESET\n");
>> +			sim_warm_reset(sim);
>> +			if (sim->power == SIM_POWER_OFF) {
>> +				ret = -SIM_E_POWERED_OFF;
>> +				break;
>> +			};
>> +			break;
>> +
>> +		case SIM_IOCTL_CLK_PORT:
>> +			sim_debug("ioctl cmd SIM_IOCTL_CLK_PORT\n");
>> +			ret = copy_from_user(&value, (int *) arg,
>> +								 sizeof(int));
>> +			if (value == 0)
>> +				sim_set_ports(sim, SIM_PORT_CNTL_SCEN);
>> +			else
>> +				sim_clear_ports(sim, SIM_PORT_CNTL_SCEN);
>> +			break;
>> +
>> +		case SIM_IOCTL_RST_PORT:
>> +			sim_debug("ioctl cmd SIM_IOCTL_RST_PORT\n");
>> +			ret = copy_from_user(&value, (int *) arg,
>> +								 sizeof(int));
>> +			if (value == 0)
>> +				sim_set_ports(sim, SIM_PORT_CNTL_SRST);
>> +			else
>> +				sim_clear_ports(sim, SIM_PORT_CNTL_SRST);
>> +			break;
>> +
>> +		case SIM_IOCTL_VCC_PORT:
>> +			sim_debug("ioctl cmd SIM_IOCTL_VCC_PORT\n");
>> +			ret = copy_from_user(&value, (int *) arg,
>> +								 sizeof(int));
>> +			if (value == 0)
>> +				sim_set_ports(sim, SIM_PORT_CNTL_SVEN);
>> +			else
>> +				sim_clear_ports(sim, SIM_PORT_CNTL_SVEN);
>> +			break;
>> +
>> +		case SIM_IOCTL_SET_CLK_SIM:
>> +			sim_debug("ioctl cmd SIM_IOCTL_SET_CLK_SIM\n");
>> +			ret = copy_from_user(&real_freq, (unsigned long *) arg,
>> +									 sizeof(unsigned long));
>> +			if (sim->clk_sim>  0)
>> +			{
>> +				sim->clk_sim = real_freq;
>> +				real_freq = sim_set_clk_sim(sim);
>> +			}
>> +			else
>> +			{
>> +				sim_debug("Invalid Freq. %lu Hz\n",real_freq );
>> +				real_freq = -1;
>> +			}
>> +			ret = copy_to_user((unsigned long *) arg,&real_freq,
>> +						sizeof(unsigned long));
>> +			break;
>> +
>> +		case SIM_IOCTL_SET_CLK_DIV:
>> +			sim_debug("ioctl cmd SIM_IOCTL_SET_CLK_DIV\n");
>> +			ret = copy_from_user(&value, (int *) arg,
>> +									 sizeof(int));
>> +			if (sim->uart_div>  0)
>> +					{
>> +						sim->uart_div = value;
>> +						ret = sim_set_clk_uart_divisor(sim);
>> +					}
>> +					else
>> +					{
>> +						sim_debug("Invalid DIV. %d\n",value);
>> +					}
>> +			break;
>> +
>> +	/*debug register*/
>> +		case SIM_IOCTL_GET_REG:
>> +			sim_debug("ioctl cmd SIM_IOCTL_GET_REG\n");
>> +			ret = copy_from_user(&s_reg, (sim_reg *) arg, sizeof(sim_reg));
>> +			s_reg.data =(unsigned long) __raw_readl(s_reg.addr);
>> +			ret = copy_to_user((sim_reg *) arg,&s_reg, sizeof(sim_reg));
>> +			break;
>> +
>> +		case SIM_IOCTL_SET_REG:
>> +			sim_debug("ioctl cmd SIM_IOCTL_SET_REG\n");
>> +			ret = copy_from_user(&s_reg, (sim_reg *) arg, sizeof(sim_reg));
>> +			__raw_writel( (uint32_t) s_reg.data,  sim->ioaddr + s_reg.addr);
>> +			break;
>> +	};
>> +
>> +	return ret;
>> +};
>> +
>> +/* Function: sim_write
>> + *
>> + * Description: handle write calls
>> + *
>> + * Parameters: OS specific
>> + */
>> +static ssize_t sim_write(struct file *file, const char *user_buf,
>> +		size_t count, loff_t *ppos)
>> +{
>> +	int ret=0, i;
>> +	uint32_t reg_data=0;
>> +	sim_t *sim = (sim_t *) file->private_data;
>> +	char write_buffer[SIM_XMT_BUFFER_SIZE];
>> +	int timeout;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +
>> +		ret = copy_from_user(write_buffer, user_buf,count);
> broken indention.
>
>> +		if (ret)
>> +			return  -EFAULT;
>> +
>> +		//start XMT
>> +		reg_data = __raw_readl(sim->ioaddr + ENABLE);
>> +		reg_data |= SIM_ENABLE_XMTEN;
>> +		__raw_writel(reg_data, sim->ioaddr + ENABLE);
>> +
>> +		for (i=0; i<  count; i++)
>> +		{
>> +			//transmit 1 Byte
>> +			__raw_writel( write_buffer[i],sim->ioaddr + PORT1_XMT_BUF );
>> +			sim_debug( "TX = %02x\n", write_buffer[i] );
>> +
>> +			// wait write 1 Byte TODO: interupts
>> +			timeout= WRITE_TIMEOUT;
>> +			do {
>> +			reg_data = __raw_readl( sim->ioaddr + XMT_FIFO_STAT );
>> +			reg_data = ( reg_data&&  SIM_XMT_FIFO_XMT_CNT_MASK )>>  8;
>> +			sim_debug("wait write, timeout = %d", timeout );
>> +			timeout--;
>> +			}while  ( reg_data>  0&&  timeout != 0 );
> broken indention.
>
>> +		}
>> +
>> +		//disable write
>> +		reg_data = __raw_readl( sim->ioaddr + ENABLE );
>> +		reg_data&= ~SIM_ENABLE_XMTEN;
>> +		__raw_writel( reg_data, sim->ioaddr + ENABLE );
>> +
>> +		return i;
>> +};
>> +
>> +/* Function: sim_read
>> + *
>> + * Description: handle read calls
>> + *
>> + * Parameters: OS specific
>> + */
>> +static ssize_t sim_read(struct file *file, char *user_buf,
>> +		size_t count, loff_t *ppos)
>> +{
>> +	int ret=0;
>> +	char read_buffer[SIM_RCV_BUFFER_SIZE];
>> +	sim_t *sim = (sim_t *) file->private_data;
>> +	int i=0;
>> +	int timeout = READ_TIMEOUT;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +
>> +	while (__raw_readl(sim->ioaddr + RCV_FIFO_CNT) != 0&&  i<  count&&
>> timeout>  0 ) {
>> +		uint32_t data;
>> +		data = __raw_readl(sim->ioaddr + PORT1_RCV_BUF);
>> +		sim_debug("RX = %02x\n", data);
>> +		//detect parity ERROR or FRAME ERROR or CWT ERROR
>> +		if ( data&  (PORT_RCV_BUF_PE | PORT_RCV_BUF_FE | PORT_RCV_BUF_CWT ) )
>> +		{
>> +			printk(KERN_ERR "ERROR READ !\n");
>> +			return IRQ_HANDLED;
>> +		}
>> +		else{
>> +			read_buffer[i] = (char) data;
>> +			i++;
>> +		}
>> +		timeout--;
>> +	};
>> +	ret = copy_to_user(user_buf, read_buffer,i);
>> +	if (ret)
>> +		return -EFAULT;
>> +
>> +	return i;
>> +}
>> +
>> +
>> +/* Function: sim_open
>> + *
>> + * Description: ramp up interface when being opened
>> + *
>> + * Parameters: OS specific
>> + */
>> +
>> +static int sim_open(struct inode *inode, struct file *file)
>> +{
>> +	int errval = SIM_OK;
>> +
>> +	sim_t *sim = dev_get_drvdata(sim_dev.parent);
>> +	file->private_data = sim;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +	if (!sim->ioaddr) {
>> +		errval = -ENOMEM;
>> +		return errval;
>> +	}
>> +
>> +	if (!(sim->clk_flag)) {
>> +		sim_debug("\n%s enable the clock ret = %d\n", __func__,
>> clk_enable(sim->clk) );
>> +		sim->clk_flag = 1;
>> +	}
>> +
>> +	sim_start(sim);
>> +
>> +	return errval;
>> +};
>> +/* Function: sim_fasync
>> + *
>> + * Description: async handler
>> + *
>> + * Parameters: OS specific
>> + */
>> +
>> +static int sim_fasync(int fd, struct file *file, int mode)
>> +{
>> +	sim_t *sim = (sim_t *) file->private_data;
>> +	pr_debug("%s entering.\n", __func__);
>> +	return fasync_helper(fd, file, mode,&sim->fasync);
>> +}
>> +/* Function: sim_release
>> + *
>> + * Description: shut down interface when being closed
>> + *
>> + * Parameters: OS specific
>> + */
>> +
>> +static int sim_release(struct inode *inode, struct file *file)
>> +{
>> +	uint32_t reg_data;
>> +
>> +	sim_t *sim = (sim_t *) file->private_data;
>> +
>> +	sim_debug("%s entering.\n", __func__);
>> +	if (sim->clk_flag) {
>> +		sim_debug("\n%s disable the clock\n", __func__);
>> +		clk_disable(sim->clk);
>> +		sim->clk_flag = 0;
>> +	}
>> +
>> +	/* disable presense detection */
>> +	reg_data = __raw_readl(sim->ioaddr + PORT0_DETECT);
>> +	__raw_writel(reg_data | SIM_PORT_DETECT_SDIM, sim->ioaddr + PORT0_DETECT);
>> +
>> +	if (sim->present != SIM_PRESENT_REMOVED) {
>> +		sim_power_off(sim);
>> +		if (sim->fasync)
>> +			kill_fasync(&sim->fasync, SIGIO, POLL_IN);
>> +	};
>> +
>> +	sim_stop(sim);
>> +
>> +	sim_fasync(-1, file, 0);
>> +
>> +	sim_debug("exit\n");
>> +	return 0;
>> +};
>> +
>> +static const struct file_operations sim_fops = {
>> +	.owner 	=	THIS_MODULE,
>> +	.read = sim_read,
>> +	.write = sim_write,
>> +	.open = sim_open,
>> +	.unlocked_ioctl = sim_ioctl,
>> +	.fasync = sim_fasync,		// FQ commented
>> +	.release = sim_release
>> +};
>> +
>> +// TODO ->  Dev name must be dynamic or include all SIM ports
>> +/*
>> +static struct miscdevice sim_dev = {
>> +		MISC_DYNAMIC_MINOR,
>> +		NULL,
>> +		&sim_fops,
>> +};
>> +*/
>> +
>> +/*****************************************************************************\
>> + *
>>     *
>> + * Driver init/exit
>>     *
>> + *
>>     *
>> +\*****************************************************************************/
> Trailing whitespaces here.
>
>> +
>> +static int sim_probe(struct platform_device *pdev)
>> +{
>> +	int ret = 0;
>> +	struct mxc_sim_platform_data *sim_plat = pdev->dev.platform_data;
>> +
>> +	sim_t *sim = kzalloc(sizeof(sim_t), GFP_KERNEL);
>> +
>> +	if (sim == 0) {
>> +		ret = -ENOMEM;
>> +		printk(KERN_ERR "Can't get the MEMORY\n");
>> +		return ret;
>> +	};
>> +
>> +	BUG_ON(pdev == NULL);
>> +
>> +	sim->plat_data = sim_plat;
>> +	sim->clk_flag = 0;
>> +	sim->sim_number = sim->plat_data->sim_number;
>> +
>> +	printk(KERN_INFO "Trying initialize port %d...\n", sim->sim_number);
>> +
>> +	sim->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!sim->res) {
>> +		ret = -ENOMEM;
>> +		printk(KERN_ERR "Can't get the MEMORY\n");
> Use dev_err here. Also it is useful to print the error value here.
>
>> +		goto out;
>> +	}
>> +
>> +	// request the sim clk and sim_serial_clk
>> +	sim_debug("CLK rate:%d\n", sim->plat_data->clk_rate);
>> +	sim->clk = clk_get_sys(sim->plat_data->clock_sim, NULL);
>> +	if (IS_ERR(sim->clk)) {
>> +		ret = PTR_ERR(sim->clk);
>> +		printk(KERN_ERR "Get CLK ERROR !\n");
>> +		goto out;
>> +	}
>> +	sim_debug("sim clock:%lu\n", clk_get_rate(sim->clk));
>> +
>> +	if (!request_mem_region(sim->res->start,
>> +				sim->res->end -
>> +				sim->res->start + 1, pdev->name)) {
>> +		printk(KERN_ERR "request_mem_region failed\n");
>> +		ret = -ENOMEM;
>> +		goto out1;
>> +	}
>> +
>> +	sim->ioaddr = (void *)ioremap(sim->res->start, sim->res->end -
>> +				      sim->res->start + 1);
> ioremap can fail.
>
>> +
>> +	platform_set_drvdata(pdev, sim);
>> +	sim_dev.minor = MISC_DYNAMIC_MINOR;
>> +	if 				(sim->sim_number == 0)
>> +		sim_dev.name = SIM1_DEV_NAME;
>> +	else if 	(sim->sim_number == 1)
>> +		sim_dev.name = SIM2_DEV_NAME;
>> +	sim_dev.fops =&sim_fops,
>> +	sim_dev.parent =&(pdev->dev);
>> +
>> +	misc_register(&sim_dev);
> I suppose this function can fail?
>
>> +
>> +	return ret;
>> +
>> +out1:
>> +	clk_put(sim->clk);
>> +out:
>> +	kfree(sim);
>> +	return ret;
>> +}
>> +
>> +static int sim_remove(struct platform_device *pdev)
>> +{
>> +	sim_t *sim = platform_get_drvdata(pdev);
>> +
>> +	clk_put(sim->clk);
>> +
>> +	if (sim->ipb_irq)
>> +		free_irq(sim->ipb_irq, sim);
>> +	if (sim->dat_irq)
>> +		free_irq(sim->dat_irq, sim);
> I see no request_irq anywhere in this patch.
>
>> +
>> +	iounmap(sim->ioaddr);
>> +
>> +	kfree(sim);
>> +	release_mem_region(sim->res->start,
>> +			   sim->res->end - sim->res->start + 1);
>> +
>> +
>> +	misc_deregister(&sim_dev);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver sim_driver = {
>> +	.driver = {
>> +		   .name = DRIVER_NAME,
>> +		   .owner	= THIS_MODULE,
>> +		   },
>> +	.probe = sim_probe,
>> +	.remove = sim_remove,
>> +	.suspend = NULL,
>> +	.resume = NULL,
>> +};
>> +
>> +static int __init sim_drv_init(void)
>> +{
>> +	printk(KERN_INFO "IMX : SIM driver\n");
>> +
>> +	return platform_driver_register(&sim_driver);
>> +}
>> +
>> +static void __exit sim_drv_exit(void)
>> +{
>> +	platform_driver_unregister(&sim_driver);
>> +}
>> +
>> +module_init(sim_drv_init);
>> +module_exit(sim_drv_exit);
>> +
>> +MODULE_AUTHOR("FQ Ingenieria Electronica S.A.");
>> +MODULE_DESCRIPTION("MXC SIM Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 1.5.4.3
>>
>>
>>
