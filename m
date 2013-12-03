From: marex@denx.de (Marek Vasut)
Date: Tue, 3 Dec 2013 01:32:10 +0100
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <5298AA23.7080404@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
Message-ID: <201312030132.10410.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Angus,

_nicely_ explained indeed :)

> Hi Huang Shijie,
> 
> On 11/27/2013 04:32 AM, Brian Norris wrote:
> > + Lee Jones, others
> > 
> > I'd like to keep a similar CC list for the various conversations going
> > on about SPI NOR frameworks.
> > 
> > On Tue, Nov 26, 2013 at 02:32:51PM +0800, Huang Shijie wrote:
> >> 1.) Why add a new framework for SPI NOR?
> >> 
> >>   The SPI-NOR controller such as Freescale's Quadspi controller is
> >>   working in a different way from the SPI bus. It should knows the NOR
> >>   commands to find the right LUT sequence. Unfortunately, the current
> >>   code can not meet this requirement.
> 
> I fully support your argument for introducing a new framework to support
> Serial Flash controllers.

So do I, now I finally get the problem.

> Reiterating my previous comment:
> 
> "The kernel offers many examples of others who have struggled with the same
> problem.  Some have chosen to write self-contained drivers (e.g.
> drivers/mtd/devices/spear_smi.c and drivers/mtd/devices/sst251.c)
> duplicating much of m25p80.c, while others have attempted to squeeze into
> the SPI framework (e.g. drivers/spi/spi-tegra20-sflash.c and
> drivers/spi/spi-falcon.c), relying on fragile heuristics to recreate the
> semantics of m25p80 that is lost over the , current circumstances SPI
> framework ."
> 
> However, having now been through your proposed framework, it would not seem
> to provide a generally applicable solution.  Indeed, other than making the
> Serial Flash commands and the device table available, it is not obvious
> how it improves the situation for your own specific controller either; the
> read/write/read_reg/write_reg callbacks do not offer a great deal more than
> spi_read_then_write().  (Perhaps all will become clear when you submit the
> fsl-quadspi driver.)
> 
> As I see it, the main problem with the current support is that dedicated
> Serial Flash Controllers require a level of semantics that cannot be
> conveyed over the generic SPI framework.  With this in mind, I would start
> by defining something along the lines of a "Serial Flash transfer".  Some
> initial ramblings of my mind:
> 
> /**
>  * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash transfer
>  * @wren:		command for "Write Enable", or 0x00 for not required
>  * @cmd:		command for operation
>  * @cmd_pins:		number of pins to send @cmd (1, 2, 4)
>  * @addr:		address for operation
>  * @addr_pins:		number of pins to send @addr (1, 2, 4)
>  * @addr_width: 	number of address bytes (3,4, or 0 for address not
> required) * @mode:		mode data
>  * @mode_pins:		number of pins to send @mode (1, 2, 4)
>  * @mode_cycles:	number of mode cycles (0 for mode not required)
>  * @dummy_cycles:	number of dummy cycles (0 for dummy not required)
>  */
> struct spi_nor_xfer_cfg {
> 	uint8_t		wren;
> 	uint8_t		cmd;
> 	int		cmd_pins;
> 	uint32_t	addr;
> 	int		addr_pins;
> 	int		addr_width;
> 	uint32_t	mode;
> 	int		mode_pins;
> 	int		mode_cycles;
> 	int		dummy_cycles;
> };
> 
> We could then build up layers of functionality, based on two fundamental
> primitives:
> 
> 	int (*read_xfer)(struct spi_nor_info *info,
> 			 struct spi_nor_xfer_cfg *cfg,
> 			 uint8_t *buf, size_t len);
> 
> 	int (*write_xfer)(struct spi_nor_info *info,
> 			  struct spi_nor_xfer_cfg *cfg,
> 			  uint8_t *buf, size_t len);
> 
> Default implementations for standard operations could follow:
> 
> 	int (*read_reg)(struct spi_nor_info *info,
> 			uint8_t cmd, uint8_t *reg, int len);
> 	int (*write_reg)(struct spi_nor_info *info,
> 			 uint8_t cmd, uint8_t *reg, int len,
> 			 int wren, int wtr);
> 
> 	int (*readid)(struct spi_nor_info *info, uint8_t *readid);
> 	int (*wait_till_ready)(struct spi_nor_info *info);
> 
> 	int (*read)(struct spi_nor_info *info, uint8_t buf, off_t offs, size_t
> len); int (*write)(struct spi_nor_info *info, off_t offs, size_t len);
> 	int (*erase_sector)(struct spi_nor_info *info, off_t offs);
> 
> Each driver would be required to implement read_xfer() and write_xfer(),
> and then free to either use the default implementations, or override with
> driver-optimised implementations.

