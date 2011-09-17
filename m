From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Sep 2011 22:52:38 +0200
Subject: [PATCH 0/19] removal of mach/vmalloc.h and generic optimizations
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <3319383.WZQsqr8ND4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 September 2011 03:07:11 Nicolas Pitre wrote:
> This patch series removes all instances of mach/vmalloc.h in order to
> have a more unified memory map across all ARM architectures.  To do so,
> the static mappings are moved inside the vmalloc area.  And finally this
> allows for a generic optimization to ioremap where static mappings are
> reused whenever possible, using common code instead of having this
> duplicated in a couple places.
> 
> This also provides a net reduction of more than 1200 lines of code.
> 
> Those patches are also available in the following repository:
> 
>         git://git.linaro.org/people/nico/linux vmalloc

Hi Nicolas,

I like the series a lot. I had planned to work on this myself, but
I guess you did a better job than I could have anyway.

Doing some randconfig tests, I noticed that your series is currently broken
on shmobile, which triggers a 

	BUILD_BUG_ON(VMALLOC_END > CONSISTENT_BASE);

in mem_init(), because the platform has a CONSISTENT_DMA_SIZE of 158MB.
All other platforms have a CONSISTENT_DMA_SIZE of at most 14MB, which
works correctly.

My feeling is that a 158MB CONSISTENT_DMA_SIZE causes other problems
anyway because we cannot map regular RAM both cached and uncached,
but this is still a regression. The problem might be solved using
Marek's CMA patches, which should eliminate the need for a huge
CONSISTENT_DMA_SIZE.

	Arnd
