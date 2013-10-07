From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 7 Oct 2013 16:28:52 -0600
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link is
 up to enable hot plug
In-Reply-To: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Seungwon]

On Tue, Oct 1, 2013 at 11:58 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix it.
>
> Tested on kirkwood with repeated plug/unplug of the link partner.
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Last I heard (Sep 26), you had some mvebu changes in your tree
already, Jason, so I was assuming you'd handle pci-mvebu.c changes, at
least for the v3.13 merge window.  But you marked this "resend"; does
that mean you're waiting for me to do something with it?

I see the following mvebu patches in patchwork:

  PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
  PCI: mvebu - Support a bridge with no IO port window
  PCI: mvebu: add I/O access wrappers

Let me know if I need to do anything with any of them.

Bjorn

> ---
>  drivers/pci/host/pci-mvebu.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 729d5a1..f2d61f5 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -115,7 +115,6 @@ struct mvebu_pcie_port {
>         char *name;
>         void __iomem *base;
>         spinlock_t conf_lock;
> -       int haslink;
>         u32 port;
>         u32 lane;
>         int devfn;
> @@ -552,7 +551,7 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>         if (bus->number == 0)
>                 return mvebu_sw_pci_bridge_write(port, where, size, val);
>
> -       if (!port->haslink)
> +       if (!mvebu_pcie_link_up(port))
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>
>         /*
> @@ -594,7 +593,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>         if (bus->number == 0)
>                 return mvebu_sw_pci_bridge_read(port, where, size, val);
>
> -       if (!port->haslink) {
> +       if (!mvebu_pcie_link_up(port)) {
>                 *val = 0xffffffff;
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>         }
> @@ -883,22 +882,11 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>
>                 mvebu_pcie_set_local_dev_nr(port, 1);
>
> -               if (mvebu_pcie_link_up(port)) {
> -                       port->haslink = 1;
> -                       dev_info(&pdev->dev, "PCIe%d.%d: link up\n",
> -                                port->port, port->lane);
> -               } else {
> -                       port->haslink = 0;
> -                       dev_info(&pdev->dev, "PCIe%d.%d: link down\n",
> -                                port->port, port->lane);
> -               }
> -
>                 port->clk = of_clk_get_by_name(child, NULL);
>                 if (IS_ERR(port->clk)) {
>                         dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
>                                port->port, port->lane);
>                         iounmap(port->base);
> -                       port->haslink = 0;
>                         continue;
>                 }
>
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
