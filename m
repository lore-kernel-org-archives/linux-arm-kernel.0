From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:04:05 +0200
Subject: [PATCH v4 00/26] ARM: pxa: magician: Rework HTC Magician support
Message-ID: <5609AB45.9030009@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset will clean, fix, optimize and add multiple devices,
which can be found on the HTC Magician machine.

Platform data for the pasic3-leds driver has been removed, as this
driver do not exist in the vanilla. And it is expected to be recreated
in the future with an incompatible platform data structure.

Default setting of the Samsung LCD pixel clock period has been
increased, so resulting frequency is 50Hz (original 117Hz). Period
can be possibly incresed even more. At this moment there is no video
player with IWMMXT support and software only versions cannot make it
to 30fps. Frequency decreasing has a good impact to memory troughtput
as LCD controller does not do as many memory bursts as at original
speed. This was verified with the lat_mem_rd from the lmbench3.

The Omnivision OV9640 camera has a problem with running on 400kHz
of the I2C clock. It seems it freezes the bus until PXA I2C driver
reload. Datasheet says it OK on 400kHz though. There may be some
compatibility bug in the PXA I2C driver as Omnivision cameras often
uses special I2C protocol (SCCB).

Using the CPU frequency scaling (with help of an MAX1587A regulator)
sometimes causes an SoC failure. It is probably related to the PXA27x
erratum E37, E36, E80 or E89. Infreqent changes mostly works.

STUART removal is a prepare for:

	net: irda: pxaficp_ir: dmaengine conversion

Function was tested on the board_id 0x3a version (specifically on
the T-Mobile MDA compact).

Changes from v3:
 * Nontrivial rebase for indentation fixup (EGPIO and PXA UDC)

Petr Cvek (26):
  ARM: pxa: magician: Fix indentation in machine files
  ARM: pxa: magician: Change comments to be more informative
  ARM: pxa: magician: Print more specific error message for global
    GPIOs
  ARM: pxa: magician: Optimize debug messages for LCD power
  ARM: pxa: magician: Change description of LCD power GPIO
  ARM: pxa: magician: Add new discovered EGPIO pins
  ARM: pxa: magician: Fix HTC Magician pin mux definitions
  ARM: pxa: magician: Rename abstract LCD GPIOs
  ARM: pxa: magician: Optimize powerup delays for Samsung LCD
  ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
  ARM: pxa: magician: Optimize EGPIO initial values
  ARM: pxa: magician: Rename charger cable detection EGPIOs
  ARM: pxa: magician: Fix and add charging detection functions
  ARM: pxa: magician: Fix platform data for both PXA27x I2C controllers
  ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
  ARM: pxa: magician: Fix support for Intel Strata NOR Flash
  ARM: pxa: magician: Fix wrongly enabled USB host ports
  ARM: pxa: magician: Add support for ADS7846
  ARM: pxa: magician: Add support for Omnivision OV9640 camera
  ARM: pxa: magician: Add support for MAX1587A Vcore regulator
  ARM: pxa: magician: Add support for PXA27x UDC
  ARM: pxa: magician: Remove pdata for pasic3-leds
  ARM: pxa: magician: Remove definition of the STUART port
  ARM: pxa: magician: Add debug message for backlight brightness
    function
  ARM: pxa: magician: Add missing regulator for PWM backlight
  ARM: pxa: magician: Move platform_add_devices() to the end of
    magician_init()

 arch/arm/mach-pxa/include/mach/magician.h |  70 ++-
 arch/arm/mach-pxa/magician.c              | 907 +++++++++++++++++++++---------
 2 files changed, 678 insertions(+), 299 deletions(-)

-- 
1.7.12.1
