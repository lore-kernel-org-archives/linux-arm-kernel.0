From: josh.beavers@gmail.com (Josh Beavers)
Date: Fri, 7 Apr 2017 08:13:45 -0400
Subject: kmap_atomic() and manual VIVT cache flushes
Message-ID: <CAE=AiOOB3QoDCy-XS=fyOTqziM8tHZi1oFcVFa88AQFoLjL+cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Short version:  Are manual cache flushes still required on Linux 4.10
when using kmap_atomic() / kunmap_atomic()?



I have been doing heavy refactoring of a driver.  Previously, it used
vmalloc() mappings, and I learned there is no support for coherency
with vmalloc mappings and userspace mappings.

I am running on an ARMv5 VIVT cache system, so I refactored everything
to malloc() in userspace, get_user_pages_locked() in the kernel to
grab the pages, and then kmap_atomic() / kunmap_atomic() the pages
when the kernel needs to read or write anything.  I do not know of any
other "correct" way this can be done without causing incompatibility
with other ARM systems (ARMv7 does not support multiple mappings where
one side is cached and the other is not, for example).

This initially looked promising, but once I removed all debug traces I
started observing strange behavior.


1.  If I write to user memory, call usleep(1), and then call into the
driver, the driver reads the new data.
2.  If I write to user memory, call printf() with some message, and
then call into the driver, the driver reads the new data.
3.  If I write to user memory and immediately call the driver, the
driver DOES NOT read the new data.
4.  If I write to user memory and immediately call the driver, and
then call flush_dcache_page() in the driver before reading, the driver
DOES NOT read the new data (at least, not all the time).
5.  If I write to user memory and immediately call the driver, and
then call flush_cache_all() in the driver before reading, the driver
reads the new data.


I suspect cases 1 and 2 work because context switching is causing a
full cache flush.  I had hoped manual cache flushes in the driver
would be magically handled inside the kmap_atomic() / kunmap_atomic()
code but this does not appear to be the case empirically.

Question A:  Is case 3 supposed to work and I may be missing something
in my get_user_pages_locked() setup?

Question B:  Why would I need a more extreme cache flush than
flush_dcache_page()?


Any insight is appreciated since I am still new to the memory mapping
and cache internals.  I also appreciate being CC'd on replies since I
am not directly subscribed to the list.


Thanks,
-J
