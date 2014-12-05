From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 19:12:35 +0000
Subject: [PATCH] arm64: respect mem= for EFI
In-Reply-To: <1417692140-29796-1-git-send-email-mark.rutland@arm.com>
References: <1417692140-29796-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20141205191235.GH31222@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 11:22:20AM +0000, Mark Rutland wrote:
> Hi all,
> 
> While trying to debug a userspace test failure, I noticed that the mem=
> option didn't work when booting via EFI due to some unfortunate init
> ordering.
> 
> However, with that alone fixed (patch below) things blow up early if a
> mem= option is passed to the kernel, because of the way we currently map
> the EFI runtime services.
> 
> I've given this patch a spin atop of Ard's rework of the runtime
> services mapping [1], and that's far happier; I can boot to userspace
> and memory is limited int he way I expect.
> 
> Assuming people are fine with this, would this make sense to append to
> the runtime services mapping series?
> 
> Cheers,
> Mark.
> 
> [1] https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/efi-for-arm64
> 
> ---->8----
> When booting with EFI, we acquire the EFI memory map after parsing the
> early params. This unfortuantely renders the option useless as we call
> memblock_enforce_memory_limit (which uses memblock_remove_range behind
> the scenes) before we've added any memblocks. We end up removing
> nothing, then adding all of memory later when efi_init calls
> reserve_regions.
> 
> Instead, we can log the limit and apply this later when we do the rest
> of the memblock work in memblock_init, which should work regardless of
> the presence of EFI. At the same time we may as well move the early
> parameter into arm64's mm/init.c, close to arm64_memblock_init.
> 
> Any memory which must be mapped (e.g. for use by EFI runtime services)
> must be mapped explicitly reather than relying on the linear mapping,
> which may be truncated as a result of a mem= option passed on the kernel
> command line.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
