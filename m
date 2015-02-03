From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 3 Feb 2015 12:39:32 +0200
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <20150203011730.GA15653@node.dhcp.inet.fi>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
 <20150203011730.GA15653@node.dhcp.inet.fi>
Message-ID: <20150203103932.GA14259@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 03:17:30AM +0200, Kirill A. Shutemov wrote:
> Results for 10 runs on my laptop -- i5-3427U (IvyBridge 1.8 Ghz, 2.8Ghz Turbo
> with 3MB LLC):

I've screwed up the inner loop condition and step. As result the benchmark
touches the same cache line 8 times and scan SIZE/8 of memory. Fixed test
is in attach.
				Avg		Stddev
baseline			14.0663		0.0182
-DCHECK_BEFORE_SET		13.8594		0.0458
-DCACHE_HOT			12.3896		0.0867
-DCACHE_HOT -DCHECK_BEFORE_SET	11.7480		0.2497

And now it's faster *with* the check. Sometimes CPU is just too clever. ;)

-- 
 Kirill A. Shutemov
-------------- next part --------------
#include <stdio.h>
#include <time.h>
#include <sys/mman.h>

#ifdef CACHE_HOT
#define SIZE (2UL << 20)
#define TIMES 100000
#else
#define SIZE (1UL << 30)
#define TIMES 100
#endif

#define CACHE_LINE 64

int main(int argc, char **argv)
{
	struct timespec a, b, diff;
	unsigned long i, *p, times = TIMES;

	p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
			MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
	
	clock_gettime(CLOCK_MONOTONIC, &a);
	while (times--) {
		for (i = 0; i < SIZE / sizeof(*p);
				i += CACHE_LINE / sizeof(*p)) {
#ifdef CHECK_BEFORE_SET
			if (p[i] != times)
#endif
				p[i] = times;
		}
	}
	clock_gettime(CLOCK_MONOTONIC, &b);

	diff.tv_sec = b.tv_sec - a.tv_sec;
	if (a.tv_nsec > b.tv_nsec) {
		diff.tv_sec--;
		diff.tv_nsec = 1000000000 + b.tv_nsec - a.tv_nsec;
	} else
		diff.tv_nsec = b.tv_nsec - a.tv_nsec;

	printf("%lu.%09lu\n", diff.tv_sec, diff.tv_nsec);
	return 0;
}
