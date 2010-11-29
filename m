From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 29 Nov 2010 15:50:21 +0100 (CET)
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <20101129142200.GA14941@n2100.arm.linux.org.uk>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
	<AANLkTinbAVFE+HZrx+9KUwx8=MKFHPqrhpOpAWAEQFv-@mail.gmail.com>
	<201011271639.21694.arnd@arndb.de>
	<20101129142200.GA14941@n2100.arm.linux.org.uk>
Message-ID: <alpine.LNX.2.00.1011291546550.12293@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 29 Nov 2010, Russell King - ARM Linux wrote:

> On Sat, Nov 27, 2010 at 04:39:21PM +0100, Arnd Bergmann wrote:
> > On Saturday 27 November 2010 14:01:20 Micha? Miros?aw wrote:
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index db524e7..74ea522 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1164,7 +1164,7 @@ config ISA_DMA_API
> > >         bool
> > > 
> > >  config PCI
> > > -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> > > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> > > +       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> > > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX ||
> > > ARCH_GEMINI
> > >         help
> > >           Find out whether you have a PCI motherboard. PCI is the name of a
> > >           bus system, i.e. the way the CPU talks to the other stuff inside
> > > 
> > 
> > This approach really does not scale as we add more boards to the list.
> > 
> > Better make a new CONFIG_HAVE_PCI option that you can select from the
> > individual boards, and make that the only dependency that CONFIG_PCI has.
> 
> Be careful.  There are two things going on here:
> 
> 1. those which PCI support is configurable
> 2. those which always have PCI support
> 
> Making PCI "depend on HAVE_PCI" is wrong, and will throw up lots of
> Kconfig warnings, as those platforms which always have PCI support
> won't select HAVE_PCI - and making them do so such that "PCI support"
> gets offered to them - with the only possible value being 'Y' is
> silly.
> 
> So, rather than HAVE_PCI, it should be MIGHT_HAVE_PCI, and that
> symbol needs to control whether the "PCI support" prompt is offered
> to the user, not whether PCI is available or not.
> 

Here's my idea

bool "PIC support" if MIGHT_HAVE_PCI

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..614cf2f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -34,6 +34,9 @@ config ARM
 config HAVE_PWM
 	bool
 
+config MIGHT_HAVE_PCI
+	bool
+
 config SYS_SUPPORTS_APM_EMULATION
 	bool
 
@@ -298,6 +301,7 @@ config ARCH_CNS3XXX
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
+	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
@@ -433,6 +437,7 @@ config ARCH_IXP4XX
 	select CPU_XSCALE
 	select GENERIC_GPIO
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
 	select DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
@@ -1164,7 +1169,7 @@ config ISA_DMA_API
 	bool
 
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || 
ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if MIGHT_HAVE_PCI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of 
a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 9ebfcc4..29b13f2 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -3,6 +3,7 @@ menu "CNS3XXX platform type"
 
 config MACH_CNS3420VB
 	bool "Support for CNS3420 Validation Board"
+	select MIGHT_HAVE_PCI
 	help
 	  Include support for the Cavium Networks CNS3420 MPCore Platform
 	  Baseboard.
diff --git a/arch/arm/mach-integrator/Kconfig 
b/arch/arm/mach-integrator/Kconfig
index 27db275..769b0f1 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -4,6 +4,7 @@ menu "Integrator Options"
 
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
+	select MIGHT_HAVE_PCI
 	help
 	  Include support for the ARM(R) Integrator/AP and
 	  Integrator/PP2 platforms.
diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
index fe0c82e..f5c39a8 100644
--- a/arch/arm/mach-ks8695/Kconfig
+++ b/arch/arm/mach-ks8695/Kconfig
@@ -4,6 +4,7 @@ menu "Kendin/Micrel KS8695 Implementations"
 
 config MACH_KS8695
 	+++ b/arch/arm/mach-versatile/Kconfig
@@ -4,6 +4,7 @@ menu "Versatile platform type"
 config ARCH_VERSATILE_PB
 	bool "Support Versatile/PB platform"
 	select CPU_ARM926T
+	select HAVE_PCI
 	default y
 	help
 	  Include support for the ARM(R) Versatile/PB platform.bool 
"KS8695 development board"
+	select MIGHT_HAVE_PCI
 	help
 	  Say 'Y' here if you want your kernel to run on the original
 	  Kendin-Micrel KS8695 development board.
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index dd235ec..716a2e1 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -94,6 +94,7 @@ config MACH_ARMCORE
 	select PXA27x
 	select IWMMXT
 	select PXA25x
+	select MIGHT_HAVE_PCI
 
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
diff --git a/arch/arm/mach-versatile/Kconfig 
b/arch/arm/mach-versatile/Kconfig
index c781f30..3f7b5e9 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -4,6 +4,7 @@ menu "Versatile platform type"
 config ARCH_VERSATILE_PB
 	bool "Support Versatile/PB platform"
 	select CPU_ARM926T
+	select MIGHT_HAVE_PCI
 	default y
 	help
 	  Include support for the ARM(R) Versatile/PB platform.


IF OK I send is a a patch on the list	

Ulli
