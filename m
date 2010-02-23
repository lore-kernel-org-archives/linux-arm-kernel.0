From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 11:41:16 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E13E7@dbde02.ent.ti.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C42E13E7@dbde02.ent.ti.com>
Message-ID: <20100223114116.GB10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 05:05:31PM +0530, Shilimkar, Santosh wrote:
> OMAP3 and family would be ok with this much needed mandatory barriers
> but for OMAP4, we need platform specified barriers as you mentioned. Will
> have a look at this series and do some testing on OMAP4. Will send
> a follow up patch then.

Wait for v2 - it introduces barriers onto the older CPUs which do not
need it, and therefore is definitely not right.

Eg, ARMv4 CPUs don't need the drain-write-buffer instruction for mb()
and wmb() - we have no relaxed behaviours on those CPUs, so this is
pointless.  As I also pointed out, it breaks ARMv3 because the drain-
write-buffer instruction there is an undefined instruction.

Plus, non-coherent Xscale has the same requirements as ARMv4, so getting
rid of the arch_is_coherent() stuff was completely wrong.

Basically, the patch is not suitable as it currently stands, and is in
need of rework.
