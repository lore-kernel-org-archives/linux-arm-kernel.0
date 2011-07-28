From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 28 Jul 2011 01:44:21 -0600
Subject: [GIT PULL] Basic arm device tree support patches for v3.1
In-Reply-To: <CACxGe6s8uDd_3+QyE7G5CetL0XySMZhCgg_NEn2PBRxDsGWcnA@mail.gmail.com>
References: <CACxGe6s8uDd_3+QyE7G5CetL0XySMZhCgg_NEn2PBRxDsGWcnA@mail.gmail.com>
Message-ID: <CACxGe6vUTaRO8KwHqc=1c3gPDnM+X6boRQ85w1R7vxj=e2Z73A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here's the updated pull request including dt board support for tegra
and versatile.  It also includes the as-of-yet-unacked-by-tglx
irq_domain patches, but it's pretty important to get these into
mainline this cycle, and I've not gotten any response from him,
positive or negative, and there needs to be some linux-next exposure
before getting Linus to pull.

g.

The following changes since commit 95b6886526bb510b8370b625a49bc0ab3b8ff10f:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6
(2011-07-27 19:26:38 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 devicetree/next-arm

Grant Likely (6):
      arm/dt: Add dt machine definition
      arm/dt: Add skeleton dtsi file
      irq: add irq_domain translation infrastructure
      dt/irq: add irq_domain_generate_simple() helper
      arm/versatile: Add device tree support
      arm/dt: tegra devicetree support

Rob Herring (1):
      arm/dt: Add dtb make rule

 Documentation/devicetree/bindings/arm/arm-boards   |   20 ++
 .../devicetree/bindings/i2c/arm-versatile.txt      |   10 +
 .../devicetree/bindings/mtd/arm-versatile.txt      |    8 +
 .../devicetree/bindings/net/smsc-lan91c111.txt     |   10 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/Makefile                                  |    7 +
 arch/arm/boot/Makefile                             |    6 +
 arch/arm/boot/dts/skeleton.dtsi                    |   13 ++
 arch/arm/boot/dts/tegra-harmony.dts                |   70 +++++++
 arch/arm/boot/dts/tegra-seaboard.dts               |   28 +++
 arch/arm/boot/dts/tegra20.dtsi                     |  139 ++++++++++++++
 arch/arm/boot/dts/versatile-ab.dts                 |  192 ++++++++++++++++++++
 arch/arm/boot/dts/versatile-pb.dts                 |   48 +++++
 arch/arm/include/asm/mach/arch.h                   |    7 +
 arch/arm/include/asm/prom.h                        |    5 -
 arch/arm/kernel/devtree.c                          |   14 --
 arch/arm/mach-tegra/Kconfig                        |    6 +
 arch/arm/mach-tegra/Makefile                       |    3 +
 arch/arm/mach-tegra/Makefile.boot                  |    3 +
 arch/arm/mach-tegra/board-dt.c                     |  119 ++++++++++++
 arch/arm/mach-versatile/Kconfig                    |    8 +
 arch/arm/mach-versatile/Makefile                   |    1 +
 arch/arm/mach-versatile/core.c                     |   62 +++++++
 arch/arm/mach-versatile/core.h                     |    4 +
 arch/arm/mach-versatile/versatile_dt.c             |   51 +++++
 include/linux/irq.h                                |    6 +
 include/linux/irqdomain.h                          |   91 +++++++++
 include/linux/of_irq.h                             |    4 +
 kernel/irq/Kconfig                                 |    4 +
 kernel/irq/Makefile                                |    1 +
 kernel/irq/irqdomain.c                             |  180 ++++++++++++++++++
 31 files changed, 1102 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-boards
 create mode 100644 Documentation/devicetree/bindings/i2c/arm-versatile.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/arm-versatile.txt
 create mode 100644 Documentation/devicetree/bindings/net/smsc-lan91c111.txt
 create mode 100644 arch/arm/boot/dts/skeleton.dtsi
 create mode 100644 arch/arm/boot/dts/tegra-harmony.dts
 create mode 100644 arch/arm/boot/dts/tegra-seaboard.dts
 create mode 100644 arch/arm/boot/dts/tegra20.dtsi
 create mode 100644 arch/arm/boot/dts/versatile-ab.dts
 create mode 100644 arch/arm/boot/dts/versatile-pb.dts
 create mode 100644 arch/arm/mach-tegra/board-dt.c
 create mode 100644 arch/arm/mach-versatile/versatile_dt.c
 create mode 100644 include/linux/irqdomain.h
 create mode 100644 kernel/irq/irqdomain.c


On Mon, Jul 25, 2011 at 9:56 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hi Arnd,
>
> Here are some of the basic DT patches that are needed for arm in v3.1.
> ?This isn't board support yet (need an ack on irq_domain first), but
> it is some of the prerequisites.
>
> g.
>
> The following changes since commit b6844e8f64920cdee620157252169ba63afb0c89:
>
> ?Merge branch 'for-linus' of
> master.kernel.org:/home/rmk/linux-2.6-arm (2011-07-24 10:20:54 -0700)
>
> are available in the git repository at:
>
> ?git://git.secretlab.ca/git/linux-2.6 devicetree/next-arm
>
> Grant Likely (2):
> ? ? ?arm/dt: Add dt machine definition
> ? ? ?arm/dt: Add skeleton dtsi file
>
> Rob Herring (1):
> ? ? ?arm/dt: Add dtb make rule
>
> ?arch/arm/Makefile ? ? ? ? ? ? ? ?| ? ?7 +++++++
> ?arch/arm/boot/Makefile ? ? ? ? ? | ? ?6 ++++++
> ?arch/arm/boot/dts/skeleton.dtsi ?| ? 13 +++++++++++++
> ?arch/arm/include/asm/mach/arch.h | ? ?7 +++++++
> ?4 files changed, 33 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/boot/dts/skeleton.dtsi
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
