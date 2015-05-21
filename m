From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 21 May 2015 14:13:03 +0200
Subject: [PATCH 4/4] arm64: gicv3: its: Increase FORCE_MAX_ZONEORDER for
 Cavium ThunderX
In-Reply-To: <555D98E3.2030908@arm.com>
References: <1430686172-18222-5-git-send-email-rric@kernel.org>
 <20150505105329.GC1550@arm.com>
 <20150511091438.GW4251@rric.localhost>
 <20150512123056.GA2062@arm.com>
 <20150512162049.GP10428@rric.localhost>
 <20150512172416.GF2062@arm.com>
 <20150520132213.1128eb90@why.wild-wind.fr.eu.org>
 <20150520123159.GE10428@rric.localhost>
 <20150520164858.GD29424@e104818-lin.cambridge.arm.com>
 <555D98E3.2030908@arm.com>
Message-ID: <20150521121303.GK10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.05.15 09:35:47, Marc Zyngier wrote:
> On 20/05/15 17:48, Catalin Marinas wrote:
> > On Wed, May 20, 2015 at 02:31:59PM +0200, Robert Richter wrote:
> >> On 20.05.15 13:22:13, Marc Zyngier wrote:
> >>> On Tue, 12 May 2015 18:24:16 +0100
> >>> Will Deacon <will.deacon@arm.com> wrote:
> >>>> On Tue, May 12, 2015 at 05:20:49PM +0100, Robert Richter wrote:
> >>>>> On 12.05.15 13:30:57, Will Deacon wrote:
> >>
> >>>>> For allocation of 16MB cont. phys mem of a defconfig kernel (4KB
> >>>>> default pagesize) I see this different approaches:
> >>>>
> >>>> 16MB sounds like an awful lot. Is this because you have tonnes of MSIs or
> >>>> a sparse DeviceID space or both?
> >>>
> >>> That's probably due to the sparseness of the DeviceID space. With some
> >>> form of bridge number encoded on top of the BFD number, the device
> >>> table is enormous, and I don't see a nice way to avoid it...
> >>
> >> Right. At the momement out of 21 bits (16MB) we currently have 2 spare
> >> bits, which reduces the actually size used to 4MB. Though, for the
> >> current cpu model we can reduce it at least to 8MB total.
> >>
> >> I will come up with an additional patch setting this to 8MB.
> >>
> >> As said before, I also write on a patch to use CMA.
> > 
> > Can we not reserve a chunk of memory and pass the information to the
> > kernel via DT (/memreserve/ and a new GIC-specific binding)?
> 
> That would have to be done on a per-table basis then. And how would that
> work with ACPI? I don't think the ACPI ITS table specifies anything in
> that respect.
> 
> We're just facing the horrible reality that linear tables are not very
> well suited to sparse addressing. Nobody copied the VAX MMU model for a
> reason... until now.

We could still fall back to mem alloc if the DT or ACPI does not
provide a base address for the table.

For know I would prefer to just implement mem allocation with CMA.

-Robert
