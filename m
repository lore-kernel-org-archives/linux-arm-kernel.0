From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Sat, 1 Nov 2014 13:32:08 +0100
Subject: [RFC PATCH 1/2] arm: cns3xxx: pci: remove artificial dependency
 on pci_sys_data domain
In-Reply-To: <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-30 12:44 GMT+01:00 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
[...]
> @@ -323,6 +308,14 @@ static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
>  void __init cns3xxx_pcie_init_late(void)
>  {
>         int i;
> +       void *private_data;
> +       struct hw_pci hw_pci = {
> +              .nr_controllers = 1,
> +              .ops = &cns3xxx_pcie_ops,
> +              .setup = cns3xxx_pci_setup,
> +              .map_irq = cns3xxx_pcie_map_irq,
> +              .private_data = &private_data,
> +       };
>
>         pcibios_min_io = 0;
>         pcibios_min_mem = 0;
> @@ -335,7 +328,8 @@ void __init cns3xxx_pcie_init_late(void)
>                 cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
>                 cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
>                 cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
> -               pci_common_init(&cns3xxx_pcie[i].hw_pci);
> +               private_data = &cns3xxx_pcie[i];
> +               pci_common_init(&hw_pci);
>         }

This looks weird. hw_pci.private_data is a pointer to a (temporary)
pointer to private data?

Best Regards,
Micha? Miros?aw
