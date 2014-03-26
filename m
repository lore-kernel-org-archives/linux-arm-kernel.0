From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 12:52:31 +0100
Subject: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <OF362EF259.A035C442-ON80257CA7.003E97FF-80257CA7.003F9959@eu.necel.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
 <5228683.eofaEcInBi@wuerfel>
 <OF362EF259.A035C442-ON80257CA7.003E97FF-80257CA7.003F9959@eu.necel.com>
Message-ID: <17762778.T67iL7T7u4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014 11:34:41 Phil.Edworthy at renesas.com wrote:
> > But the ranges you specified in the property don't actually fit in those
> > constraints: you have a range with size 0x8000000 and start 0x40000000,
> > which you say can't be programmed into the hardware.
> 
> Actually, the driver checks the dma-ranges against these constraints, and 
> if necessary will create multiple mappings to fulfil the requested 
> dma-ranges.

Ok, I didn't notice. My initial suggestion was to not put that logic
into the driver but instead specify in the host bridge binding that each
entry in the dma-ranges property has to meet the hardware constraints.

As long as you don't have too much complexity to detect this case, I'm
fine with it either way.
 
> > > Still, my comment about the OF PCI range code treating both 32 and 
> 64-bit 
> > > types the same way means that PCIe host driver has to assume it's a 
> 64-bit 
> > > mapping.
> > 
> > I was thinking more of PCI devices than the host itself. If the host
> > driver can verify that all mappings are in the first 4GB and cover all 
> of
> > RAM, we won't have to use an swiotlb for devices that don't support 
> 64-bit
> > DMA, which is a very significant performance difference.
> Ok, I think I understand. However, all the other PCI host drivers just do 
> 1-to-1 mapping between PCI and CPU addresses, right? Whilst it might be 
> nice be able to support mapping CPU addresses > 4GiB to PCI addresses 
> under 4GiB, can that be something to consider later on?

Yes, fair enough. The current version is much simpler, so that's ok.
Just keep it in mind if you run into performance problems. Also, note
that we don't actually support swiotlb on arm32 yet, so your current
code is broken for an PCI DMA master that is not 64-bit capable.
We need swiotlb on arm32 anyway, and that will fix this problem, but
adding the hack I described would also fix it.

	Arnd
