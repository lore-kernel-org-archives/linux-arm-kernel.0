From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 09:53:03 -0700
Subject: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
In-Reply-To: <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
[...]

Hi Thomas,

I just noticed two minor issues, see below.

> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
[...]
> @@ -36,6 +36,8 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);

This hunk...

> @@ -63,6 +65,8 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };

and this one use inconsistent indentation (spaces instead of tabs).

> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
[...]
> @@ -464,6 +478,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
>  		sys->align_resource = hw->align_resource;
> +		sys->add_bus        = hw->add_bus;
> +		sys->remove_bus     = hw->remove_bus;

And this one aligns the '=' sign, whereas none of the other assignments
do.

Might be nice to fix those up before sending them to Russell's patch
tracker.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/6f6205d2/attachment.sig>
