From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Sep 2014 14:47:48 +0400
Subject: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
Message-ID: <540994D4.6040500@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/5/2014 2:10 PM, Yijing Wang wrote:

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>   1 files changed, 12 insertions(+), 2 deletions(-)

> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
> index 71bd161..01781a4 100644
> --- a/arch/powerpc/kernel/msi.c
> +++ b/arch/powerpc/kernel/msi.c
[...]
> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>   	return ppc_md.setup_msi_irqs(dev, nvec, type);
>   }
>
> -void arch_teardown_msi_irqs(struct pci_dev *dev)
> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)

    Shouldn't this function take IRQ # instead?

>   {
>   	ppc_md.teardown_msi_irqs(dev);
>   }
> +
> +static struct msi_chip ppc_msi_chip = {
> +	.setup_irqs = ppc_setup_msi_irqs,
> +	.teardown_irqs = ppc_teardown_msi_irqs,
> +};
> +
> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
> +{
> +	return &ppc_msi_chip;
> +}

WBR, Sergei
