From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 5 May 2010 11:04:15 +0200
Subject: [spi-devel-general] [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636E9BA5D3@AUSP01VMBX24.collaborationhost.net>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636E9BA5D3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <w2h63386a3d1005050204t13284de8p3fa692ed647e3bee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/3 H Hartley Sweeten <hartleys@visionengravers.com>:
> On Sunday, May 02, 2010 5:19 PM, Linus Walleij wrote:

>> When I look at this it's quite obvious that this is the same hardware or very
>> close (maybe a redux version) of the thing supported by
>> drivers/spi/amba-pl022.c.
>>
>> What is the difference really? I suspect this is a PL022 PrimeCell straight off.
>> Even the CPSR algorithm is the same, just written differently.
>>
>> Can you make a hexdump of the PrimeCell ID registers at offset
>> base+0xffe0..0xffff and post the contents?
>
> As Mika already pointed out, the ep93xx ssp peripheral does not have a valid
> PeripheralID or PrimeCellID to identify it as an AMBA PL022 peripheral.

Yep, but how close is it... the raw PL022 and the ST Micro variant only differ
in a few small places.

> It probably was originally based on the PL022 but I think Cirrus hacked it
> enough that the generic amba-pl022 driver will not work with it, at least
> without a number of ugly #ifdef hacks.

The stuff we've done with vendor data is mostly done so that we alter
execution path in runtime rather than throwing in #ifdefs.

> Or, I could be wrong. ?It appears the amba-pl022 driver doesn't actually match
> the ARM spec for the PL022.

You're right, the control registers are not cleanly separated into the vanilla
PL022 vs ST Micro Nomadik extensions. I will post a fixup patch soonish,
covering all the stuff you pointed out.

When you look at the code post-patch I think you will see that it
is actually even closer, to the vanilla PL022.

Sorry for the mess, I was retrofitting a driver for the ST extended
version to the plain PL022 found in U300 and missed some stuff.

By chance, Rabin pointed me to the same problems some day ago...

> The PL022 spec only shows the peripheral as supporting up to 16-bit transfers.
> This is the limit for the EP93xx also but the amba-pl022 driver actually supports
> up to 32-bit transfers.

Actually the code execution path takes this into account in
the pl022_setup() function:

	if (chip_info->data_size <= 8) {
		dev_dbg(&spi->dev, "1 <= n <=8 bits per word\n");
		chip->n_bytes = 1;
		chip->read = READING_U8;
		chip->write = WRITING_U8;
	} else if (chip_info->data_size <= 16) {
		dev_dbg(&spi->dev, "9 <= n <= 16 bits per word\n");
		chip->n_bytes = 2;
		chip->read = READING_U16;
		chip->write = WRITING_U16;
	} else {
		if (pl022->vendor->max_bpw >= 32) {
			dev_dbg(&spi->dev, "17 <= n <= 32 bits per word\n");
			chip->n_bytes = 4;
			chip->read = READING_U32;
			chip->write = WRITING_U32;
		} else {
			dev_err(&spi->dev,
				"illegal data size for this controller!\n");
			dev_err(&spi->dev,
				"a standard pl022 can only handle "
				"1 <= n <= 16 bit words\n");
			goto err_config_params;
		}
	}

As you see 32bit transfers will only be accepted as configuration if the
vendor data indicates that this is possible on that version of the controller.

> /*
> ?* SSP Interrupt Mask Set/Clear Register - SSP_IMSC
> ?*/
> #define SSP_IMSC_MASK_RORIM (0x1UL << 0) /* Receive Overrun Interrupt mask */
> #define SSP_IMSC_MASK_RTIM ?(0x1UL << 1) /* Receive timeout Interrupt mask */
> #define SSP_IMSC_MASK_RXIM ?(0x1UL << 2) /* Receive FIFO Interrupt mask */
> #define SSP_IMSC_MASK_TXIM ?(0x1UL << 3) /* Transmit FIFO Interrupt mask */
>
> In the EP93xx this register is called SSPIIR / SSPICR. ?It is the interrupt
> status register for reads and the interrupt clear register for writes. ?For
> reads it is defined as:
>
> 0 ?RIS ? ?SSP Receive FIFO service request
> 1 ?TIS ? ?SSP Transmit FIFO service request
> 2 ?RORIS ?SSP Receive FIFO overrun interrupt status

This seems like it is either a precursor to the PL022 or a seriously
stripped down version. I don't know if this alone warrants duplicating the
rest of the code, could be.

> The other registers listed for the amba-pl022 do not exist in the EP93xx
> implementation.

We have a stripped down version called "PL023" as well, it's simply
that we don't use the extended features and it just works, so I think
it's not much of a problem.

> The biggest problem I can see trying to use the amba-pl022 with the ep93xx
> are the missing Peripheral ID and PrimeCell ID registers. ?The AMBA bus driver
> will not be able to match the driver to the device.

That is actually not a problem at all, you can hardcode a PrimeCell
ID into the platform config, and the device will be registered on the
given ID instead, like this:

struct amba_device ssp0_device = {
        .dev = {
                .coherent_dma_mask = ~0,
                .init_name = "ssp0",
                .platform_data = &ssp0_platform_data,
        },
        .res = {
                .start = U8500_SSP0_BASE,
                .end   = U8500_SSP0_BASE + SZ_4K - 1,
                .flags = IORESOURCE_MEM,
        },
        .irq = {IRQ_SSP0, NO_IRQ },
        /* PL022 Device ID */
        .periphid = 0x00041022,
};

Then you have to register it on the PrimeCell bus with

static struct amba_device *amba_devs[] __initdata = {
        &ssp0_device,
};

for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
         amba_device_register(amba_devs[i], &iomem_resource);

> Beyond that, once the amba-pl022 driver supports DMA transfers the implementation
> needed for the EP93xx will be completely different.

The idea about the PrimeCell DMA is to use the DMAdevices in the
DMA engine only, to find some common ground exactly in order to
facilitate usage with diverse platforms.

I know that there are many custom DMA implementations, the idea
is that if we can unify these under DMA engine we can abstract away
the specifics. I have already done this for two very different DMA
engines: COH901318 and DMA40 and it works. DMA controllers IMO
are not so special at all, they all share the same features and
shall hopefully all go in behind the DMA engine API.

> I think it's best to leave these as separate drivers. ?Cirrus has stopped
> development of their ARM processors so we have no hope of ever getting a full
> pl022 compatible version.

I think it's worth a try to use amba-pl022.c, but hey, it's just me...

Yours,
Linus Walleij
