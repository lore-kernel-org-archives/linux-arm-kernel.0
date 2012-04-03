From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Apr 2012 23:24:35 +0200
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <201204031347.35256.arnd@arndb.de>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de>
Message-ID: <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 3:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The initialization order dependencies can now be handled using
> the deferred probe mechanism, by returning -EPROBE_DEFER from
> the probe() function of any driver that is loaded before its
> pins are available.

So how do I as a driver writer do that?

Example: drivers/tty/serial/sirfsoc_uart.c:

#include <linux/pinctrl/consumer.h>

probe() {
       if (sirfport->hw_flow_ctrl) {
                sirfport->p = pinctrl_get_select_default(&pdev->dev);
                ret = IS_ERR(sirfport->p);
                if (ret)
                        goto pin_err;
        }

pin_err:
    (...)
   return ret;

So basically the pinctrl subsystem needs to return -EPROBE_DEFER
to the driver in this case, so it can escalate that further.

Shall we go in and patch not just pinctrl but also regulator,
clk etc to return this if the subsystem is not yet up and no maps
and drivers at all have been yet been registered?

Yours,
Linus Walleij
