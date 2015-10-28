From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 17:26:19 +0000
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <563101DD.8080508@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <563101DD.8080508@codeaurora.org>
Message-ID: <20151028172619.GA26777@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:11:57PM -0500, Timur Tabi wrote:
> On 10/27/2015 09:06 PM, Ard Biesheuvel wrote:
> >
> >diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> >index 816120ece6bc..a60ce249cfc0 100644
> >--- a/arch/arm64/kernel/efi-stub.c
> >+++ b/arch/arm64/kernel/efi-stub.c
> >@@ -42,7 +42,8 @@
> >                  * Mustang), we can still place the kernel at the address
> >                  * 'dram_base + TEXT_OFFSET'.
> >                  */
> >-               *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> >+               *image_addr = *reserve_addr = round_up(dram_base, SZ_2M) +
> >+                                                      TEXT_OFFSET);
> >                 nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
> >                            EFI_PAGE_SIZE;
> >                 status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
> 
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

I assume with the trailing ')' removed. ;)

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> However, I think this formatting is easier to read:
> 
> 		*image_addr = *reserve_addr =
> 			round_up(dram_base, SZ_2M) + TEXT_OFFSET;

I have no strong feeling on this either way.

> This does make the kernel boot, but we suspect that there may be
> another problem.  We need to investigate it, but we have a suspicion
> that the EFI stub is trying to allocate from the Runtime Data block,
> and the alignment adjustment "fixes" the problem by moving the
> pointer to Conventional Memory.

I don't follow. EFI_BOOT_SERVICES.AllocatePages() should only give us
pages which are available, so it shouldn't ever return pages which are
runtime data -- it would fail and we'd fall back to efi_low_alloc().

Could you elaborate?

> Anyway, is there any chance we can get this fix into 4.3?  I'd hate
> to have 4.3 released knowing that it's broken on our hardware.

It's probably too late now, but it should certainly be Cc'd stable and
get backported.

Thanks,
Mark.
