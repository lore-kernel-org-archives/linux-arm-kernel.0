From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Thu, 27 Sep 2018 15:25:17 +0530
Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <28640b87-007f-dc72-110a-a57179e2b76a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 09/22/2018 01:29 AM, Marc Zyngier wrote:
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

Thanks for the patchset. I can confirm that with Ard's patchset in [1] 
and this patchset applied on 'efi/next' branch, I see that the "Booted 
with LPIs enabled, memory probably corrupted" issue that I was seeing on 
gigabyte boards in kdump kernel is fixed. Here are some logs:

without patchset applied:
=========================

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, direct LPI support
[    0.000000] ITS [mem 0x801000020000-0x80100021ffff]
[    0.000000] ITS at 0x0000801000020000: allocated 2097152 Devices 
@c1000000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000000c03b0000
[    0.000000] GICv3: CPU0: found redistributor a region 
0:0x0000801080140000
[    0.000000] CPU0: Booted with LPIs enabled, memory probably corrupted
[    0.000000] CPU0: Failed to disable LPIs
<..snip..>
[  198.702976] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  199.332238] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  199.922944] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  200.512239] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
<..snip..>


with patchset applied:
======================
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 109 region 
0:0x0000801080320000
[    0.000000] ITS [mem 0x801000020000-0x80100021ffff]
[    0.000000] ITS at 0x0000801000020000: allocated 2097152 Devices 
@c1000000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: Using preallocated redistributor tables
[    0.000000] GICv3: using LPI property table @0x0000000fc0420000
[    0.000000] GICv3: CPU0: using reserved LPI pending table 
@0x0000000fc05c0000


So, please feel to add:
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh
