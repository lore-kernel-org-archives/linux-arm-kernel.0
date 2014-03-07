From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  7 Mar 2014 11:13:23 -0800
Subject: [PATCH RFC v2 00/11] tty: xuartps: Rebranding
Message-ID: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A second iteration of this series.

I added some more to the cleanup parts. The more you look at things the
more things to fix you find.

The read-modify-write refactoring is more or less a result of the prefix
substitution. With the changed prefix for better indentation is
necessary, and I think it makes the code more readably in general.

The controversial part, the re-branding: I split this up into 4 separate
patches, starting at 5/8. Each going a little further and I'd like to
know which ones are wanted/okay and which rather not. And whether the
wanted ones should be squashed.

The first one is pretty much the light-weight changes Alan suggested.

The second changes the driver name. I don't know if that is acceptable.
I think the name is used in some sysfs nodes. Does that make it part of
the userspace API? And I don't know if the name might be used elsewhere?

The third is mostly a search and replace of 'xuartps' with
'cdns-uart'. A noisy change but it should not impact anything else. I
thought it might be nice to have more generic names since they show in
stack traces and the xuartps thing may not be that meaningful on
non-Zynq platforms - though there is non for this driver as of now.

Similar the Kconfig symbol renaming. Probably not worth it, but might
clarify things a bit.

The defconfig update would - obviously - only needed if the Kconfig
change is done. Which is probably another reason to not change the
config symbol.

In the documentation I added xlnx,xuartps as valid compatible string,
but refrained from documenting the Zynq-specific clock names. The
driver, though, allows them, but prints a warning.

The DT update would silence the afore-mentioned warning by migrating to
the new clock names.

	Thanks,
	S?ren

Soren Brinkmann (11):
  tty: xuartps: Clean up
  tty: xuartps: Print warning in clock notifier
  tty: xuartps: Refactor read-modify-writes
  tty: xuartps: Remove bogus comment and register write
  tty: xuartps: Rebrand driver as Cadence UART
  tty: xuartps: Change driver name to 'cdns-uart'
  tty: xuartps: Replace function and symbol prefix
  tty: xuartps: Rename Kconfig symbols
  ARM: multi_v7_defconfig: Adopt to UART driver renaming
  tty: cadence: Document DT binding
  ARM: zynq: DT: Migrate UART to Cadence binding

 .../devicetree/bindings/serial/cdns,uart.txt       |   20 +
 arch/arm/boot/dts/zynq-7000.dtsi                   |    8 +-
 arch/arm/configs/multi_v7_defconfig                |    4 +-
 drivers/tty/serial/Kconfig                         |   15 +-
 drivers/tty/serial/Makefile                        |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 | 1123 ++++++++++----------
 include/uapi/linux/serial_core.h                   |    2 +-
 7 files changed, 569 insertions(+), 605 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

-- 
1.9.0.1.g4196000
