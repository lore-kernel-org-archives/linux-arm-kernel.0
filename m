From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 14:56:44 +0200
Subject: [PATCH] watchdog: constify watchdog_ops and watchdog_info
 structures
In-Reply-To: <1501795291-21372-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1501795291-21372-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZ1WwqakQs1b4fjH_6T6jaox61RdabRSAWNC5_9o2osKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 11:21 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> These watchdog_ops and watchdog_info structures are only stored
> in the ops and info fields of a watchdog_device structure,
> respectively, which are const.  Thus make the watchdog_ops and
> watchdog_info structures const as well.
>
> Done with the help of Coccinelle.  The rules for the watchdog_ops case are
> as follows:
>
> // <smpl>
> @r disable optional_qualifier@
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
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
