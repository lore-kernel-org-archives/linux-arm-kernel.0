From: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Sun, 14 Jul 2013 12:32:51 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130714T130546-799@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey>
 <loom.20130714T130546-799@post.gmane.org>
Message-ID: <20130714113251.GA27803@gallifrey>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Harm Hanemaaijer (fgenfb at yahoo.com) wrote:
> Dr. David Alan Gilbert <gilbertd <at> treblig.org> writes:
> > 
> > Maybe neon is worth a try these days (although be careful of platforms
> > like Tegra 2 that doens't have it); there was a recent patch that enabled
> > use in the kernel (I think for some RAID use). The downside is it's
> > supposed to be quite power hungry.
> > 
> 
> As it turns out, NEON isn't too hard to implement. I have added NEON support
> to copy_page, memset, memzero, and memcpy (both for the aligned and unaligned
> case) in my userspace testing environment. It gives a nice boost (ranging
> from 10% for copy_page to >30% for unaligned memcpy on a Cortex A8), which
> can potentially be more on other cores.

What size memcpy's is that on?   If I remember correctly A8 happens to be
able to do very fast Neon to it's cache but it doesn't help outside of the cache,
and it doesn't make any benefit on A9.

> Although I have not tested a live
> kernel yet, it looks like NEON can be used fairly transparently #ifdefed on
> the CONFIG_NEON kernel definition as long as only the lower end of the
> NEON/vfp register file is clobbered (although this needs verification).

Hmm I'd assumed there would be some save/restory stuff needed and given
copy_to_ etc get used everywhere I'd be careful.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
