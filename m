From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 24 Feb 2013 13:36:03 +0100
Subject: [PATCH 1/2] Drivers: w1: mxc_w1, Add support for DT
In-Reply-To: <CALBypN4+ioS=YDrw7YnvtS1AeS+UH=FidYd2zG1_NsBWDh9bgQ@mail.gmail.com>
References: <1361640958-1876-1-git-send-email-mpa@pengutronix.de>
 <CALBypN4+ioS=YDrw7YnvtS1AeS+UH=FidYd2zG1_NsBWDh9bgQ@mail.gmail.com>
Message-ID: <20130224123603.GA11323@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Sun, Feb 24, 2013 at 12:37:17PM +0100, Martin Fuzzey wrote:
> Hi Markus,
> 
> I've already submitted basically this and it's in linux-next:
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=
> 28c55dc1acc863cb29832b5be2464ebcdafdc3d5

Ok, but 2/2 is still needed.

> 
> Also:
> +Example:
> +               w1: w1 at 10009000 {
> +                       compatible = "fsl,imx27-w1";
> +                       reg = <0x10009000 0x1000>;
> +               };
> ...
> +struct of_device_id mxc_w1_of_ids[] = {
> +       { .compatible = "fsl,imx21-w1", },
> +       { /* sentinel */ }
> +};
> 
> Isn't there a mismatch imx27 vs imx21 here?

Yes that's a mismatch from a previous version.

Thanks

Markus

> 
> Regards,
> 
> Martin
> 
> 
> 
> On Sat, Feb 23, 2013 at 6:35 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
>     Add devicetree support for mxc_w1 driver.
> 
>     Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>     ---
>      Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt | 13 +++++++++++++
>      drivers/w1/masters/mxc_w1.c                         |  7 +++++++
>      2 files changed, 20 insertions(+)
>      create mode 100644 Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt
> 
>     diff --git a/Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt b/
>     Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt
>     new file mode 100644
>     index 0000000..686ced4
>     --- /dev/null
>     +++ b/Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt
>     @@ -0,0 +1,13 @@
>     +Freescale driver for Dalla's 1-wire bus master on imx chips
>     +
>     +This driver supports imx21,27,31,35.
>     +
>     +Required properties:
>     +- compatible : "fsl,<chip>-w1"
>     +- reg : Should be the memory range.
>     +
>     +Example:
>     +               w1: w1 at 10009000 {
>     +                       compatible = "fsl,imx27-w1";
>     +                       reg = <0x10009000 0x1000>;
>     +               };
>     diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
>     index 708a25f..827ff7f 100644
>     --- a/drivers/w1/masters/mxc_w1.c
>     +++ b/drivers/w1/masters/mxc_w1.c
>     @@ -186,9 +186,16 @@ static int mxc_w1_remove(struct platform_device *pdev)
>             return 0;
>      }
> 
>     +struct of_device_id mxc_w1_of_ids[] = {
>     +       { .compatible = "fsl,imx21-w1", },
>     +       { /* sentinel */ }
>     +};
>     +MODULE_DEVICE_TABLE(of, mxc_w1_of_ids);
>     +
>      static struct platform_driver mxc_w1_driver = {
>             .driver = {
>                        .name = "mxc_w1",
>     +                  .of_match_table = mxc_w1_of_ids,
>             },
>             .probe = mxc_w1_probe,
>             .remove = mxc_w1_remove,
>     --
>     1.8.1.2
> 
> 
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel at lists.infradead.org
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
