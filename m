From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Jun 2017 19:20:44 +0100
Subject: [PATCH v2] arm64: kernel: restrict /dev/mem read() calls to
 linear region
In-Reply-To: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
References: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
Message-ID: <20170601182044.GF16599@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, May 19, 2017 at 04:42:00PM +0100, Ard Biesheuvel wrote:
> When running lscpu on an AArch64 system that has SMBIOS version 2.0
> tables, it will segfault in the following way:
> 
>   Unable to handle kernel paging request at virtual address ffff8000bfff0000
>   pgd = ffff8000f9615000
>   [ffff8000bfff0000] *pgd=0000000000000000
>   Internal error: Oops: 96000007 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>   task: ffff8000fa78e800 task.stack: ffff8000f9780000
>   PC is at __arch_copy_to_user+0x90/0x220
>   LR is at read_mem+0xcc/0x140
> 
> This is caused by the fact that lspci issues a read() on /dev/mem at the
> offset where it expects to find the SMBIOS structure array. However, this
> region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
> and so it is omitted from the linear mapping.
> 
> So let's restrict /dev/mem read/write access to those areas that are
> covered by the linear region.
> 
> Reported-by: Alexander Graf <agraf@suse.de>
> Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: check whether the entire region is covered by the same memblock that has
>     the MEMBLOCK_NOMAP attribute cleared
> 
>  arch/arm64/mm/mmap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Thanks. I'll stick this into -next and see how we do.

Will
