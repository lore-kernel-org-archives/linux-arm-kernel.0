From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:52:58 +0100
Subject: [RFC PATCH 0/5] Allwinner MMC firmware clocks implementation
Message-ID: <20160809115303.17032-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a proof-of-concept series to demonstrate the usage of firmware
driven clocks using the SCPI protocol for Allwinner SoCs.
This aims to replace the tricky and highly SoC specific clocks drivers
that every new Allwinner SoC seems to require.
The idea is to abstract the internal clock specific code by the rather
generic SCPI interface, which support programming and reading clock
frequencies in an SoC agnostic manner. The actual clock access can be
put in firmware, which is by definition SoC specific and thus can
be easier and much quicker adapted to support a new SoC.
The SCPI interface requires a mailbox and a shared memory region to
send commands and receive results.

This series introduces a new mailbox driver, which uses smc instructions
to trigger a mailbox. This allows the SCPI handlers to live as a runtime
service component in the existing ARM Trusted Firmware port. Beside
being able to easily add those handlers to the existing firmware code
this approach has the advantage of avoiding building, maintaining and
loading yet another firmware component. The management processor on the
A64 uses an OpenRISC core, which requires a not fully upstream supported
toolchain. Also this core can remain free to other tasks, like offloading
of realtime-sensitive tasks.
A future implementation may later revisit this decision, adding a proper
mailbox driver and implement the SCPI handler on the OpenRISC core, the
only change needed would be to swap the mailbox node in the DT then.

Another added value is that SCPI brings us sensors and regulators
support, using this very same interface. All that's needed is to add
some firmware code to read the THS register or poke the AXP, for
instance (which ATF does already anyway) and advertise those via a DT
node. There would be no Linux changes needed for that.

As an example this series adds MMC support on top of the basic support
bit posted recently [1].
We use the existing sunxi MMC driver for the purpose of this series,
although it is known to not fully support the new MMC controller in the
A64 chip. I found the support sufficient enough to drive SD cards, though.

Patch 1/5 introduces the SMC mailbox driver, while patch 2/5 adds the
associated DT binding documentation. Patch 3/5 adds the basic SCPI nodes
to the SoC .dtsi, which patch 4/5 complements with the MMC nodes,
referencing the new firmware clocks.
The final patch 5/5 enables the SD card for the two boards which we
currently support.

This series goes on top of the v4 A64 support series [1], which itself
is based on v4.8-rc1.
It allows booting and running a userland from a micro SD card on both
the Pine64 and the BananaPi M64 board.
The matching firmware implementation can be found in the allwinner-scpi
branch here [2]. The clock code in there is probably pretty stupid, but
works and is good enough to at least serve as a proof-of-concept for this
new clock approach.

Please have a look and give comments, I am particularily interested in
how you like this idea. One motiviation is to save the kernel from
endless variations of clock driver code, also to be able to support
newer SoCs much easier without having to submit and maintain tedious
clock patches.

Cheers,
Andre.

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447512.html
[2]: https://github.com/apritzel/arm-trusted-firmware/commits/allwinner-scpi

Andre Przywara (5):
  mailbox: introduce ARM SMC based mailbox
  DT: mailbox: add binding doc for the ARM SMC mailbox
  arm64: dts: sunxi: add SCPI node to sun50i-a64.dtsi
  arm64: dts: sunxi: add SCPI driven clocks and nodes for A64 MMC
  arm64: dts: sunxi: add MMC nodes to Pine64 and BPi-M64 .dts

 .../devicetree/bindings/mailbox/arm-smc.txt        |  53 ++++++++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  29 +++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  20 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  87 +++++++++++++
 drivers/mailbox/Kconfig                            |   8 ++
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/smc-mailbox.c                      | 135 +++++++++++++++++++++
 7 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
 create mode 100644 drivers/mailbox/smc-mailbox.c

-- 
2.9.0
