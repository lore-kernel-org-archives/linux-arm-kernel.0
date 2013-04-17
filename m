From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Apr 2013 13:38:10 -0400
Subject: [PATCHv3 00/10] Use the mvebu PCIe driver on Kirkwood
In-Reply-To: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130417173810.GD27197@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, et al.

I applied this series to an experimental branch mvebu-late/pcie.  Please
check that everything is kosher.  I had to add mvebu/boards as a
dependency since there is a patch in there alphabetizing kirkwood's
Kconfig (and thus _defconfig).

*If* rmk creates a stable branch in time, or drops the patch so we can
take it, this branch will be rebased to fix that.  Currently, it depends
on rmk/for-next, which is *not* stable.  This is the only public rmk
branch that has the needed patch.  :-(

Assuming the above happens, I'll send two PRs, one for the mvebu-pcie
stuff, then one for the kirkwood-pcie stuff.

If the stars align, we're ready.  Otherwise, we have everything set to
go into arm-soc early for the next round.

thx,

Jason.


On Sat, Apr 13, 2013 at 04:56:35PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is a set of patches that migrates adds support for Kirkwood
> platforms to use the mvebu PCIe driver. All the Kirkwood platforms
> that have already been converted to the Device Tree are converted to
> use the new driver, and the DB-88F6281 evaluation board from Marvell
> is also converted to the Device Tree and the usage of the new PCIe
> driver.
> 
> Only non-DT platforms continue to use the legacy code in
> arch/arm/mach-kirkwood/pcie.c.
> 
> This branch depends on the mvebu-mbus driver and the mvebu-pcie
> driver. I have pushed this branch to the following Git repository for
> easier testing:
> 
>   https://github.com/MISL-EBU-System-SW/mainline-public/tree/kirkwood-pcie-dt-v3
> 
> # /usr/sbin/lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> 01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> 02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> 
> # cat /proc/cpuinfo | grep ^Hardware
> Hardware	: Marvell Kirkwood (Flattened Device Tree)
> 
> I've tested both the e1000e NIC card and the SATA 4 ports card and
> they work fine.
> 
> Changes between v2 and v3:
> 
>  * Integrate a replacement patch from Andrew Lunn for the QNAP changes
>    after he tested on his hardware platform.
> 
>  * Add Andrew Lunn Tested-by tags on the appropriate patches.
> 
> Changes between v1 and v2:
> 
>  * Remove the 'needs_pcie_win' logic, and instead move the static
>    initialization of PCIe windows into the legacy PCIe code, for the
>    platforms that will still be using it. Platforms that will use the
>    new PCIe driver benefit directly from dynamic allocation of PCIe
>    windows.
> 
>  * Move the PCIe interface definitions from kirkwood.dtsi to
>    kirkwood-6281.dtsi and kirkwood-6282.dtsi to take into account the
>    fact that the 6281 has one PCIe interface, and the 6282 has two of
>    them.
> 
>  * Convert all DT-platforms that were initializing PCIe using the
>    legacy driver to use the DT to initialize the PCIe interface. This
>    includes the Iomega Iconnect, the MPL CEC4, the ZyXEL NSA310and the
>    QNAP TS219.
> 
>  * Fix the conversion to the Device Tree of the DB-88F6181/6282
>    board. We now have two Device Trees, one for the 6281 variant of
>    the board (one PCIe interface) and another for the 6282 variant of
>    the board (two PCIe interfaces).
> 
>  * Update the defconfig with PCIe driver enabled and some board
>    updates.
> 
> Best regards,
> 
> Thomas
> 
> Thomas Petazzoni (10):
>   pci: mvebu: enable driver usage on Kirkwood
>   bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
>   arm: kirkwood: move PCIe window init to legacy driver
>   arm: kirkwood: add SoC-level Device Tree data for PCIe interfaces
>   arm: kirkwood: convert Iomega Iconnect to use DT for the PCIe
>     interface
>   arm: kirkwood: convert MPL CEC4 to use DT for the PCIe interface
>   arm: kirkwood: convert ZyXEL NSA310 to use DT for the PCIe interface
>   arm: kirkwood: convert QNAP TS219 to use DT for the PCIe interface
>   arm: kirkwood: convert db-88f6281 to the Device Tree
>   arm: kirkwood: update defconfig with PCIe driver and board updates
> 
>  .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
>  arch/arm/boot/dts/Makefile                         |    5 +-
>  arch/arm/boot/dts/kirkwood-6281.dtsi               |   31 ++++++
>  arch/arm/boot/dts/kirkwood-6282.dtsi               |   48 +++++++++
>  arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   30 ++++++
>  arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   34 ++++++
>  arch/arm/boot/dts/kirkwood-db.dtsi                 |   89 ++++++++++++++++
>  arch/arm/boot/dts/kirkwood-iconnect.dts            |    8 ++
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             |    8 ++
>  arch/arm/boot/dts/kirkwood-nsa310.dts              |    8 ++
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |    3 +-
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts          |    3 +-
>  arch/arm/boot/dts/kirkwood-ts219.dtsi              |    9 +-
>  arch/arm/boot/dts/kirkwood.dtsi                    |    1 +
>  arch/arm/configs/kirkwood_defconfig                |    6 +-
>  arch/arm/mach-kirkwood/Kconfig                     |   21 ++--
>  arch/arm/mach-kirkwood/Makefile                    |    3 +-
>  arch/arm/mach-kirkwood/board-db88f6281-bp.c        |   26 +++++
>  arch/arm/mach-kirkwood/board-dt.c                  |    2 +
>  arch/arm/mach-kirkwood/board-iconnect.c            |    8 --
>  arch/arm/mach-kirkwood/board-mplcec4.c             |    1 -
>  arch/arm/mach-kirkwood/board-nsa310.c              |   25 -----
>  arch/arm/mach-kirkwood/board-ts219.c               |   10 --
>  arch/arm/mach-kirkwood/common.c                    |   24 -----
>  arch/arm/mach-kirkwood/common.h                    |    6 ++
>  arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |  108 --------------------
>  arch/arm/mach-kirkwood/pcie.c                      |   22 ++++
>  drivers/bus/mvebu-mbus.c                           |    2 +-
>  drivers/pci/host/Kconfig                           |    2 +-
>  drivers/pci/host/pci-mvebu.c                       |    1 +
>  30 files changed, 343 insertions(+), 202 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6282.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-db.dtsi
>  create mode 100644 arch/arm/mach-kirkwood/board-db88f6281-bp.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
>  delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> 
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
