From: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Sat, 13 Jul 2013 17:48:40 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130713T172357-560@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
Message-ID: <20130713164840.GC28473@gallifrey>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Harm Hanemaaijer (fgenfb at yahoo.com) wrote:
> Hello,
> 
> I've been doing some work on optimizing the memset/memcpy family of
> functions for modern ARM platforms, including copy_page, memset,
> memzero, memcpy, copy_from_user and copy_to_user. It appears that
> there is room for improvement, especially with regard to using an
> optimal preload strategy for armv6/v7 architectures as well as
> aligning the write target. For example, on an armv6-based platform
> (RPi) I am seeing a 80% speed-up in copy_page and large sized
> memcpy. Gains in the range 10-25% are seen on a Cortex A8 device.
> These optimizations use the regular register file, like the
> previous implementation, and do not use any NEON or vfp registers.

You might like to compare with some of the routines at:
https://launchpad.net/cortex-strings
and some of the numbers at:
https://wiki.linaro.org/WorkingGroups/ToolChain/Benchmarks/

(I'm sure Michael Hope who owns that set of stuff would be
interested in seeing your stuff as well).

> To properly benchmark and test these new implementations, I've
> created a userspace testing utility that can be used to compare
> and validate exact copies of the original and optimized kernel
> versions of the functions in userspace. The repository is
> available at https://github.com/hglm/test-arm-kernel-memcpy.git.
> It would be useful to compare the results on different
> platforms and to check whether changes in the prefetch distance
> or write alignment result in optimized performance.

It's quite tricky figuring out across different machines; also
even the same machine in different setups;

http://ssvb.github.io/2013/06/27/fullhd-x11-desktop-performance-of-the-allwinner-a10.html

is an interesting article on one machine being screwed over by
video bandwidth.

I've only had a brief scan through your code, one thing I remember
from a couple of years ago was a theory that ldrd/strd was supposed
to be faster on A15's (but I never had a chance to try it out).

<snip>

> So in short, I am looking for opinions, and test results especially
> from the userspace benchmark, to see the relative merit of these
> optimizations on different platforms.

Maybe neon is worth a try these days (although be careful of platforms
like Tegra 2 that doens't have it); there was a recent patch that enabled
use in the kernel (I think for some RAID use). The downside is it's
supposed to be quite power hungry.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
