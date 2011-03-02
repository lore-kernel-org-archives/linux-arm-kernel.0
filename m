From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Mar 2011 16:29:19 +0900
Subject: [PATCH V4] ARM: EXYNOS4: Implement kernel timers using MCT
In-Reply-To: <AANLkTim9XMD=x5dbm0vOcrCcrL0TRKvdb7CuXBv3r_qX@mail.gmail.com>
References: <1298870207-1850-1-git-send-email-kgene.kim@samsung.com>
	<1298870207-1850-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTim9XMD=x5dbm0vOcrCcrL0TRKvdb7CuXBv3r_qX@mail.gmail.com>
Message-ID: <010b01cbd8ab$8d575830$a8060890$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
> MCT is only possible from EVT1.0 or later. The current universal_c210
> used the EVT0 version.
> So can you remove the ifdef and board can select which timer is used?
> Please refer the omap implementation and how to use it.
> 
Basically, "CONFIG_EXYNOS4_MCT" can be selected in kernel menuconfig.
It means default one is using local timer which is included in every
Exynos4210.

> If we use the same configuration, It will be boot failed at
> universal_c210 board.
> 
No, see as above.

One more basically, each machine specific CONFIGs should be selected in
kernel menuconfig after "make exynos4_defconfig". Because each machine
supports different components on each one now.

As a note, however, I don't want to add each machine's defconfig. Maybe
Russell also.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Thank you,
> Kyungmin Park
> 
> On Mon, Feb 28, 2011 at 2:16 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Changhwan Youn <chaos.youn@samsung.com>
> >
> > The Multi-Core Timer(MCT) of EXYNOS4 is designed for implementing
> > clock source timer and clock event timers. This patch implements
> > 1 clock source timer with 64 bit free running counter of MCT and
> > 2 clock event timers with two of 31-bit tick counters.
> >
> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > Changes since v3:
> > - Re-worked based on exynos4
> > - Changed member of clock_evetn_device like following
> > ?struct mct_clock_event_device {
> > ? ? ? ?struct clock_event_device *evt;
> > ?...
> > - Address comments from Russell King
> > ?Added static into "irqreturn_t exynos4_mct_comp_isr()"
> > ?Added .dev_id member into "struct irqaction mct_comp_event_irq"
> >
> > Changes since v2:
> > - Addressed comments from Russell King
> > ?Added mct_clock_event_device structure
> > - Removed suspend()/resume() which are not used now
> >
> > Changes since v1:
> > - Addressed comments from Russell King
> > ?(implemented global timer, used local timer and so on)
> > - Fixed small things
> >
> > ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> > ?arch/arm/mach-exynos4/Kconfig ? ? ? ? ? ? ? ? | ? ?5 +
> > ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? ? ? ?| ? 11 +-
> > ?arch/arm/mach-exynos4/include/mach/regs-mct.h | ? 52 +++
> > ?arch/arm/mach-exynos4/mct.c ? ? ? ? ? ? ? ? ? | ?421
> +++++++++++++++++++++++++
> > ?5 files changed, 488 insertions(+), 3 deletions(-)
> > ?create mode 100644 arch/arm/mach-exynos4/include/mach/regs-mct.h
> > ?create mode 100644 arch/arm/mach-exynos4/mct.c
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index ec3bf98..b4db99b 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1366,7 +1366,7 @@ config LOCAL_TIMERS
> > ? ? ? ?bool "Use local timer interrupts"
> > ? ? ? ?depends on SMP
> > ? ? ? ?default y
> > - ? ? ? select HAVE_ARM_TWD if !ARCH_MSM_SCORPIONMP
> > + ? ? ? select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> > ? ? ? ?help
> > ? ? ? ? ?Enable support for local timers on SMP platforms, rather then
the
> > ? ? ? ? ?legacy IPI broadcast method. ?Local timers allows the system
> > diff --git a/arch/arm/mach-exynos4/Kconfig
b/arch/arm/mach-exynos4/Kconfig
> > index ad03840..77b5d93 100644
> > --- a/arch/arm/mach-exynos4/Kconfig
> > +++ b/arch/arm/mach-exynos4/Kconfig
> > @@ -15,6 +15,11 @@ config CPU_EXYNOS4210
> > ? ? ? ?help
> > ? ? ? ? ?Enable EXYNOS4210 CPU support
> >
> > +config EXYNOS4_MCT
> > + ? ? ? bool "Kernel timer support by MCT"
> > + ? ? ? help
> > + ? ? ? ? Use MCT (Multi Core Timer) as kernel timers
> > +
> > ?config EXYNOS4_DEV_PD
> > ? ? ? ?bool
> > ? ? ? ?help
> > diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-
> exynos4/Makefile
> > index 0558235..de20b91 100644
> > --- a/arch/arm/mach-exynos4/Makefile
> > +++ b/arch/arm/mach-exynos4/Makefile
> > @@ -13,11 +13,18 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:=
> > ?# Core support for EXYNOS4 system
> >
> > ?obj-$(CONFIG_CPU_EXYNOS4210) ? += cpu.o init.o clock.o irq-combiner.o
> > -obj-$(CONFIG_CPU_EXYNOS4210) ? += setup-i2c0.o time.o gpiolib.o
irq-eint.o
> dma.o
> > +obj-$(CONFIG_CPU_EXYNOS4210) ? += setup-i2c0.o gpiolib.o irq-eint.o
dma.o
> > ?obj-$(CONFIG_CPU_FREQ) ? ? ? ? += cpufreq.o
> >
> > ?obj-$(CONFIG_SMP) ? ? ? ? ? ? ?+= platsmp.o headsmp.o
> > -obj-$(CONFIG_LOCAL_TIMERS) ? ? += localtimer.o
> > +
> > +ifeq ($(CONFIG_EXYNOS4_MCT),y)
> > +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= mct.o
> > +else
> > +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= time.o
> > +obj-$(CONFIG_LOCAL_TIMERS) ? ? += localtimer.o
> > +endif
> > +
> > ?obj-$(CONFIG_HOTPLUG_CPU) ? ? ?+= hotplug.o
> >
> > ?# machine support

(snip)
