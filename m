From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:32:29 +0000
Subject: [PATCH 04/17] ARM: sa11x0: assabet: ensure that GPIO27 is driven
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOs1-0001Bl-8B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO27 is just connected to a CPLD input without any pull-ups or pull-
downs.  If GPIO27 is left as an input, it will float around mid-supply,
which for CMOS inputs is the worst place for a pin to be.  Ensure that
this pin is driven.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 6356896..e3805d4 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -215,6 +215,14 @@ static void __init assabet_init(void)
 	GPDR |= GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
 
 	/*
+	 * Also set GPIO27 as an output; this is used to clock UART3
+	 * via the FPGA and as otherwise has no pullups or pulldowns,
+	 * so stop it floating.
+	 */
+	GPCR = GPIO_GPIO27;
+	GPDR |= GPIO_GPIO27;
+
+	/*
 	 * Set up registers for sleep mode.
 	 */
 	PWER = PWER_GPIO0;
-- 
1.7.4.4
