From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Oct 2014 14:13:25 +0000
Subject: No subject
Message-ID: <20141028141325.GE9796@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bcc:
Subject: Re: [PATCHv4 7/7] arm64: add better page protections to arm64
Reply-To:
In-Reply-To: <1414440752-9411-8-git-send-email-lauraa@codeaurora.org>

Hi Laura,

On Mon, Oct 27, 2014 at 08:12:32PM +0000, Laura Abbott wrote:
> Add page protections for arm64 similar to those in arm.
> This is for security reasons to prevent certain classes
> of exploits. The current method:
>
> - Map all memory as either RWX or RW. We round to the nearest
>   section to avoid creating page tables before everything is mapped
> - Once everything is mapped, if either end of the RWX section should
>   not be X, we split the PMD and remap as necessary
> - When initmem is to be freed, we change the permissions back to
>   RW (using stop machine if necessary to flush the TLB)
> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>   read only.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v4: Combined the Kconfig options
> ---
>  arch/arm64/Kconfig.debug            |  23 +++
>  arch/arm64/include/asm/cacheflush.h |   4 +
>  arch/arm64/kernel/vmlinux.lds.S     |  17 ++
>  arch/arm64/mm/init.c                |   1 +
>  arch/arm64/mm/mm.h                  |   2 +
>  arch/arm64/mm/mmu.c                 | 303 +++++++++++++++++++++++++++++++-----
>  6 files changed, 314 insertions(+), 36 deletions(-)

With this patch applied to v3.18-rc2, my board to blows up at boot when
using UEFI (without DEBUG_RODATA selected):

---->8----
EFI stub: Booting Linux Kernel...
Initializing cgroup subsys cpu
Linux version 3.18.0-rc2+ (mark at leverpostej) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) ) #112 SMP PREEMPT Tue Oct 28 13:58:41 GMT 2014
CPU: AArch64 Processor [410fd030] revision 0
Detected VIPT I-cache on CPU0
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
EFI v2.40 by ARM Juno EFI Oct  7 2014 15:05:42
efi:  ACPI=0xfebdc000  ACPI 2.0=0xfebdc014
cma: Reserved 16 MiB at fd800000
BUG: failure at arch/arm64/mm/mmu.c:234/alloc_init_pmd()!
Kernel panic - not syncing: BUG!
CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc2+ #112
Call trace:
[<ffffffc000087ec8>] dump_backtrace+0x0/0x124
[<ffffffc000087ffc>] show_stack+0x10/0x1c
[<ffffffc0004ebd58>] dump_stack+0x74/0xb8
[<ffffffc0004eb018>] panic+0xe0/0x220
[<ffffffc0004e8e08>] alloc_init_pmd+0x1cc/0x1dc
[<ffffffc0004e8e3c>] alloc_init_pud+0x24/0x6c
[<ffffffc0004e8f54>] __create_mapping+0xd0/0xf0
[<ffffffc00069a0a0>] create_id_mapping+0x5c/0x68
[<ffffffc00069964c>] efi_idmap_init+0x54/0xd8
[<ffffffc0006978a8>] setup_arch+0x408/0x5c0
[<ffffffc00069566c>] start_kernel+0x94/0x3a0
---[ end Kernel panic - not syncing: BUG!
---->8----

I've not yet figured out precisely why. I haven't tried a !EFI boot
because of the way my board is set up at the moment.

Mark.
