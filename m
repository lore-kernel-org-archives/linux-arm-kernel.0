From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 11 Apr 2017 23:38:48 +1000
Subject: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
In-Reply-To: <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
Message-ID: <1491917928.7236.8.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-11 at 13:29 +0100, Lorenzo Pieralisi wrote:
> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
> mandate non-posted configuration transactions. As further highlighted in
> the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
> Enhanced Configuration Access Mechanism"), through ECAM and
> ECAM-derivative configuration mechanism, the memory mapped transactions
> from the host CPU into Configuration Requests on the PCI express fabric
> may create ordering problems for software because writes to memory
> address are typically posted transactions (unless the architecture can
> enforce through virtual address mapping non-posted write transactions
> behaviour) but writes to Configuration Space are not posted on the PCI
> express fabric.
> 
> Include the asm-generic ioremap_nopost() implementation (currently
> falling back to ioremap_nocache()) to provide a non-posted writes
> ioremap interface to kernel subsystems.

NAK. As explained in my reply to patch 0.

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> ---
> ?arch/powerpc/include/asm/io.h | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 5ed2924..6dcd0e2 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -757,6 +757,7 @@ extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
> ?extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
> > ?#define ioremap_nocache(addr, size)	ioremap((addr), (size))
> > ?#define ioremap_uc(addr, size)		ioremap((addr), (size))
> +#include <asm-generic/ioremap-nopost.h>
> ?
> ?extern void iounmap(volatile void __iomem *addr);
> ?
