From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 17:45:28 +0100
Subject: Getting a lot of zero values from a driver using DMA. D-cache
	is not updated?
In-Reply-To: <1303921659.19857.141.camel@SESTOWS194>
References: <1303921659.19857.141.camel@SESTOWS194>
Message-ID: <20110428164528.GX17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 06:27:39PM +0200, Niclas Karlsson wrote:
> I'm running linux on a custom made harware based on AT91SAM9263-ek
> (evaluation board from Atmel). A touchcontroller (ads7846) is connected
> to the SPI bus. When I read data
> (cat /sys/bus/spi/devices/spi0.1/in0_input or in1_input) from the two
> extra AD-channels in the ads7846 chip I get a zero value very often. The
> ads7846 driver uses the atmel_spi driver. The ads7846 driver allocates
> memory with kzalloc(). the atmel_spi then uses dma_map_single() before
> starting the transfer with PDC (Peripheral Dma Controller). When the
> transfer has finished, an interrupt is fired from the SPI.
> dma_unmap_single() is then called and the value from the ADC should be
> in the allocated buffer, but it's not. The buffer is still zero. If I
> add a delay (like printk("wait\n")) the value from the ADC can be read
> in the buffer. How do I fix this? Could it be that the d-cache is not
> updated with the new value which is written by the PDC? If so, how do I
> update the cache with the value the PDC just wrote to RAM?

I think we know this one.  The ADS7846 is basically buggy.

I think this is the struct in question:

struct ser_req {
        u8                      ref_on;
        u8                      command;
        u8                      ref_off;
        u16                     scratch;
        __be16                  sample;
        struct spi_message      msg;
        struct spi_transfer     xfer[6];
};

So, we have at offsets (hex):

00: ref_on
01: command
02: ref_off
03: scratch
04: scratch
05: sample
06: sample
07: unused
08: struct spi_msg msg
...

Now, the CPU has these things called "cache lines".  They're normally
about 32 bytes long for ARM926, aligned to a 32 byte natural boundary.
Accessing any data within one of these cache lines results in the entire
cache line being read into the cache.

So, on dma_map_single() for sample, we writeback and invalidate the
cache line containing this data, which also overlaps msg.

When the driver then accesses msg, it drags the cache line back in,
and if that happens _before_ DMA completes, the CPU will read the old
value of sample back into the cache (iow zero, as set by kzalloc).
DMA then completes, and the DMA buffer is unmapped.  On ARM926, unmap
is a no-op operation, because of the DMA API buffer ownership rules.
(Cache lines associated with DMA should not be shared with other data
otherwise it causes the DMA API to go wrong - exactly as here.)

So, when you next access 'sample' you read the value read into the cache,
which will be zero.

The right answer is to ensure that the DMA data is separated from the
metadata for the transfer, either by a separate allocation or by
ensuring that there's sufficient padding to avoid overlapping cache
lines with the DMA data and metadata.  I'm not sure why that hasn't
already been fixed.
