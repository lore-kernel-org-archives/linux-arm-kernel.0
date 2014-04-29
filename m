From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 29 Apr 2014 08:55:35 +0300
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <20140428103919.GF19455@ulmo>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
 <4447051.OnJtcFSqFV@wuerfel> <20140428103919.GF19455@ulmo>
Message-ID: <87eh0gd6i0.fsf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thierry Reding <thierry.reding@gmail.com> writes:

> * PGP Signed by an unknown key
>
> On Sun, Apr 27, 2014 at 08:23:06PM +0200, Arnd Bergmann wrote:
>> On Sunday 27 April 2014 13:07:43 Shaik Ameer Basha wrote:
>> > +- mmu-masters: A phandle to device nodes representing the master for which
>> > +               the System MMU can provide a translation. Any additional values
>> > +              after the phandle will be ignored because a System MMU never
>> > +              have two or more masters. "#stream-id-cells" specified in the
>> > +              master's node will be also ignored.
>> > +              If more than one phandle is specified, only the first phandle
>> > +              will be treated.
>> 
>> This seems completely backwards: Why would you list the masters for an IOMMU
>> in the IOMMU node?
>> 
>> The master should have a standard property pointing to the IOMMU instead.
>> 
>> We don't have a generic binding for IOMMUs yet it seems, but the time is
>> overdue to make one.
>> 
>> Consider this NAKed until there is a generic binding for IOMMUs that all
>> relevant developers have agreed to.
>
> I'd like to take this opportunity and revive one of the hibernating
> patch sets that we have for Tegra. The last effort to get things merged
> was back in January I think. I haven't bothered to look up the reference
> since it's probably good to start from scratch anyway.
>
> The latest version of the binding that was under discussion back then I
> think looked something like this:
>
> 	device at ... {
> 		iommus = <&iommu [spec]>[, <&other_iommu [other_spec]>...];
> 	};
>
> And possibly with a iommu-names property to go along with that. The idea
> being that a device can be a master on possibly multiple IOMMUs. Using
> the above it would also be possible to have one device be multiple
> masters on the same IOMMU.
>
> On Tegra the specifier would be used to encode a memory controller's
> client ID. One discussion point back at the time was to encode the ID as
> a bitmask to allow more than a single master per entry. Another solution
> which I think is a little cleaner and more generic, would be to use one
> entry per master and use a single cell to encode the client ID. Devices
> with multiple clients to the same IOMMU could then use multiple entries
> referencing the same IOMMU.
>
> I've added Hiroshi Doyu on Cc since he knows the Tegra IOMMU best.
> Hiroshi, can you summarize exactly what the proposed bindings were. If
> my memory serves me well they were mostly along the lines of what Arnd
> proposes here, and perhaps they are something that can also be used for
> Exynos.

You can find the detail from:

[PATCHv7 09/12] iommu/tegra: smmu: get swgroups from DT "iommus="
  http://lists.linuxfoundation.org/pipermail/iommu/2013-December/007212.html

You can specify any parameters which your iommu requires from a device,
and a device(master) can have multiple IOMMUs.

 	device at ... {
 		iommus = <&iommu [spec]>[, <&other_iommu [other_spec]>...];
 	};
