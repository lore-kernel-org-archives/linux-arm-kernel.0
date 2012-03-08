From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 8 Mar 2012 10:27:07 -0700
Subject: [PATCH 06/11] PCI: Keep pci_fixup_irqs() around after init
In-Reply-To: <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2012 at 7:51 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> ?drivers/pci/setup-irq.c | ? ?4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index eb219a1..270ae7b 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -18,7 +18,7 @@
> ?#include <linux/cache.h>
>
>
> -static void __init
> +static void
> ?pdev_fixup_irq(struct pci_dev *dev,
> ? ? ? ? ? ? ? u8 (*swizzle)(struct pci_dev *, u8 *),
> ? ? ? ? ? ? ? int (*map_irq)(const struct pci_dev *, u8, u8))
> @@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
> ? ? ? ?pcibios_update_irq(dev, irq);
> ?}
>
> -void __init
> +void
> ?pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
> ? ? ? ? ? ? ? int (*map_irq)(const struct pci_dev *, u8, u8))
> ?{


        struct pci_dev *dev = NULL;
        for_each_pci_dev(dev)
                pdev_fixup_irq(dev, swizzle, map_irq);
}

Hmm, your patch looks OK as far as it goes, but the implementation of
pci_fixup_irqs() as a call-once-at-boot-time thing with a loop through
all the PCI devices we've found so far looks completely broken with
regard to hotplug.

Who does the swizzle for devices hot-added after boot?

Bjorn
