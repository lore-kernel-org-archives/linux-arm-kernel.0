From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Thu, 19 Feb 2015 20:28:13 +0200
Subject: [PATCH 3/4] arm: am33xx: DT quirks for am33xx based beaglebone
 variants
In-Reply-To: <20150219181656.GF32521@atomide.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-4-git-send-email-pantelis.antoniou@konsulko.com>
 <20150219181656.GF32521@atomide.com>
Message-ID: <9C7BFC7C-0751-4233-927F-D01AF078704B@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> On Feb 19, 2015, at 20:16 , Tony Lindgren <tony@atomide.com> wrote:
> 
> * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150218 07:03]:
>> Implement DT quirks for the am33xx beaglebone boards.
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/am33xx-dt-quirks.c
> ...
>> +
>> +/*
>> + * The board IDs for am33xx board are in an I2C EEPROM
>> + * We are very early in the boot process so we have to
>> + * read the EEPROM directly without using the I2C layer.
>> + *
>> + * Note that we rely on the bootloader setting up the muxes
>> + * (which is the case for u-boot).
>> + */
>> +
>> +/* I2C Status Register (OMAP_I2C_STAT): */
>> +#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
>> +#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
>> +#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
>> +#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
>> +#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
>> +#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
>> +#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
>> +#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
>> +#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
>> +#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
>> +#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
>> +#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
> ...
> 
> Uhh I don't like the idea of duplicating the i2c-omap.c driver under
> arch/arm.. And in general we should initialize things later rather
> than earlier.
> 
> What's stopping doing these quirk checks later on time with just
> a regular device driver, something like drivers/misc/bbone-quirks.c?
> 

We have no choice; we are way early in the boot process, right after
the device tree unflattening step.

I?ve toyed with the idea of using early platform devices but the omap-i2c driver
would need some tender love and care to make it work, and I didn?t want to get
bogged down with i2c driver details at this point.

> Regards,
> 
> Tony

Regards

? Pantelis
