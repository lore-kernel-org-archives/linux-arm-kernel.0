From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 12 Nov 2015 15:31:50 +0000
Subject: [PATCH 2/3] arm64: reimplement page_is_ram() using memblock and
 UEFI memory map
In-Reply-To: <1446126059-25336-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
 <1446126059-25336-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151112153150.GC2681@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Oct, at 02:40:58PM, Ard Biesheuvel wrote:
> This patch overrides the __weak default implementation of page_is_ram(),
> which uses string comparisons to find entries called 'System RAM' in
> /proc/iomem. Since we used the contents of memblock to create those entries
> in the first place, let's use memblock directly.
> 
> Also, since the UEFI memory map may describe regions backed by RAM that are
> not in memblock (i.e., reserved regions that were removed from the linear
> mapping), check the pfn against the UEFI memory map as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/mmu.c | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
 
Am I correct in thinking that the purpose of this series is just to
placate acpi_os_ioremap() on arm64, and its use of page_is_ram()?

While there aren't many users of page_is_ram() right now, I can see
how in the future if new users are added they'd be extremely confused
to find that page_is_ram(pfn) returns true but 'pfn' isn't accessible
by the kernel proper.

Wouldn't it make more sense to teach acpi_os_ioremap() about these
special reserved regions outside of page_is_ram()?
