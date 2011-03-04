From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2011 23:28:16 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110304081916.GB29521@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303121153.GJ29521@pengutronix.de>
	<20110303162513.GS22310@pengutronix.de>
	<20110303180026.GC18351@pengutronix.de>
	<20110303201009.GT22310@pengutronix.de>
	<20110304081916.GB29521@pengutronix.de>
Message-ID: <20110304222816.GZ22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added linux-kbuild to Cc:]

Hello,

yet another reply to your mail, the last one for today, I promise.

> +config ARCH_IMX_MULTI_OMX27
> +	select ARCH_ALLOW_IMX27
> +	bool "i.MX27 support"
s/OMX/IMX/

Other than that is works.  One ugly thing about that patch is that when
starting with

 ?       *** enable ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR to get *** ?
 ?       *** support for multiple i.MX Families ***                  ?
 ?       Select i.MX CPU (i.MX27 support)  --->                      ?
 ?     *** MX27 platforms: ***                                       ?
 ? [*] MX27ADS platform                                              ?
 ? [*] Phytec phyCORE-i.MX27 CPU module (pcm038)                     ?

and then enabling ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR this yields

 ? [ ]   i.MX1 support (NEW)                                         ?
 ? [ ]   i.MX21 support (NEW)                                        ?
 ? [ ]   i.MX25 support (NEW)                                        ?
 ? [ ]   i.MX27 support (NEW)                                        ?
 ? [ ]   i.MX31 and i.MX35 support (NEW)                             ?

.

At least the machines enabled before are reselected when enabling "i.MX27
support". Still it would be nice if "i.MX27 support" would be
autoselected in this case. Any ideas?
[For those that didn't see Sascha's patch, the construct in
arch/arm/mach-imx/Kconfig is:

	config ARCH_ALLOW_IMX1
		bool

	config ARCH_ALLOW_IMX21
		bool
	...

	if ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR
	config ARCH_IMX_MULTI_IMX1
		select ARCH_ALLOW_IMX1
		bool "i.MX1 support"

	config ARCH_IMX_MULTI_IMX21
		select ARCH_ALLOW_IMX21
		bool "i.MX21 support"
	...
	endif

	if !(ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR)
	choice
		prompt "Select i.MX CPU"
	config ARCH_IMX_ONLY_IMX1
		select ARCH_ALLOW_IMX1
		bool "i.MX1 support"

	config ARCH_IMX_ONLY_IMX21
		select ARCH_ALLOW_IMX21
		bool "i.MX21 support"
	...
	endchoice
	endif
]

I merged Sascha's patch into my "move mach-mx3/* to mach-imx" series;
the tree is provided at

	git://git.pengutronix.de/git/ukl/linux-2.6.git multi-soc-kernel

. As this tree doesn't contain ARM_PATCH_PHYS_VIRT yet, I tested the UI
with the patch below.

Best regards
Uwe

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index cfc398a..f5e0638 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -106,6 +106,9 @@ config ARCH_ALLOW_IMX31
 config ARCH_ALLOW_IMX35
 	bool
 
+config ARM_PATCH_PHYS_VIRT
+	bool "testme"
+
 if ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR
 config ARCH_IMX_MULTI_IMX1
 	select ARCH_ALLOW_IMX1

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
