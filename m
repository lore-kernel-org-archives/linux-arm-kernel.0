From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Jul 2013 20:36:10 +0200
Subject: NSA310 + DT
In-Reply-To: <20130730191943.49f8070c@skate>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
Message-ID: <20130730183610.GT24782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 07:19:43PM +0200, Thomas Petazzoni wrote:
> Dear Finn Hoffmann,
> 
> BTW, any reason why this discussion is not taking place on LAKML ?

Ah, sorry, did not look at the CC: list. Now one list...

    Andrew

> 
> On Tue, 30 Jul 2013 18:37:13 +0200, Finn Hoffmann wrote:
> 
> > $ lspci -v
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 
> > 00 [Normal decode])
> >          Flags: bus master, fast devsel, latency 0
> >          Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >          I/O behind bridge: 00010000-00010fff
> >          Prefetchable memory behind bridge: e0000000-e00fffff
> 
> Ok, so there should be one mem window from e0000000 to e0100000...
> 
> > # cat /sys/kernel/debug/mvebu-mbus/devices
> > [00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap 0000000000010000)
> > [01] disabled
> > [02] disabled
> > [03] disabled
> > [04] 00000000f4000000 - 00000000f4010000 : nand
> > [05] 00000000f5000000 - 00000000f5010000 : sram
> > [06] disabled
> > [07] disabled
> 
> ... but there's none here.
> 
> Seems like your device is using a prefetchable memory window, and our
> emulated PCI-to-PCI bridge isn't taking this into account.
> 
> Can you test the below (completely untested) patch? Regardless of
> whether it works or not, I'm interested in seeing the "PCI MVEBU"
> debug messages that I've added, as well as the output
> of /sys/kernel/debug/mvebu-mbus/devices.
> 
> Thanks a lot!
> 
> Thomas
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13a633b..641dd3d 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -129,6 +129,8 @@ struct mvebu_pcie_port {
>  	struct mvebu_pcie *pcie;
>  	phys_addr_t memwin_base;
>  	size_t memwin_size;
> +	phys_addr_t prefmemwin_base;
> +	size_t prefmemwin_size;
>  	phys_addr_t iowin_base;
>  	size_t iowin_size;
>  };
> @@ -348,6 +350,39 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  					  MVEBU_MBUS_PCI_MEM);
>  }
>  
> +static void mvebu_pcie_handle_prefmembase_change(struct mvebu_pcie_port *port)
> +{
> +	/* Are the new membase/memlimit values invalid? */
> +	if (port->bridge.prefmemlimit < port->bridge.prefmembase) {
> +
> +		/* If a window was configured, remove it */
> +		if (port->prefmemwin_base) {
> +			mvebu_mbus_del_window(port->prefmemwin_base,
> +					      port->prefmemwin_size);
> +			port->prefmemwin_base = 0;
> +			port->prefmemwin_size = 0;
> +		}
> +
> +		return;
> +	}
> +
> +	/*
> +	 * We read the PCI-to-PCI bridge emulated registers, and
> +	 * calculate the base address and size of the address decoding
> +	 * window to setup, according to the PCI-to-PCI bridge
> +	 * specifications.
> +	 */
> +	port->prefmemwin_base  = ((port->bridge.prefmembase & 0xFFF0) << 16);
> +	port->prefmemwin_size  =
> +		(((port->bridge.prefmemlimit & 0xFFF0) << 16) | 0xFFFFF) -
> +		port->prefmemwin_base;
> +
> +	mvebu_mbus_add_window_remap_flags(port->name, port->prefmemwin_base,
> +					  port->prefmemwin_size,
> +					  MVEBU_MBUS_NO_REMAP,
> +					  MVEBU_MBUS_PCI_MEM);
> +}
> +
>  /*
>   * Initialize the configuration space of the PCI-to-PCI bridge
>   * associated with the given PCIe interface.
> @@ -492,18 +527,28 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>  		bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
>  		bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
>  		bridge->secondary_status = value >> 16;
> +		pr_info("MVEBU PCI %d.%d: new io, base 0x%x, limit 0x%x\n",
> +			port->port, port->lane,
> +			bridge->iobase, bridge->iolimit);
>  		mvebu_pcie_handle_iobase_change(port);
>  		break;
>  
>  	case PCI_MEMORY_BASE:
>  		bridge->membase = value & 0xffff;
>  		bridge->memlimit = value >> 16;
> +		pr_info("MVEBU PCI %d.%d: new mem, base 0x%x, limit 0x%x\n",
> +			port->port, port->lane,
> +			bridge->membase, bridge->memlimit);
>  		mvebu_pcie_handle_membase_change(port);
>  		break;
>  
>  	case PCI_PREF_MEMORY_BASE:
>  		bridge->prefmembase = value & 0xffff;
>  		bridge->prefmemlimit = value >> 16;
> +		pr_info("MVEBU PCI %d.%d: new pref mem, base 0x%x, limit 0x%x\n",
> +			port->port, port->lane,
> +			bridge->prefmembase, bridge->prefmemlimit);
> +		mvebu_pcie_handle_prefmembase_change(port);
>  		break;
>  
>  	case PCI_PREF_BASE_UPPER32:
> 
> 
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
