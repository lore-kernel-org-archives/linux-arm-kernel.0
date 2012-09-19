From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Sep 2012 08:37:31 +1000
Subject: [PATCH v2 2/2] PCI: Provide a default pcibios_update_irq()
In-Reply-To: <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
 <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 17 Sep 2012 13:22:54 +0200 Thierry Reding <thierry.reding@avionic-design.de> wrote:
>
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index 270ae7b..3d61ce3 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -17,6 +17,11 @@
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
>  
> +void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> +{
> +	dev_dbg(&dev->dev, "Assigning IRQ %02d\n", irq);
> +	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> +}
>  
>  static void
>  pdev_fixup_irq(struct pci_dev *dev,

Didn't we have a problem with some compiler versions when the weak
definition was in the same file as the call (there is a call to this
function in drivers/pci/setup-irq.c)?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/bf1e4426/attachment-0001.sig>
