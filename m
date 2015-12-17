From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 17:55:42 +0100
Subject: [PATCH 0/4] ARM Versatile multi-platform support
In-Reply-To: <CAL_JsqLpD8jRZF=mh0rs8Heb3XZftUmbjr7xparFzWYnqC25iQ@mail.gmail.com>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
 <3265937.pryQQXUTv3@wuerfel>
 <CAL_JsqLpD8jRZF=mh0rs8Heb3XZftUmbjr7xparFzWYnqC25iQ@mail.gmail.com>
Message-ID: <6928127.mYXKeRL6vI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 08:53:09 Rob Herring wrote:
> On Tue, Dec 15, 2015 at 4:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 08 December 2015 14:44:14 Rob Herring wrote:
> >> Arnd lit a fire under me to dust this off and get it merged. So here it
> >> is. The main change from prior version is I merged all the code to a
> >> single file. It's a bigger patch than I'd like, but I don't think trying
> >> to do it in multiple steps is worth it.
> >>
> >> This is dependent on some solution for the default platform choice on
> >> !MMU builds (allnoconfig) as it can't be Versatile after this series.
> >> Arnd has some ideas on how to address that.
> >>
> >> This is tested under QEMU. Linus previously tested this on actual h/w
> >> and had a problem with the display identification which needs
> >> investigation or agreement to worry about it if and when someone
> >> actually cares.
> >
> >
> > Merged into next/multiplatform, thanks a lot!
> 
> Are you going to apply something for the default platform? This is
> breaking allnoconfig without it.

Thanks for the reminder, I have committed this patch on top now,

>From 70722803de91a7670979dcb5748631b4e3c1b219 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Dec 2015 17:45:47 +0100
Subject: [PATCH] ARM: make default platform work for NOMMU

Moving ARCH_VERSATILE into ARCH_MULTIPLATFORM means that it no longer
works as the default target for MMU-less kernels. While we might
want to get that working again in the future, it's also a rather
bad default, and it makes sense to make ARM_SINGLE_V7M the default
because that is what realistically all NOMMU users on ARM are using,
and it actually is what gets selected by default in the absence of
versatile in the choice statement.

Related to this, 'allnoconfig' kernels fail to link with the new
default, as they do not include a machine record:

arm-linux-gnueabi-ld: no machine record defined

For ARCH_MULTIPLATFORM kernels, we avoid this error by using a
default machine descriptor that works for all trivial platforms,
like ARCH_VIRT. The same reasoning applies for ARM_SINGLE_V7M,
as that can also boot with empty machine descriptors both on
qemu and on real hardware, as long as all the drivers are present.

We could also follow up with a patch to remove the existing
machine descriptors for the ARMv7M platforms, the only callback
pointer the four platforms contain today is the armv7m_restart
handler and we can simply make that the default for v7M with an
add-on patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72c1df0..a0fda44 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -313,7 +313,7 @@ config MMU
 #
 choice
 	prompt "ARM system type"
-	default ARCH_VERSATILE if !MMU
+	default ARM_SINGLE_ARMV7M if !MMU
 	default ARCH_MULTIPLATFORM if MMU
 
 config ARCH_MULTIPLATFORM
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 65addcb..2e26016 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -211,7 +211,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
+#if defined(CONFIG_ARCH_MULTIPLATFORM) || defined(CONFIG_ARM_SINGLE_ARMV7M)
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
 	MACHINE_END
 

> It looks like versatile_defconfig is also broken, but perhaps due to
> debug_ll changes?

Yes, a glitch in my test infrastructure caused me not to notice this earlier.
I've added a fix for that as well, see my reply to Russell "Re: [PATCH 00/10]
ARM: debug-ll fixes".

	Arnd
