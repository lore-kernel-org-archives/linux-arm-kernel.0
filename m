From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 15:21:10 +0200
Subject: [PATCH] pinctrl: st: constify gpio_chip structure
In-Reply-To: <20170711181519.GA20001@embeddedgus>
References: <20170711181519.GA20001@embeddedgus>
Message-ID: <CACRpkdaxG4-3cu5JxO0tmeibTvvCDqj07zQpNOwzKvn91oWyuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 8:15 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:

> This structure is only used to copy into other structure, so declare
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
>   21671    3632     128   25431    6357 drivers/pinctrl/pinctrl-st.o
>
> after:
>    text    data     bss     dec     hex filename
>   21366    3576     128   25070    61ee drivers/pinctrl/pinctrl-st.o
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch applied with Patrice's ACK.

Yours,
Linus Walleij
