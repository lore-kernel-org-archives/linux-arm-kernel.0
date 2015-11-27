From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Nov 2015 09:32:50 +0000
Subject: [PATCH v3 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <CAPAsAGyJr5OD+_4TO9dt2EwOGUGewEy4bAmhFhDbP3RJ+6QxaA@mail.gmail.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <1447888808-31571-3-git-send-email-dcashman@android.com>
 <1447888808-31571-4-git-send-email-dcashman@android.com>
 <20151123150459.GD4236@arm.com> <56536114.1020305@android.com>
 <20151125120601.GC3109@e104818-lin.cambridge.arm.com>
 <56561C71.30602@android.com>
 <CAPAsAGyJr5OD+_4TO9dt2EwOGUGewEy4bAmhFhDbP3RJ+6QxaA@mail.gmail.com>
Message-ID: <20151127093249.GW3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 11:36:30AM +0300, Andrey Ryabinin wrote:
> 2015-11-25 23:39 GMT+03:00 Daniel Cashman <dcashman@android.com>:
> > On 11/25/2015 04:06 AM, Catalin Marinas wrote:
> >> For KASan, we ended up calculating KASAN_SHADOW_OFFSET in
> >> arch/arm64/Makefile. What would the formula be for the above
> >> ARCH_MMAP_RND_BITS_MAX?
> >
> > The general formula I used ended up being:
> > _max = floor(log(TASK_SIZE)) - log(PAGE_SIZE) - 3
> 
> For kasan, we calculate KASAN_SHADOW_OFFSET in Makefile, because we need to use
> that value in Makefiles.
> 
> For ARCH_MMAP_RND_COMPAT_BITS_MIN/MAX I don't see a reason why it has
> to be in Kconfig.
> Can't we just use your formula to #define ARCH_MMAP_RND_COMPAT_BITS_*
> in some arch header?

Because there is another option, ARCH_MMAP_RND_BITS depending on EXPERT
which uses the MIN/MAX range defined per architecture. Since it's an
expert feature, we could as well ignore the MIN/MAX in Kconfig and just
add BUILD_BUG_ON checks to the code. This way we could simply define
them in C files.

Alternatively, add arithmetics support to kbuild ;).

-- 
Catalin
