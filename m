From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Nov 2015 16:45:58 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
Message-ID: <HK2PR06MB056196B2E169A504A16ED9738A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The old method with conditional placement in the linker script is
> broken beyond repair.  There is simply way too much stuff these days
> to do this sanely.  I think the only way to fix it properly is to
> have a separate linker script for XIP usage with proper (and obvious)
> section placement.



Step 1: Change the Makefiles to select an alternative linker script.

What do you think about doing the following?


diff --git a/Makefile b/Makefile
index fd46821..956ad21 100644
--- a/Makefile
+++ b/Makefile
@@ -898,7 +898,11 @@ libs-y		:= $(libs-y1) $(libs-y2)
 # Externally visible symbols (used by link-vmlinux.sh)
 export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
 export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+ifdef CONFIG_XIP_KERNEL
+export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux-xip.lds
+else
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
+endif
 export LDFLAGS_vmlinux
 # used by scripts/pacmage/Makefile
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools virt)
 
 

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59b..d97fc2e 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -3,6 +3,7 @@
 #
 
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
+CPPFLAGS_vmlinux-xip.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 ifdef CONFIG_FUNCTION_TRACER
@@ -92,4 +93,8 @@ obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+ifdef CONFIG_XIP_KERNEL
+extra-y := $(head-y) vmlinux-xip.lds
+else
 extra-y := $(head-y) vmlinux.lds
+endif






Chris
