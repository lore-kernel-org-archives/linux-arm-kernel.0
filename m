From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 15:21:25 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <1400145519-28530-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <8288032.jL4bOz6qPT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 11:18:37 Thomas Petazzoni wrote:
> @@ -445,7 +452,7 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
>         return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
>                                   PCI_IO_VIRT_BASE + offset + SZ_64K,
>                                   phys_addr,
> -                                 __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
> +                                 __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
>  }
>  EXPORT_SYMBOL_GPL(pci_ioremap_io);
> 

As discussed on IRC, I think we'd be better off making this a strong-ordered
mapping for all platforms unconditionally. The PCI I/O space semantics
require non-posted writes, which is the main difference between device
and SO mappings, so the same fix is required both for mvebu as a workaround
for the deadlock as well as for everyone else as a fix for an incorrect
PCI behavior.

	Arnd
