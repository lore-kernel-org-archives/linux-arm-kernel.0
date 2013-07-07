From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Jul 2013 13:43:27 +0100
Subject: [RFC PATCH 0/9] Clean up debugging support
Message-ID: <20130707124326.GP24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up some aspects of the LL debug support by:

- Removing the multi-level choice madness
- Consolidating the 8250 debug UART support
- Consolidating the PL01x debug UART support

The differences between the various 8250 debug UART implementations are:
- Physical/Virtual addresses
- Register offset shift
- Access size
- Flow control

These are now parameterised in the Kconfig.  I've left OMAP because
that's a complex case, but it looks like it can be adapted to it if
some of the unnecessary complexity is eliminated.

Similar is done with the PL01x implementation, except a few complex
cases are left - automatic detection on Versatile Express, and the
Ux500 support which looks like it'll take some picking through header
files to work out what the base addresses are.

The approach I've taken is to consolidate without losing any information
- what that means it that the Kconfig parameters have rather a lot of
dependencies/defaults associated with them, and the main choice
statement keeps all its options.

In the longer run, I want to consolidate that down to just a pair of
"Kernel low-level debugging messages via 8250 UART" and "Kernel
low-level debugging messages via PL01x UART" options, possibly with the
base addresses/shifts/access width/flow control supplied by the user.

I've not really been able to test these because of the current breakage
on ARM devel platforms caused by the "get_signal" saga, so these are
RFC only at the moment.

Nevertheless, even avoiding the loss of information, I think the diffstat
is quite impressive:

 arch/arm/Kconfig.debug                             |  488 +++++++++++++-------
 arch/arm/include/asm/hardware/debug-8250.S         |   29 --
 arch/arm/include/asm/hardware/debug-pl01x.S        |   29 --
 arch/arm/include/debug/8250.S                      |   54 +++
 arch/arm/include/debug/8250_32.S                   |   27 --
 arch/arm/include/debug/bcm2835.S                   |   22 -
 arch/arm/include/debug/cns3xxx.S                   |   19 -
 arch/arm/include/debug/highbank.S                  |   17 -
 arch/arm/include/debug/mvebu.S                     |   30 --
 arch/arm/include/debug/mxs.S                       |   27 --
 arch/arm/include/debug/nomadik.S                   |   20 -
 arch/arm/include/debug/nspire.S                    |   28 --
 arch/arm/include/debug/picoxcell.S                 |   19 -
 arch/arm/include/debug/pl01x.S                     |   36 ++
 arch/arm/include/debug/pxa.S                       |   33 --
 arch/arm/include/debug/rockchip.S                  |   42 --
 arch/arm/include/debug/socfpga.S                   |   21 -
 arch/arm/include/debug/sunxi.S                     |   27 --
 arch/arm/include/debug/u300.S                      |   18 -
 arch/arm/include/debug/ux500.S                     |    2 +-
 arch/arm/include/debug/vexpress.S                  |   48 +--
 arch/arm/mach-dove/include/mach/debug-macro.S      |   19 -
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |   22 -
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |   21 -
 .../arm/mach-footbridge/include/mach/debug-macro.S |   15 -
 arch/arm/mach-gemini/include/mach/debug-macro.S    |   21 -
 .../arm/mach-integrator/include/mach/debug-macro.S |   20 -
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |   24 -
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |   21 -
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |   22 -
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |   26 -
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |   19 -
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |   29 --
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |   19 -
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |   21 -
 arch/arm/mach-realview/include/mach/debug-macro.S  |   29 --
 arch/arm/mach-rpc/include/mach/debug-macro.S       |   23 -
 arch/arm/mach-versatile/include/mach/debug-macro.S |   21 -
 38 files changed, 423 insertions(+), 985 deletions(-)
