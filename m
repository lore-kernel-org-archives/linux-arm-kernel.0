From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Nov 2009 23:18:54 +0000
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <m34oowyako.fsf@intrepid.localdomain>
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
	<m34oowyako.fsf@intrepid.localdomain>
Message-ID: <20091114231854.GB30027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2009 at 12:02:15AM +0100, Krzysztof Halasa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > This is rather horrible, linux/mm.h is one of those headers which drag
> > in lots of other headers, and we're risking horrible include loops if we
> > do this.  (while ifdefs give some protection against those running away,
> > it does mean that we lose ordering of definitions - which can and does
> > lead to indeterminent behaviour.)
> 
> Right, that's bad.
> 
> I wonder why is this ioremap() etc. code interested in VMALLOC_START at all.
> Perhaps reversing the test would make more sense?

You're confusing virtual addresses with pci addresses, these are not the
same thing.

> +
> +static inline int is_pci_memory(u32 addr)
> +{
> +	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
> +}
> +
> @@ -66,7 +72,7 @@ static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
>  
>  static inline void __indirect_iounmap(void __iomem *addr)
>  {
> -	if ((__force u32)addr >= VMALLOC_START)
> +	if (!is_pci_memory(__force u32)addr)

So here you're testing a virtual address against a pci address.
