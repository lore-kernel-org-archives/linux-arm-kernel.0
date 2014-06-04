From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 4 Jun 2014 20:05:47 +0200 (CEST)
Subject: [PATCH 3/3] clocksource: exynos_mct: Optimize register reads
 with ldmia
In-Reply-To: <1401903034-20074-3-git-send-email-dianders@chromium.org>
References: <1401903034-20074-1-git-send-email-dianders@chromium.org>
 <1401903034-20074-3-git-send-email-dianders@chromium.org>
Message-ID: <alpine.DEB.2.10.1406042004140.3319@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jun 2014, Doug Anderson wrote:

> As we saw in (clocksource: exynos_mct: cache mct upper count), the
> time spent reading the MCT shows up fairly high in real-world
> profiles.  That means that it's worth some optimization.
> 
> We get a roughly 10% speedup in userspace gettimeofday() by using an
> ldmia to read the two halfs of the MCT.  That seems like a worthwhile
> thing to do.
> 
> Before: 1173084 us for 1000000 gettimeofday in userspace
> After:  1045674 us for 1000000 gettimeofday in userspace
> 
> NOTE: we could actually do better than this if we really wanted to.
> Technically we could register the clocksource as a 32-bit timer and
> only use the "lower" half.  Doing so brings us down to 1014429 us for
> 1000000 gettimeofday in userspace (and doesn't even require assembly
> code).  That would be an alternative to this change.

I was about to ask exactly that question: What's the advantage of the
64 bit dance there? AFAICT nothing.
 
Thanks,

	tglx
