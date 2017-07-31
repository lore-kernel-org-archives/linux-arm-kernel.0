From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 31 Jul 2017 07:55:16 +0200
Subject: [PATCH 12/12] mmc: bcm2835: constify mmc_host_ops structures
In-Reply-To: <1501307981-29745-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
 <1501307981-29745-13-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <0beb2ef0-0a2d-5289-2956-af106d092cf6@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.07.2017 um 07:59 schrieb Julia Lawall:
> The mmc_host_ops structure is only stored in the ops field of an
> mmc_host structure, which is declared as const.  Thus the mmc_host_ops
> structure itself can be const.
>
> Done with the help of Coccinelle.
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct mmc_host_ops i at p = { ... };
>
> @ok1@
> struct mmc_host *mmc;
> identifier r.i;
> position p;
> @@
> mmc->ops = &i at p
>
> @bad@
> position p != {r.p,ok1.p};
> identifier r.i;
> struct mmc_host_ops e;
> @@
> e at i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct mmc_host_ops i = { ... };
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
