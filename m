From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jun 2012 18:52:57 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
Message-ID: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

You'll find in this patch set the new version of the initial support for a
new family of ARMv7-compatible Marvell SoCs initially submitted by my
colleague Thomas Petazzoni. Following the conclusion of the discussion when
we submitted our first version we have chosen to add this support for this
SoC family in the to support in the arch/arm/mach-mvebu/ directory.

As for the previous release, both the Armada 370 and the Armada XP SoCs are
supported in this directory, and we are able to build a single kernel image
that boots on both SoCs. Both SoCs use the PJ4B processor, a
Marvell-developed ARM core that implements the ARMv7 instruction set. We are
currently using Marvell evaluation boards for both of those SoCs, and the
support for those boards is added in this patch set.

We remained focused on a limited preliminary support which only includes the
necessary code for timer and IRQ support, the serial controller is a
standard 16550-compatible one. The diffstat looks like:

 Documentation/devicetree/bindings/arm/armada_370_xp-mpic.txt  |   23 +
 Documentation/devicetree/bindings/arm/armada_370_xp-timer.txt |   11 +
 Documentation/devicetree/bindings/arm/armada_370_xp.txt       |   24 +
 MAINTAINERS                                                   |    8 +
 arch/arm/Kconfig                                              |   15 +
 arch/arm/Makefile                                             |    1 +
 arch/arm/boot/dts/armada-370-db.dts                           |   41 ++
 arch/arm/boot/dts/armada-370-xp.dtsi                          |   66 +++
 arch/arm/boot/dts/armada-370.dtsi                             |   29 +
 arch/arm/boot/dts/armada-xp-db.dts                            |   40 ++
 arch/arm/boot/dts/armada-xp.dtsi                              |   49 ++
 arch/arm/configs/mvebu_defconfig                              |   47 ++
 arch/arm/mach-mvebu/Kconfig                                   |   14 +
 arch/arm/mach-mvebu/Makefile                                  |    2 +
 arch/arm/mach-mvebu/Makefile.boot                             |    1 +
 arch/arm/mach-mvebu/armada-370-xp-dt.c                        |   65 +++
 arch/arm/mach-mvebu/common.c                                  |   36 ++
 arch/arm/mach-mvebu/common.h                                  |   24 +
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h              |   22 +
 arch/arm/mach-mvebu/include/mach/debug-macro.S                |   24 +
 arch/arm/mach-mvebu/include/mach/mvebu.h                      |   22 +
 arch/arm/mach-mvebu/include/mach/timex.h                      |   13 +
 arch/arm/mach-mvebu/include/mach/uncompress.h                 |   41 ++
 arch/arm/mach-mvebu/irq-armada-370-xp.c                       |  133 +++++
 arch/arm/mach-mvebu/time-armada-370-xp.c                      |  244 +++++++++
 25 files changed, 995 insertions(+)

This patch set, and the support for those SoCs, started as a collaborative
effort from Marvell engineers (who have done the initial development work)
and Free Electrons engineers (who are reshaping the code for mainline
submission, adding device tree support, etc.). And for this new version we
got contributions from Ben Dooks from Codethink.

The patch set is based on your arm-soc/for-next branch (updated on Monday
11th June).

The main change between V1 and V2 is the use of a new mach-mvebu directory
as this directory is aimed to receive most of the Marvell SOC converted to
the device tree, we intended to make the code less specific. The other main
part was to remove all the unnecessary code or even files.

Here comes a pretty exhaustive list of the changes:

* Created a new mach- directory called mach-mvebu as suggested on the
 mainling-list. Converted most the "armada" word by the "mvebu", but as some
 code remains specific to the armada 370 and armada XP SOC, then created
 also the aramada_370_xp suffix for this part. This suffix was dedicated for
 the irq and timer part. It was also used for the register related to the
 reset part. And of course it was also used for the device tree part.

* Merged axp-dt.c and a370-dt.c files in one single armada_370_xp-dt.c file.

* Deleted most of the mapping address in include/mach/armada.h and split it
  in two headers file:

  - mvebu.h which contains the virtual and physical mapping for the internal
    registers of the mvebu SOC. This ones are mainly used for the early
    print during boot.

  - armada_370_xp which contains the registers offset and mask for resetting
    the CPU.

* Removed unused headers such as
  - hardware.h by directly including accurate header when needed
  - gpio.h by removing the dependencies to PLAT-ORION
  - io.h no more needed for CPI
  - irqs.h by using SPARSE_IRQ
  - system.h no more needed for new SOC

* Removed the PCI related code as it was not necessary for the initial
  submission

* Removed all the PLAT-ORION dependencies remaining

* Ensured property reading checks for error when getting data from device
  tree in the timer file. This was a patch from Ben Dooks with the following
  comments:

  "The call to of_property_read_u32() only checks for the value that the clk
   variable is set to being non-zero, and not the return value of the call
   itself.

   This caused a system without the clock-frequency attribute to fail to
   boot as it used a random value on the stack to setup the system timers
   and thus cause an interrupt storm.

   Also ensure clk is set to zero, to avoid warnings."

* Converted irq.c to use SPARSE_IRQ

* Added the following bug fixes and improvements in irq.c from Ben Dooks
  
  - MPIC: BUG_ON() if the of_iomap() fails: Ensure that if either resource
    is missing, we stop the kernel in a reasonably fatal way.

  - MPIC: Move main register base to base of MPIC registers: The current
    kernel driver had the MPIC base at the base of the block containing the
    MPIC and not the MPIC itself. Change this value in the driver and the
    .dtsi file

	Also change the register size in the .dtsi to be the size of the
	register range for the MIPC and not the block it is in.

  - MPIC: Move per-cpu register base: The current kernel driver had the MPIC
  	per-cpu register base at the base of the per-cpu register block and not
  	at the base of the specific per-cpu interrupt registers.

	Move the driver and .dtsi to use the correct base and size.

  - MPIC: number fetch should use irqd_to_hwirq(): The mask and unmask
  	routines are assuming that d->irq is a 1:1 mapping with the interrupt
  	hardware. Use the irqd_to_hwirq() call to map the irq_data to the
  	hardware irq number directly.

  - MPIC: read number of interrupts from control register: Read the number
   	of MPIC interrupts from the controller and only register that many.

Andrew Lunn asked for refactoring the _restart() function to being used by
any MVEBU SOC, but we didn't find a nice way to do it. Indeed the registers
mapping differs between the SOC and the bit mask too. A solution could be to
get this mapping through the device tree, but we are not sure it was a good
usage of the device tree.


Best regards,

Gregory Clement
