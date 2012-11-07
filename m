From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed,  7 Nov 2012 23:00:57 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Statically define parent clock of the
 "camera" clock
In-Reply-To: <1352325657-28885-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1352325657-28885-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1352325657-28885-2-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "camera" clock defined in arch/arm/mach-s3c64xx/clock.c has null
clock source mux control register as it can have only one parent
clock. In such cases there is a need to configure the parent clock
statically, otherwise s3c_set_clksrc() bails out with an error message
"no parent clock specified" leaving the parent clock not configured.
Define statically the parent clock so it is possible to get or set rate
of the "camera" clock.

Reported-by: In-Bae Jeong <kukyakya@gmail.com>
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 28041e8..85b9cf1 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -744,6 +744,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "camera",
 			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 			.enable		= s3c64xx_sclk_ctrl,
+			.parent		= &clk_h2,
 		},
 		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
 		.reg_src	= { .reg = NULL, .shift = 0, .size = 0  },
-- 
1.7.4.1
