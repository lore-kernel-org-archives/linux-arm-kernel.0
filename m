From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 Sep 2014 10:22:39 +0200
Subject: [PATCH 0/9] ARM: vf610: Suspend/resume support
In-Reply-To: <87zjdqmjr3.fsf@nbsps.com>
References: <cover.1411404079.git.stefan@agner.ch> <87zjdqmjr3.fsf@nbsps.com>
Message-ID: <4ee0621b0bf5f4d4e10eae7673bdf1cd@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-23 17:36, schrieb Bill Pringlemeir:
> On 22 Sep 2014, stefan at agner.ch wrote:
> 
>> This patchset provides suspend/resume support for Freescale Vybrid
>> SoC (vf610). The code is generally aligned to the implementation
>> for i.MX6. The subsystems SRC and GPC need some changes to support
>> the Vybrid specific implementation.
>>
>> This patchset relies on GPIO driver to be present (in order to
>> provide a wakeup source) as well as using the ARM Global Timer
>> clock source (the Vybrid specifc PIT clock source, vf_pit_timer.c
>> does not support shutdown).
>>
>> The implemented sleep states (LP-RUN and STOP), are not the most
>> power saving functions available on Vybrid. Especially for
>> suspend-to-memory one of the LPSTOP modes looks more appropriate.
>> However, the complexity is somewhat higher (we would need to move
>> execution path to SRAM and store IOMUX and DDRMC configuration).
>> Currently, I have not the resources to look into that so I hope
>> that this initial code qualifies as power saving functions to be
>> applied.
>>
>> Suspend-to-memory as well as standby mode is tested on Colibri
>> VF61.
> 
>> Power measurement (Colibri VF61, whole module):
>> - Idle: 540mW
>> - LP-RUN: 220mW (standby)
>> - STOP: 200mW (mem)
> 
>> Stefan Agner (9):
>> ARM: dts: vf610: Add system reset controller (SRC)
>> ARM: dts: vf610: add global power controller (GPC)
>> ARM: dts: vf610: add on-chip SRAM
> 
> These above three change sets have some implications for dual-chip
> (Cortex-A5/Cortex-M4) configurations.  Epecially those running MQX.
> There is not harm to define the register space (except DT size).
> However, if you activate drivers that manipulate the registers for all
> systems, then there is no choice to have MQX work on the 2nd core.

On the Timesys BSP, the kernel is fiddling around with this registers
too, and AFAIK MQX is working with that kernel. Is MQX really using the
GPC and SRC modules? I thought MQX is just relying on Linux taking care
of that.

Also, you have this problem with other registers as well, for instance
the CCM module. In fact, to get into deeper sleep modes, you need to
access the GPC (global power controller) as well as the CCM (clock
controller module, for instance the CCM_CLPCR register). When you look
at all the entry sequences, they all fiddling around with the GPC and
the CCM. And I don't think that the kernel can work properly without
having control over the clock module.

IMHO, the SRC and GPC are like the CCM, and need to be under control of
Linux exclusively.

Another case is the SRAM. There are other peripherals which are much
more important, e.g. both instances of the EDMA modules are currently
unconditional part of the device tree.

Besides, afaik you can also use status = "disabled" in a device tree
including the vf610.dtsi. The device tree is parsed sequential, the last
settings wins.

> 
> I think that Shawn Guo already did a patchset to remove stuff from the
> vf610.dtsi to the machine/configuration DT files.
> 
>> ARM: dts: vf610-colibri: GPIO power key
>> gpio: vf610: Extend with wakeup support
>> ARM: imx: gpc: Support vf610 global power controller
>> ARM: imx: src: Support vf610 system reset controller
>> ARM: imx: clk-gate2: allow custom gate configuration
>> ARM: vf610: initial suspend/resume support
>>
>> arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 26 ++
>> arch/arm/boot/dts/vf610.dtsi | 33 +++ arch/arm/mach-imx/Kconfig | 2 +
>> arch/arm/mach-imx/Makefile | 1 + arch/arm/mach-imx/clk-gate2.c | 7 +-
>> arch/arm/mach-imx/clk-vf610.c | 6 + arch/arm/mach-imx/clk.h | 13 +-
>> arch/arm/mach-imx/common.h | 14 +- arch/arm/mach-imx/gpc.c | 61 ++--
>> arch/arm/mach-imx/mach-imx6q.c | 2 +- arch/arm/mach-imx/mach-imx6sl.c
>> | 2 +- arch/arm/mach-imx/mach-vf610.c | 9 +
>> arch/arm/mach-imx/pm-vf610.c | 428 ++++++++++++++++++++++++++++
>> arch/arm/mach-imx/src.c | 11 + drivers/gpio/gpio-vf610.c | 16 ++
>> include/dt-bindings/clock/vf610-clock.h | 3 +- 16 files changed, 605
>> insertions(+), 29 deletions(-) create mode 100644
>> arch/arm/mach-imx/pm-vf610.c
