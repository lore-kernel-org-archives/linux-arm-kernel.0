From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Jul 2014 13:14:54 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140731105017.GB22994@leverpostej>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730152646.GC20162@leverpostej>
 <CAOesGMi3zM1-cqmeGddJ69RNXx0ktFm_zXO_yq7N0EeA3HNrUQ@mail.gmail.com>
 <20140730181842.GG20162@leverpostej> <20140731100905.GA7458@ulmo>
 <20140731105017.GB22994@leverpostej>
Message-ID: <20140731111453.GA11955@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 11:50:17AM +0100, Mark Rutland wrote:
> On Thu, Jul 31, 2014 at 11:09:06AM +0100, Thierry Reding wrote:
> > On Wed, Jul 30, 2014 at 07:18:42PM +0100, Mark Rutland wrote:
> > [...]
> > > > >> +
> > > > >> +Multiple-master IOMMU with configurable DMA window:
> > > > >> +---------------------------------------------------
> > > > >> +
> > > > >> +     / {
> > > > >> +             #address-cells = <1>;
> > > > >> +             #size-cells = <1>;
> > > > >> +
> > > > >> +             iommu {
> > > > >> +                     /* master ID, address and length of DMA window */
> > > > >> +                     #iommu-cells = <4>;
> > > > >> +             };
> > > > >> +
> > > > >> +             master {
> > > > >> +                     /* master ID 42, 4 GiB DMA window starting at 0 */
> > > > >> +                     iommus = <&/iommu  42  0  0x1 0x0>;
> > > > >
> > > > > Is this that window is from the POV of the master, i.e. the master can
> > > > > address 0x0 to 0xffffffff when generating transactions, and these get
> > > > > translated somehow?
> > > > >
> > > > > Or is this the physical addresses to allocate to the master?
> > > > 
> > > > It needs to be clarified in the documentation, but as far as I know it
> > > > is the DMA address space that is used.
> > > 
> > > Ok. So that's pre-translation, from the POV of the master?
> > 
> > Correct. It represents the window of the IOMMU's addressable I/O virtual
> > address space that should be assigned to this particular master.
> > 
> > > If we don't have that knowledge about the master already (e.g. based on
> > > the compatible string), surely we always need that information in a
> > > given iommu-specifier format? Otherwise certain iommus won't be able to
> > > handle masters with limited addressing only due to limitations of their
> > > binding.
> > 
> > This is only used for what's often called a windowed IOMMU. Many IOMMUs
> > (non-windowed) typically allow only a complete address space to be
> > assigned to a master without additional control over subregions. So this
> > is really a property/capability of the IOMMU rather than the masters
> > themselves.
> 
> I'm not sure I follow, but I'm happy to wait until we have the first
> windowed IOMMU using this binding. I'll try to get myself up to speed in
> the mean time.

As I understand it, a windowed IOMMU manages a given I/O virtual address
space (only one or perhaps even several). Each such address space is the
complete range that the IOMMU can take as inputs from any master. For
purposes of virtualization and process separation it can subdivide this
address space into subranges, so that each context can only access that
given range of virtual I/O addresses. I suspect that this works by
setting up a mapping between that range and the context's master ID(s).
And I also suppose it could be possible for the DMA windows to be truly
configurable within the IOMMU or for specific devices to be assigned a
fixed window.

Simpler IOMMUs (Tegra uses one of those for example) know only address
spaces. That is each address space can be assigned to one or more
masters. But each master can always access the whole address space and
accesses cannot be restricted to subregions thereof.

So from a memory protection point of view the difference is that for
non-windowed IOMMUs translations will fault only if no mapping has been
set up for the I/O virtual address being accessed, whereas for windowed
IOMMUs translations can in addition also fault if they access an I/O
virtual addresses outside of the range that they've been assigned.

Does that help? Note that I've never dealt with windowed IOMMUs myself,
so this is largely based on what I scooped up in previous discussions
with Arnd.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/e98963bc/attachment.sig>
