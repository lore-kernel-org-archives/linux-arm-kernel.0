From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:32:08 +0000
Subject: [PATCH 03/17] ARM: sa11x0: assabet: avoid glitching GPIOs when
 setting outputs
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOrg-0001Bh-Hi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid glitching the GPIO signals during initialization, which can
have undesirable effects.  Ensure that the desired pin state is set
before we change the GPIO pin direction to be an output.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 3a3282e..6356896 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -202,8 +202,8 @@ static void __init assabet_init(void)
 	/*
 	 * Ensure that the power supply is in "high power" mode.
 	 */
-	GPDR |= GPIO_GPIO16;
 	GPSR = GPIO_GPIO16;
+	GPDR |= GPIO_GPIO16;
 
 	/*
 	 * Ensure that these pins are set as outputs and are driving
@@ -211,8 +211,8 @@ static void __init assabet_init(void)
 	 * the WS latch in the CPLD, and we don't float causing
 	 * excessive power drain.  --rmk
 	 */
-	GPDR |= GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
 	GPCR = GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
+	GPDR |= GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
 
 	/*
 	 * Set up registers for sleep mode.
-- 
1.7.4.4
