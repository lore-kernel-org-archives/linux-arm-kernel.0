From: vigneshr@ti.com (Vignesh R)
Date: Mon, 3 Aug 2015 10:27:19 +0530
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <20150731181745.GM20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk>
Message-ID: <55BEF4AF.5090704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 7/31/2015 11:47 PM, Mark Brown wrote:
> On Tue, Jul 28, 2015 at 02:11:12PM +0530, Vignesh R wrote:
> 
>> Introduce use_mmap_read field in spi_message struct. This can be set by
>> mtd devices (m25p80) to indicate to spi-master (ti-qspi) to perform
>> memory mapped read. This helps to distinguish whether the spi-message is
>> from mtd layer(hence mmap read is possible) or by other spi devices.
> 
> Based on this description and...
> 
>> + * @use_mmap_mode: Indicate to spi master to perform memory mapped
>> + *	read if possible.
> 
> ...the internal documentation I unable to tell what is meant by "perform
> a memory mapped read", at least to the extent where it is visible
> outside of the driver.  This means we can't really use this as a generic
> API since other people won't be able to tell what it does.
> 


Will the following documentation provide better idea regarding the flag:

@use_mmap_mode: Some SPI controller chips are optimized for interacting
with serial flash memories. These chips have memory mapped interface,
through which entire serial flash memory slave can be read/written as if
though they are physical memories (like RAM). Using this interface,
flash can be accessed using memcpy() function and the spi controller
hardware will take care of communicating with serial flash over SPI.
Setting this flag will indicate the SPI controller driver that the
spi_message is from mtd layer to read from/write to flash. The SPI
master driver can then appropriately switch the controller to memory
mapped interface to read from/write to flash, based on this flag (See
drivers/spi/spi-ti-qspi.c for example).
NOTE: If the SPI controller chip lacks memory mapped interface, then the
driver will ignore this flag and use normal SPI protocol to read
from/write to flash. Communication with non-flash SPI devices is not
possible using the memory mapped interface.

I can update the patch commit message and documentation accordingly?

Regards
Vignesh
