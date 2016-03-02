From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2016 02:17:10 +0000
Subject: [PATCH 1/2] topology, cleanup: Avoid redefinition of
 cpumask_of_pcibus in asm header files.
In-Reply-To: <1456358528-24213-2-git-send-email-ddaney.cavm@gmail.com>
References: <1456358528-24213-1-git-send-email-ddaney.cavm@gmail.com>
 <1456358528-24213-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160302021710.GJ14022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 04:02:07PM -0800, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> At present cpumask_of_pcibus is defined for !CONFIG_NUMA and moving out
> to common will allow to use for numa too. This also avoids
> redefinition of this macro in respective architecture header files.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/include/asm/topology.h   | 3 ---
>  arch/ia64/include/asm/topology.h    | 4 ----
>  arch/metag/include/asm/topology.h   | 3 ---
>  arch/powerpc/include/asm/topology.h | 4 ----
>  arch/s390/include/asm/pci.h         | 2 +-
>  arch/s390/include/asm/topology.h    | 1 +
>  arch/sh/include/asm/topology.h      | 3 ---
>  arch/tile/include/asm/pci.h         | 2 --
>  arch/tile/include/asm/topology.h    | 3 +++
>  arch/x86/include/asm/pci.h          | 2 +-
>  arch/x86/include/asm/topology.h     | 1 +
>  include/asm-generic/topology.h      | 4 ++--
>  12 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 8b57339..6e1f62c 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -26,9 +26,6 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
>  
>  struct pci_bus;
>  int pcibus_to_node(struct pci_bus *bus);
> -#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
> -				 cpu_all_mask :				\
> -				 cpumask_of_node(pcibus_to_node(bus)))
>  
>  #endif /* CONFIG_NUMA */

Looks like a sensible clean up to me (on top of the arm64 NUMA patches):

Acked-by: Will Deacon <will.deacon@arm.com>

Will
