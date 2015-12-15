From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Dec 2015 09:53:36 +0100
Subject: [GIT PULL] RealView base patches for cleanup and DT
In-Reply-To: <1991538.uU1eR25cvh@wuerfel>
References: <CACRpkdZAD-eh8k5RchnAjWyfRBiD0AN0qg_YHhwM6o001rTSQA@mail.gmail.com>
 <1991538.uU1eR25cvh@wuerfel>
Message-ID: <CACRpkdZg36hgT_YTm6dma=B164xo2BP0vq3gb8-JXw6mVaO2bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 12:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 December 2015 14:31:11 Linus Walleij wrote:
>> Hi ARM SoC maintainers,
>>
>> this is the base stack of patches piled up for the RealView platforms.
>> It basically adds a set of cleanups from Arnd and device tree support
>> for the RealView PB11MPCore. The stack has been tested on hardware.
(...)

> Thanks a lot for getting this ready. I see that your branch is based
> on top of 4.4-rc4. Is this necessary to get it working?

Nope. What is necessary to get it working is a rogue patch fixing the
unaddressed problem that is actually regressing RealView in the
current kernel:
http://marc.info/?l=linux-arm-kernel&m=144439011804098&w=2

> I'd prefer not to have a backmerge, and the branches are currently
> based on 4.4-rc3. If you don't mind, can you rebase the branch on -rc1
> or -rc3?
>
> Also, I'd prefer to merge the new .dts file as a separate patch, so these
> I can take it through the next/dt branch. As far as I can see, there are
> no dependencies here, you just need the file to get the machine to boot.

I took all three DT-related patches into a separate branch. It makes
more sense.

Please pull the following TWO pull requests instead:

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-base-armsoc-1-tag

for you to fetch changes up to 5420b4b156179ec634d9e42279b6898b85852960:

  ARM: realview: add an DT SMP boot method (2015-12-15 09:42:52 +0100)

----------------------------------------------------------------
The board and infrastructure changes for RealView
multiplatform and extended DT support.

----------------------------------------------------------------
Arnd Bergmann (5):
      ARM: realview: remove sparsemem hack
      ARM: realview: don't map undefined PCI registers
      clk/realview: stop using machine headers
      ARM: no longer force unbuffered DMA for realview
      ARM: realview: remove private barrier implementation

Linus Walleij (6):
      clk: versatile-icst: convert to use regmap
      clk: versatile-icst: refactor to allocate regmap separately
      clk: versatile-icst: add device tree support
      soc: versatile: add support for the PB11MPCore
      ARM: realview: select SP810 and ICST for the DT variant
      ARM: realview: add an DT SMP boot method

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm/Kconfig                               |   2 -
 arch/arm/mach-realview/Kconfig                 |  11 +-
 arch/arm/mach-realview/Makefile                |   2 +-
 arch/arm/mach-realview/include/mach/barriers.h |   8 -
 arch/arm/mach-realview/include/mach/memory.h   |  64 --------
 arch/arm/mach-realview/platsmp-dt.c            |  91 ++++++++++++
 arch/arm/mach-realview/realview_eb.c           |   7 +
 arch/arm/mach-realview/realview_pb11mp.c       |   6 +
 arch/arm/mach-realview/realview_pba8.c         |   8 -
 arch/arm/mach-realview/realview_pbx.c          |   8 -
 arch/arm/mm/Kconfig                            |   2 -
 drivers/clk/versatile/Kconfig                  |   1 +
 drivers/clk/versatile/clk-icst.c               | 194 ++++++++++++++++++++-----
 drivers/clk/versatile/clk-realview.c           |  10 +-
 drivers/soc/versatile/soc-realview.c           |   4 +
 16 files changed, 285 insertions(+), 134 deletions(-)
 delete mode 100644 arch/arm/mach-realview/include/mach/barriers.h
 delete mode 100644 arch/arm/mach-realview/include/mach/memory.h
 create mode 100644 arch/arm/mach-realview/platsmp-dt.c

AND

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-base-armsoc-2-tag

for you to fetch changes up to acde758b31f33d1599a07930b8c0ea082157cf70:

  ARM: realview: add device tree for PB11MPCore (2015-12-15 09:45:30 +0100)

----------------------------------------------------------------
The device tree changes for the continued RealView DT
support.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: add DT bindings for the ARM11MPCore CPU cluster
      clk: add ARM syscon ICST device tree bindings
      ARM: realview: add device tree for PB11MPCore

 Documentation/devicetree/bindings/arm/scu.txt      |   3 +
 .../devicetree/bindings/clock/arm-syscon-icst.txt  |  40 ++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          | 668 +++++++++++++++++++++
 4 files changed, 713 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
 create mode 100644 arch/arm/boot/dts/arm-realview-pb11mp.dts

Yours,
Linus Walleij
