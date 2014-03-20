From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 20 Mar 2014 09:46:54 +0000
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <8312584.jdZZuHGAjg@wuerfel>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <20140319135619.GC6231@localhost>
 <20140319172140.GA16328@e106497-lin.cambridge.arm.com>
 <8312584.jdZZuHGAjg@wuerfel>
Message-ID: <20140320094654.GZ6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 06:37:51PM +0000, Arnd Bergmann wrote:
> On Wednesday 19 March 2014 17:21:41 Liviu Dudau wrote:
> > 
> > My ultimate point is that no matter how long we argue about the shape of the functions that
> > I've added into arch/arm64/kernel/pci.c I don't think we can get away without having that
> > file, or at least not in the first phase if we want speedy integration into mainline.
> 
> Let me simplify the discussion here:
> 
> NAK to adding yet another architecture specific implementation.

So what would be your approach for handling pci_address_to_pio() in a non-arch specific way?

unsigned long __weak pci_address_to_pio(phys_addr_t address)
{
#ifdef ARCH_HAS_IOSPACE
	if (address > IO_SPACE_LIMIT)
		return (unsigned long)-1;

	return (unsigned long) address;
#else
	struct ioresource *res;

	list_for_each_entry(res, &io_list, list) {
		if (address >= res->start &&
			address < res->start + res->size) {
			return res->start - address;
		}
	}

	return (unsigned long)-1;
#endif
}


Either that, or you have more magic rabbits than me.

Best regards,
Liviu

> 
> 	Arnd
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
