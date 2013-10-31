From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 31 Oct 2013 12:58:09 -0300
Subject: [PATCH v2 00/27] Armada 370/XP NAND support
In-Reply-To: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131031155808.GB2468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian,

Can we start discussing this patchset?
I realize is a big series, but better starting sooner than later! :)

In particular... (see below)

On Fri, Oct 18, 2013 at 08:02:27PM -0300, Ezequiel Garcia wrote:
> Hi guys,
> 
> This is the v2 of the work implementing NAND support in Armada 370/XP SoCs.
> This series is probably not yet complete (see below), but I feel like
> we're really closer now :-)
> 
> As in the previous version and given I don't have any public datasheet
> to show, I'll try to write some of the most relevant parts of the controller.
> 
> * NFCv2 controller background
> 
> The controller has a 2176 bytes FIFO buffer. Therefore, in order to support
> larger pages, I/O operations on 4 KiB and 8 KiB pages is done with a set of
> chunked transfers.
> 
> For instance, if we choose a 2048 data chunk and set "BCH" ECC (see below)
> we'll have this layout in the pages:
> 
>   ------------------------------------------------------------------------------
>   | 2048B data | 32B spare | 30B ECC || 2048B data | 32B spare | 30B ECC | ... |
>   ------------------------------------------------------------------------------
> 
> The driver reads the data and spare portions independently and builds an internal
> buffer with this layout (in the 4 KiB page case):
> 
>   ------------------------------------------
>   |     4096B data     |     64B spare     |
>   ------------------------------------------
> 
> Also, for the READOOB command the driver disables the ECC and reads a 'spare + ECC'
> OOB, one per chunk read.
> 
>   -------------------------------------------------------------------
>   |     4096B data     |  32B spare | 30B ECC | 32B spare | 30B ECC |
>   -------------------------------------------------------------------
> 
> So, in order to achieve reading (for instance), we issue several READ0 commands
> (with some additional controller-specific magic) and read two chunks of 2080B
> (2048 data + 32 spare) each.
> The driver accomodates this data to expose the NAND core a contiguous buffer
> (4096 data + spare) or (4096 + spare + ECC + spare + ECC).
> 
> * ECC
> 
> The controller has built-in hardware ECC capabilities. In addition it is
> configurable between two modes: 1) Hamming, 2) BCH.
> 
> Note that the actual BCH mode: BCH-4 or BCH-8 will depend on the way
> the controller is configured to transfer the data.
> 
> In the BCH mode the ECC code will be calculated for each transfered chunk
> and expected to be located (when reading/programming) right after the spare
> bytes as the figure above shows.
> 
> So, repeating the above scheme, a 2048B data chunk will be followed by 32B
> spare, and then the ECC controller will read/write the ECC code (30B in
> this case):
> 
>   ------------------------------------
>   | 2048B data | 32B spare | 30B ECC |
>   ------------------------------------
> 
> If the ECC mode is 'BCH' then the ECC is *always* 30 bytes long.
> If the ECC mode is 'Hamming' the ECC is 6 bytes long, for each 512B block.
> So in Hamming mode, a 2048B page will have a 24B ECC.
> 
> Despite all of the above, the controller requires the driver to only read or
> write in multiples of 8-bytes, because the data buffer is 64-bits.
> 
> * Changes from v1
> 
> Aside from several changes based in Brian's feedback, the main changes
> from v1 are:
> 
>   * The controller's clock source is now fully modeled, see patche 1 to 4.
>     Of course, none of those patches should be taken through the mtd
>     subsystem, but I'm adding them here for completeness.
> 
>   * The chip's cmdfunc() is now independently implemented in each SoC variant.
>     The rationale behind this decision is that 'chunked' I/O is the only tested
>     mode on the Armada370 variant, while the old 'vanilla' I/O is the only
>     tested mode on the PXA variant.
> 
>     So it's safer to have an implementation for each variant.
> 
>   * Added support for BCH-8, in other words: 8-bits of correction in a 512-byte
>     region. This is obtained by using a data chunk size of 1024B, thus doubling
>     the ECC BCH strength, as per this ECC engine mechanism.
> 
>   * The ECC layout in use, which must be set according to the page size and
>     desired ECC strength is now strictly chosen to match only the tested
>     combinations.
> 
> * Pending stuff
> 
>   1. Factory bad blocks handling
> 
>   Currently, there's no factory bad block initial scan (when the bad block
>   table is missing). The ECC BCH requires to layout the device's pages in
>   a splitted "data + OOB + data + OOB" way. This layout being different from
>   the factory layout. In other words,
> 
>   Factory view:
> 
>   -----------------------------------------------
>   |                    Data           |x  OOB   |
>   -----------------------------------------------
> 
>   Driver's view:
> 
>   -----------------------------------------------
>   |      Data      | OOB |      Data   x  | OOB |
>   -----------------------------------------------
> 
>   It can be seen from the above, that the factory bad block marker must be
>   searched within the 'data' region, and not in the usual OOB region.
> 
>   This seems to be similar to the gpmi-nand driver, yet I really find its
>   'bad block swapping' solution odd, so I'm trying to find something
>   cleaner.
> 
>   2. ECC modeling
> 
>   Although I've exposed some ECC information in the ECC layout, I'm still
>   not sure why is this needed, or if it's needed at all.
> 
> * About this patchset
> 
> This is based in l2-mtd's master branch and I've pushed a branch to our
> github in case anyone wants to test it:
> 
>   https://github.com/MISL-EBU-System-SW/mainline-public/tree/l2-mtd/upstream-nand-v2
> 
> Just as the previous, this series is complex and lengthy and any feedback will
> be highly appreciated as well as questions, suggestions or flames. Also, I hope
> our brave PXA regression tester Daniel Mack finds some time to give it a ride
> and report any issues. Daniel: I think owe you several beers already.
> 
> * About Mirabox testing
> 
> As this work is not considered completely stable, be extra careful when trying
> on the Mirabox. The Mirabox has the bootloader at NAND, and there's some risk
> to brick the board.
> 
> That said: I've been using the driver on my Mirabox for several days doing
> simple long-run NAND activity and everything worked fine.
> 
> If despite this you happen to brick the board, Willy Tarreau has provided
> excellent instructions to un-brick the Mirabox:
> 
>   http://1wt.eu/articles/mirabox-vs-guruplug/
> 
> Thanks!
> 
> Ezequiel Garcia (27):
>   clk: mvebu: Add Core Divider clock
>   ARM: mvebu: Add Core Divider clock device-tree binding
>   ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
>   ARM: mvebu: Add the core-divider clock to Armada 370/XP
>   mtd: nand: pxa3xx: Make config menu show supported platforms
>   mtd: nand: pxa3xx: Prevent sub-page writes
>   mtd: nand: pxa3xx: Early variant detection
>   mtd: nand: pxa3xx: Use chip->cmdfunc instead of the internal
>   mtd: nand: pxa3xx: Split FIFO size from to-be-read FIFO count
>   mtd: nand: pxa3xx: Replace host->page_size by mtd->writesize
>   mtd: nand: pxa3xx: Disable OOB on arbitrary length commands
>   mtd: nand: pxa3xx: Use a completion to signal device ready
>   mtd: nand: pxa3xx: Add bad block handling
>   mtd: nand: pxa3xx: Add driver-specific ECC BCH support
^^
This one and ...

