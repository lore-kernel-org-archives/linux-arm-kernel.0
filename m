From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Apr 2014 13:34:54 -0600
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <6414220.SShvCHLvZQ@wuerfel>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
 <6414220.SShvCHLvZQ@wuerfel>
Message-ID: <20140423193454.GA10076@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 08:58:05PM +0200, Arnd Bergmann wrote:

> PCI guarantees this, but I have seen systems in the past (on
> PowerPC) that would violate them on the internal interconnect: You
> could sometimes see the completion DMA data in the descriptor ring
> before the actual user data is there. We only ever observed it in
> combination with an IOMMU, when the descriptor address had a valid
> IOTLB but the data address did not.

Ordering in PCI-E gets a bit fuzzy when you talk about internal order
within the host bridge, but AFAIK, re-ordering non-relaxed PCI-E
writes is certainly a big no-no.. It breaks the entire
producer/consumer driver model..

> Another problem is MSI processing. MSI was specifically invented to avoid
> having to check an MMIO register for a DMA completion that as a side-effect
> flushes pending DMAs from the same device. This breaks down if the MSI
> packet gets turned into a level interrupt before it reaches the CPU's
> coherency domain, which is likely the case on the dw-pcie controller that
> comes with its own MSI block.

I recently implemented a PCI-E to AXI bridge HW that does MSI in an
AXI environment and it requires waiting for all AXI operations
associated with prior PCI-E packets to complete and be acked back to
the bridge before sending an MSI edge over to the GIC.

Unlike PCI, AXI provides a write completion ack back to the initiator,
which can only be sent by the completor once the transaction is
visible to all other initiators.

A bridge must similarly serialize other TLPs: eg a series of posted
writes with the relaxed ordering bit set can be pipelined into AXI,
but once a non-relaxed TLP is hit, the bridge must wait for all the
prior writes to be ack'd before forwarding the non-relaxed one.

Not doing this serialization would be the root cause of problem like
you described above in PPC - where the IOMMU path takes longer than
the non-IOMMU path so the non-relaxed completion write arrives too
soon.

IMHO, if someone builds a PCI-E bridge that doesn't do this, then it's
MSI support is completely broken and should not be used. Delivering a
MSI interrupt before data visibility completely violates requirements
in PCI-E for transaction ordering.

It is also important to note that even level interrupts require bridge
serialization. When a non-relaxed read-response TLP is returned the
bridge must wait for all AXI writes to be ack'd before forwarding the
read response. Otherwise writes could be buffered within the
interconnect and still not be visible to the CPU while the read
response 'passes' them.

Jason
