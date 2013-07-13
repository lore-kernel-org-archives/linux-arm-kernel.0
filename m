From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sat, 13 Jul 2013 21:13:12 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey>
Message-ID: <loom.20130713T225129-903@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dr. David Alan Gilbert <gilbertd <at> treblig.org> writes:

> 
> You might like to compare with some of the routines at:
> https://launchpad.net/cortex-strings
> and some of the numbers at:
> https://wiki.linaro.org/WorkingGroups/ToolChain/Benchmarks/

That's interesting. I had looked at cortex-strings before but didn't
dig into it, also because its benchmark program seemed to be limited in
scope. From the Linaro numbers it seems NEON isn't always a win
especially on newer Cortex platforms, with large variability across
different platforms/cores.

> 
>
http://ssvb.github.io/2013/06/27/fullhd-x11-desktop-performance-of-the-allwinner-a10.html
> 
> is an interesting article on one machine being screwed over by
> video bandwidth.

I have the same type of device (the Cortex A8 which I've tested on),
when running a 1920x1080 screen at 32bpp that does indeed cost a lot
bandwidth (it's 500MB/s of scanout bandwidth), I think this applies to
most devices except higher-end ones with a 64-bit DRAM interface.

> I've only had a brief scan through your code, one thing I remember
> from a couple of years ago was a theory that ldrd/strd was supposed
> to be faster on A15's (but I never had a chance to try it out).

I briefly experimented with ldrd/strd, it seemed to be fast but
highly dependent on the proper (64-bit) alignment. In my current code
it is only used in Thumb2 mode in one spot.

> Maybe neon is worth a try these days (although be careful of platforms
> like Tegra 2 that doens't have it); there was a recent patch that enabled
> use in the kernel (I think for some RAID use). The downside is it's
> supposed to be quite power hungry.

Although I don't have experience with NEON, there seems to be a lot of
variability across platforms/cores when using it for memcpy, and it may
have extra overhead when used in the kernel. I will look at it in more
detail, but not using NEON does make things easier (not having to detect
NEON, being compatible with older platforms etc).

Thanks for the comments.
