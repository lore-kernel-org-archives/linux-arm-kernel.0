From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 30 May 2018 03:59:33 +0300
Subject: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
In-Reply-To: <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <CAHp75VfwfKbikfat3tTbMzSfNgt4v9nFpExyDvhOdX9ko1Z4Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 12:58 AM, Ray Jui <ray.jui@broadcom.com> wrote:
> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
> INTD share the same interrupt line connected to the GIC in the system,
> while the status of each INTx can be obtained through the INTX CSR
> register

> +       while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
> +               SYS_RC_INTX_MASK) != 0) {
> +               for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +                       virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> +                       if (virq)
> +                               generic_handle_irq(virq);
> +                       else
> +                               dev_err(dev, "unexpected INTx%u\n", bit);
> +               }
> +       }

do {
  status = ...;
  for_each_set_bit() {
    ...
  }
} while (status);

would look slightly better for my opinion.

-- 
With Best Regards,
Andy Shevchenko
