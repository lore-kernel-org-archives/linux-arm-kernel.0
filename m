From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2018 09:45:51 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
Message-ID: <20180618074556.6944-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a proposal for how to handle the non-discoverable
96boards plug-in expansion boards called "mezzanines" in the
Linux kernel. It is a working RFC series meant for discussion
at the moment.

The RFC was done on the brand new Ultra96 board from Xilinx
with a Secure96 mezzanine expansion board. The main part
is in patch 4, the rest is enabling and examples.

The code can be obtained from here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=ultra96

You can for example probably augment the DTS file for any
upstream-supported 96board and get the Secure96 going with
it with minor efforts.

TODO:

- Proper device tree bindings for the connector, for now
  look at the example.

- Discuss whether to actually do this or just take it all and
  flush it down the drain because the community doesn't like
  it. I'm not one of those especially infatuated with my own code,
  I always stay by the old programming project management mantra
  to calculate to make one version and throw it away as stepping
  stone to a good final design.

- Placement: putting this in drivers/bus is just an example.
  drivers/platform/96boards-mezzanines is fine too, maybe better?

- I am especially curious about input from Andy and Mika from
  the Intel/ACPI camp on what they have seen for non-discoverable
  plug-in boards. Does this problem even exist in the Intel
  world, or not...

Background:

- These boards connect on a custom connector on this family
  of boards. The relationship is many-to-many with the connector
  as nexus. The electronic standard for the connector is specified:
  https://github.com/96boards/documentation/blob/master/Specifications/96Boards-CE-Specification.pdf
  Example mezzanines:
  https://www.96boards.org/documentation/mezzanine/

- These boards have siblings on other platforms, the problem
  scope is similar with BeagleBone "capes":
  https://beagleboard.org/capes
  Raspberry Pi expansion boards:
  https://www.abelectronics.co.uk/products/18/raspberry-pi-expansion-boards
  Intel Edison, Galileo, Joule also have expansion boards.

Idea: add a driver for the connector itself and tie it in to
the device tree with a compatible string. Since the boards
are non-discoverable two mechanisms are provided to discover
them:

- Add a very simple device tree node with just a compatible
  string for the board in the node. This will be simple to
  add from e.g. a boot loader or as an overlay from userspace.

  board {
        compatible = "96boards,secure96";
  };


- Echo 1 > boardname into a sysfs file to populate the
  board and echo 0 > boardname to depopulate it. This
  makes it easy to even switch out expansion boards at
  runtime, if allowed by the electronics.

  > cd /sys/devices/platform/connector
  > echo 1 > secure96
  lscon connector: called mezzanine_store on secure96
  lscon connector: populate secure96
  at24 1-0050: 2048 byte 24c128 EEPROM, writable, 128 bytes/write
  atmel-ecc 1-0060: configuration zone is unlocked
  tpm_tis_spi spi0.0: 2.0 TPM (device-id 0x1B, rev-id 16)
  (...)

What this patch set does not do:

- It does not use device tree or ACPI DSDT or any other
  hardware decription language to model the contents of the
  board per se. Instead the boards buses are populated
  directly with platform devices.

Predictable complaints about this design:

Q: This is not device tree overlays. Why is it not device
   tree overlays?

A1: Right tool for the job, overlays are complex and the
    plan to get it in place seems to be spanning years, this
    is a few devices on simple busses and it works today.
    Using this approach I can already work on shaping up
    drivers for the mezzanine board devices as proved by:
    https://marc.info/?l=linux-crypto-vger&m=152820660120590&w=2
    https://marc.info/?l=linux-crypto-vger&m=152820662820595&w=2
    (...)

    I can work on drivers for the chips on the
    Secure96 mezzanine board. It's just an example of
    what the mezzanine community can do.
    Now they are hacking around in userspace instead of
    doing/reusing kernel drivers for their stuff:
    https://github.com/jbech-linaro/secure96

    This way we can bring developers for these components
    into the kernel community instead of telling them to
    wait for some big infrastructure that comes later
    before they can contribute their stuff.

A2: Overlays does not solve the problem if the system runs
    ACPI, and what about if the same connector[s] appear
    on a server board, servers use ACPI. Also notice
    that Intel have development boards with non-discoverable
    expansion boards as well. They just will not use
    device tree.

A3: Overlays is Big Upfront Design.
    https://en.wikipedia.org/wiki/Big_Design_Up_Front
    This way of designing things is associated with the
    (pejorative term) "waterfall model" which is out of
    fashion as a way of doing development. I think I am not
    the only one slightly annoyed by the fact that device
    tree overlays is now starting to look like a very
    big very upfront design. It's just not possible to get
    something up and running in small iterative steps with
    device tree overlays. Instead huge efforts are
    required and it involves major possible showstoppers
    and uncertain outcome as indicated by Frank's TODO:
    https://elinux.org/Frank's_Evolving_Overlay_Thoughts

    This appears also in our work process documents:
    Documentation/process/4.Coding.rst
    "experience has shown that excessive or premature
     abstraction can be just as harmful as premature
     optimization.  Abstraction should be used to the level
     required and no further."

So for that reason, or other predictable statements such
as "you're reinventing board files", I'd like to have an
open discussion on how to actually support these boards
with the mainline kernel and work on device drivers common
with other systems now, and not in 2020 when they are already
obsolete.

Yeah it is a bit controversial, but what we are doing right
now for non-discoverable expansion boards isn't working
in my opinion, so I have to throw something out there,
and this is it.

Linus Walleij (5):
  RFC: gpio: Add API to explicitly name a consumer
  RFC: eeprom: at24: Allow passing gpiodesc from pdata
  RFC: spi: Make of_find_spi_device_by_node() available
  RFC: bus: 96boards Low-Speed Connector
  RFC: ARM64: dts: Add Low-Speed Connector to ZCU100

 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  27 +-
 .../96boards-ls-connector.c                   | 307 ++++++++++++++++++
 .../96boards-mezzanines/96boards-mezzanines.h |  46 +++
 .../96boards-mezzanines/96boards-secure96.c   | 249 ++++++++++++++
 drivers/bus/96boards-mezzanines/Kconfig       |  36 ++
 drivers/bus/96boards-mezzanines/Makefile      |   6 +
 drivers/bus/Kconfig                           |   2 +
 drivers/bus/Makefile                          |   4 +-
 drivers/gpio/gpiolib.c                        |  13 +
 drivers/misc/eeprom/at24.c                    |   6 +-
 drivers/spi/spi.c                             |  33 +-
 include/linux/gpio/consumer.h                 |   7 +
 include/linux/platform_data/at24.h            |   2 +
 include/linux/spi/spi.h                       |   4 +
 14 files changed, 723 insertions(+), 19 deletions(-)
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-ls-connector.c
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-mezzanines.h
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-secure96.c
 create mode 100644 drivers/bus/96boards-mezzanines/Kconfig
 create mode 100644 drivers/bus/96boards-mezzanines/Makefile

-- 
2.17.0
