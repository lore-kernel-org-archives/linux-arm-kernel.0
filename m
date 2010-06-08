From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 08 Jun 2010 16:23:41 -0700
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <alpine.LFD.2.00.1006081213190.30664@xanadu.home>
References: <4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080839240.30664@xanadu.home>
	<20100608125053.GD25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080857390.30664@xanadu.home>
	<20100608131319.GF25370@n2100.arm.linux.org.uk>
	<AANLkTinWCRIKyMUseSpkRfEC0Cba4JRGBiUwb_jD_MkZ@mail.gmail.com>
	<alpine.LFD.2.00.1006081213190.30664@xanadu.home>
Message-ID: <1276039421.14529.29.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-08 at 12:55 -0400, Nicolas Pitre wrote:

> Hence with the above you immediately get a sense of what this particular 
> hardware target needs in a fairly human readable form without having to 
> dig and guess through all the Kconfig options.  And having that 
> information next to the very Kconfig entry concerned is also much easier 
> to maintain rather than having that located in a separate file.


I think this is what Linus wants .. I tested this to make a OK msm
config for trout, and it does that although I didn't boot test it. I
couldn't get the select statement to select inside a choice menu, so I
had to convert to a regular menu.

You use it like this,

KBUILD_KCONFIG=arch/arm/Kconfig.trout make ARCH=arm allnoconfig

For me, I don't like this method.

Daniel

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..ce18fb0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -206,9 +206,7 @@ config MMU
 # The "ARM system type" choice list is ordered alphabetically by option
 # text.  Please add new entries in the option alphabetic order.
 #
-choice
-	prompt "ARM system type"
-	default ARCH_VERSATILE
+menu "ARM system type"
 
 config ARCH_AAEC2000
 	bool "Agilent AAEC-2000 based"
@@ -794,7 +792,7 @@ config PLAT_SPEAR
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
-endchoice
+endmenu
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
diff --git a/arch/arm/configs/Kconfig.trout b/arch/arm/configs/Kconfig.trout
new file mode 100644
index 0000000..cf81793
--- /dev/null
+++ b/arch/arm/configs/Kconfig.trout
@@ -0,0 +1,12 @@
+
+config TROUT_BASE_CONFIG
+	bool
+	default y
+	select ARCH_MSM
+	select ARCH_MSM7X00A 
+	select MACH_TROUT
+	select MSM_DEBUG_UART3
+	select MMC
+	select MMC_MSM7X00A
+
+source "arch/arm/Kconfig"
