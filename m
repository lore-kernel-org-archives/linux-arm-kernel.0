From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jun 2013 22:32:45 +0200
Subject: [GIT PULL] Integrator/AP PCI DT support
In-Reply-To: <20130615000922.GG18124@quad.lixom.net>
References: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
 <20130614230838.GA18124@quad.lixom.net>
 <20130615000922.GG18124@quad.lixom.net>
Message-ID: <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 2:09 AM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jun 14, 2013 at 04:08:38PM -0700, Olof Johansson wrote:
>> On Mon, Jun 03, 2013 at 01:09:17PM +0200, Linus Walleij wrote:

>> > The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
>> >
>> >   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
>> > tags/integrator-pci-for-arm-soc
>>
>> Pulled, apologies for the delay on this one, fell of my list of
>> branches-to-pull somehow.
>
> Hmm. integrator_defconfig no longer builds:
>
> arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_map_irq_dt':
> arch/arm/mach-integrator/pci_v3.c:835:16: error: storage size of 'oirq' isn't known
> arch/arm/mach-integrator/pci_v3.c:845:2: error: implicit declaration of function 'irq_create_of_mapping'
>
> linux/of_irq.h is already included, but it seems that CONFIG_USE_OF is off in
> integrator defconfig.

Grrr what is wrong with me.

OK I sent out a revised version of the DT enablement patch that adds some
#ifdef. I also squashed the IRQ enablement into the main DT enablement
patch.

It now compiles nicely with and without ATAGs.

> What's the plan here? Making DT mandatory? Or making PCI depend on DT for this
> platform?

I have a branch that selects USE_OF for the integrator and *deletes*
the ATAG boot path. I will rebase that on top of this and send out ASAP,
maybe you can even get those quite nice yet simple cleanups in for this
merge window then, as a stepping stone to multiplatform.

> I've dropped the branch again until resolved.

OK here is the fixed branch, using the v3 patch of DT enablement just
posted to the list, please pull this instead (still the same base):


The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:

  of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-pci-for-arm-soc

for you to fetch changes up to f55b2b56cd37fa8bcfcb75248c27094eaf09e04c:

  ARM: integrator: basic PCIv3 device tree support (2013-06-15 22:18:39 +0200)

----------------------------------------------------------------
This is a patch series that:
- Pulls the Integrator/AP PCI bridge driver into one file
- Adds full device tree support for it
- Keeps ATAG support around for the time being

----------------------------------------------------------------
Linus Walleij (11):
      Documentation/devicetree: add a small note on PCI
      ARM: pci: create pci_common_init_dev()
      ARM: integrator: merge PCIv3 driver into one file
      ARM: integrator: convert PCIv3 bridge to platform device
      ARM: integrator: grab PCI error IRQ in probe()
      ARM: integrator: move PCI base address grab to probe
      ARM: integrator: move V3 register definitions into driver
      ARM: integrator: remap PCIv3 base dynamically
      ARM: integrator: move VGA base assignment
      ARM: integrator: move static ioremapping into PCIv3 driver
      ARM: integrator: basic PCIv3 device tree support

 Documentation/devicetree/bindings/pci/pci.txt      |   9 +
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  15 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/integratorap.dts                 |  41 ++
 arch/arm/include/asm/hardware/pci_v3.h             | 186 -------
 arch/arm/include/asm/mach/pci.h                    |  17 +-
 arch/arm/kernel/bios32.c                           |   9 +-
 arch/arm/mach-integrator/Makefile                  |   2 +-
 arch/arm/mach-integrator/include/mach/platform.h   |  23 -
 arch/arm/mach-integrator/integrator_ap.c           |  31 +-
 arch/arm/mach-integrator/pci.c                     | 113 -----
 arch/arm/mach-integrator/pci_v3.c                  | 532 +++++++++++++++++++--
 arch/arm/mach-integrator/pci_v3.h                  |   2 +
 13 files changed, 575 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 delete mode 100644 arch/arm/include/asm/hardware/pci_v3.h
 delete mode 100644 arch/arm/mach-integrator/pci.c
 create mode 100644 arch/arm/mach-integrator/pci_v3.h

Yours,
Linus Walleij
