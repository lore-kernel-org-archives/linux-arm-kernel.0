From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Oct 2013 16:46:57 +0100
Subject: [PATCH v3 0/3] MCPM/TC2 support for CPU powerdown synchronisation
In-Reply-To: <CALicx6uAPM8x_BcqUWtrSAMPOmc=EGMiwMKFtxL=7sUMo7BmqA@mail.gmail.com>
References: <CALicx6v86NMp53+zbE=A3ang-ftGE3KiUojkRZO4ss6Pmks1ow@mail.gmail.com>
 <CALicx6tUgu=OnrBo1NaUHQz=hd7zHrXNbDmUGKPj6EnnXRQWTw@mail.gmail.com>
 <CALicx6uAPM8x_BcqUWtrSAMPOmc=EGMiwMKFtxL=7sUMo7BmqA@mail.gmail.com>
Message-ID: <20131025154651.GA3579@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 06:19:42PM +0530, Vijay Kilari wrote:
> Sorry. Below is the right DCC configuration for SCC 700
> SCC: 0x700 0x0032F003           ;CFGRW48 - [25:24]Boot CPU [28]Boot
> 
> On Thu, Oct 24, 2013 at 6:18 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> > Hi Dave Martin,
> >
> >    With the below configuration, I tried to check cpu hotplug as this
> > is prerequisite for kexec.
> > I see cpu hotplug fails. hot-unplug is OK but hot plug-in fails.

Thanks for giving this a try.

> > Below is my DCC board configuration


I've attached my board.txt.

The only obvious difference that I think should have an impact is that
bit 13 in SCC 0x700 needs to be 1 in order for the non-boot cluster to
be powered down on startup.

In my board.txt, SCC 0x700 has the value 0x0032F003 -- you have that,
but it's commented out.

What happens if you set that bit, and make no other changes to your
config?

[more comments below]

> >
> > SCC REGISTERS]
> > TOTALSCCS: 32                   ;Total Number of SCC registers
> > SCC: 0x018 0x1FFFFFFF
> > SCC: 0x01C 0xFF00FF00           ;CFGRW3  - SMC CS6/7 N/U
> > SCC: 0x118 0x01CD1011           ;CFGRW17 - HDLCD PLL external bypass
> > ;SCC: 0x700 0x1032F003           ;CFGRW48 - [25:24]Boot CPU [28]Boot
> > Cluster (default CA7_0)
> > SCC: 0x700 0x0032D003           ;CFGRW48 - [25:24]Boot CPU [28]Boot
> > Cluster (default CA7_0)
> >                                 ;          Bootmon configuration:
> >                                 ;          [15]: A7 Event stream
> > generation (default: disabled)
> >                                 ;          [14]: A15 Event stream
> > generation (default: disabled)
> >                                 ;          [13]: Power down the
> > non-boot cluster (default: disabled)
> >                                 ;          [12]: Use per-cpu mailboxes
> > for power management (default: disabled)
> >                                 ;          [11]: A15 executes WFEs as
> > nops (default: disabled)
> >                                 ;          [ 4]: Erase UEFI variable
> > storage in NOR flash
> >
> > SCC: 0x400 0x33330c00           ;CFGREG41 - A15 configuration register
> > 0 (Default 0x33330c80)
> >                                 ;       [29:28] SPNIDEN
> >                                 ;       [25:24] SPIDEN
> >                                 ;       [21:20] NIDEN
> >                                 ;       [17:16] DBGEN
> >                                 ;       [13:12] CFGTE
> >                                 ;       [9:8] VINITHI_CORE
> >                                 ;       [7] IMINLN
> >                                 ;       [3:0] CLUSTER_ID
> >
> >
> > ;Power management interface
> >
> > SCC: 0xC00 0x00000005           ;Control: [0]PMI_EN [1]DBG_EN [2]SPC_SYSCFG
> > SCC: 0xC04 0x000005DC           ;Latency in uS max: [15:0]DVFS [31:16]PWRUP
> >
> >
> > On Mon, Oct 21, 2013 at 6:47 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> >> Hi Dave Martin,
> >>
> >>   On which kernel base this kexec is tested? is it 3.10 or 3.12?
> >> can you please share your git (public) if available?

