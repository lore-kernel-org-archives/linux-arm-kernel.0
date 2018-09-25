From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 25 Sep 2018 13:48:50 -0500
Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <815a32a5-483c-576c-8483-54042a84d5bd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/21/2018 02:59 PM, Marc Zyngier wrote:
> The GICv3 architecture has the remarkable feature that once LPI tables
> have been assigned to redistributors and that LPI delivery is enabled,
> there is no guarantee that LPIs can be turned off (and most
> implementations do not allow it), nor can it be reprogrammed to use
> other tables.
> 
> This is a bit of a problem for kexec, where the secondary kernel
> completely looses track of the previous allocations. If the secondary
> kernel doesn't allocate the tables exactly the same way, no LPIs will
> be delivered by the GIC (which continues to use the old tables), and
> memory previously allocated for the pending tables will be slowly
> corrupted, one bit at a time.
> 
> The workaround for this is based on a series[1] by Ard Biesheuvel,
> which adds the required infrastructure for memory reservations to be
> passed from one kernel to another using an EFI table.
> 
> This infrastructure is then used to register the allocation of GIC
> tables with EFI, and allow the GIC driver to safely reuse the existing
> programming if it detects that the tables have been correctly
> registered. On non-EFI systems, there is not much we can do.
> 
> This has been tested on a TX2 system both as a host and a guest. I'd
> welcome additional testing of different HW. For convenience, I've
> stashed a branch containing the whole thing at [2].

When combined with Ard's patch set, this fixes kdump on a QC machine.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks,

> 
> [1] https://marc.info/?l=linux-efi&m=153754757208163&w=2
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
> 
> Marc Zyngier (10):
>    irqchip/gic-v3-its: Change initialization ordering for LPIs
>    irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ usage
>    irqchip/gic-v3-its: Split property table clearing from allocation
>    irqchip/gic-v3-its: Move pending table allocation to init time
>    irqchip/gic-v3-its: Keep track of property table's PA and VA
>    irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
>    irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump
>      kernels
>    irqchip/gic-v3-its: Check that all RDs have the same property table
>    irqchip/gic-v3-its: Register LPI tables with EFI config table
>    irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
> 
>   drivers/irqchip/irq-gic-v3-its.c   | 249 ++++++++++++++++++++++-------
>   drivers/irqchip/irq-gic-v3.c       |  20 ++-
>   include/linux/irqchip/arm-gic-v3.h |   4 +-
>   3 files changed, 208 insertions(+), 65 deletions(-)
> 
