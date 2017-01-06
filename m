From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jan 2017 11:42:32 +0000
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
In-Reply-To: <6092525.UgRCY3dpzP@wuerfel>
References: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
 <6092525.UgRCY3dpzP@wuerfel>
Message-ID: <20170106114231.GC15333@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 12:24:25PM +0100, Arnd Bergmann wrote:
> On Friday, January 6, 2017 11:15:22 AM CET John Garry wrote:
> > [apologies if this has been queried before]
> > 
> > Hi ARM guys,
> > 
> > I have a question about the device memory attributes we assign for PCIe 
> > config space for arm64. Currently we use ioremap to map in the config 
> > space; this uses nGnRE, which means we enable Early Write Acknowledge.
> > 
> > The ARMv8 ARM states that "ARM recommend that No Early Write Acknowledge 
> > Hint is used for PCIe configuration writes".
> > 
> > I understand a problem with using E is in that configuration write is a 
> > non-post operation, which means the RP requires to get the completion 
> > ack from the EP The problem here is if CPU writes data to ECAM by E, 
> > complete will go back to CPU directly, and maybe at this point the write 
> > has not reached the EP.
> > 
> > I believe that this may cause ordering issues in PCI read/write. In 
> > practice we use non-relaxed readl/writel to access config space, which 
> > include the synchronization barriers, which, *as I understand*, even if 
> > for full system domain, may be negated by the E attribute for PCIe.
> 
> I don't think the barriers in readl/writel are enough here, in particular
> the write barrier is *before* the access to synchronize DMAs
> on RAM with MMIO accesses, which is a bit different from what you
> have here.
> 
> > So a question: why is the recommendation in the ARMv8 ARM ignored?
> 
> Probably nobody thought about this properly in the Linux drivers. The
> ARMv8 ARM sounds correct here.

The ARMv8 ARM also says that the E attribute is a hint, so there's no
guarantee that it's actually honoured by the implementation. However,
now that it explicitly mentions PCI config space, the intention is clearly
that nE *is* honoured for systems using PCIe, so I agree that we should make
this change. I don't want to use the nE type for all ioremap invocations,
though.

Will
