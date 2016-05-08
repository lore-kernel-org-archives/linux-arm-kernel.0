From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 May 2016 21:13:10 +0200
Subject: [PATCH v3] sunxi-irq: Fix Kconfig dependency on GENERIC_IRQ_CHIP
In-Reply-To: <572B55CC.7080603@arm.com>
References: <1461546292-21110-1-git-send-email-andre.przywara@arm.com>
 <20160502064854.GL17159@lukather> <5729D2A0.70900@arm.com>
 <20160505132146.GH17159@lukather> <572B55CC.7080603@arm.com>
Message-ID: <20160508191310.GE6167@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 03:16:44PM +0100, Andre Przywara wrote:
> Hi Maxime,
> 
> On 05/05/16 14:21, Maxime Ripard wrote:
> > On Wed, May 04, 2016 at 11:44:48AM +0100, Andre Przywara wrote:
> >> Hi Maxime,
> >>
> >> On 02/05/16 07:48, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> On Mon, Apr 25, 2016 at 02:04:52AM +0100, Andre Przywara wrote:
> >>>> The Allwinner NMI irqchip driver requires GENERIC_IRQ_CHIP, but
> >>>> we can't select it directly, because there is no specific Kconfig entry
> >>>> for the driver. Compiling this NMI driver with certain arm64
> >>>> configurations thus fails due to the missing dependency:
> >>>>
> >>>> drivers/built-in.o: In function `sunxi_sc_nmi_set_type':
> >>>> drivers/irqchip/irq-sunxi-nmi.c:114: undefined reference to `irq_setup_alt_chip'
> >>>> drivers/built-in.o: In function `irq_domain_add_linear':
> >>>> include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
> >>>> include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
> >>>> drivers/built-in.o: In function `sunxi_sc_nmi_irq_init':
> >>>> drivers/irqchip/irq-sunxi-nmi.c:146: undefined reference to `irq_alloc_domain_generic_chips'
> >>>> drivers/irqchip/irq-sunxi-nmi.c:161: undefined reference to `irq_get_domain_generic_chip'
> >>>> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'
> >>>> drivers/irqchip/irq-sunxi-nmi.c:171: undefined reference to `irq_gc_mask_set_bit'
> >>>> drivers/irqchip/irq-sunxi-nmi.c:172: undefined reference to `irq_gc_ack_set_bit'
> >>>> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'
> >>>>
> >>>> Add separate Kconfig options for both Allwinner specific irqchip
> >>>> drivers and select GENERIC_IRQ_CHIP for the NMI driver.
> >>>> The older sun4i IRQ driver only gets selected when support for these
> >>>> specific SoCs is compiled, while the NMI driver is selected for all
> >>>> Allwinner SoCs (copying the current behaviour and covering future SoCs
> >>>> automatically).
> >>>>
> >>>> Reported-by: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> >>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>>> ---
> >>>> Hi,
> >>>>
> >>>> this is a new approach to the problem that Suzuki tried to address
> >>>> already.
> >>>> It separates the sun4i IRQ controller driver and the NMI driver as
> >>>> Maxime requested.
> >>>> While there should be no difference for the NMI driver, the sun4i
> >>>> driver now only gets selected for certain SoCs, which is admittedly
> >>>> a bold call for -rc5. If people find this too risky, I can bring the
> >>>> sun4i in line with the NMI driver (selected for all ARCH_SUNXI) for
> >>>> this release and re-create the more selective dependency as a merge
> >>>> window patch, so that it gets more testing.
> >>>> Please let me know.
> >>>>
> >>>> Cheers,
> >>>> Andre.
> >>>>
> >>>>  arch/arm/mach-sunxi/Kconfig | 3 ++-
> >>>>  drivers/irqchip/Kconfig     | 8 ++++++++
> >>>>  drivers/irqchip/Makefile    | 4 ++--
> >>>>  3 files changed, 12 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> >>>> index c124d65..c092bc2 100644
> >>>> --- a/arch/arm/mach-sunxi/Kconfig
> >>>> +++ b/arch/arm/mach-sunxi/Kconfig
> >>>> @@ -4,7 +4,6 @@ menuconfig ARCH_SUNXI
> >>>>  	select ARCH_REQUIRE_GPIOLIB
> >>>>  	select ARCH_HAS_RESET_CONTROLLER
> >>>>  	select CLKSRC_MMIO
> >>>> -	select GENERIC_IRQ_CHIP
> >>>>  	select PINCTRL
> >>>>  	select SUN4I_TIMER
> >>>>  	select RESET_CONTROLLER
> >>>> @@ -14,11 +13,13 @@ if ARCH_SUNXI
> >>>>  config MACH_SUN4I
> >>>>  	bool "Allwinner A10 (sun4i) SoCs support"
> >>>>  	default ARCH_SUNXI
> >>>> +	select SUN4I_IRQCHIP
> >>>>  
> >>>>  config MACH_SUN5I
> >>>>  	bool "Allwinner A10s / A13 (sun5i) SoCs support"
> >>>>  	default ARCH_SUNXI
> >>>>  	select SUN5I_HSTIMER
> >>>> +	select SUN4I_IRQCHIP
> >>>>  
> >>>>  config MACH_SUN6I
> >>>>  	bool "Allwinner A31 (sun6i) SoCs support"
> >>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >>>> index 3e12479..94f3f42 100644
> >>>> --- a/drivers/irqchip/Kconfig
> >>>> +++ b/drivers/irqchip/Kconfig
> >>>> @@ -165,6 +165,14 @@ config ST_IRQCHIP
> >>>>  	help
> >>>>  	  Enables SysCfg Controlled IRQs on STi based platforms.
> >>>>  
> >>>> +config SUN4I_IRQCHIP
> >>>> +	bool
> >>>> +
> >>>> +config SUNXI_NMI
> >>>> +	bool "Allwinner SoC NMI controller"
> >>>> +	default ARCH_SUNXI
> >>>> +	select GENERIC_IRQ_CHIP
> >>>
> >>> This one is only used on SUN6I, SUN7I and SUN8I. There's no need to
> >>> enable it for all the SoCs.
> >>
> >> But it is enabled for all SoCs at the moment - and as it is actually a
> >> fix (-rc1 does not compile for certain arm64 configs) I'd really like to
> >> not take chances here.
> >> As mentioned I am happy to send a follow up patch to restrict it further
> >> - given that it gets more testing, but at the moment I'd really like to
> >> just fix the arm64 build without accidentally breaking existing arm(32)
> >> boards.
> > 
> > Then at least be consistent and do the same thing for the A10 irq
> > controller too.
> 
> Which is basically what Suzuki proposed with v2:
> https://lkml.org/lkml/2016/4/13/592

And I already told that this was the wrong approach back then. A month
down the road, we still have made no progress.

> This patch also has been acked by Marc, so can't we just take that for
> 4.6 and I'll send a patch on top of that to make a more fine grained
> selection for the next release?

I'm really not a fan of holding people hostage to get patches merged,
but yeah, go ahead. We're very close from the merge window now, so I
guess I won't even have a proper patch in 4.7... Great.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160508/c24a883e/attachment.sig>
