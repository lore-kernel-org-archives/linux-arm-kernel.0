From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 21 May 2014 11:02:45 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4506822.XX7GrvtHhk@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <5123714.0MpMQfsmcr@wuerfel> <20140521081608.GA11068@ulmo>
 <4506822.XX7GrvtHhk@wuerfel>
Message-ID: <20140521090244.GB19268@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 10:54:42AM +0200, Arnd Bergmann wrote:
> On Wednesday 21 May 2014 10:16:09 Thierry Reding wrote:
> > On Tue, May 20, 2014 at 10:31:29PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 20 May 2014 16:00:02 Thierry Reding wrote:
> > > > On Tue, May 20, 2014 at 03:34:46PM +0200, Arnd Bergmann wrote:
> > > > > On Tuesday 20 May 2014 15:17:43 Thierry Reding wrote:
> > > > > > On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > > > > > > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
> > > > > > [...]
> > > > > > > > Couldn't a single-master IOMMU be windowed?
> > > > > > > 
> > > > > > > Ah, yes. That would actually be like an IBM pSeries, which has a windowed
> > > > > > > IOMMU but uses one window per virtual machine. In that case, the window could
> > > > > > > be a property of the iommu node though, rather than part of the address
> > > > > > > in the link.
> > > > > > 
> > > > > > Does that mean that the IOMMU has one statically configured window which
> > > > > > is the same for each virtual machine? That would require some other
> > > > > > mechanism to assign separate address spaces to each virtual machine,
> > > > > > wouldn't it? But I suspect that if the IOMMU allows that it could be
> > > > > > allocated dynamically at runtime.
> > > > > 
> > > > > The way it works on pSeries is that upon VM creation, the guest is assigned
> > > > > one 256MB window for use by assigned DMA capable devices. When the guest
> > > > > creates a mapping, it uses a hypercall to associate a bus address in that
> > > > > range with a guest physical address. The hypervisor checks that the bus
> > > > > address is within the allowed range, and translates the guest physical
> > > > > address into a host physical address, then enters both into the I/O page
> > > > > table or I/O TLB.
> > > > 
> > > > So when a VM is booted it is passed a device tree with that DMA window?
> > > 
> > > Correct.
> > > 
> > > > Given what you describe above this seems to be more of a configuration
> > > > option to restrict the IOMMU to a subset of the physical memory for
> > > > purposes of virtualization. So I agree that this wouldn't be a good fit
> > > > for what we're trying to achieve with iommus or dma-ranges in this
> > > > binding.
> > > 
> > > Thinking about it again now, I wonder if there are any other use cases
> > > for windowed IOMMUs. If this is the only one, there might be no use
> > > in the #address-cells model I suggested instead of your original
> > > #iommu-cells.
> > 
> > So in this case virtualization is the reason why we need the DMA window.
> > The reason for that is that the guest has no other way of knowing what
> > other guests might be using, so it's essentially a mechanism for the
> > host to manage the DMA region and allocate subregions for each guest. If
> > virtualization isn't an issue then it seems to me that the need for DMA
> > windows goes away because the operating system will track DMA regions
> > anyway.
> > 
> > The only reason I can think of why a windowed IOMMU would be useful is
> > to prevent two or more devices from stepping on each others' toes. But
> > that's a problem that the OS should already be handling during DMA
> > buffer allocation, isn't it?
> 
> Right. As long as we always unmap the buffers from the IOMMU after they
> have stopped being in use, it's very unlikely that even a broken device
> driver causes a DMA into some bus address that happens to be mapped for
> another device.

I think that if buffers remain mapped in the IOMMU when they have been
deallocated that should be considered a bug.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/5b719c8c/attachment.sig>
