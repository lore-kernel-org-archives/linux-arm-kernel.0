From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 28 Mar 2013 08:52:08 +0800
Subject: [PATCH V2 3/6] usb: ehci: mv_ehci: remove unused clock
In-Reply-To: <1364195217-1226-4-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
 <1364195217-1226-4-git-send-email-chao.xie@marvell.com>
Message-ID: <CADApbeiLTM2RD9kW0Eqi5uW99nGpt5w38WCHZro_KhZX1rDqug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Alan

This is the patch for EHCI clock fix. Can you help to review and ack it? Thanks.

On Mon, Mar 25, 2013 at 3:06 PM, Chao Xie <chao.xie@marvell.com> wrote:
> The origianl understanding of clock is wrong. The EHCI controller
> only have one clock input.
> Passing clock name by pdata is wrong. The clock is defined by device
> iteself.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  drivers/usb/host/ehci-mv.c |   35 ++++++++++-------------------------
>  1 files changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index 3804820..6bad41a 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -33,25 +33,17 @@ struct ehci_hcd_mv {
>
>         struct mv_usb_platform_data *pdata;
>
> -       /* clock source and total clock number */
> -       unsigned int clknum;
> -       struct clk *clk[0];
> +       struct clk *clk;
>  };
>
>  static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
>  {
> -       unsigned int i;
> -
> -       for (i = 0; i < ehci_mv->clknum; i++)
> -               clk_prepare_enable(ehci_mv->clk[i]);
> +       clk_prepare_enable(ehci_mv->clk);
>  }
>
>  static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
>  {
> -       unsigned int i;
> -
> -       for (i = 0; i < ehci_mv->clknum; i++)
> -               clk_disable_unprepare(ehci_mv->clk[i]);
> +       clk_disable_unprepare(ehci_mv->clk);
>  }
>
>  static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
> @@ -144,9 +136,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
>         struct ehci_hcd *ehci;
>         struct ehci_hcd_mv *ehci_mv;
>         struct resource *r;
> -       int clk_i, retval = -ENODEV;
> +       int retval = -ENODEV;
>         u32 offset;
> -       size_t size;
>
>         if (!pdata) {
>                 dev_err(&pdev->dev, "missing platform_data\n");
> @@ -160,8 +151,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
>         if (!hcd)
>                 return -ENOMEM;
>
> -       size = sizeof(*ehci_mv) + sizeof(struct clk *) * pdata->clknum;
> -       ehci_mv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +       ehci_mv = devm_kzalloc(&pdev->dev, sizeof(*ehci_mv), GFP_KERNEL);
>         if (ehci_mv == NULL) {
>                 dev_err(&pdev->dev, "cannot allocate ehci_hcd_mv\n");
>                 retval = -ENOMEM;
> @@ -172,16 +162,11 @@ static int mv_ehci_probe(struct platform_device *pdev)
>         ehci_mv->pdata = pdata;
>         ehci_mv->hcd = hcd;
>
> -       ehci_mv->clknum = pdata->clknum;
> -       for (clk_i = 0; clk_i < ehci_mv->clknum; clk_i++) {
> -               ehci_mv->clk[clk_i] =
> -                   devm_clk_get(&pdev->dev, pdata->clkname[clk_i]);
> -               if (IS_ERR(ehci_mv->clk[clk_i])) {
> -                       dev_err(&pdev->dev, "error get clck \"%s\"\n",
> -                               pdata->clkname[clk_i]);
> -                       retval = PTR_ERR(ehci_mv->clk[clk_i]);
> -                       goto err_clear_drvdata;
> -               }
> +       ehci_mv->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(ehci_mv->clk)) {
> +               dev_err(&pdev->dev, "error getting clock\n");
> +               retval = PTR_ERR(ehci_mv->clk);
> +               goto err_clear_drvdata;
>         }
>
>         r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phyregs");
> --
> 1.7.4.1
>
