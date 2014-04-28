From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:07:02 -0700
Subject: [PATCH 1/5] wdt: sunxi: Move restart code to the watchdog driver
In-Reply-To: <535BD13B.103@roeck-us.net>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-2-git-send-email-maxime.ripard@free-electrons.com>
 <535BD13B.103@roeck-us.net>
Message-ID: <20140428230702.GN3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 26, 2014 at 08:31:07AM -0700, Guenter Roeck wrote:
> On 04/23/2014 08:04 AM, Maxime Ripard wrote:
> >Most of the watchdog code is duplicated between the machine restart code and
> >the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> >remove it from the machine code eventually.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  drivers/watchdog/sunxi_wdt.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> >diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> >index cd00a7836cdc..0644c45d2b60 100644
> >--- a/drivers/watchdog/sunxi_wdt.c
> >+++ b/drivers/watchdog/sunxi_wdt.c
> >@@ -14,6 +14,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> >+#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >@@ -22,9 +23,12 @@
> >  #include <linux/moduleparam.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >+#include <linux/reboot.h>
> >  #include <linux/types.h>
> >  #include <linux/watchdog.h>
> >
> >+#include <asm/system_misc.h>
> >+
> >  #define WDT_MAX_TIMEOUT         16
> >  #define WDT_MIN_TIMEOUT         1
> >  #define WDT_MODE_TIMEOUT(n)     ((n) << 3)
> >@@ -70,6 +74,30 @@ static const int wdt_timeout_map[] = {
> >  	[16] = 0b1011, /* 16s */
> >  };
> >
> >+static struct sunxi_wdt_dev *sunxi_restart_ctx;
> >+
> >+static void sun4i_wdt_restart(enum reboot_mode mode, const char *cmd)
> >+{
> >+	if (!sunxi_restart_ctx)
> >+		return;
> >+
> The only condition where this can happen if is there is a race between the calling
> code and the remove function below. If that race really exists, it could as well
> happen after this check, so the check does not really provide any value and can
> be removed.
> 
> Note that I find the variable name a bit misleading. It isn't a context,
> it is the poitner to sunxi_wdt_dev. What is really needed is wdt_base,
> not this pointer. Would it make more sense to provide that pointer
> directly instead, like you did in the code for the A31 ?

Hmm, right, I'll change this.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/7dc72fb8/attachment.sig>
