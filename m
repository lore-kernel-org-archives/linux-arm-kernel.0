From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Oct 2015 11:29:14 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <20151029112914.GB28221@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 02:43:54PM -0700, Alex Van Brunt wrote:
> This patchset reverts three patches that attempt to query the CPU for cache
> geometry and then make use of that information. Those patches rely on the
> NumSets and LineSize fields of CCSIDR to determine the cache geometry. However,
> the architectural documentation for these registers forbids such use:
> 
> 	The parameters NumSets, Associativity, and LineSize in these registers
> 	define the architecturally visible parameters that are required for the
> 	cache maintenance by Set/Way instructions. They are not guaranteed to
> 	represent the actual microarchitectural features of a design. You cannot
> 	make any inference about the actual sizes of caches based on these
> 	parameters.
> 
> It is not just theoretical. For example, the Denver CPU will report one set and
> one way in CCSIDR even though the actual microarchitectural implementation has
> many sets and many ways.
> 
> I have two suggestions for how to get the cache geometry on an ARMv8 processor:
>   1. Specify the information in the device tree. The purpose of the deivce tree
>      is to specify information that software cannot query at run-time. Becuase
>      the architecture does not have an architectural way to query the cache
>      geometry this may be a good fit.

We already have to detect the unification of caches via DT, so the geomtery
should probably live there too.

Thanks,
Mark.
