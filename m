From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 10:38:18 -0300
Subject: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
In-Reply-To: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5BQjxeGOUE3jwbA_sRuYWQkHTJo3AeywXXpm-9kVdsYfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Fri, Jul 20, 2018 at 9:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> +       int ret = 0;

There is no need for initializing 'ret' here.

> +       struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +       struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> +       if (imx6_pcie->variant != IMX7D)
> +               return 0;
> +
> +       imx6_pcie_assert_core_reset(imx6_pcie);
> +       imx6_pcie_init_phy(imx6_pcie);
> +       imx6_pcie_deassert_core_reset(imx6_pcie);
> +       dw_pcie_setup_rc(pp);
> +
> +       ret = imx6_pcie_establish_link(imx6_pcie);
> +       if (ret < 0)
> +               pr_err("pcie link is down after resume.\n");

Shouldn't the error be propagated?

Also, dev_err() is preferred instead of pr_err().
