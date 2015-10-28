From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Oct 2015 17:27:36 +0000
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <563101DD.8080508@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <563101DD.8080508@codeaurora.org>
Message-ID: <20151028172735.GL18966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:11:57PM -0500, Timur Tabi wrote:
> On 10/27/2015 09:06 PM, Ard Biesheuvel wrote:
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
> 
> However, I think this formatting is easier to read:
> 
> 		*image_addr = *reserve_addr =
> 			round_up(dram_base, SZ_2M) + TEXT_OFFSET;
> 
> This does make the kernel boot, but we suspect that there may be another
> problem.  We need to investigate it, but we have a suspicion that the EFI
> stub is trying to allocate from the Runtime Data block, and the alignment
> adjustment "fixes" the problem by moving the pointer to Conventional Memory.
> 
> Anyway, is there any chance we can get this fix into 4.3?  I'd hate to have
> 4.3 released knowing that it's broken on our hardware.

If you want something in for 4.3, you'll need to post a new patch in a
separate thread and I'd like to see at least Ard's ack on it.

Will
