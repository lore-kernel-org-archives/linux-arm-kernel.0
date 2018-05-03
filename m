From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 3 May 2018 16:12:55 +0100
Subject: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
In-Reply-To: <20180425233121.13270-14-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
Message-ID: <20180503151255.GB28409@work-enc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 06:31:21PM -0500, Jeremy Linton wrote:
> Now that we have an accurate view of the physical topology
> we need to represent it correctly to the scheduler. Generally MC
> should equal the LLC in the system, but there are a number of
> special cases that need to be dealt with.
> 
> In the case of NUMA in socket, we need to assure that the sched
> domain we build for the MC layer isn't larger than the DIE above it.
> Similarly for LLC's that might exist in cross socket interconnect or
> directory hardware we need to assure that MC is shrunk to the socket
> or NUMA node.
> 
> This patch builds a sibling mask for the LLC, and then picks the
> smallest of LLC, socket siblings, or NUMA node siblings, which
> gives us the behavior described above. This is ever so slightly
> different than the similar alternative where we look for a cache
> layer less than or equal to the socket/NUMA siblings.
> 
> The logic to pick the MC layer affects all arm64 machines, but
> only changes the behavior for DT/MPIDR systems if the NUMA domain
> is smaller than the core siblings (generally set to the cluster).
> Potentially this fixes a possible bug in DT systems, but really
> it only affects ACPI systems where the core siblings is correctly
> set to the socket siblings. Thus all currently available ACPI
> systems should have MC equal to LLC, including the NUMA in socket
> machines where the LLC is partitioned between the NUMA nodes.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

This patch looks good to me.

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
