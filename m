From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 14:20:54 +0100
Subject: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <1393506402-11474-2-git-send-email-Liviu.Dudau@arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <14735193.MhDlU8yNYG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 13:06:39 Liviu Dudau wrote:
> +       res->flags = range->flags;
> +       if (res->flags & IORESOURCE_IO) {
> +               unsigned long port;
> +               port = pci_address_to_pio(range->pci_addr);
> +               if (port == (unsigned long)-1) {
> +                       res->start = (resource_size_t)OF_BAD_ADDR;
> +                       res->end = (resource_size_t)OF_BAD_ADDR;
> +                       return;
> +               }
> 

I think this conflicts with the way that pci_address_to_pio() is
defined on powerpc, where it expects a CPU address as the input,
not a PCI i/o address.

	Arnd
