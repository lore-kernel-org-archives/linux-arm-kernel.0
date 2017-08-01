From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 09:59:11 +0200
Subject: [PATCH] pinctrl: nomadik: abx500: constify gpio_chip structure
In-Reply-To: <20170711212929.GA1037@embeddedgus>
References: <20170711212929.GA1037@embeddedgus>
Message-ID: <CACRpkdZmUMRWZLak+3u3uGNyPDBmxqe6GH-aV2V1medoKmebBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 11:29 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:

> This structure is only used to copy into another structure, so declare
> it as const.
>
> This issue was detected using Coccinelle and the following semantic patch:
>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct gpio_chip i at p = { ... };
>
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e = i at p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct gpio_chip e;
> @@
> e at i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct gpio_chip i = { ... };
>
> In the following log you can see a significant difference in the code size
> and data segment, hence in the dec segment. This log is the output
> of the size command, before and after the code change:
>
> before:
>    text    data     bss     dec     hex filename
>   17545    5376       0   22921    5989 drivers/pinctrl/nomadik/pinctrl-abx500.o
>
> after:
>             bss     dec     hex filename
>   17273    5320       0   22593    5841 drivers/pinctrl/nomadik/pinctrl-abx500.o
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
