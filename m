From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Mar 2016 10:28:08 +0200
Subject: [PATCH 3/4] drivers/bus: make simple-pm-bus.c explicitly
 non-modular
In-Reply-To: <1459113058-14340-4-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
 <1459113058-14340-4-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CAMuHMdVjbQZWFqk23=GX1NF-aTKz9SU+c2DUs-BV-zcTqhoqwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sun, Mar 27, 2016 at 11:10 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The Kconfig currently controlling compilation of this code is:
>
> config SIMPLE_PM_BUS
>         bool "Simple Power-Managed Bus Driver"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.

Be prepared for the fallout. There are test farms running bind/unbind cycles
on random drivers.

> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

NAK.

IIRC, I did test unbind.

The real and productive fix is to change "bool" to "tristate" in Kconfig.

All of these "make ... explicitly non-modular" may have to be reverted again
when our kernels become too big to boot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
