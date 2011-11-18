From: psandeep.s@gmail.com (sandeep patil)
Date: Fri, 18 Nov 2011 13:20:48 -0800
Subject: [Linaro-mm-sig] [PATCHv17 0/11] Contiguous Memory Allocator
In-Reply-To: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+K6fF6SH6BNoKgwArcqvyav4b=C5SGvymo5LS3akfD_yE_beg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 8:43 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Welcome everyone once again,

> Please notice that this patch series is aimed to start further
> discussion. There are still few issues that need to be resolved before
> CMA will be really ready. The most hot problem is the issue with movable
> pages that causes migration to fail from time to time. Our investigation
> leads us to the point that these rare pages cannot be migrated because
> there are some pending io operations on them.


I am running a simple test to allocate contiguous regions and write a log on
in a file on sdcard simultaneously. I can reproduce this migration failure 100%
times with it.
when I tracked the pages that failed to migrate, I found them on the
buffer head lru
list with a reference held on the buffer_head in the page, which
causes drop_buffers()
to fail.

So, i guess my question is, until all the migration failures are
tracked down and fixed,
is there a plan to retry the contiguous allocation from a new range in
the CMA region?

~ sandeep