I checked the VYBRIDRM.pdf datasheet. I grok down that the thing Vybrid does is 
it has such a lookup table. The table has 16 slots , each can contain up to 8 
SPI NOR instructions . These instructions are programmed when the driver 
probe()s I suppose. To do a communication with the SPI NOR, you give the 
controller an index in this lookup table and it will execute this pre-programmed 
sequence of commands on the SPI NOR.

So yes, your API would work nicely with Vybrid. I agree about read_reg() and 
write_reg() functions, they will be needed for reading the standard CR/SR etc 
registers on the SPI NOR and also SPI NOR specific cruft if need be. As for 
readid(), I wonder if we cannot implement it via some generalized read_reg() 
call, I suspect we can for starters. Same goes for wait_till_read(), let's 
implement it in the spi-nor framework first and only if a piece of hardware can 
speed this up significantly by re-implementing it itself, they will change the 
framework.

The read() and write() calls are nice, something like mmap() might be 
interesting here as well, since based on what Poddar explained, his controller 
can somehow map the SPI flash into the CPU address space. I don't know how this 
should work precisely, but again, this can be left until such controller driver 
hits mainline and the benefits of such implementation would become obvious.

Finally, the erase_sector() call would probably need to be extended. I would 
rename it to simple erase(), since we can erase from sub-sectors (4K) to whole 
chip.

btw. I really like the idea of the new SPI NOR framework. The M25P80 driver 
could then be rewritten and plugged into the SPI NOR framework just like any 
other SPI NOR controller driver with "advanced capabilities".

> In the case of a pure SPI Controller, read_xfer() and write_xfer() would
> simply flatten to spi_messages.  The key benefit is that dedicated Serial
> Flash Controllers would be able to take advantage of the richer semantics
> offered by the 'spi_nor_xfer_cfg' data.
> 
> I would also expect the spi-nor framework to provide the following
> services, applicable to all Serial Flash drivers:
> 
> 	- determine devices properties at runtime, based on the READID data (and
> perhaps SFDP, if and when it matures!).  This should include supported
> opcodes (e.g. READ_1_1_4, READ_1_4_4, READ4B_1_1_4...), operating
> frequencies, mode and dummy requirements, means of setting Quad Enable,
> entering/exiting 4-byte addressing etc.
> 
> 	- provide optimal read, write and erase configurations, based on the
> combined capabilities of the Serial Flash device and the H/W Controller.

Talking about read-write-erase, why don't we -- instead of passing buffer -- 
pass a scatterlist ? I suppose that might make it easier for these "advanced" 
controller to do DMA on it.

> 	- device specific configuration (e.g. setting QE, unlock BPx bits, DYB
> unlocking).
> 
> Getting back to reality, I realise undertaking such a task would be a huge
> commitment.  I would be keen to put forward my own proposal, but current
> circumstances mean that that is unlikely to happen any time soon.

I'd love to take this on, but I need to flush my pipeline first ;-( Besides, it 
seems we have an abundance of good engineers here already, so maybe someone will 
actually write it ;-)

> I guess in summary, while I am pleased that this area is being looked at,
> my own feeling is that proposed framework needs to be reworked for it to
> be generally applicable to other Serial Flash controllers.  Of course,
> another option would be to stick with what is currently offered, and make
> do.

Full ACK.

> Cheers,
> 
> Angus
