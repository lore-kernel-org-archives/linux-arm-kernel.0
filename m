From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 22:24:16 +0200
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <1341565763-10074-1-git-send-email-b29396@freescale.com>
References: <1341565763-10074-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbKOQt=gqydQNRfCOU-TaschHtFq0e_86xgvtHYMnwpKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 11:09 AM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The General Purpose Registers (GPR) is used to select operating modes for
> general features in the SoC, usually not related to the IOMUX itself,
> but it does belong to IOMUX controller.
> We simply provide an convient API for driver to call to set the general purpose
> register bits if needed.
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

I have an overall objection to this:

I have no idea at all about what's going on, and why this belongs in the pin
control subsystem. On the contrary, from the commit description it seems to
*not* belong in this subsystem at all.

So: exactly what does this register do, and which are the consumers?

Notice: nothing at all stops you from mapping the same address range or
just this register in some other driver. So the same address range being
used is not a reason to have this in this driver, it could very well be
handled by drivers/misc/imx-syscon.c or maybe my postulated
(but non-existent) drivers/syscon/*.

The reason I react against it is that some GPIO drivers already have
custom API:s doing pinctrl stuff, and shunning this kind of stuff into
the pinctrl subsystem might hide it from the real subsystem where it
actually belongs and hinder development of the proper subsystems.

Yours,
Linus Walleij
