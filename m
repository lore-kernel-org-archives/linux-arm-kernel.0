From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Mar 2017 16:25:32 +0000
Subject: [PATCH 6/6] arm64: KVM: Add support for VPIPT I-caches
In-Reply-To: <aa5b11a4-2630-db44-e403-db7ef9bfa60c@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
 <1489177945-8590-6-git-send-email-will.deacon@arm.com>
 <aa5b11a4-2630-db44-e403-db7ef9bfa60c@arm.com>
Message-ID: <20170320162531.GA11066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 04:22:15PM +0000, Marc Zyngier wrote:
> On 10/03/17 20:32, Will Deacon wrote:
> > A VPIPT I-cache has two main properties:
> > 
> > 1. Lines allocated into the cache are tagged by VMID and a lookup can
> >    only hit lines that were allocated with the current VMID.
> > 
> > 2. I-cache invalidation from EL1/0 only invalidates lines that match the
> >    current VMID of the CPU doing the invalidation.
> > 
> > This can cause issues with non-VHE configurations, where the host runs
> > at EL1 and wants to invalidate I-cache entries for a guest running with
> > a different VMID. VHE is not affected, because the host runs at EL2 and
> > I-cache invalidation applies as expected.
> > 
> > This patch solves the problem by invalidating the I-cache when unmapping
> > a page at stage 2 on a system with a VPIPT I-cache but not running with
> > VHE enabled. Hopefully this is an obscure enough configuration that the
> > overhead isn't anything to worry about, although it does mean that the
> > by-range I-cache invalidation currently performed when mapping at stage
> > 2 can be elided on such systems, because the I-cache will be clean for
> > the guest VMID following a rollover event.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
[...]
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> It is worth noting that this now conflicts with 68925176296a ("arm64: 
> KVM: VHE: Clear HCR_TGE when invalidating guest TLBs"). I've resolved 
> it as such in my tree:

Thanks for the ack and conflict resolution. All patches applied to the
arm64 tree.

-- 
Catalin
