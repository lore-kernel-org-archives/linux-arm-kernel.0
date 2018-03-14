From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 14 Mar 2018 12:43:02 +0000
Subject: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
In-Reply-To: <d6497158-c58f-4fd4-4613-699fb2af7a61@gmail.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
 <d6497158-c58f-4fd4-4613-699fb2af7a61@gmail.com>
Message-ID: <20180314124302.GL4589@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 09:41:17PM +0100, Brice Goglin wrote:
> 
> > Is there a good reason for diverging instead of adjusting the
> > core_sibling mask? On x86 the core_siblings mask is defined by the last
> > level cache span so they don't have this issue. 
> 
> No. core_siblings is defined as the list of cores that have the same
> physical_package_id (see the doc of sysfs topology files), and LLC can
> be smaller than that.
> Example with E5v3 with cluster-on-die (two L3 per package, core_siblings
> is twice larger than L3 cpumap):
> https://www.open-mpi.org/projects/hwloc/lstopo/images/2XeonE5v3.v1.11.png
> On AMD EPYC, you even have up to 8 LLC per package.

Right, I missed the fact that x86 reports a different cpumask for
topology_core_cpumask() which defines the core_siblings exported through
sysfs than the mask used to define MC level in the scheduler topology.
The sysfs core_siblings is defined by the package_id, while the MC level
is defined by the LLC.

Thanks for pointing this out.

On arm64 MC level and sysfs core_siblings are currently defined using
the same mask, but we can't break sysfs, so using different masks is the
only option.

Morten 