>   mtd: nand: pxa3xx: Clear cmd buffer #3 (NDCB3) on command start
>   mtd: nand: pxa3xx: Add helper function to set page address
>   mtd: nand: pxa3xx: Remove READ0 switch/case falltrough
>   mtd: nand: pxa3xx: Split prepare_command_pool() in two stages
>   mtd: nand: pxa3xx: Move the data buffer clean to
>     prepare_start_command()
>   mtd: nand: pxa3xx: Fix SEQIN column address set
>   mtd: nand: pxa3xx: Add a read/write buffers markers
>   mtd: nand: pxa3xx: Introduce multiple page I/O support
^^^
.. this one seems to me like the most conflicting patches as
they extend the ECC, adding BCH. Could you review them and
provide any comments?

>   mtd: nand: pxa3xx: Add multiple chunk write support
>   mtd: nand: pxa3xx: Add ECC BCH correctable errors detection
>   ARM: mvebu: Add support for NAND controller in Armada 370/XP
>   ARM: mvebu: Enable NAND controller in Armada XP GP board
>   ARM: mvebu: Enable NAND controller in Armada 370 Mirabox
> 
>  .../bindings/clock/mvebu-corediv-clock.txt         |  19 +
>  arch/arm/boot/dts/armada-370-mirabox.dts           |  21 +
>  arch/arm/boot/dts/armada-370-xp.dtsi               |  26 +
>  arch/arm/boot/dts/armada-xp-gp.dts                 |   8 +
>  drivers/clk/mvebu/Kconfig                          |   5 +
>  drivers/clk/mvebu/Makefile                         |   1 +
>  drivers/clk/mvebu/clk-corediv.c                    | 223 +++++++
>  drivers/mtd/nand/Kconfig                           |   4 +-
>  drivers/mtd/nand/pxa3xx_nand.c                     | 686 ++++++++++++++++-----
>  include/linux/platform_data/mtd-nand-pxa3xx.h      |   3 +
>  10 files changed, 856 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
>  create mode 100644 drivers/clk/mvebu/clk-corediv.c
> 
> -- 
> 1.8.1.5
> 

Huang: It seems gpmi-nand driver has some similar quirks,
so I'd like if you could take some time to review my patches.

I realise that you might be busy with your own patches, but the
best way of having them cross-reviewed is by doing some review
on others work.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
