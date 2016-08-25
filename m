From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 15:25:31 +0100
Subject: [PATCH] arm64: mark reserved memblock regions explicitly in iomem
In-Reply-To: <20160822065524.8085-1-takahiro.akashi@linaro.org>
References: <20160822065524.8085-1-takahiro.akashi@linaro.org>
Message-ID: <20160825142531.GF20748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 03:55:24PM +0900, AKASHI Takahiro wrote:
> Kdump(kexec-tools) parses /proc/iomem to identify all the memory regions
> on the system. Since the current kernel names "nomap" regions, like UEFI
> runtime services code/data, as "System RAM," kexec-tools sets up elf core
> header to include them in a crash dump file (/proc/vmcore).
> 
> Then crash dump kernel parses UEFI memory map again, re-marks those regions
> as "nomap" and does not create a memory mapping for them unlike the other
> areas of System RAM. In this case, copying /proc/vmcore through
> copy_oldmem_page() on crash dump kernel will end up with a kernel abort,
> as reported in [1].
> 
> This patch names all the "nomap" regions explicitly as "reserved" so that
> we can exclude them from a crash dump file. acpi_os_ioremap() must also
> be modified because those regions have WB attributes [2].
> 
> Apart from kdump, this change also matches x86's use of acpi (and
> /proc/iomem).
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448186.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450089.html
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h | 8 ++++++--
>  arch/arm64/kernel/setup.c     | 9 +++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)

The patch looks fine to me but it would be good if James gave it a try.
FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
