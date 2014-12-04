From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 4 Dec 2014 15:43:56 +0100
Subject: [GIT PULL v2 1/4] ARM: tegra: IOMMU support for v3.19
In-Reply-To: <2157417.mTprjOdEjk@wuerfel>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
 <2735208.aqBxNpBLAO@wuerfel> <20141202115123.GF6135@ulmo>
 <2157417.mTprjOdEjk@wuerfel>
Message-ID: <20141204144354.GA31464@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We discussed this on IRC and come to the conclusion that this approach
(encoding the table in the driver) was indeed the best for this
particular type of setup. For the record I'll try to explain the same
here and provide more details.

On Thu, Dec 04, 2014 at 02:36:18PM +0100, Arnd Bergmann wrote:
> On Tuesday 02 December 2014 12:51:24 Thierry Reding wrote:
> > On Mon, Dec 01, 2014 at 06:55:01PM +0100, Arnd Bergmann wrote:
> > > On Monday 01 December 2014 16:05:54 Thierry Reding wrote:
> > > > On Fri, Nov 28, 2014 at 11:20:19PM +0100, Arnd Bergmann wrote:
> > > > > On Wednesday 26 November 2014, Thierry Reding wrote:
> > > > An ID refers to the client ID. Each client ID represents one requester
> > > > and a set of IDs makes up one SWGROUP. For example there are two display
> > > > controllers, each being three clients, yet there's only two SWGROUPs for
> > > > them:
> > > > 
> > > > 	SWGROUP dc: - display0a
> > > > 	            - display0b
> > > > 	            - display0c
> > > > 
> > > > 	SWGROUP dcb: - display0ab
> > > > 	             - display0bb
> > > > 	             - display0cb
> > > > 
> > > > Each SWGROUP can be assigned a separate address space. That is, an
> > > > address space for SWGROUP dc will apply for all clients in that group.
> > > > However it can be additionally specified for which clients in a group
> > > > IOMMU address translation should be enabled. Theoretically one could
> > > > enable translation only for display0a and display0b, but not for
> > > > display0c. I don't immediately see when that would be desirable, hence
> > > > the driver always enables translation for all clients in a group.
> > > 
> > > Ok, I see. So specifying both SWGROUP and ID in DT would let you do
> > > that, but you don't think anybody ever wants it.
> > 
> > Correct. I don't think it makes sense and it'd require significant work
> > in a driver to know which buffers need translation and which don't. In
> > fact I don't think you could make that work with the current frameworks
> > because both the IOMMU and DMA APIs operate at a struct device level. A
> > client could therefore not be distinguished from another.
> 
> I was assuming that you'd have one 'struct device' per client in all
> cases, so you'd have a unique association between a swgroup/id tuple
> and the device pointer that you pass into the dma-mapping and IOMMU APIs.

The majority of devices have two clients: one for read transactions,
another for write transactions. These are typically named <module>r and
<module>w, respectively. But each such module is a single device and
represented by a single device tree node.

The display controllers are somewhat exceptional in that they only read
data, so there are no write clients. But they also have a couple of
clients, one for each display window (or overlay). Like you said, this
looks really like each client is a unidirectional special-purpose DMA
master.

Some examples:

	HDA: 2 clients: hdar and hdaw
	SATA: 2 clients: satar and satar
	DC: 6 clients: display{0a,0b,0c,hc,t,d}
	DCB: 4 clients: display{0ab,0bb,0cb,hcb}

Each of those is a single IP block, and each has a SWGROUP that contains
the set of all the memory clients.

> > > It's less of an issue for the particular implementation from NVIDIA,
> > > since you have a relatively low number of SoC designs coming out,
> > > compared to some of the other vendors, and in particular compared to
> > > the ARM SMMU that will be shared across many vendors. I definitely
> > > would not want to see per-SoC files for each chip that contains an
> > > ARM SMMU, and I also would like to see IOMMU drivers in general being
> > > implemented in a similar fashion, and your driver sets an example that
> > > others should better not copy IMHO ;-)
> > 
> > Actually I disagree. I think this sets exactly the right example. Since
> > none of these associations are configurable or change from board to
> > board, everything is implied by the compatible property. Adding this
> > data to DT would therefore be completely redundant.
> > 
> > Moving the data to DT would also mean that we would be adding a table of
> > registers to the DT. There used to be a time when there was concensus at
> > least that that was a really bad idea. Has that changed in the last few
> > years?
> 
> I wasn't thinking of adding the entire table to the IOMMU node, that would
> indeed achieve nothing compare to having the table in the driver source.
> 
> What I was trying to get at was whether you could make it work without
> a table whatsoever, by doing the DT IOMMU reference on the ID level rather
> than the more coarse SWGROUP level, and doing the memory controller
> settings (latency allowance) separately from that.

Like the examples above show, there is no 1:1 relationship between
clients and devices. Rather one device usually has multiple clients, but
all clients that pertain to one device are arranged in one SWGROUP.

