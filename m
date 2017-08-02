From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 10:24:03 +0200
Subject: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
In-Reply-To: <20170708003330.GA15374@embeddedgus>
References: <20170708003330.GA15374@embeddedgus>
Message-ID: <CACRpkda3N-taTuBXJu626r8UCU34vOkvXFqQXvGnwkha_ywTbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 8, 2017 at 2:33 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:

> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure. This field is declared const, so watchdog_ops
> structures that have this property can be declared as const also.
>
> This issue was detected using Coccinelle and the following semantic patch:
>
> @r
> disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i at p = { ... };
>
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i at p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e at i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i = { ... };
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
