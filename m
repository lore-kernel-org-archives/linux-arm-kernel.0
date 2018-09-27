From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 27 Sep 2018 15:40:02 -0500
Subject: [PATCH v2 07/22] soc/fsl/bman_portals: defer probe after bman's
 probe
In-Reply-To: <20180926132247.10971-8-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
 <20180926132247.10971-8-laurentiu.tudor@nxp.com>
Message-ID: <CADRPPNQyp=zC7Bo441gRQL61GMNdL-EMo4BA_NYV+CErOaM6tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> A crash in bman portal probing could not be triggered (as is the case
> with qman portals) but it does make calls [1] into the bman driver so
> lets make sure the bman portal probing happens after bman's.
>
> [1]  bman_p_irqsource_add() (in bman) called by:
>        init_pcfg() called by:
>          bman_portal_probe()
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

As this is part of a bug fix for v4.19, applied on soc/fsl for fix.

> ---
>  drivers/soc/fsl/qbman/bman_portal.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index 2f71f7df3465..f9edd28894fd 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -91,7 +91,15 @@ static int bman_portal_probe(struct platform_device *pdev)
>         struct device_node *node = dev->of_node;
>         struct bm_portal_config *pcfg;
>         struct resource *addr_phys[2];
> -       int irq, cpu;
> +       int irq, cpu, err;
> +
> +       err = bman_is_probed();
> +       if (!err)
> +               return -EPROBE_DEFER;
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failing probe due to bman probe error\n");
> +               return -ENODEV;
> +       }
>
>         pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
>         if (!pcfg)
> --
> 2.17.1
>
