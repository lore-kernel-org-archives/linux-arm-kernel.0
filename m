From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 28 Dec 2012 13:06:55 -0800
Subject: [PATCH Resend] ARM: pxa27x: fix ac97 controller warm reset code
Message-ID: <1356728815-14410-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some code that implements a work-around to a hardware bug in
the ac97 controller on the pxa27x.  A bug in the controller's warm reset
functionality requires that the mfp used by the controller as the AC97_RESET_n
line be temporarily reconfigured as a generic output gpio (AF0) and manually
held high for the duration of the warm reset cycle.  This is what was done in
the original code, but it was broken long ago by commit
fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6 
([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
which changed the mfp to a GPIO input instead of a high output.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/pxa27x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 8047ee0..76221e4 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -47,9 +47,9 @@ void pxa27x_clear_otgph(void)
 EXPORT_SYMBOL(pxa27x_clear_otgph);

 static unsigned long ac97_reset_config[] = {
-	GPIO113_GPIO,
+	MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH),
 	GPIO113_AC97_nRESET,
-	GPIO95_GPIO,
+	MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH),
 	GPIO95_AC97_nRESET,
 };

--
1.7.8.6
