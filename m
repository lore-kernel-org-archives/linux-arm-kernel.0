From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Dec 2016 18:57:17 +0000
Subject: [PATCH 1/1] arm64: mm: add config options for page table
 configuration
In-Reply-To: <762b8bec-60da-0bb8-28f4-b407ad70687b@broadcom.com>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
 <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
 <20161208100014.GE33075@MBP.local>
 <762b8bec-60da-0bb8-28f4-b407ad70687b@broadcom.com>
Message-ID: <20161208185717.GC15141@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 08:30:36AM -0800, Scott Branden wrote:
> On 16-12-08 02:00 AM, Catalin Marinas wrote:
> >On Wed, Dec 07, 2016 at 11:40:00AM -0800, Scott Branden wrote:
> >>Make MAX_PHYSMEM_BITS and SECTIONS_SIZE_BITS configurable by adding
> >>config options.
> >>Default to current settings currently defined in sparesmem.h.
> >>For systems wishing to save memory the config options can be overridden.
> >>Example, changing MAX_PHYSMEM_BITS from 48 to 36 at the same time as
> >>changing SECTION_SIZE_BITS from 30 to 26 frees 13MB of memory.
[...]
> > I would rather reduce SECTION_SIZE_BITS permanently where
> >feasible, like in this patch:
> >
> >http://lkml.kernel.org/r/1465821119-3384-1-git-send-email-jszhang at marvell.com
>
> This patch does not meet my requirements as I need SECTION_SIZE_BITS to be
> set to 28 to reduce memory

So with this patch, we reduce it to 27, it should be fine-grained enough
for 128MB sections. Alternatively, there were other suggestions here:

http://lkml.iu.edu/hypermail/linux/kernel/1604.1/03036.html

> and to allow memory hotplug to allocate a 256 MB section.

Can memory hotplug not work with 2*128MB sections in this case?

> My patch future proofs the tuning of the parameters by allowing
> any section size to be made. 

While MAX_PHYSMEM_BITS makes sense to users in general,
SECTION_SIZE_BITS is not always clear to the average user what it means
and its min/max boundaries. That's another reason (apart from single/few
Image case) why I prefer to not expose it as configuration option.

> I could combine the patch you list such that
> SECTION_SIZE_BITS defaults to 30 when CONFIG_ARM64_64_PAGES is selected and
> 27 otherwise.  Should it default to something else for 16K and 4K pages?

I haven't done any calculations for 16K yet but we could probably come
up with some formula based on PAGE_SHIFT to cover all cases.

> In terms of MAX_PHYSMEM_BITS, if our SoCs only use 40 (or less) bits I would
> also like the configuration functionality.  This allows us to make the
> SECTION_SIZE_BITS smaller.

So how small do you want SECTION_SIZE_BITS to be? As I said above, 128MB
sections should be sufficient in most cases and without the need to
reduce MAX_PHYSMEM_BITS.

-- 
Catalin
