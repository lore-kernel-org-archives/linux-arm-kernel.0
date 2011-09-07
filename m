From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 7 Sep 2011 12:49:06 +0300
Subject: [RFC 7/7] iommu/core: split mapping to page sizes as supported by
	the hardware
In-Reply-To: <CAHQjnOMnOjAJ6QuuLmLa1UKvTRHfyyjiUYrfvzLx8FSsCixxng@mail.gmail.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-8-git-send-email-ohad@wizery.com>
	<CAHQjnOMT3UOFMi=JbSXf4-s_BbZ+fSGbOEjxwT7t7N-zd+9-zg@mail.gmail.com>
	<CAK=WgbZPFryzCFLa5AhAYDmH1S8c3x-OsSTyxYeq0WLAe8VyTg@mail.gmail.com>
	<CAHQjnOMnOjAJ6QuuLmLa1UKvTRHfyyjiUYrfvzLx8FSsCixxng@mail.gmail.com>
Message-ID: <CAK=Wgbayt0D8u8u_t=Zs=15A0YBjKX3RUNtWFKVCOxEOKvH7fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending due to mailer-daemon errors I got, sorry]

Hi KyongHo,

On Wed, Sep 7, 2011 at 11:05 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> However, it is faster because it does not calculate the given order and
> not call any function.

Hmm this sounds a bit like a red herring to me; optimization of the
map function is not the main subject here. Especially not when we're
discussing mapping of large physically contiguous memory regions which
do not happen too often.

But generally I don't think that duplicating code and eliminating
function calls is a good optimization (the compiler can do that for
us..). Moreover, it looks like s5p_iommu_map() gives a higher priority
for bigger pages first, and only reaches 4KB pages after it tried all
other supported pages. IMHO that's sub-optimal, because small mappings
are more common than big ones.

Another advantage for migrating s5p_iommu_map() over to the subject
patch, is that s5p_iommu_map() doesn't support super sections yet. To
support it, you'd need to add more code (duplicate another while
loop). But if you migrated to the subject patch, then you would only
need to flip the 16MB bit when you advertise page size capabilities
and then that's it; you're done.

> It is a logical error because the caller of iommu_map() gives
> 4KB aligned physical address while saying that it is 64KB aligned.

The caller of iommu_map() doesn't say anything about alignments. It
just gives it a memory region to map, and expect things to just work.

Obviously it's better if big physically contiguous mapping will be
aligned to big pages, but things can still work even if it's not, by
using smaller pages. No reason not to provide this flexibility.

The only requirement the IOMMU API should have is the minimum 4KB
alignment, because IOMMU hardware does not support smaller pages.

Thanks,
Ohad.
