From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 18:55:01 +0100
Subject: [GIT PULL v2 1/4] ARM: tegra: IOMMU support for v3.19
In-Reply-To: <20141201150552.GB11943@ulmo.nvidia.com>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
 <201411282320.19546.arnd@arndb.de> <20141201150552.GB11943@ulmo.nvidia.com>
Message-ID: <2735208.aqBxNpBLAO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 16:05:54 Thierry Reding wrote:
> On Fri, Nov 28, 2014 at 11:20:19PM +0100, Arnd Bergmann wrote:
> > On Wednesday 26 November 2014, Thierry Reding wrote:
> > > Hi ARM SoC maintainers,
> > > 
> > > The following changes since commit 0690cbd2e55a72a8eae557c389d1a136ed9fa142:
> > > 
> > >   powerpc/iommu: Rename iommu_[un]map_sg functions (2014-11-18 11:30:01 +0100)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-iommu-rebased
> > > 
> > > for you to fetch changes up to 37d21f8918f2aa2289036cc778ee188951e53288:
> > > 
> > >   memory: Add NVIDIA Tegra memory controller support (2014-11-26 09:45:02 +0100)
> > > 
> > > Here's a version of the pull request rebased on top of Joerg's core
> > > branch from the IOMMU tree. It has the advantage of having resolved
> > > the merge conflicts and the disadvantage of pulling in v3.18-rc3.
> > > 
> > 
> > Hi Thierry,
> > 
> > sorry for taking my time on this, I had some concerns when I first
> > looked at the memory controller driver and binding (after I got your
> > pull request), and wanted to be sure everything is fine before I merge
> > it.
> > 
> > Pulling in v3.18-rc3 is not a problem, since the next/soc branch is
> > already based on -rc3 (you can see that yourself if you check out the
> > branch from the arm-soc tree), and I'm absolutely fine with merging
> > either v1 or v2 of this, the conflict seems harmless, and so does 
> > pulling in the dependency.
> > 
> > The extra attention for the binding is because the base iommu binding
> > is still very new and gives some options to driver authors, and I want
> > to make sure we are setting a good example for others to look at.
> > My problem is mainly lack of understanding for your hardware requirements,
> > so hopefully you can clarify this all and I can just merge it, or we
> > find an easy way to change the code if I have stumbled on a problem.
> > 
> > My main question is about the relation between 'swgroup' and 'id'
> > settings. What do the two things mean respectively, does your driver
> > define how they get combined, or is each master hardcoded to both?
> 
> An ID refers to the client ID. Each client ID represents one requester
> and a set of IDs makes up one SWGROUP. For example there are two display
> controllers, each being three clients, yet there's only two SWGROUPs for
> them:
> 
> 	SWGROUP dc: - display0a
> 	            - display0b
> 	            - display0c
> 
> 	SWGROUP dcb: - display0ab
> 	             - display0bb
> 	             - display0cb
> 
> Each SWGROUP can be assigned a separate address space. That is, an
> address space for SWGROUP dc will apply for all clients in that group.
> However it can be additionally specified for which clients in a group
> IOMMU address translation should be enabled. Theoretically one could
> enable translation only for display0a and display0b, but not for
> display0c. I don't immediately see when that would be desirable, hence
> the driver always enables translation for all clients in a group.

Ok, I see. So specifying both SWGROUP and ID in DT would let you do
that, but you don't think anybody ever wants it.

> > I generally dislike having SoC-specific lookup tables in drivers for
> > things that could be fully described in DT, so I really want to understand
> > why you added those tables.
> 
> What exactly is your concern with these tables? Is it the size? Roughly
> these are 3.5 KiB of .rodata per SoC generation. If that's too much I
> think I could perhaps get that down to something like half of it using
> bitfields (reg could be 11 bits, bit/shift could be 5, so that both fit
> into a single u16 instead of 2 u32). That'll probably increase code size
> a little to extract these fields, but that may be a suitable tradeoff.

I'm not too worried about the size. My concern is mainly the fact that
you have to add a new file for each new SoC, which is not necessary if
we can find a way to make the binding generic enough to cover any variant.

It's less of an issue for the particular implementation from NVIDIA,
since you have a relatively low number of SoC designs coming out,
compared to some of the other vendors, and in particular compared to
the ARM SMMU that will be shared across many vendors. I definitely
would not want to see per-SoC files for each chip that contains an
ARM SMMU, and I also would like to see IOMMU drivers in general being
implemented in a similar fashion, and your driver sets an example that
others should better not copy IMHO ;-)

> > The .smmu.reg and .smmu.bit settings seem to directly correlate to the
> > .id value in the table, so I'm assuming you could derive one from the
> > other if it was advantagous.
> 
> This could be done using something like this:
> 
> 	unsigned int reg = 0x228 + (id / 32) * 4;
> 	unsigned int bit = id % 32;
> 
> However there are a couple of entries that are special, notable the PTC
> and MPCORE clients. Those have a SWGROUP but none of these enable bits,
> so I can't immediately think of a way to do that nicely. We'd probably
> have to hard-code checks for that, making it somewhat brittle. Having
> this all in a simple lookup table makes this really straightforward and
> easy to verify for correctness by comparing the table to internal files
> that specify these registers.

I see.

> > The name is only used for debugging purposes and we could also leave
> > it out if we had a way to kill off the other fields of the table.
> 
> The name is also used in error messages to clarify where an error comes
> from. That's been very essential in tracking down various issues in some
> drivers (DRM primarily).

Couldn't you print the DT path of the DMA master to provide the
same information?

> > In the comment you mention that the latency allowance is set up to the
> > hardware defaults, so I guess in the current version this is not required,
> > but the .la.reg/shift/mask fields can't be determined from the other
> > fields. This means in order to implement the extension for changing the
> > setting in the future, you'd have to add some other way of communicating
> > it without the table, right?
> 
> Right, there is no programmatic way to derive the latency allowance data
> from the ID. They're more or less randomly spread across the registers.
> 
> Note that there are other knobs in the memory controller associated with
> the memory clients, though they aren't in use (yet). Having this kind of
> table gives us a very nice way of collecting the per-client data in one
> location and then use that for register programming.

So what does "lacency allowance" actually mean, and why do you need to
access this field from Linux? I'm not too familiar with memory controller
concepts, so I'm sorry if this is an RTFM question.

> > Back to the swgroup/id fields: if you need both, would it make sense
> > to have #iommu-cells = <2> and pass both from the dma master device?
> 
> I think they are really orthogonal settings. Client IDs have nothing to
> do with the IOMMU specifically. The IOMMU is primarily concerned with
> the SWGROUP. The driver only makes sure that IOVA translation is enabled
> for each client in a SWGROUP.

Hmm, where are they actually needed both at the same time then? IOW,
why can't the IOMMU driver just deal with the SWGROUP and ignore the
table with the ID and LA values, leaving that to the memory controller
driver?

	Arnd
