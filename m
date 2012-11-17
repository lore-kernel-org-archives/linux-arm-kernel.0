From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2012 20:03:21 +0100
Subject: [GIT PULL] Integrator SoC bus patches
In-Reply-To: <CACRpkdYKWLMMOa7+CV8yMNe5-EV1p5fYeVJ+bn55KLLFBZdD=A@mail.gmail.com>
References: <CACRpkdYKWLMMOa7+CV8yMNe5-EV1p5fYeVJ+bn55KLLFBZdD=A@mail.gmail.com>
Message-ID: <CACRpkdZ35y6tm5JCJttkEr+rFT1J-XN1Hyq=8E4tFxvOHWa3mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 11:51 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> Hi ARM SoC guys,
>
> could you please pull this Integrator patch set as previously circulated
> on the list, targetting the v3.8 merge window? The details are in the
> tag.
>
> Please pull it in!

Iterating this pull request adding two new patches on top. Unless
there is something wrong with them, please pull in this instead!

Yours,
Linus Walleij


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-arm-soc

for you to fetch changes up to f7a9b36517d38cfa2213a346b154d2d7046ff223:

  ARM: integrator: use BUG_ON where possible (2012-11-17 19:44:39 +0100)

----------------------------------------------------------------
---------------------------------------------------------------
This series will do the following:
- Switch the Integrator/AP and /CP to use the SoC bus
  when booting from device tree.
- Group all devices on the SoC below this bus so as to
  set a good example of how to do this. The bus was
  invented by Lee Jones, let's show how it's to be used
  on a DT:ed SoC.
- Fetch the special system controller offsets from two
  special device tree nodes for each case and replace
  the static mappings with these at boot.
- Move some static remaps to the ATAG-only code path
  and delete some static maps that aren't used.
- Push dependencies on system controller remaps down
  to the Integrator/AP board file and the PCIv3 driver
  respectively and use only dynamic remappings.
- Fix up conditional BUG() usage in the PCIv3 driver
  to be simpler and more to the point.

----------------------------------------------------------------
Linus Walleij (7):
      ARM: integrator: hook the AP into the SoC bus
      ARM: integrator: hook the CP into the SoC bus
      ARM: integrator: remove static AP syscon mapping
      ARM: integrator: remove static CP syscon mapping
      ARM: integrator: delete SC mapping on the CP
      ARM: integrator: delete static UART1 mapping
      ARM: integrator: push down SC dependencies

Sasha Levin (1):
      ARM: integrator: use BUG_ON where possible

 Documentation/devicetree/bindings/arm/arm-boards |   4 +
 arch/arm/boot/dts/integratorap.dts               |   5 +
 arch/arm/boot/dts/integratorcp.dts               |   5 +
 arch/arm/mach-integrator/Kconfig                 |   2 +
 arch/arm/mach-integrator/common.h                |   8 +-
 arch/arm/mach-integrator/core.c                  | 141 +++++++++++++-------
 arch/arm/mach-integrator/include/mach/platform.h |   1 -
 arch/arm/mach-integrator/integrator_ap.c         | 158 +++++++++++++++++++----
 arch/arm/mach-integrator/integrator_cp.c         | 115 +++++++++++++----
 arch/arm/mach-integrator/pci_v3.c                |  32 ++---
 10 files changed, 354 insertions(+), 117 deletions(-)
