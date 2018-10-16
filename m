From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Oct 2018 13:03:47 -0300
Subject: [PATCH v3 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <dcbcaf888bbd0a35dcf34228df2d9eb4fd762ea7.1539705286.git.leonard.crestez@nxp.com>
References: <cover.1539705285.git.leonard.crestez@nxp.com>
 <dcbcaf888bbd0a35dcf34228df2d9eb4fd762ea7.1539705286.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5Ck846zd_Xo=9sVK0EAxNLsUsWiC59H2Ms6x8xoD8iwWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Tue, Oct 16, 2018 at 12:58 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +       /* DCP clock is optional, only used on some SOCs */
> +       sdcp->dcp_clk = devm_clk_get(dev, "dcp");
> +       if (IS_ERR(sdcp->dcp_clk)) {
> +               if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
> +                       return PTR_ERR(sdcp->dcp_clk);
> +               sdcp->dcp_clk = NULL;

This dcp_clk assignment to NULL does not seem to be necessary.

> +
> +       ret = clk_prepare_enable(sdcp->dcp_clk);
> +       if (ret)
> +               return ret;
>
>         ret = devm_request_irq(dev, dcp_vmi_irq, mxs_dcp_irq, 0,
>                                "dcp-vmi-irq", sdcp);
>         if (ret) {
>                 dev_err(dev, "Failed to claim DCP VMI IRQ!\n");

In case of subsequent errors you should call
clk_disable_unprepare(sdcp->dcp_clk).
