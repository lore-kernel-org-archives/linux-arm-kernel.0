From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Dec 2014 10:42:39 +0000
Subject: [PATCH 16/19] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <547BD0BA.7080809@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-17-git-send-email-cw00.choi@samsung.com>
 <20141127111834.GB857@leverpostej> <54787621.4000503@samsung.com>
 <20141128140059.GH25883@leverpostej> <547BD0BA.7080809@samsung.com>
Message-ID: <20141202104239.GA23671@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 02:21:46AM +0000, Chanwoo Choi wrote:
> Dear Mark,
> 
> On 11/28/2014 11:00 PM, Mark Rutland wrote:
> > On Fri, Nov 28, 2014 at 01:18:25PM +0000, Chanwoo Choi wrote:
> >> Dear Mark,
> >>
> >> On 11/27/2014 08:18 PM, Mark Rutland wrote:
> >>> On Thu, Nov 27, 2014 at 07:35:13AM +0000, Chanwoo Choi wrote:
> >>>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC
> >>>> based on Octal core CPUs (quad Cortex-A57 and quad Cortex-A53).
> >>>>
> >>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>>> Cc: Olof Johansson <olof@lixom.net>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>>> Acked-by: Inki Dae <inki.dae@samsung.com>
> >>>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698 +++++++++++++++++++++
> >>>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 523 +++++++++++++++
> >>>>  2 files changed, 1221 insertions(+)
> >>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> >>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
> >>>
> >
> > [...]
> >
> >>>> +       cpus {
> >>>> +               #address-cells = <2>;
> >>>> +               #size-cells = <0>;
> >>>> +
> >>>> +               cpu0: cpu at 100 {
> >>>> +                       device_type = "cpu";
> >>>> +                       compatible = "arm,cortex-a53", "arm,armv8";
> >>>> +                       enable-method = "psci";
> >>>
> >>> While the CPU nodes have enable-methods, I didn't spot a PSCI node
> >>> anywhere, so this dts cannot possibly have been used to bring up an SMP
> >>> system.
> >>>
> >>> How has this dts been tested?
> >>>
> >>> What PSCI revision have you implemented? Have have you tested it?
> >>
> >> My mistake,
> >> Exynos5433 supports PSCI v0.1. I'll add following PSCI nodes:
> >> I tested the boot of secondary cpu.
> >>
> >>         psci {
> >>                 compatible = "arm,psci";
> >>                 method = "smc";
> >>                 cpu_off = <0x84000002>;
> >>                 cpu_on = <0xC4000003>;
> >>         };
> >
> > Ok. I take it _any_ CPU may be hotplugged (including CPU0), given that
> > you don't have MIGRATE_INFO_TYPE from PSCI 0.2 to tell you that this is
> > not possible? If not, attempting to hotplug CPU0 will result in a BUG()
> > and the kernel will explode.
> >
> > Has that been tested?
> 
> I just tested secondary CPU on during kernel booting after added 'psci' dt node.
> So, I got the ON state of Octa CPUs.
> 
> Maybe I need more time to implement CPU0 and secondary cpu hotplugged dynamically on runtime.

So currently PSCI CPU_OFF is not implemented at all?

> > Do all CPUs enter the kernel at EL2?
> 
> I didn't consider EL2 for hypervisor mode.
> First role of this job, I'll implement CPU on/off and suspend by using PSCI.

Is there any reason not to enter the kernel at EL2?

PSCI 0.2 mandates entering at EL2 if present (and not under a
hypervisor), and it gives the kernel a lot more flexibility to fix
things up (and there's less for FW to restore) even when a hypervisor is
not in use.

Implementing all that to EL2 is _simpler_ than implementing it to EL1.
The kernel will restore what it needs to.

Thanks,
Mark.
