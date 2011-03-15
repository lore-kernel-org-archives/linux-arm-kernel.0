From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Mar 2011 22:42:08 +0000
Subject: [PATCH] ARMv7: Flush the vectors page using the base address
In-Reply-To: <20110315184519.GA3620@n2100.arm.linux.org.uk>
References: <20110315181314.26384.97754.stgit@e102109-lin.cambridge.arm.com>
	<20110315184519.GA3620@n2100.arm.linux.org.uk>
Message-ID: <AANLkTingxwvRwKP_Q0o-+XZwoGtzGeGg-goiCgF9cqf0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, 15 March 2011, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 15, 2011 at 06:13:15PM +0000, Catalin Marinas wrote:
>> With the domains removal patch, the vectors page is populated using the
>> kernel linear mapping address. However, the flush_icache_range()
>> function must be called on the high vectors address because the I-cache
>> is allowed to have aliases (or can even be ASID-tagged VIVT).
>
> This is exactly one of the issues I raised when we went down this hacky
> path of always doing this crap.

I don't think we have better options but feel free to rewrite it.

> What you're now doing is missing the D-cache flush in the case of an
> aliasing D-cache. ?It's no better than it was before.

In cases where we have domains disabled (ARMv7), the D-cache is
non-aliasing, so there is no issue.

Even if we enable this code for other cache configurations, we can
always flush both aliases. This only happen during boot and I doubt
you would notice any delay.

Catalin

-- 
Catalin
