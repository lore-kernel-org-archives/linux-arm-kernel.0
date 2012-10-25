From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 25 Oct 2012 11:49:44 -0600
Subject: [PATCHv2] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <50895D9F.4080009@gmail.com>
References: <1350581567-17229-1-git-send-email-dinguyen@altera.com>
 <50887348.9070904@gmail.com> <1351182356.15182.7.camel@dinh-ubuntu>
 <50895D9F.4080009@gmail.com>
Message-ID: <1351187384.15182.18.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Rob,

On Thu, 2012-10-25 at 10:41 -0500, Rob Herring wrote:
> 
> On 10/25/2012 11:25 AM, Dinh Nguyen wrote:
> > Hi Rob,
> > 
> > On Wed, 2012-10-24 at 18:01 -0500, Rob Herring wrote:
> >> On 10/18/2012 12:32 PM, dinguyen at altera.com wrote:
> >>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>
> >>> Enable SMP for the SOCFPGA platform.
> >>>
> >>> Signed-off-by: Pavel Machek <pavel@denx.de>
> >>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> >>> ---
> >>> v2:
> >>> -Remove pen_release code
> >>> -Remove code that was already done by v7_setup
> >>> -Add bindings document for reset and system manager
> >>> -Move socfpga_sysmgr_init from platsmp.c to socfpga.c, because
> >>> we will need to use the reset and system manager for more than SMP.
> >>> -Move core.h to mach-socfpga from mach-socfpga/include/mach
> >>
> >> Just some lingering comments on the defconfig. Otherwise,
> >>
> >> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> >>
> >>> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> >>> index 0ac1293..349ac22 100644
> >>> --- a/arch/arm/configs/socfpga_defconfig
> >>> +++ b/arch/arm/configs/socfpga_defconfig
> >>
> >> I'm still not clear why multi_v7 config does not work for you?
> > 
> > multi_v7 works fine for me. But I need
> > +#CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set 
> 
> Why? I don't think those should break other versions of A9. If they do,
> we need to fix that. In general, we should turn on all errata for
> multi-platform builds, so we need to make sure they are done in a
> compatible way and can be bypassed if they have performance impacts.
> That may ultimately require some runtime patching though.

Our virtual platform is having a problem with CONFIG_ARM_ERRATA_751472.
It could be that our virtual platform is not simulating this correctly.

Dinh
> 
> Rob
> 
> > 
> > in order for SMP to work correctly on our platform.
> > 
> > 
> >>
> >>> @@ -1,5 +1,5 @@
> >>>  CONFIG_EXPERIMENTAL=y
> >>> -CONFIG_SYSVIPC=y
> >>> +CONFIG_NO_HZ=y
> >>>  CONFIG_IKCONFIG=y
> >>>  CONFIG_IKCONFIG_PROC=y
> >>>  CONFIG_LOG_BUF_SHIFT=14
> >>> @@ -16,10 +16,13 @@ CONFIG_MODULE_UNLOAD=y
> >>>  # CONFIG_IOSCHED_DEADLINE is not set
> >>>  # CONFIG_IOSCHED_CFQ is not set
> >>>  CONFIG_ARCH_SOCFPGA=y
> >>> -CONFIG_MACH_SOCFPGA_CYCLONE5=y
> >>> -CONFIG_ARM_THUMBEE=y
> >>> +# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
> >>>  # CONFIG_CACHE_L2X0 is not set
> >>>  CONFIG_HIGH_RES_TIMERS=y
> >>> +CONFIG_SMP=y
> >>> +CONFIG_ARM_ARCH_TIMER=y
> >>
> >> You're an A9, right? You don't have arch timers.
> > 
> > Yes, will remove in v3.
> >>
> >>> +CONFIG_HIGHMEM=y
> >>
> >> How much RAM? You need more than 2GB with CONFIG_VMSPLIT_2G.
> > 
> > 1G for RAM only, so will remove in v3.
> > 
> > Thanks,
> > Dinh
> >>
> >>> +CONFIG_HIGHPTE=y
> >>>  CONFIG_VMSPLIT_2G=y
> >>>  CONFIG_NR_CPUS=2
> >>>  CONFIG_AEABI=y
> >>
> >>
> > 
> > 
> > 
> 
