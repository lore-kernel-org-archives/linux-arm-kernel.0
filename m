From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Aug 2017 15:16:53 -0700
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.14
In-Reply-To: <20170817183748.1450-2-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-2-f.fainelli@gmail.com>
Message-ID: <cc4d171e-47cf-3045-738c-929807454297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2017 11:37 AM, Florian Fainelli wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/soc
> 
> for you to fetch changes up to e831871597aaa1f650b83f96b61858907c203b76:
> 
>   Merge tag 'bcm2835-soc-next-2017-08-15' into soc/next (2017-08-16 18:14:49 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC/Kconfig changes for 4.14,
> please pull the following:
> 
> - Stefan moves the BCM2836 SMP bring-up code from the irqchip driver down to
>   where it belongs under arch/arm/mach-bcm/. This requires us to merge parts
>   of the devicetree/next branch because we depend on Eric's change that relocates
>   the bcm2836/37 Device Tree files as well as the "enable-method" being correctly
>   set in the Device Tree source files.
> 
> - Danilo removes the fixed clocks introduced earlier when we did not have a
>   CPRMAN clock provider and in the process removes the init_machine callback
>   since we no longer need it.
> 
> - Phil provides a fix for the SMP bring-up code to have a "sev" (and corresponding
>   barrier) instruction in order to wake-up secondary cores. Future Rasperry Pi
>   firmware(s) will depend on this.
> 
> ----------------------------------------------------------------

Copying what Arnd was writing on IRC this morning, Eric, Stefan, can you
implement what Arnd recommends and I will pull again or cherry-pick
(whatever you prefer) thanks! Arnd, how quickly should we give you a new
PR with those changes?

10:07 < arnd> [florian], anholt, maz: I looked at the
arm-soc/for-4.14/soc pull request again now, and wonder if we can do a
little better than  that

10:08 < arnd> it seems you have pulled in the DT branch before the move
of the bcm2836_smp_ops from drivers/irqchip to arch/arm/mach-bcm, to
hide an incompatible DT binding change: in the old code, no
 enable-method was needed, but now it is

10:09 < arnd> clearly we want the enable-method to be there, but it
would be good if old dts files could keep working, in particular as
there are probably lots of people that hack their dts files to add
  random peripherals, and we don't want to force them to update their
dtb with every kernel change

10:11 < arnd> how about we add a .smp_init handler to
DT_MACHINE_START(BCM2835, ...) to keep it working with the old DT?

10:12 < arnd> that would also get rid of the branch dependency as an
added bonus, but avoiding the boot breakage is more important of course

10:13 < arnd> Stefan Wahren did the patch, but he's either not on this
channel, or I don't know his nick

10:30 < arnd> on a related note, I see that the match table for the
machine descriptor doesn't list bcm2837, and the bcm2837.dtsi file
doesn't list itself as compatible with bcm2836, so that would have to be
   added too to make it actually work

> Danilo Krummrich (1):
>       clk: bcm2835: remove remains from stub clk driver
> 
> Eric Anholt (2):
>       ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64 to arm.
>       Merge tag 'bcm2835-dt-next-2017-08-15' into HEAD
> 
> Florian Fainelli (3):
>       ARM: dts: BCM53573: Add Broadcom BCM947189ACDBMR board support
>       Merge tag 'bcm2835-dt-next-2017-08-07' into devicetree/next
>       Merge tag 'bcm2835-soc-next-2017-08-15' into soc/next
> 
> Jon Mason (3):
>       ARM: dts: NSP: Add dma-coherent to relevant DT entries
>       ARM: dts: NSP: Rearrage USB entries
>       ARM: dts: NSP: Add USB3 and USB3 PHY to NSP
> 
> Phil Elwell (1):
>       ARM: bcm2836: Send event when onlining other cores
> 
> Rafa? Mi?ecki (2):
>       ARM: dts: BCM5301X: Specify USB ports for each controller
>       ARM: dts: BCM5301X: Specify USB ports for USB LEDs of few devices
> 
> Stefan Wahren (6):
>       ARM: bcm283x: Define UART pinmuxing on board level
>       dt-bindings: bcm: Add Raspberry Pi Zero W
>       ARM: dts: bcm2835: Add Raspberry Pi Zero W
>       dt-bindings: arm: add SMP enable-method for BCM2836
>       ARM: dts: bcm283x: Add 32-bit enable method for SMP
>       irqchip: bcm2836: Move SMP startup code to arch/arm
> 
>  .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
>  Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
>  arch/arm/boot/dts/Makefile                         |   6 +-
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  59 ++++++---
>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   6 +
>  arch/arm/boot/dts/bcm2835-rpi-a.dts                |   6 +
>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   6 +
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   6 +
>  arch/arm/boot/dts/bcm2835-rpi-b.dts                |   6 +
>  arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           | 139 +++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   6 +
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   6 +
>  arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  52 +++++++-
>  .../dts/broadcom => arm/boot/dts}/bcm2837.dtsi     |   1 +
>  arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   4 +
>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   3 +
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   6 +
>  arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |   4 +
>  arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   5 +
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   3 +
>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |   3 +
>  arch/arm/boot/dts/bcm5301x.dtsi                    |  34 +++++
>  arch/arm/boot/dts/bcm947189acdbmr.dts              |  97 ++++++++++++++
>  arch/arm/boot/dts/bcm958522er.dts                  |   8 ++
>  arch/arm/boot/dts/bcm958525er.dts                  |   8 ++
>  arch/arm/boot/dts/bcm958525xmc.dts                 |   8 ++
>  arch/arm/boot/dts/bcm958622hr.dts                  |   8 ++
>  arch/arm/boot/dts/bcm958623hr.dts                  |   8 ++
>  arch/arm/boot/dts/bcm958625hr.dts                  |   8 ++
>  arch/arm/boot/dts/bcm958625k.dts                   |   8 ++
>  arch/arm/mach-bcm/Makefile                         |   5 +
>  arch/arm/mach-bcm/board_bcm2835.c                  |   7 --
>  arch/arm/mach-bcm/platsmp.c                        |  38 ++++++
>  arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi      |   1 -
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |  42 +------
>  .../boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi    |   1 -
>  .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi    |   1 -
>  arch/arm64/boot/dts/broadcom/bcm283x.dtsi          |   1 -
>  drivers/clk/bcm/clk-bcm2835-aux.c                  |   1 -
>  drivers/clk/bcm/clk-bcm2835.c                      |  30 -----
>  drivers/irqchip/irq-bcm2836.c                      |  79 +-----------
>  include/linux/clk/bcm2835.h                        |  24 ----
>  include/linux/irqchip/irq-bcm2836.h                |  70 +++++++++++
>  45 files changed, 620 insertions(+), 202 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
>  rename arch/{arm64/boot/dts/broadcom => arm/boot/dts}/bcm2837.dtsi (96%)
>  create mode 100644 arch/arm/boot/dts/bcm947189acdbmr.dts
>  delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
>  delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
>  delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
>  delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
>  delete mode 100644 include/linux/clk/bcm2835.h
>  create mode 100644 include/linux/irqchip/irq-bcm2836.h
> 


-- 
Florian
