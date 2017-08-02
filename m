From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 10:25:50 +0200
Subject: [PATCH] pinctrl: bcm2835: constify gpio_chip structure
In-Reply-To: <20170711180339.GA17806@embeddedgus>
References: <20170711180339.GA17806@embeddedgus>
Message-ID: <CACRpkdZCJzqKnHDFy4ga6n-NMMs21m80_i1=O_2VPua4yx3rfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 8:03 PM, Gustavo A. R. Silva
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
>   18958    9000     128   28086    6db6 drivers/pinctrl/bcm/pinctrl-bcm2835.o
>
> after:
>    text    data     bss     dec     hex filename
>   18764    8912     128   27804    6c9c drivers/pinctrl/bcm/pinctrl-bcm2835.o
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch applied with Eric's ACK.

Yours,
Linus Walleij
