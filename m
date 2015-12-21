From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 14:42:58 +0100
Subject: [PATCH] ARM64: Improve copy_page for 128 cache line sizes.
In-Reply-To: <20151221124637.GN23092@arm.com>
References: <1450570278-19404-1-git-send-email-apinski@cavium.com>
 <20151221124637.GN23092@arm.com>
Message-ID: <201512211442.58803.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 December 2015, Will Deacon wrote:
> On Sat, Dec 19, 2015 at 04:11:18PM -0800, Andrew Pinski wrote:
> > Adding a check for the cache line size is not much overhead.
> > Special case 128 byte cache line size.
> > This improves copy_page by 85% on ThunderX compared to the
> > original implementation.
> 
> So this patch seems to:
> 
>   - Align the loop
>   - Increase the prefetch size
>   - Unroll the loop once
> 
> Do you know where your 85% boost comes from between these? I'd really
> like to avoid having multiple versions of copy_page, if possible, but
> maybe we could end up with something that works well enough regardless
> of cacheline size. Understanding what your bottleneck is would help to
> lead us in the right direction.
> 
> Also, how are you measuring the improvement? If you can share your
> test somewhere, I can see how it affects the other systems I have access
> to.

A related question would be how other CPU cores are affected by the change.
The test for the cache line size is going to take a few cycles, possibly
a lot on certain implementations, e.g. if we ever get one where 'mrs' is
microcoded or trapped by a hypervisor.

Are there any possible downsides to using the ThunderX version on other
microarchitectures too and skip the check?

	Arnd
