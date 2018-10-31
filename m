From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 31 Oct 2018 14:43:40 +0100
Subject: [RFC PATCH v2 0/6] New QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Message-ID: <20181031144340.4f1a030a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Piotr, Tudor,

On Wed, 27 Jun 2018 15:16:03 +0200
Piotr Bugalski <bugalski.piotr@gmail.com> wrote:

> Hello,
> 
> Atmel SAMA5D2 is equipped with two QSPI interfaces. These interfaces can
> work as in SPI-compatible mode or use two / four lines to improve
> communication speed. At the moment there is QSPI driver strongly tied to
> NOR-flash memory and MTD subsystem.
> Intention of this change is to provide new driver which will not be tied
> to MTD and allows using QSPI with NAND-flash memory or other peripherals
> New spi-mem API provides abstraction layer which can disconnect QSPI
> from MTD. This driver doesn't support regular SPI interface, it should
> be used with spi-mem interface only.
> Unfortunately SAMA5D2 hardware by default supports only NOR-flash
> memory. It allows 24- and 32-bit addressing while NAND-flash requires
> 16-bit long. To workaround hardware limitation driver is a bit more
> complicated.
> 
> Request to spi-mem contains three fiels: opcode (command), address,
> dummy bytes. SAMA5D2 QSPI hardware supports opcode, address, dummy and
> option byte where address field can only be 24- or 32- bytes long.
> Handling 8-bits long addresses is done using option field. For 16-bits
> address behaviour depends of number of requested dummy bits. If there
> are 8 or more dummy cycles, address is shifted and sent with first dummy
> byte. Otherwise opcode is disabled and first byte of address contains
> command opcode (works only if opcode and address use the same buswidth).
> The limitation is when 16-bit address is used without enough dummy
> cycles and opcode is using different buswidth than address. Other modes
> are supported with described workaround.
> 
> It looks like hardware has some limitation in performance. The same issue
> exists in current QSPI driver (MTD/nor-flash) and soft-pack (bare-metal
> library from Atmel). Without using DMA read speed is much worse than
> maximum bandwidth (efficiency 30-40%). Any help with performance
> improvement is highly welcome, especially for NAND-flash memories which
> offers higher capacity than NOR-flash used with previous driver.
> 
> Best Regards,
> Piotr
> 
> v2 changes:
>  - driver is now replacement of existing atmel-quadspi
>  - code was re-written to follow original code structure
>  - deinitialization order fixed
>  - empty atmel_qspi_adjust_op_size function removed
>  - code formatting fixes
>  - use spi_device->max_speed_hz to get spi speed
>  - spi freqency set in spi_controller->setup() hook
>  - address range checkng for 4-bytes addressing
>  - use timeout to avoid infinite waiting

IIRC, this version was almost ready to be merged except for the missing
->get_name() implementation which should be easy to add.

Can one of you post a new version of this patchset?

Thanks,

Boris
