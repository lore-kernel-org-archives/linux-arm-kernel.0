From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 3 May 2010 12:00:32 -0500
Subject: [spi-devel-general] [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636E9BA5D3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 02, 2010 5:19 PM, Linus Walleij wrote:
> 2010/5/2 Mika Westerberg <mika.westerberg@iki.fi>:
>> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>> in EP93xx chips.
>(...)
>> +#define SSPCR0 ? ? ? ? ? ? ? ? 0x0000
>> +#define SSPCR0_MODE_SHIFT ? ? ?6
>> +#define SSPCR0_SCR_SHIFT ? ? ? 8
>> +
>> +#define SSPCR1 ? ? ? ? ? ? ? ? 0x0004
>> +#define SSPCR1_RIE ? ? ? ? ? ? BIT(0)
>> +#define SSPCR1_TIE ? ? ? ? ? ? BIT(1)
>> +#define SSPCR1_RORIE ? ? ? ? ? BIT(2)
>> +#define SSPCR1_LBM ? ? ? ? ? ? BIT(3)
>> +#define SSPCR1_SSE ? ? ? ? ? ? BIT(4)
>> +#define SSPCR1_MS ? ? ? ? ? ? ?BIT(5)
>> +#define SSPCR1_SOD ? ? ? ? ? ? BIT(6)
>> +
>> +#define SSPDR ? ? ? ? ? ? ? ? ?0x0008
>> +
>> +#define SSPSR ? ? ? ? ? ? ? ? ?0x000c
>> +#define SSPSR_TFE ? ? ? ? ? ? ?BIT(0)
>> +#define SSPSR_TNF ? ? ? ? ? ? ?BIT(1)
>> +#define SSPSR_RNE ? ? ? ? ? ? ?BIT(2)
>> +#define SSPSR_RFF ? ? ? ? ? ? ?BIT(3)
>> +#define SSPSR_BSY ? ? ? ? ? ? ?BIT(4)
>> +#define SSPCPSR ? ? ? ? ? ? ? ? ? ? ? ?0x0010
>> +
>> +#define SSPIIR ? ? ? ? ? ? ? ? 0x0014
>> +#define SSPIIR_RIS ? ? ? ? ? ? BIT(0)
>> +#define SSPIIR_TIS ? ? ? ? ? ? BIT(1)
>> +#define SSPIIR_RORIS ? ? ? ? ? BIT(2)
>> +#define SSPICR ? ? ? ? ? ? ? ? SSPIIR
>
> When I look at this it's quite obvious that this is the same hardware or very
> close (maybe a redux version) of the thing supported by
> drivers/spi/amba-pl022.c.
>
> What is the difference really? I suspect this is a PL022 PrimeCell straight off.
> Even the CPSR algorithm is the same, just written differently.
>
> Can you make a hexdump of the PrimeCell ID registers at offset
> base+0xffe0..0xffff and post the contents?

Linus,

As Mika already pointed out, the ep93xx ssp peripheral does not have a valid
PeripheralID or PrimeCellID to identify it as an AMBA PL022 peripheral.

It probably was originally based on the PL022 but I think Cirrus hacked it
enough that the generic amba-pl022 driver will not work with it, at least
without a number of ugly #ifdef hacks.

Or, I could be wrong.  It appears the amba-pl022 driver doesn't actually match
the ARM spec for the PL022.

#define SSP_CR0(r)	(r + 0x000)

/*
 * SSP Control Register 0  - SSP_CR0
 */
#define SSP_CR0_MASK_DSS	(0x1FUL << 0)
#define SSP_CR0_MASK_HALFDUP	(0x1UL << 5)
#define SSP_CR0_MASK_SPO	(0x1UL << 6)
#define SSP_CR0_MASK_SPH	(0x1UL << 7)
#define SSP_CR0_MASK_SCR	(0xFFUL << 8)
#define SSP_CR0_MASK_CSS	(0x1FUL << 16)
#define SSP_CR0_MASK_FRF	(0x3UL << 21)

The spec says that the DSS bits are only bits 3:0 (16-bit transfers), the
driver has them as bits 4:0 (32-bit transfers).
HALFDUP is not listed in the spec, and FRF is listed as bits 5:4.
CSS is not listed in the spec.

The PL022 spec actually matches the EP93xx usage.

#define SSP_CR1(r)	(r + 0x004)

/*
 * SSP Control Register 0  - SSP_CR1
 */
#define SSP_CR1_MASK_LBM	(0x1UL << 0)
#define SSP_CR1_MASK_SSE	(0x1UL << 1)
#define SSP_CR1_MASK_MS		(0x1UL << 2)
#define SSP_CR1_MASK_SOD	(0x1UL << 3)
#define SSP_CR1_MASK_RENDN	(0x1UL << 4)
#define SSP_CR1_MASK_TENDN	(0x1UL << 5)
#define SSP_CR1_MASK_MWAIT	(0x1UL << 6)
#define SSP_CR1_MASK_RXIFLSEL	(0x7UL << 7)
#define SSP_CR1_MASK_TXIFLSEL	(0x7UL << 10)

Bits 15:4 are listed as reserved in the spec, bits 3:0 match the spec. 
The EP93xx usage of this register is different.

0  RIE    Receive FIFO interrupt enable
1  TIE    Transmit FIFO interrupt enable
2  RORIE  Receive FIFO overrun interrupt enable
3  LBM    Loop back mode
4  SSE    Synchronous serial port enable
5  MS     Master / Slave mode select
6  SOD    Slave-mode output disable

#define SSP_DR(r)	(r + 0x008)

/*
 * SSP Data Register - SSP_DR
 */
#define SSP_DR_MASK_DATA	0xFFFFFFFF

The PL022 spec only shows the peripheral as supporting up to 16-bit transfers.
This is the limit for the EP93xx also but the amba-pl022 driver actually supports
up to 32-bit transfers.

#define SSP_SR(r)	(r + 0x00C)

/*
 * SSP Status Register - SSP_SR
 */
#define SSP_SR_MASK_TFE		(0x1UL << 0) /* Transmit FIFO empty */
#define SSP_SR_MASK_TNF		(0x1UL << 1) /* Transmit FIFO not full */
#define SSP_SR_MASK_RNE		(0x1UL << 2) /* Receive FIFO not empty */
#define SSP_SR_MASK_RFF 	(0x1UL << 3) /* Receive FIFO full */
#define SSP_SR_MASK_BSY		(0x1UL << 4) /* Busy Flag */

#define SSP_CPSR(r)	(r + 0x010)

/*
 * SSP Clock Prescale Register  - SSP_CPSR
 */
#define SSP_CPSR_MASK_CPSDVSR	(0xFFUL << 0)

These match the spec and the EP93xx usage.

#define SSP_IMSC(r)	(r + 0x014)

/*
 * SSP Interrupt Mask Set/Clear Register - SSP_IMSC
 */
#define SSP_IMSC_MASK_RORIM (0x1UL << 0) /* Receive Overrun Interrupt mask */
#define SSP_IMSC_MASK_RTIM  (0x1UL << 1) /* Receive timeout Interrupt mask */
#define SSP_IMSC_MASK_RXIM  (0x1UL << 2) /* Receive FIFO Interrupt mask */
#define SSP_IMSC_MASK_TXIM  (0x1UL << 3) /* Transmit FIFO Interrupt mask */

In the EP93xx this register is called SSPIIR / SSPICR.  It is the interrupt
status register for reads and the interrupt clear register for writes.  For
reads it is defined as:

0  RIS    SSP Receive FIFO service request
1  TIS    SSP Transmit FIFO service request
2  RORIS  SSP Receive FIFO overrun interrupt status

For writes, any value written clears the RORIS bit.

The other registers listed for the amba-pl022 do not exist in the EP93xx
implementation.

The biggest problem I can see trying to use the amba-pl022 with the ep93xx
are the missing Peripheral ID and PrimeCell ID registers.  The AMBA bus driver
will not be able to match the driver to the device.

Beyond that, once the amba-pl022 driver supports DMA transfers the implementation
needed for the EP93xx will be completely different.

I think it's best to leave these as separate drivers.  Cirrus has stopped
development of their ARM processors so we have no hope of ever getting a full
pl022 compatible version.

Regards,
Hartley
