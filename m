From: atull@kernel.org (Alan Tull)
Date: Sun, 18 Dec 2016 20:14:19 -0600 (CST)
Subject: [PATCH v6 0/5] Altera Cyclone Passive Serial SPI FPGA Manager
In-Reply-To: <cover.1481918884.git.stillcompiling@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
Message-ID: <alpine.DEB.2.10.1612182012440.2528@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Dec 2016, Joshua Clayton wrote:

> This series adds an FPGA manager for Altera cyclone FPGAs
> that can program them using an spi port and a couple of gpios, using
> Alteras passive serial protocol.
> 
> Need ACKs from ARCH maintainers for ARCH specific implementations of
> __arch_bitrev8x4(), and I've added more ARCHes, so will need more ACKS, 
> but the generic code will work without that patch, so if there is a holdup
> the rest of the series can go in without patch 2

Hi Joshua,

We still need Russell to ACK or take patch 1.  It's the merge window
so he may be busy.

Alan

> 
> Changes from v5:
> - Rebased on next-20161214xi
> - Corrected for FPGA Mgr API change in  write_init() and write_complete()
> - Better describe the device cyclone-ps-spi runs on in the file header.
> - Split the bitrev8x4 patch into generic and arch specific patches...
> - Added AARCH64 and MIPS implementations of bitrev8x4()... they all have to 
>   have an implementation for it to compile cleanly across platforms
> - Added the changes to imx6q-evi.dts to the patch set.
> 
> Changes from v4:
> - Added the needed return statement to __arch_bitrev8x4()
> - Added Rob Herrings ACK for and fix a typo in the commit log of patch 2
> 
> Changes from v3:
> - Fixed up the state() function to return the state of the status pin
>   reqested by Alan Tull
> - Switched the pin to ACTIVE_LOW and coresponding logic level, and updated
>   the corresponding documentation. Thanks Rob Herring for pointing out my
>   mistake.
> - Per Rob Herring, switched from "gpio" to "gpios" in dts
> 
> Changes from v2:
> - Merged patch 3 and 4 as suggested in review by Moritz Fischer
> - Changed FPGA_MIN_DELAY from 250 to 50 ms is the time advertized by
>   Altera. This now works, as we don't assume it is done
> 
> Changes from v1:
> - Changed the name from cyclone-spi-fpga-mgr to cyclone-ps-spi-fpga-mgr
>   This name change was requested by Alan Tull, to be specific about which
>   programming method is being employed on the fpga.
> - Changed the name of the reset-gpio to config-gpio to closer match the
>   way the pins are described in the Altera manual
> - Moved MODULE_LICENCE, _AUTHOR, and _DESCRIPTION to the bottom
> 
> - Added a bitrev8x4() function to the bitrev headers and implemented ARM
>  const, runtime, and ARM specific faster versions (This may end up
>  needing to be a standalone patch)
> 
> - Moved the bitswapping into cyclonespi_write(), as requested.
>   This falls short of my desired generic lsb first spi support, but is a step
>   in that direction.
> 
> - Fixed whitespace problems introduced during refactoring
> 
> - Replaced magic number for initial delay with a descriptive macro
> - Poll the fpga to see when it is ready rather than a fixed 1 ms sleep
> 
> Joshua Clayton (5):
>   lib: add bitrev8x4()
>   lib: implement __arch_bitrev8x4()
>   doc: dt: add cyclone-ps-spi binding document
>   fpga manager: Add cyclone-ps-spi driver for Altera FPGAs
>   ARM: dts: imx6q-evi: support cyclone-ps-spi
> 
>  .../bindings/fpga/cyclone-ps-spi-fpga-mgr.txt      |  25 +++
>  arch/arm/boot/dts/imx6q-evi.dts                    |  16 ++
>  arch/arm/include/asm/bitrev.h                      |   6 +
>  arch/arm64/include/asm/bitrev.h                    |   6 +
>  arch/mips/include/asm/bitrev.h                     |   6 +
>  drivers/fpga/Kconfig                               |   7 +
>  drivers/fpga/Makefile                              |   1 +
>  drivers/fpga/cyclone-ps-spi.c                      | 186 +++++++++++++++++++++
>  include/linux/bitrev.h                             |  26 +++
>  9 files changed, 279 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/cyclone-ps-spi-fpga-mgr.txt
>  create mode 100644 drivers/fpga/cyclone-ps-spi.c
> 
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
