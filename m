From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 20:15:47 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408180828.GC32490@obsidianresearch.com>
References: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu>
 <20140408180828.GC32490@obsidianresearch.com>
Message-ID: <20140408201547.7bf37e2a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 8 Apr 2014 12:08:28 -0600, Jason Gunthorpe wrote:

> > BTW I can try your patch with the myricom NIC which started to work
> > when rounding up, I'll quickly see if that fixes the issue as well,
> > but I'm now a little bit confused.
> 
> This patch won't fix anything, it just fixes the mbus driver to always
> program the hardware with valid values, even if the upper layer
> requests something invalid. Basically, we spent a few weeks tracking
> this behavior down, the patch would ensure that time doesn't get spent
> again.

Agreed.

> The goal now is to avoid the WARN_ON in the patch from firing.
> 
> For a proper fix, something like this to create multiple aligned
> windows is a simple option (untested, need the inverse on the
> de-register, loop should probably live in mbus code):
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 789cdb2..7312c82 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -382,6 +382,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  
>  static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  {
> +       phys_addr_t base;
> +       unsigned int mapped_size;
> +
>         /* Are the new membase/memlimit values invalid? */
>         if (port->bridge.memlimit < port->bridge.membase ||
>             !(port->bridge.command & PCI_COMMAND_MEMORY)) {
> @@ -408,8 +411,16 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>                 (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
>                 port->memwin_base;
>  
> -       mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
> -                                   port->memwin_base, port->memwin_size);
> +       base = port->memwin_base;
> +       mapped_size = 0;
> +       while (mapped_size < port->memwin_size) {
> +               unsigned int size =
> +                   rounddown_pow_of_two(port->memwin_size - mapped_size);
> +               mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
> +                                           base, size);
> +               base += size;
> +               mapped_size += size;
> +       }
>  }

The problem I have with this approach is the consumption of windows. We
have a limited number of them, and this approach could easily consume
quite a few windows for one single bridge BAR, depending on its size.
Like a bridge BAR of 120 MB would consume four windows (one 64 MB, one
32 MB, one 16 MB and one 8 MB).

Instead, I would really like to see the PCI core being told about this
constraint, so that it can oversize the bridge BAR (to 128 MB in the
above example of a 120 MB bridge BAR). Of course, it would be better if
the PCI core would not blindly apply this logic: if there is a 129 MB
bridge BAR, we'd prefer to have two windows (one 128 MB and one 1 MB),
so as to not loose too much physical address space.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
