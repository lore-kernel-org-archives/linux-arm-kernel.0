From: dja@axtens.net (Daniel Axtens)
Date: Wed, 19 Jul 2017 12:15:12 +1000
Subject: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
Message-ID: <20170719021516.24718-1-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v2, in which I send the right patches. My apologies to you all.]

Hi all,

Previously I posted a patch that provided a quirk for a hibmc card
behind a particular Huawei bridge that allowed it to be marked as the
default device in the VGA arbiter.[0] This lead to some discussion.[1]
It was broadly suggested that a more generic solution would be better,
something in the style of powerpc's fixup_vga() quirk.

Here is my suggested solution:

 - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK
 
 - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
   hook. This hook fires when a card is enabled, which will require
   that a driver has been bound.

 - if there is no default device when the hook fires, and the device
   can control memory and I/O, mark it as default.

The patches are as follows:

 (1) powerpc: simplify and fix VGA default device behaviour

     This cleans up some quirks in the powerpc implementation of the
     vga_fixup. It should make the behaviour match the original
     intention.

 (2) vgaarb: allow non-legacy cards to be marked as default

     Add the Kconfig option, and create the fixup in vgaarb.c gated
     behind the option. Nothing happens at this stage because no arch
     has selected the option yet.

 (3) powerpc: replace vga_fixup() with generic code

     Select the option on powerpc and remove the old code. The only
     change is that it moves from being a final fixup to an enable
     fixup.
 
 (4) arm64: allow non-legacy VGA devices to be default

     Select the option on arm64. This solves my problem with the D05,
     but may cause other cards to be marked as default on other
     boards. This shouldn't cause any real issues but is worth being
     aware of.

Regards,
Daniel

[0]: https://patchwork.ozlabs.org/patch/787003/
[1]: https://www.spinics.net/lists/arm-kernel/msg593656.html

Daniel Axtens (4):
  powerpc: simplify and fix VGA default device behaviour
  vgaarb: allow non-legacy cards to be marked as default
  powerpc: replace vga_fixup() with generic code
  arm64: allow non-legacy VGA devices to be default

 arch/arm64/Kconfig               |  1 +
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c | 12 ------------
 drivers/gpu/vga/Kconfig          |  7 +++++++
 drivers/gpu/vga/vgaarb.c         | 21 +++++++++++++++++++++
 5 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.11.0
