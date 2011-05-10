From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 May 2011 23:25:44 +0200
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <20110502225708.GD28001@n2100.arm.linux.org.uk>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110502225708.GD28001@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikSwkYEvbQ8XVrB3LUetVqBBUjT2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally I'm back at the pinmux patch set trying to answer all questions
accumulated:

2011/5/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> While I like the idea of consolidating the pinmuxing stuff, I'm not sure
> about having a struct pin_mux pointer in each bus types device structure.
> It'd mean this would have to be added to platform devices as well...

Yeah I'm not sure about the patch to the AMBA/PrimeCell bus really,
an alternative is for all drivers to request their mux individually. But in
the AMBA bus we already request the silicon block clock and the
silicon power switch so it seemed natural to also request a mux setting,
if there is one.

> Then there's SA1100 (and PXA?) to consider with its IrDA setup, where its
> necessary to switch the pin muxing during driver operation, when switching
> between SIR and FIR modes (SIR uses the UART, FIR uses a separate hardware
> block.)
>
> So any per-device pinmuxing subsystem also needs a way that a driver can
> change the pinmuxing of its associated pins on the fly too.

It can, basically:

struct pinmux *pmx;

pmx = pinmux_get(dev, "irda-uart");
pinmux_enable(pmx);
(... SIR UART operations ...)
pinmux_disable(pmx);
pinmux_put(pmx);
(... stuff to init FIR silicon ...)
pmx = pinmux_get(dev, "irda-fir");
pinmux_enable(pmx);
(... etc ...)

Just like you would take an alternative clock or regulator in case using i would
exclude the use of another clock/regulator.

Thanks,
Linus Walleij
