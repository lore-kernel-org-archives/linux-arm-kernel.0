From: b32955@freescale.com (Huang Shijie)
Date: Fri, 8 Jul 2011 15:40:46 +0800
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <20110708073119.GP29624@pengutronix.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<1309406028-2924-2-git-send-email-b32955@freescale.com>
	<201106301555.19440.arnd@arndb.de>
	<20110708073119.GP29624@pengutronix.de>
Message-ID: <4E16B47E.8090909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?07?08? 15:31, Uwe Kleine-K?nig ??:
> Hello,
>
> On Thu, Jun 30, 2011 at 03:55:19PM +0200, Arnd Bergmann wrote:
>> On Thursday 30 June 2011, Huang Shijie wrote:
>>> add GPMI-NFC support for imx23 and imx28.
>>>
>>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>>> +/**
>>> + * struct gpmi_nfc_platform_data - GPMI NFC driver platform data.
>>> + *
>>> + * This structure communicates platform-specific information to the GPMI NFC
>>> + * driver that can't be expressed as resources.
>>> + *
>>> + * @platform_init:           A pointer to a function the driver will call to
>>> + *                           initialize the platform (e.g., set up the pin mux).
>>> + * @platform_exit:           A pointer to a function the driver will call to
>>> + *                           exit the platform (e.g., free pins).
>>> + * @min_prop_delay_in_ns:    Minimum propagation delay of GPMI signals to and
>>> + *                           from the NAND Flash device, in nanoseconds.
>>> + * @max_prop_delay_in_ns:    Maximum propagation delay of GPMI signals to and
>>> + *                           from the NAND Flash device, in nanoseconds.
>>> + * @max_chip_count:          The maximum number of chips for which the driver
>>> + *                           should configure the hardware. This value most
>>> + *                           likely reflects the number of pins that are
>>> + *                           connected to a NAND Flash device. If this is
>>> + *                           greater than the SoC hardware can support, the
>>> + *                           driver will print a message and fail to initialize.
>>> + * @partitions:              An optional pointer to an array of partition
>>> + *                           descriptions.
>>> + * @partition_count:         The number of elements in the partitions array.
>>> + */
>>> +struct gpmi_nfc_platform_data {
>>> +	/* SoC hardware information. */
>>> +	int		(*platform_init)(void);
>>> +	void		(*platform_exit)(void);
>>> +
>>> +	/* NAND Flash information. */
>>> +	unsigned int	min_prop_delay_in_ns;
>>> +	unsigned int	max_prop_delay_in_ns;
>>> +	unsigned int	max_chip_count;
>>> +
>>> +	/* Medium information. */
>>> +	struct mtd_partition *partitions;
>>> +	unsigned	partition_count;
>>> +};
>> When adding new infrastructure, always keep in mind how you want it to look
>> after the device tree conversion. The partitions and min/max_* are easily covered
>> with that, but the init/exit function pointers are somewhat problematic.
>>
>> Fortunately, you don't really require these functions for this driver. The _exit
>> function is completely unused, so just get rid of it.
>>
>> The init function is used only to set up iomux, so the logical replacement is
>> a pointer to the iomux data, and calling mxs_iomux_setup_multiple_pads
>> directly from the driver.
> Why not put the iomux stuff into the per-machine table and get rid of
> the init callback, too?

The mmc (ssp) has pin conflict with gpmi on both mx23evk and mx28evk.
So, it's better to initialize the pin when the driver(GPMI or MMC) is 
enabled.
I think the init callback is good solution.

Best Regards
Huang Shijie

> Best regards
> Uwe
>
