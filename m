From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sun, 14 Jul 2013 11:19:27 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey>
Message-ID: <loom.20130714T130546-799@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dr. David Alan Gilbert <gilbertd <at> treblig.org> writes:
> 
> Maybe neon is worth a try these days (although be careful of platforms
> like Tegra 2 that doens't have it); there was a recent patch that enabled
> use in the kernel (I think for some RAID use). The downside is it's
> supposed to be quite power hungry.
> 

As it turns out, NEON isn't too hard to implement. I have added NEON support
to copy_page, memset, memzero, and memcpy (both for the aligned and unaligned
case) in my userspace testing environment. It gives a nice boost (ranging
from 10% for copy_page to >30% for unaligned memcpy on a Cortex A8), which
can potentially be more on other cores. Although I have not tested a live
kernel yet, it looks like NEON can be used fairly transparently #ifdefed on
the CONFIG_NEON kernel definition as long as only the lower end of the
NEON/vfp register file is clobbered (although this needs verification).