I don't have a public git tree right now (that's on my todo list).

I tested the latest post of the series (v4) with v3.12-rc3.

> >> I tested using 3.10 + TC2 patches. However I see sometimes kexec fails
> >> to reboot and hangs at very early stage (log below)
> >>
> >> root at armeb-cortex-a15:/# kexec -e
> >> [   59.311559] Starting new kernel

I don't know why this should happen.  There is a known bug affecting
kexec when the initial kernel is Thumb (i.e., CONFIG_THUMB2_KERNEL=y).
What's your config?

Do you get any extra output if you enable the debug UART earlyprintk? 


Note that in the kernel config, you'll need CONFIG_NR_CPUS=5.  The
default is 4, which may result in the final A7 CPU not being properly
parked across kexec -- I suggest you try changing this too.

Cheers
---Dave

> >>
> >> Thanks
> >> Vijay
> >>
> >> Message: 2
> >> Date: Tue,  1 Oct 2013 18:15:15 +0100
> >> From: Dave Martin <Dave.Martin@arm.com>
> >> To: linux-arm-kernel at lists.infradead.org
> >> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Lorenzo Pieralisi
> >>         <Lorenzo.Pieralisi@arm.com>, Pawel Moll <Pawel.Moll@arm.com>, Sudeep
> >>         KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com
> >>>, Will Deacon
> >>         <Will.Deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>
> >> Subject: [PATCH v3 0/3] MCPM/TC2 support for CPU powerdown
> >>         synchronisation
> >> Message-ID: <1380647718-9178-1-git-send-email-Dave.Martin@arm.com>
> >>
> >> This series adds MCPM support for detecting when a CPU is safely powered
> >> down, and provides an implementation for TC2.
> >>
> >> It should be possible to implement the same thing for PSCI using the
> >> AFFINITY_INFO call (I need to check the semantics with Charles)
> >>
> >> This is sufficient to for working kexec with real power management on
> >> TC2.  To test it, you'll also need:
> >>
> >>   * CONFIG_KEXEC=y
> >>   * CONFIG_PROC_DEVICE_TREE=y
> >>   * CONFIG_MCPM=y
> >>   * CONFIG_ARCH_VEXPRESS_TC2_PM=y
> >>   * sufficiently new kexec-tools
> >>     (git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >>     v2.0.4 worked for me)
> >>
> >> This build on Nico's patch
> >> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7842/1
> >> (MCPM: don't explode if invoked without being initialized first)
> >>
> >> To prevent CPUs from running off into the weeds across kexec, this
> >> series requires Lorenzo's patch
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200917.html
> >> (arm: vexpress: tc2: fix hotplug/idle/kexec race on cluster power down).
> >>
> >> Changes since v2:
> >>
> >>  * Return a proper failure code if mcpm_cpu_power_down_finish() is
> >>    called with no mcpm platforms_ops registered, or a NULL
> >>    power_down_finish() method.  (Thanks again Nico)
> >>
> >>  * Minor refactoring of the loop in tc2_pm_power_down_finish() to
> >>    avoid the goto.
> >>
> >> Changes between v1 and v2:
> >>
> >>  * "Fix" erroneous documentation comment by switching to -errno return
> >>    value convention for power_down_finish(), which is more informative.
> >>    tc2_pm now returns -ETIMEDOUT on timeout.  The return is adapted to
> >>    bool convention on return from smp_ops.cpu_kill() instead.  (Thanks,
> >>    Nico).
> >>
> >>  * For consistency, BUG_ON out of range cpu or cluster values
> >>    tc2_pm_power_down_finish(), as for tc2_pm_power_down().
> >>
> >> Changes between RFC and v1:
> >>
> >>  * Print a big fat warning instead of branching to null if the
> >>    power_down_finish() method is not supplied by the backend, or not
> >>    registered.
> >>
> >>  * Add a generous timeout of 1 second for the TC2 implementation.
> >>
> >>  * Relax the polling interval to 10ms for TC2, since the need to poll
> >>    more than once is rare and this is not a performance-critical path.
> >>
> >>  * Fix some silly typos.
> >>
> >>
> >> Dave Martin (3):
> >>   ARM: mcpm: Factor out logical-to-physical CPU translation
> >>   ARM: mcpm: Implement cpu_kill() to synchronise on powerdown
> >>   ARM: vexpress/TC2: Implement MCPM power_down_finish()
> >>
> >>  arch/arm/common/mcpm_entry.c    |   15 +++++++++
> >>  arch/arm/common/mcpm_platsmp.c  |   27 +++++++++++++---
> >>  arch/arm/include/asm/mcpm.h     |   31 ++++++++++++++++++
> >>  arch/arm/mach-vexpress/spc.c    |   39 +++++++++++++++++++++++
> >>  arch/arm/mach-vexpress/spc.h    |    1 +
> >>  arch/arm/mach-vexpress/tc2_pm.c |   66 ++++++++++++++++++++++++++++++++++++---
> >>  6 files changed, 170 insertions(+), 9 deletions(-)
> >>
> >> --
> >> 1.7.9.5
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
BOARD: HBI0249
TITLE: V2P-CA15_A7 Configuration File

[DCCS]
TOTALDCCS: 1                    ;Total Number of DCCS
M0FILE: dbb_v110.ebf            ;DCC0 Filename
M0MODE: MICRO                   ;DCC0 Programming Mode

[FPGAS]
TOTALFPGAS: 0                   ;Total Number of FPGAs

[TAPS]
TOTALTAPS: 3                    ;Total Number of TAPs
T0NAME: STM32TMC                ;TAP0 Device Name
T0FILE: NONE                    ;TAP0 Filename
T0MODE: NONE                    ;TAP0 Programming Mode
T1NAME: STM32CM3                ;TAP1 Device Name
T1FILE: NONE                    ;TAP1 Filename
T1MODE: NONE                    ;TAP1 Programming Mode
T2NAME: CORTEXA15               ;TAP2 Device Name
T2FILE: NONE      		;TAP2 Filename
T2MODE: NONE                    ;TAP2 Programming Mode

[OSCCLKS]
TOTALOSCCLKS: 9                 ;Total Number of OSCCLKS
OSC0: 50.0                      ;CPUREFCLK0 A15 CPU (20:1 - 1.0GHz)
OSC1: 50.0                      ;CPUREFCLK1 A15 CPU (20:1 - 1.0GHz)
OSC2: 40.0                      ;CPUREFCLK0 A7  CPU (20:1 - 800MHz)
OSC3: 40.0                      ;CPUREFCLK1 A7  CPU (20:1 - 800MHz)
OSC4: 40.0                      ;HSBM AXI (40MHz)
OSC5: 23.75                     ;HDLCD (23.75MHz - TC PLL is in bypass)
OSC6: 50.0                      ;SMB (50MHz)
OSC7: 50.0                      ;SYSREFCLK (20:1 - 1.0GHz, ACLK - 500MHz)
OSC8: 50.0                      ;DDR2 (8:1 - 400MHz)

[SCC REGISTERS]
TOTALSCCS: 32                   ;Total Number of SCC registers
SCC: 0x01C 0xFF00FF00           ;CFGRW3  - SMC CS6/7 N/U
SCC: 0x118 0x01CD1011           ;CFGRW17 - HDLCD PLL external bypass

SCC: 0x700 0x0032F003           ;CFGRW48 - Cluster configuration register (Default 0x0032F003)
                                ;          [   28] Boot Cluster (default CA15)
                                ;          [25:24] Boot CPU (default 0)
                                ;          [   15] A7 Event stream generation (default: enabled)
                                ;          [   14] A15 Event stream generation (default: enabled)
                                ;          [   13] Power down the non-boot cluster (default: enabled)
                                ;          [   12] Use per-cpu mailboxes for power management (default: enabled)
                                ;          [   11] A15 executes WFEs as nops (default: disabled)

SCC: 0x400 0x33330C00           ;CFGRW41 - A15 configuration register 0 (Default 0x33330C00)
                                ;          [29:28] SPNIDEN
                                ;          [25:24] SPIDEN
                                ;          [21:20] NIDEN
                                ;          [17:16] DBGEN
                                ;          [13:12] CFGTE
                                ;          [ 9: 8] VINITHI_CORE
                                ;          [    7] IMINLN
                                ;          [ 3: 0] CLUSTER_ID

                                ;Set the CPU clock PLLs
SCC: 0x120 0x022F1010           ;CFGRW19 - CA15_0 PLL control - 20:1 (lock OFF)
SCC: 0x124 0x0011710D           ;CFGRW20 - CA15_0 PLL value
SCC: 0x128 0x022F1010           ;CFGRW21 - CA15_1 PLL control - 20:1 (lock OFF)
SCC: 0x12C 0x0011710D           ;CFGRW22 - CA15_1 PLL value
SCC: 0x130 0x022F1010           ;CFGRW23 - CA7_0  PLL control - 20:1 (lock OFF)
SCC: 0x134 0x0011710D           ;CFGRW24 - CA7_0  PLL value
SCC: 0x138 0x022F1010           ;CFGRW25 - CA7_1  PLL control - 20:1 (lock OFF)
SCC: 0x13C 0x0011710D           ;CFGRW26 - CA7_1  PLL value

                                ;Power management interface
; SCC: 0xC00 0x00000007           ;Control: [0]PMI_EN [1]DBG_EN [2]SPC_SYSCFG (disable DBG_EN for power measurements)
; Disable DBG_EN for real power management with Linux MCPM:
SCC: 0xC00 0x00000005           ;Control: [0]PMI_EN [1]DBG_EN [2]SPC_SYSCFG (disable DBG_EN for power measurements)
SCC: 0xC04 0x060E0356           ;Latency in uS max: [15:0]DVFS [31:16]PWRUP
SCC: 0xC08 0x00000000           ;Reserved
SCC: 0xC0C 0x00000000           ;Reserved

                                ;CA15 performance values: 0xVVVFFFFF
SCC: 0xC10 0x384061A8           ;CA15 PERFVAL0,  900mV, 20,000*20= 500MHz
SCC: 0xC14 0x38407530           ;CA15 PERFVAL1,  900mV, 25,000*20= 600MHz
SCC: 0xC18 0x384088B8           ;CA15 PERFVAL2,  900mV, 30,000*20= 700MHz
SCC: 0xC1C 0x38409C40           ;CA15 PERFVAL3,  900mV, 35,000*20= 800MHz
SCC: 0xC20 0x3840AFC8           ;CA15 PERFVAL4,  900mV, 40,000*20= 900MHz
SCC: 0xC24 0x3840C350           ;CA15 PERFVAL5,  900mV, 45,000*20=1000MHz
SCC: 0xC28 0x3CF0D6D8           ;CA15 PERFVAL6,  975mV, 50,000*20=1100MHz
SCC: 0xC2C 0x41A0EA60           ;CA15 PERFVAL7, 1050mV, 55,000*20=1200MHz

                                ;CA7 performance values: 0xVVVFFFFF
SCC: 0xC30 0x3840445C           ;CA7 PERFVAL0,  900mV, 10,000*20= 350MHz
SCC: 0xC34 0x38404E20           ;CA7 PERFVAL1,  900mV, 15,000*20= 400MHz
SCC: 0xC38 0x384061A8           ;CA7 PERFVAL2,  900mV, 20,000*20= 500MHz
SCC: 0xC3C 0x38407530           ;CA7 PERFVAL3,  900mV, 25,000*20= 600MHz
SCC: 0xC40 0x384088B8           ;CA7 PERFVAL4,  900mV, 30,000*20= 700MHz
SCC: 0xC44 0x38409C40           ;CA7 PERFVAL5,  900mV, 35,000*20= 800MHz
SCC: 0xC48 0x3CF0AFC8           ;CA7 PERFVAL6,  975mV, 40,000*20= 900MHz
SCC: 0xC4C 0x41A0C350           ;CA7 PERFVAL7, 1050mV, 45,000*20=1000MHz

SCC: 0xB00 0x00000007           ;CA15 PERFLVL7 (max) requested initially
SCC: 0xB08 0x00000007           ;CA7 PERFLVL7 (max) requested initially
