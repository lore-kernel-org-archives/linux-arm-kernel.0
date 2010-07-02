From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Jul 2010 15:17:23 +0100
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <20100702184848.GH2357@wear.picochip.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
	<004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
	<20100702184848.GH2357@wear.picochip.com>
Message-ID: <004501cb19f1$4a9a25a0$dfce70e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  Performance counter stats for 'git status':
> >
> >          3650781413  cycles
> >           289950734  instructions             #      0.079 IPC
> >              144882  context-switches
> >               13677  page-faults
> >           473580406  branches
> >
> >        82.426290000  seconds time elapsed
> >
> >
> > Which looks insane to me. The IPC is appalling and we've taken
> > more branches than we've executed instructions!
> No, that certainly doesn't look right. Referring back your earlier email, when
> we do the cmpxchng, shouldn't it get sign extended then? An atomic64_t should
> be signed, but looking at the arm implementation, we're using u64's. Could
> this have anything to do with it? The generic implementation in lib/atomic64.c
> uses 'long long's.

It's a 64-bit cmpxchg and we're passing in 64-bit arguments so I don't
think any sign-extension should occur. The real issue is that we're taking
the difference between two u32 quantities (prev_raw_count and new_raw_count)
but using s64s, so when the delta is shifted right we treat the u32s as signed
when they're not.
 
> Providing that the sign extension does work, I've had a quick play with some
> uint64_t's and int64_t's in userspace and I think the algorithm is ok. Is the
> assumption of atomic64_t's being signed wrong?

I don't think the signedness of atomic64_t actually matters because everything
is handled in assembly anyway.

If you do something like:

#include <stdio.h>

typedef unsigned long u32;
typedef signed long long s64;
typedef unsigned long long u64;

int main(void)
{
	u64 x = 0xffffffff;
	u64 y = 0x0fffffff;
	s64 z = (x << 32) - (y << 32);
	z >>= 32;
	printf("0x%llx\n", z);
	return 0;
}

You'll get the sign-extended number printed out. Actually, a much neater
fix to this problem is to make delta unsigned and leave everything else
as-is (although I'm not a massive fan of all the 64-bit shifting).

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c457686..de12536 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -201,7 +201,7 @@ armpmu_event_update(struct perf_event *event,
 {
        int shift = 64 - 32;
        s64 prev_raw_count, new_raw_count;
-       s64 delta;
+       u64 delta;
 
 again:
        prev_raw_count = atomic64_read(&hwc->prev_count);


What do you think?

Will
