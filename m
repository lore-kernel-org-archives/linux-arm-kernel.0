From: jgchunter@gmail.com (Jon Hunter)
Date: Fri, 20 Feb 2015 16:13:05 +0000
Subject: [PATCH 3/4] arm: am33xx: DT quirks for am33xx based beaglebone
 variants
In-Reply-To: <9C7BFC7C-0751-4233-927F-D01AF078704B@antoniou-consulting.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-4-git-send-email-pantelis.antoniou@konsulko.com>
 <20150219181656.GF32521@atomide.com>
 <9C7BFC7C-0751-4233-927F-D01AF078704B@antoniou-consulting.com>
Message-ID: <54E75D11.3060409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/2015 06:28 PM, Pantelis Antoniou wrote:
> Hi Tony,
> 
>> On Feb 19, 2015, at 20:16 , Tony Lindgren <tony@atomide.com> wrote:
>>
>> * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150218 07:03]:
>>> Implement DT quirks for the am33xx beaglebone boards.
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/am33xx-dt-quirks.c
>> ...
>>> +
>>> +/*
>>> + * The board IDs for am33xx board are in an I2C EEPROM
>>> + * We are very early in the boot process so we have to
>>> + * read the EEPROM directly without using the I2C layer.
>>> + *
>>> + * Note that we rely on the bootloader setting up the muxes
>>> + * (which is the case for u-boot).
>>> + */
>>> +
>>> +/* I2C Status Register (OMAP_I2C_STAT): */
>>> +#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
>>> +#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
>>> +#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
>>> +#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
>>> +#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
>>> +#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
>>> +#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
>>> +#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
>>> +#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
>>> +#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
>>> +#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
>>> +#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
>> ...
>>
>> Uhh I don't like the idea of duplicating the i2c-omap.c driver under
>> arch/arm.. And in general we should initialize things later rather
>> than earlier.
>>
>> What's stopping doing these quirk checks later on time with just
>> a regular device driver, something like drivers/misc/bbone-quirks.c?
>>
> 
> We have no choice; we are way early in the boot process, right after
> the device tree unflattening step.

Can you elaborate with an example of why not? Why can't the overlay
happen at a later stage in the kernel boot as Tony suggests?

One thought would be that ideally devices that are dependent on a
particular board variant would be disabled in the base DT blob until you
know what board you are. However, that assumes that they can be
initialised at a later stage in the boot process and may be for some
regulators or other devices this is not possible. I know you mentioned
some time restrictions for some devices, but I still don't see why it
could not happen later.

Jon