> > > > > In the comment you mention that the latency allowance is set up to the
> > > > > hardware defaults, so I guess in the current version this is not required,
> > > > > but the .la.reg/shift/mask fields can't be determined from the other
> > > > > fields. This means in order to implement the extension for changing the
> > > > > setting in the future, you'd have to add some other way of communicating
> > > > > it without the table, right?
> > > > 
> > > > Right, there is no programmatic way to derive the latency allowance data
> > > > from the ID. They're more or less randomly spread across the registers.
> > > > 
> > > > Note that there are other knobs in the memory controller associated with
> > > > the memory clients, though they aren't in use (yet). Having this kind of
> > > > table gives us a very nice way of collecting the per-client data in one
> > > > location and then use that for register programming.
> > > 
> > > So what does "lacency allowance" actually mean, and why do you need to
> > > access this field from Linux? I'm not too familiar with memory controller
> > > concepts, so I'm sorry if this is an RTFM question.
> > 
> > Essentially this is an input to the memory controller's arbitration unit
> > and sets an upper bound on the latency of outstanding requests. Under
> > memory bandwidth pressure this allows the memory controller to give
> > priority to requests from clients with lower latency tolerance. Display
> > for example would usually have a fairly low tolerance because stalling
> > requests for too long will cause the pixel data FIFO to underrun and
> > cause visual artifacts.
> > 
> > So to make this work the goal is for memory clients to register their
> > bandwidth needs with some central entity that uses it along with the
> > memory client's FIFO depth to compute the value for the latency
> > allowance register. The unit for this value is an internal tick from the
> > memory controller, in turn based on the EMC frequency. Therefore this is
> > usually only computed once for a given configuration and can remain the
> > same across EMC frequency changes.
> > 
> > There are patches in the works to add support for EMC frequency scaling
> > and also latency allowance programming.
> 
> Ok, I see. The part that I'm missing here is how the client driver
> knows its number, as you write that we don't have a device node per
> client. Do you have a particular binding in mind already?

I was thinking that each device tree node would get an additional
property, maybe something like the below. I'm not sure if it makes sense
to turn this into a generic binding, given that this is likely to be
implemented fairly differently on other SoCs, or perhaps other SoCs
don't even have an equivalent of it.

	mc: memory-controller at 70019000 {
		compatible = "nvidia,tegra124-mc";
		...

		#nvidia,memory-client-cells = <1>;
	};

	dc at 54200000 {
		compatible = "nvidia,tegra124-dc";

		...

		nvidia,memory-client = <&mc 1 &mc 3 &mc 5 &mc 16 &mc 90 &mc 115>;
	};

Maybe we'd even need something like nvidia,memory-client-names so that
drivers can determine for which specific clients to set the latency
allowance.

> > > > > Back to the swgroup/id fields: if you need both, would it make sense
> > > > > to have #iommu-cells = <2> and pass both from the dma master device?
> > > > 
> > > > I think they are really orthogonal settings. Client IDs have nothing to
> > > > do with the IOMMU specifically. The IOMMU is primarily concerned with
> > > > the SWGROUP. The driver only makes sure that IOVA translation is enabled
> > > > for each client in a SWGROUP.
> > > 
> > > Hmm, where are they actually needed both at the same time then? IOW,
> > > why can't the IOMMU driver just deal with the SWGROUP and ignore the
> > > table with the ID and LA values, leaving that to the memory controller
> > > driver?
> > 
> > The IOMMU driver still needs the list of clients so that it can enable
> > translation for each of the clients pertaining to a given group. That
> > is, if display controller A requests IOVA translation this maps to
> > TEGRA_SWGROUP_DC, but internally in order for the translation to
> > actually happen we also need to enable IOVA translation for each of the
> > clients in that group.
> > 
> > Note that we do share the memory clients table between the MC and the
> > IOMMU drivers, so there's not actually any duplication there.
> 
> This again comes down to the question of whether you have one device
> node per client or one device node per group, so let's focus on that
> question and then make a decision based on that. The other discussion
> points are at this stage not important, so if you can convince me that
> doing one node per group is better than one node per id, I'd be happy
> to take your patches (with a summary of the discussion added to the
> merge commit).
> 
> The IOMMU core explictly understands the concept of IOMMU groups that
> share a translation between multiple clients, and this would seem like
> the best fit for the hardware you describe, but evidently you came to
> a different conclusion, as you have more knowledge of the details behind
> it. I can see that most groups have only one ID, but there are a few
> that have up to four clients:
> 
> $ git show 37d21f8918f2aa2289036cc778ee188951e53288 | grep swgroup | uniq -c  | grep -v reg.= | grep -v 1 | sort | uniq -c
>       1       2 +               .swgroup = TEGRA_SWGROUP_A9AVP,
>       1       2 +               .swgroup = TEGRA_SWGROUP_EMUCIF,
>       2       2 +               .swgroup = TEGRA_SWGROUP_G2,
>       1       2 +               .swgroup = TEGRA_SWGROUP_GPU,
>       3       2 +               .swgroup = TEGRA_SWGROUP_HC,
>       2       2 +               .swgroup = TEGRA_SWGROUP_NV,
>       6       2 +               .swgroup = TEGRA_SWGROUP_PPCS,
>       2       2 +               .swgroup = TEGRA_SWGROUP_TSEC,
>       1       2 +               .swgroup = TEGRA_SWGROUP_VIC,
>       2       2 +               .swgroup = TEGRA_SWGROUP_XUSB_DEV,
>       2       2 +               .swgroup = TEGRA_SWGROUP_XUSB_HOST,
>       2       3 +               .swgroup = TEGRA_SWGROUP_EPP,
>       1       3 +               .swgroup = TEGRA_SWGROUP_ISP2,
>       1       3 +               .swgroup = TEGRA_SWGROUP_ISP2B,
>       1       3 +               .swgroup = TEGRA_SWGROUP_MPE,
>       1       4 +               .swgroup = TEGRA_SWGROUP_NV,
>       6       4 +               .swgroup = TEGRA_SWGROUP_VDE,
>       2       4 +               .swgroup = TEGRA_SWGROUP_VI,
> 
> Are all of these devices where you'd naturally describe each
> group as a single device node in DT?

I think that listing mixes together the mc_clients and swgroups tables.
Other than that, yes, each of these groups would be a single device tree
node. See also the examples above.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/fbd36bc8/attachment.sig>
