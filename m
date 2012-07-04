From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 00:52:06 +0200
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <CAJOA=zOaXf6QzF9yhcoTTaPYr-9=L2h5r5AvmMxoSbroJJrOFg@mail.gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
 <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
 <CACRpkdZGjMa8dBdc_wrTxHUxHUTwzQM9W55XyU+6VEBnXb8z5g@mail.gmail.com>
 <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
 <CAJOA=zOaXf6QzF9yhcoTTaPYr-9=L2h5r5AvmMxoSbroJJrOFg@mail.gmail.com>
Message-ID: <CACRpkdZYZJL6MmQ0tZD=ZWbAX7yUDoH6Xw6CfBLYkVtF2j2gGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 11:15 PM, Turquette, Mike <mturquette@ti.com> wrote:

> Thanks for the re-ping.  I've dropped the old ones and taken in these patches.

Thanks!

> I made one trivial change which is to drop "depends on COMMON_CLK"
> from both of the entries in drivers/clk/versatile/Kconfig.  COMMON_CLK
> is implied since we source your Kconfig from within a menu item that
> depends on COMMON_CLK.
>
> Let me know if that is alright with you.

OK!

> One last (maybe stupid) question.  I don't see that ARCH_VERSATILE
> actually uses COMMON_CLK, but uses a legacy platform-specific clk
> framework.  Is that intended?

Versatile is two things (just to add to the confusion):

1) A machine named arch/arm/mach-versatile
2) A platform named arch/arm/plat-versatile encompassing
  the mach-integrator, mach-versatile, mach-realview and mach-vexpress

This new folder is for the latter, but the only *machine* using it in the
versatile family is the Integrator.

So far. I will likely convert mach-realview next, since I can test it.

I don't have the mach-versatile machine sadly. I think only
Catalin and Russell really runs it, except for the QEMU users
which are plentiful.

> I have a second question on this series.  The menu option for
> CLK_VERSATILE is exposed for everybody with these series.  Is that
> necessary?  I'd prefer that folks 'select' it from platform Kconfig
> instead of having it globally exposed.

That's OK, does something like the below make it? This shoves
them (well currently only one...) under a submenu that is
only be visible to folks like me. Tested on Integrator (visible)
and SPEAr (invisible). You'll have to hand-edit it for dropping
the deps on COMMON_CLK though...


>From adb168705793bbe3c2522eff068780bb0d9c833e Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Jul 2012 00:44:44 +0200
Subject: [PATCH] clk: hide Versatile clocks from the populace

This folds in and hides the Versatile Kconfig submenu unless
CONFIG_CLK_VERSATILE was explicitly selected by the platform(s)
in the current kernel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/versatile/Kconfig |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 169b1bc..8796005 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,8 +1,16 @@
 config CLK_VERSATILE
-	bool "Clocks for the ARM Versatile family"
+	bool
 	depends on COMMON_CLK

+if CLK_VERSATILE
+
+menu  "Clocks for the ARM Versatile family"
+
 config CLK_ICST
 	bool "ICST307 VCO clock driver"
 	depends on COMMON_CLK
 	depends on ICST
+
+endmenu
+
+endif
-- 
1.7.10.4


Yours,
Linus Walleij
