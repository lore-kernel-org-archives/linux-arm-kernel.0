From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Feb 2015 16:22:37 +0000
Subject: [RFC PATCH] arm64: mm: increase VA range of identity map
In-Reply-To: <CAKv+Gu_zPFy78pGjnMFr2pK4jfAgUqFxMDjN0EoDPF0+0a=bdg@mail.gmail.com>
References: <1424775342-30588-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150224120341.GC27420@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-z9ZpOxMsrZ4mg=ZB-ftVe2kNiY5rci8Yk_W_U-OXqnA@mail.gmail.com>
 <20150224144316.GD27420@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_zPFy78pGjnMFr2pK4jfAgUqFxMDjN0EoDPF0+0a=bdg@mail.gmail.com>
Message-ID: <20150224162237.GE27420@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 02:53:07PM +0000, Ard Biesheuvel wrote:
> On 24 February 2015 at 14:43, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Feb 24, 2015 at 12:18:26PM +0000, Ard Biesheuvel wrote:
> >> On 24 February 2015 at 12:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Tue, Feb 24, 2015 at 10:55:42AM +0000, Ard Biesheuvel wrote:
> >> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> >> index f800d45ea226..19f6297a472b 100644
> >> >> --- a/arch/arm64/include/asm/memory.h
> >> >> +++ b/arch/arm64/include/asm/memory.h
> >> >> @@ -42,12 +42,14 @@
> >> >>   * PAGE_OFFSET - the virtual address of the start of the kernel image (top
> >> >>   *            (VA_BITS - 1))
> >> >>   * VA_BITS - the maximum number of bits for virtual addresses.
> >> >> + * MAX_VA_BITS - architectural max value for VA_BITS
> >> >>   * TASK_SIZE - the maximum size of a user space task.
> >> >>   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
> >> >>   * The module space lives between the addresses given by TASK_SIZE
> >> >>   * and PAGE_OFFSET - it must be within 128MB of the kernel text.
> >> >>   */
> >> >>  #define VA_BITS                      (CONFIG_ARM64_VA_BITS)
> >> >> +#define MAX_VA_BITS          48
> >> >
> >> > Can we determine this dynamically based on the phys address? So on
> >> > hardware that doesn't need such large idmap, it would stick to the host
> >> > configured levels.
> >>
> >> I guess we could. Is there a benefit to keeping TCR.T0SZ as high as
> >> possible if you are adding the additional level anyway?
> >> It only costs us one page regardless, and only if the runtime check
> >> shows that system RAM exceeds VA_BITS
> >
> > It's not the page that we may waste in the idmap table but higher T0SZ
> > implies deeper translation tables, so an additional page table walk
> > during power up/down sequences.
> 
> OK, but the patch only modifies T0SZ from the default if the system
> RAM is observed to be out of reach at runtime, and so MAX_VA_BITS is
> only used in that case. For both 4k and 64k pages, this will configure
> one additional level of translation.

Ah, I missed the cbz over the idmap_t0sz setting in your patch.

> Does it still matter then which
> exact T0SZ value is used between the possible values that all
> correspond with 4 levels, for instance?

Not really, we go for a maximum of one extra level anyway.

-- 
Catalin
