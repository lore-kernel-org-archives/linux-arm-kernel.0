From: john.stultz@linaro.org (John Stultz)
Date: Mon, 24 Sep 2018 11:52:54 -0700
Subject: [RFC/PATCH] arm64: Fix /proc/iomem for reserved but not memory
 regions
In-Reply-To: <20180910141636.21813-1-james.morse@arm.com>
References: <20180910141636.21813-1-james.morse@arm.com>
Message-ID: <CALAqxLX6oadOT80qCyj-P0ZBMJvTt1XZ-viM1uw34BrofHmOVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 7:16 AM, James Morse <james.morse@arm.com> wrote:
> commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via
> /proc/iomem") wrongly assumed that memblock_reserve() would not be used to
> reserve regions that aren't memory. It turns out, this is exactly what
> early_init_dt_reserve_memory_arch() will do if it finds a reservation
> that was also carved out of the memory node.
>
> reserve_memblock_reserved_regions() now needs to cope with reserved regions
> that aren't memory, which means we must walk two lists at once.
>
> We can't use walk_system_ram_res() and reserve_region_with_split()
> together, as the former hands its callback a copied resource on
> the stack, where as the latter expects the in-tree resource to be
> provided.
>
> Allocate an array of struct resources during request_standard_resources()
> so that we have all the 'System RAM' regions on hand.
>
> Increasing the mem_idx cursor is optional as multiple memblock_reserved()
> regions may exist in one System RAM region.
> Because adjacent memblock_reserved() regions will be merged, we also need
> to consider multiple System RAM regions for one span of memblock_reserved()
> address space.
>
> Fixes: 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
> Reported-by: John Stultz <john.stultz@linaro.org>
> CC: Akashi Takahiro <takahiro.akashi@linaro.org>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> John, any chance you could give this a test on the platform that the warning
> fires on? Thanks!


Seems to fix it.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
