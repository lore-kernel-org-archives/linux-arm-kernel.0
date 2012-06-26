From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 26 Jun 2012 12:51:25 +0530
Subject: Panda ES board hang when using GPIO as interrupt
In-Reply-To: <4FE8CF77.5080400@broadcom.com>
References: <4FE8CF77.5080400@broadcom.com>
Message-ID: <CAC83ZvL2ozQD1DYmtKeFa1PB1pZ1JmBUKFWmDWnbJOCDL3sKNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 2:22 AM, Franky Lin <frankyl@broadcom.com> wrote:
> Hi Kevin, Tarun,
>
> We are using the expansion connector A on Panda board to mount a SDIO WiFi
> dongle on MMC2 with a level triggered interrupt signal connected to GPIO
> 138. It's been working fine until 3.5 rc1. The board hang randomly within 5
> mins during a network traffic test. After bisecting we found the culprit is
> "[PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()" [1].
>
> I noticed Kevin raised some similar cases on other platforms and also
> provided two patches in the patch mail thread. But unfortunately those two
> patches doesn't help in our case. I tested the driver with 3.5-rc3 mainline
> kernel and the issue is still there. I can only "fix" the hang by either
> reverting the commit or disabling CONFIG_PM_RUNTIME. Also, the hang only
> happens on Panda ES board. Old Panda with 4430 works good.
>
> Any thoughts and suggestions?
I just had a quick look at the code. Can you please check if the
attached patch solves
the issue? I just boot tested on Panda and Blaze.
--
Tarun

>From 0e1b322451b7a49487d2d17a147db1aa1d1119fa Mon Sep 17 00:00:00 2001
From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Tue, 26 Jun 2012 12:13:47 +0530
Subject: [PATCH] gpio/omap: enabled_non_wakeup_gpios check skips
bank->saved_datain

Commit b3c64bc30af67ed328a8d919e41160942b870451
(gpio/omap: (re)fix wakeups on level-triggered GPIOs)
still skips update of bank->saved_datain in *_runtime_suspend()
which must be done irrespective of edge/level trigger types.
Therefore, move the enbaled_non_wakeup_gpios check after the
bank->saved_datain is updated.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..94ecdcf 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1177,9 +1177,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
                __raw_writel(wake_hi | bank->context.risingdetect,
                             bank->base + bank->regs->risingdetect);

-       if (!bank->enabled_non_wakeup_gpios)
-               goto update_gpio_context_count;
-
        if (bank->power_mode != OFF_MODE) {
                bank->power_mode = 0;
                goto update_gpio_context_count;
@@ -1191,6 +1188,10 @@ static int omap_gpio_runtime_suspend(struct device *dev)
         */
        bank->saved_datain = __raw_readl(bank->base +
                                                bank->regs->datain);
+
+       if (!bank->enabled_non_wakeup_gpios)
+               goto update_gpio_context_count;
+
        l1 = bank->context.fallingdetect;
        l2 = bank->context.risingdetect;

-- 
1.7.0.4



>
> Thanks,
> Franky
>
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/75708/
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpio-omap-enabled_non_wakeup_gpios-check-skips-bank-.patch
Type: text/x-patch
Size: 1556 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/eb8a718c/attachment.bin>
