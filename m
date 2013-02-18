From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Feb 2013 09:56:52 +0800
Subject: [PATCH v2 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
In-Reply-To: <1360776872-18584-4-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130218015650.GG6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:27PM +0100, Philipp Zabel wrote:
> The SRC has auto-deasserting reset bits that control reset lines to
> the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
> controller that can be controlled by those devices using the
> reset controller API.

We now architecturally depend on RESET_CONTROLLER, so need to have
Kconfig to reflect that.  Not sure if it's the best solution, the
following is what I have.

drivers/reset/Kconfig:

config ARCH_HAS_RESET_CONTROLLER
	bool

menuconfig RESET_CONTROLLER
	bool "Reset Controller Support"
	default y if ARCH_HAS_RESET_CONTROLLER

arch/arm/mach-imx/Kconfig:

 config ARCH_MXC
        bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+       select ARCH_HAS_RESET_CONTROLLER
        select ARCH_REQUIRE_GPIOLIB
        select ARM_PATCH_PHYS_VIRT
        select AUTO_ZRELADDR if !ZBOOT_ROM

Shawn
