From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 26 Sep 2014 08:55:44 +0200
Subject: [PATCH resend 2/2] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <5424DDD5.1020706@linaro.org>
References: <1409030722-30709-1-git-send-email-zhangfei.gao@linaro.org>
 <1409030722-30709-3-git-send-email-zhangfei.gao@linaro.org>
 <20140919171829.GB2874@katana> <5424DDD5.1020706@linaro.org>
Message-ID: <20140926065544.GA1284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>+#include <linux/clk.h>
> >>+#include <linux/delay.h>
> >>+#include <linux/i2c.h>
> >>+#include <linux/io.h>
> >>+#include <linux/interrupt.h>
> >>+#include <linux/module.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/pm_runtime.h>
> >
> >I think there should be at least of.h, too.
> The of.h is already in i2c.h
> include/linux/i2c.h:33:#include <linux/of.h>

Please add it nonetheless, because you use e.g. of_property_read_u32()
directly. That makes you independet of changes to i2c.h.

> >>+	rate = i2c->s_clock;
> >>+	sysclock = clk_get_rate(i2c->clk);
> >>+	sclh = (sysclock / (rate * 2)) / 2 - 1;
> >>+	writel_relaxed(sclh, i2c->regs + HIX5I2C_SCL_H);
> >>+	scll = (sysclock / (rate * 2)) / 2 - 1;
> >
> >scll and sclh use the same formula? Have you measured the setup
> >frequency with a scope?
> Yes, it is confusing, will use the same vector scl instead.
> The value is same means sclk high voltage and low voltage keep same time.

OK.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/dc5d7872/attachment.sig>
