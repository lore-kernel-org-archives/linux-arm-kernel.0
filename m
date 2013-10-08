From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Oct 2013 10:51:48 +0100
Subject: [PATCH 3/6] ARM: integrator: delete non-devicetree boot path
In-Reply-To: <1380816202-3128-1-git-send-email-linus.walleij@linaro.org>
References: <1380816202-3128-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131008095148.GD28972@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding devicetree to Cc]

On Thu, Oct 03, 2013 at 05:03:22PM +0100, Linus Walleij wrote:
> The Device Tree boot path now supports everything the ATAG
> boot can provide, and the two are equivalent. This deletes
> the ATAG boot path from the Integrator/AP and
> Integrator/CP platforms to move them on to the future.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/Kconfig                         |   1 +
>  arch/arm/mach-integrator/core.c          |  57 ----------
>  arch/arm/mach-integrator/integrator_ap.c | 135 ------------------------
>  arch/arm/mach-integrator/integrator_cp.c | 173 -------------------------------
>  arch/arm/mach-integrator/pci_v3.c        | 122 +++++-----------------
>  5 files changed, 25 insertions(+), 463 deletions(-)
> 

[...]

> +static int __init pci_v3_probe(struct platform_device *pdev)
>  {
> +       struct device_node *np = pdev->dev.of_node;
>         struct of_pci_range_parser parser;
>         struct of_pci_range range;
>         struct resource *res;
>         int irq, ret;
> 
> +       /* Remap the Integrator system controller */
> +       ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);

It seems a shame that this didn't get described in the DT. This hasn't
been fully moved over...

> +       if (!ap_syscon_base) {
> +               dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Device tree probe path */
> +       if (!np) {
> +               dev_err(&pdev->dev, "no device tree node for PCIv3\n");
> +               return -ENODEV;
> +       }

We didn't unmap the syscon registers, yet we mapped them here. Either
we've got a useless mapping, or we're mapping it from the wrong block of
code...

Cheers,
Mark.
