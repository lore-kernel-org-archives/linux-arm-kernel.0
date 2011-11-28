From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 14:17:14 +0100
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C05EC95D66A@SC-VEXCH1.marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdYPd7a29Sj-F-Aj8vqa3v7unCKNtPH5EPWwapbYgKFLRw@mail.gmail.com>
 <25B60CDC2F704E4E9D88FFD52780CB4C05EC95D66A@SC-VEXCH1.marvell.com>
Message-ID: <CACRpkdawJNP4h3gvZ4FfHYkYwzoKdcPRpQt94dieuU3gdZNESQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 10:50 AM, Haojian Zhuang <hzhuang1@marvell.com> wrote:

> The only block issue at here is that cpu_is_pxa3xx() is defined in arch-pxa and cpu_is_pxa910()
> is defined in arch-mmp. If I only enable arch-pxa, I would meet build error for undefined
> cpu_is_pxa910().

Please #ifdef and cpu_is_* in arch/arm/mach-* then pass a flag or enumerator
with the platform data to the driver. This way the platform data uniformly
tells the driver what machine/cpu it is, and the driver need not hold any
knowledge of the system or use machine-specific functions.

I don't understand where your cpu_is* functions come from anyway,
which of these includes:

+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>

Actually provides it?

Please include that file explicitly and I'll tell you to
not include it :-D

Since this driver will be used by multiple platforms, why not
create
include/linux/pinctrl/pxa3xx.h and define your platform data
struct there like:

#include <linux/pinctrl/machine.h>

/* Unless an enumerator or defines like this exist already */
enum pxa_cpu_type {
   PXA_FOO,
   PXA_BAR,
   PXA_FNORD,
};

struct pxa3xx_pinmux_plat {
    enum pxa_cpu_type cputype;
    ...other interesting stuff ...
};

Fill it in in your machine and pick it up in your
driver.

Yours,
Linus Walleij
