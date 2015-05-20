From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 May 2015 13:11:38 +0100
Subject: [PATCH 1/4] arm64: gicv3: its: Encode domain number in PCI
 stream id
In-Reply-To: <1430686172-18222-2-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
 <1430686172-18222-2-git-send-email-rric@kernel.org>
Message-ID: <20150520131138.2c94a32a@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 3 May 2015 21:49:29 +0100
Robert Richter <rric@kernel.org> wrote:

> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> PCI stream ids need to consider pci bridge number to be unique on the
> system. Using only bus and devfn can't do the trick in systems that
> have multiple pci bridges.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9687f8afebff..e30b4de04c6c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1186,7 +1186,7 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>  {
>  	struct its_pci_alias *dev_alias = data;
>  
> -	dev_alias->dev_id = alias;
> +	dev_alias->dev_id = (pci_domain_nr(pdev->bus) << 16) | alias;
>  	if (pdev != dev_alias->pdev)
>  		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
>  

This feels very scary. We're now assuming that the domain number will
always be presented to the doorbell. What guarantee do we have that
this is always the case, irrespective of the platform?

Also, domains have no PCI reality, they are a Linux thing. And they can
be "randomly" assigned, unless you force the domain in DT with a
linux,pci-domain property. This looks even more wrong, specially
considering ACPI.

It really feels like we need a way to describe how the BDF numbering is
augmented. We also need to guarantee that we get the actual bridge
number, as opposed to the domain number.

Thoughts?

	M.
-- 
Without deviation from the norm, progress is not possible.
