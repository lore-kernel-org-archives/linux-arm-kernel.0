From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 7 Sep 2015 11:34:36 -0400 (EDT)
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <1713935.2YV1sNJUyb@wuerfel>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
 <1713935.2YV1sNJUyb@wuerfel>
Message-ID: <alpine.LFD.2.20.1509071128151.22877@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Sep 2015, Arnd Bergmann wrote:

> Given how much more common 1GB hardware configurations are compared to 768MB
> configuration, we could however think about adding a VMSPLIT_3G_OPT option
> that x86 has (also VMSPLIT_2_75G on ARCH_TILE), to allow using the entire
> 1GB of lowmem without going all the way to VMSPLIT_2G. That option would
> also let us use the entire 768MB on the machines that 	Yongtaek Lee is
> interested in.

That's easy enough:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0d1b717e1e..a63970f211 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1470,6 +1470,8 @@ choice
 
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
+	config VMSPLIT_3G_OPT
+		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
 	config VMSPLIT_1G
@@ -1481,6 +1483,7 @@ config PAGE_OFFSET
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
 	default 0x80000000 if VMSPLIT_2G
+	default 0xAF000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
 
 config NR_CPUS


That shifts the risk to user space though.  But if there is a regression 
there, it will manifest itself on all systems and not only with some 
particular hardware.


Nicolas
